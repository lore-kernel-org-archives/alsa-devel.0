From: "Jonas Eymann" <sm501_dev@gmx-topmail.de>
Subject: SM501 driver development: problem with start of
	playback
Date: Wed, 22 Nov 2006 10:44:55 +0100
Message-ID: <20061122094455.187990@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I'm currently developing/ enhancing an ALSA driver for a Silicon Motion SM5=
01 compagnion chip which contains also an 8051 =B5C acting as AC97 controll=
er. It doesn't support DMA and so the copy of audio data is done in the dri=
ver. There is a small hardware buffer of 1920 bytes which is devided into t=
wo halves and used as ring buffer. When the hardware has finished playing o=
ne half, it sends an interrupt to the driver so it can fill this half with =
new audio data while the hardware plays from the other one and so on. In th=
e driver, I use an intermediate buffer with vmalloc().

Actually, I have a working driver now, but one small problem remains and I'=
m absolutely running out of ideas how to fix it: when the playback starts, =
the hardware expects the buffer to be filled completely (both halves), but =
the copy routine which does this first filling (snd_sm501_pfill()) only get=
s one period, not the two which are needed to fill the buffer completely. T=
he second half it just reads zeros. It seems that the intermediate buffer i=
s not yet filled with more data. This results in a gap of one period at the=
 beginning of the playback (it's the second period that doesn't get copied)=
. =

I've tried to change everything to a structure with .copy and .silence call=
backs, but ran into even more problems. I read everything I could find abou=
t ALSA drivers, looked at code from other ALSA drivers, but still, I just d=
on't get it. I know that the trigger function should be fast and only just =
triggering the DMA (if there was one), but I don't know where else to put t=
he pfill call. In the prepare callback there is no sound data available yet=
. Maybe I should change everything completely to another structure, but I h=
ave no idea how it should then look like.

Below are some excerpts from the code.

Thank you already very much in advance!

Jonas


/* hw_params callback */
static int snd_sm501_pcm_hw_params(snd_pcm_substream_t *substream,
				   snd_pcm_hw_params_t * hw_params)
{
	KDEBUG("pcm_hw_params\n");

	return snd_sm501_pcm_alloc_vmalloc_buffer(substream,
					params_buffer_bytes(hw_params));
}

/* hw_free callback */
static int snd_sm501_pcm_hw_free(snd_pcm_substream_t *substream)
{
	KDEBUG("pcm_hw_free\n");

	return snd_sm501_pcm_free_vmalloc_buffer(substream);
}


/* prepare callback */
static int snd_sm501_pcm_playback_prepare(snd_pcm_substream_t *substream)
{
	ac97_t *ac97;
	u8 value =3D 0x00;
	=

	snd_pcm_format_t format;
	unsigned int rate;
	unsigned int channels;
	=

	psmivgx_t s =3D snd_pcm_substream_chip(substream);
	=

	ac97 =3D smivgx_drv_data[smivgx_get_id(s)].ac97; =

	format =3D substream->runtime->format;
	rate =3D substream->runtime->rate;
	channels =3D substream->runtime->channels;

	snd_sm501_ac97_write(ac97, AC97_PCM_FRONT_DAC_RATE, rate);
	snd_sm501_ac97_write(ac97, AC97_EXTENDED_STATUS, 0x0001);
	smivgx_pokeword(s, SRAM(pb_bitrate), rate);
	=

	if(format =3D=3D SNDRV_PCM_FORMAT_S16_LE)
		value |=3D 0x01;		/* set 16 bit sample format bit (otherwise 8 bit) */
	else
		value &=3D 0xFE;
	if(channels =3D=3D 2)
		value |=3D 0x02;		/* set stereo bit (otherwise mono) */
	else
		value &=3D 0xFD;
	smivgx_pokebyte(s, SRAM(pb_mode_select),value);

	KDEBUG("pcm_playback_prepare\n");

	smivgx_drv_data[smivgx_get_id(s)].ppointer =3D 0;
	return 0;
}

/* trigger callback */
static int snd_sm501_pcm_playback_trigger(snd_pcm_substream_t *substream,
					  int cmd)
{
	psmivgx_t s =3D snd_pcm_substream_chip(substream);
	smivgx_drv_data_t *drv_data;

	drv_data =3D &smivgx_drv_data[smivgx_get_id(s)];

	spin_lock(&s->lock);

	switch (cmd) {
		case SNDRV_PCM_TRIGGER_START:
			=

			KDEBUG("pcm_playback_trigger: start\n");
			drv_data->psubstream =3D substream;
			snd_sm501_pfill(s);
			smivgx_poke(s, U8051_CPU_PROTOCOL_INTERRUPT, START_AUDIO_PLAYBACK);
			break;
		case SNDRV_PCM_TRIGGER_STOP:
			KDEBUG("pcm_playback_trigger: stop\n");
			smivgx_poke(s, U8051_CPU_PROTOCOL_INTERRUPT, STOP_AUDIO_PLAYBACK);
			drv_data->psubstream =3D NULL;
			break;
		default:
			KDEBUG("pcm_playback_trigger: default (%i)\n", cmd);
			return -EINVAL;
	}

	spin_unlock(&s->lock);

	return 0;
}

/*
 * Fill the playback buffers with audio data
 */
static void snd_sm501_pfill(psmivgx_t s)
{
	smivgx_drv_data_t *drv_data;
	int frames; =

	u32 *pframe;
	u32 *pdest;
	u32 *pborder;
	snd_pcm_runtime_t *runtime;

	drv_data =3D &smivgx_drv_data[smivgx_get_id(s)];

	if (drv_data->psubstream=3D=3DNULL) {
		return;
	}
	=

	runtime =3D drv_data->psubstream->runtime;

	if (runtime->dma_area =3D=3D NULL) {
		return;
	}
	=

	frames =3D bytes_to_frames(runtime, SM501_AC97_P_PERIOD_SIZE);
	=

	pframe =3D (u32*) (runtime->dma_area
			     + frames_to_bytes(runtime, drv_data->ppointer));
	=

	=

	pdest =3D (u32*) SRAM(playback_buffer_0);
	=

	pborder =3D pdest + 2*(SM501_AC97_P_PERIOD_SIZE / sizeof(*pdest));
	do {	=

		smivgx_poke(drv_data->device, (unsigned int) pdest,*pframe);
		pdest++;
		pframe++;
	=

	} while (pdest < pborder);
	=

	drv_data->ppointer_hiddenoffset =3D 2*frames;
}

/* =

 * Copy playback data into the hardware buffer
 * This function can also be called as tasklet!
 */
static void snd_sm501_copy_pdata(unsigned long private_data)
{
	smivgx_drv_data_t *drv_data =3D (smivgx_drv_data_t *)private_data;
	int frames; =

	u32 *pframe;
	u32 *pdest;
	u32 *pborder;
	snd_pcm_runtime_t *runtime;
	unsigned char buffer_req;
	unsigned long flags; =


	spin_lock_irqsave(&drv_data->device->lock, flags);
	=

	if (drv_data->psubstream=3D=3DNULL) {
		spin_unlock_irqrestore(&drv_data->device->lock, flags);
		return;
	}
	=

	xboardgp8_gpio_direction_set(1, 1);
	xboardgp8_gpio_set(1,1);

	runtime =3D drv_data->psubstream->runtime;

	if (runtime->dma_area =3D=3D NULL) {
		spin_unlock_irqrestore(&drv_data->device->lock, flags);
		return;
	}
	=

	frames =3D bytes_to_frames(runtime, SM501_AC97_P_PERIOD_SIZE);
	=

	pframe =3D (u32*) (runtime->dma_area
				+ frames_to_bytes(runtime, drv_data->ppointer =

				+ drv_data->ppointer_hiddenoffset));
	=

	=

	buffer_req =3D smivgx_peekbyte(drv_data->device, SRAM(buffer_request));
	if (buffer_req & 0x1) =

	{
		pdest =3D (u32*) SRAM(playback_buffer_0);
	}
	else /* if (buffer_req & 0x2) */
	{
		pdest =3D (u32*) SRAM(playback_buffer_1);
	}
		=

	pborder =3D pdest + (SM501_AC97_P_PERIOD_SIZE / sizeof(*pdest));

	do {
		smivgx_poke(drv_data->device, (unsigned int) pdest,*pframe);
		pdest++;
		pframe++;
	} while (pdest < pborder);

	drv_data->ppointer +=3D frames;
	drv_data->ppointer_hiddenoffset =3D 0;
	drv_data->ppointer %=3D frames * runtime->periods;
	=

	spin_unlock_irqrestore(&drv_data->device->lock, flags);
	=

	snd_pcm_period_elapsed(drv_data->psubstream);
	=

	xboardgp8_gpio_set(1,0);
}


/* interrupt service routine */
static irqreturn_t snd_sm501_interrupt(int irq, void* dev_id,
				       struct pt_regs* regs)
{
/* ... */
	=

	if (buffer_req) =

	{
		smivgx_drv_data_t *drv_data;
		drv_data =3D &smivgx_drv_data[smivgx_get_id(s)];
		if(buffer_req & 0x03) /* Playback */
		{
			snd_sm501_copy_pdata((unsigned long) drv_data);
		}
		if(buffer_req & 0x0C) /* Capture */
		{
			snd_sm501_copy_cdata((unsigned long) drv_data);
		}
	}

	return IRQ_HANDLED;
}

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
