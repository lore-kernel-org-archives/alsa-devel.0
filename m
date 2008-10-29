From: The Source <thesourcehim@gmail.com>
Subject: Re: sbxfi - What works/doesn't summary
Date: Wed, 29 Oct 2008 19:12:29 +0300
Message-ID: <49088B6D.3000500@gmail.com>
References: <4906FA8C.4030501@jasonline.co.uk>	<490709EF.7090803@gmail.com>	<49074E98.7070506@jasonline.co.uk>	<s5h3aigilum.wl%tiwai@suse.de>	<490768FF.3020807@jasonline.co.uk>	<s5hy708h5r1.wl%tiwai@suse.de>	<490772FA.9060508@jasonline.co.uk>	<4907EA7F.4090402@gmail.com>	<4907EEBE.5090604@gmail.com>	<4907EF8C.5050502@gmail.com>	<4907F158.3040608@gmail.com>
	<s5hiqrblpg9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010900050203060107040209"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id A12D02446B
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 17:12:32 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so54022nfd.32
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 09:12:31 -0700 (PDT)
In-Reply-To: <s5hiqrblpg9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010900050203060107040209
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> At Wed, 29 Oct 2008 08:15:04 +0300,
> The Source wrote:
>  =20
>> Ok, was able to get hw_params:
>> access: MMAP_INTERLEAVED
>> format: S16_LE
>> subformat: STD
>> channels: 2
>> rate: 48000 (48000/1)
>> period_size: 1088
>> buffer_size: 4352
>>
>> Why so weird values?
>>    =20
>
> Maybe related with the default sample rate 44.1kHz?  Who knows...
>
> Does the patch below have any influence?
> This restricts the period/buffer size aligned to 1024 bytes.
> Also, it may fix the PCM pointer calculation somehow.
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
> index e67f768..a2d908e 100644
> --- a/sound/pci/sbxfi/sbxfi.c
> +++ b/sound/pci/sbxfi/sbxfi.c
> @@ -122,6 +122,9 @@ struct sbxfi_port {
>  	/* TLB entry */
>  	int tlb_index;
>  	unsigned int tlb_pages;
> +	/* buffer pointers */
> +	unsigned int start_addr;
> +	unsigned int buffer_bytes;
>  	/* status */
>  	int state;
>  	int need_update;
> @@ -527,8 +530,8 @@ static void sbxfi_playback_start(struct sbxfi *chip=
, struct sbxfi_port *port)
>  	if (port->tlb_index < 0)
>  		return;
>  	runtime =3D port->substream->runtime;
> -	start =3D port->tlb_index * SBXFI_PAGE_SIZE;
> -	loop =3D start + frames_to_bytes(runtime, runtime->buffer_size);
> +	start =3D port->start_addr;
> +	loop =3D start + port->buffer_bytes;
> =20
>  	switch (runtime->rate) {
>  	case 48000:
> @@ -579,8 +582,8 @@ static void sbxfi_capture_start(struct sbxfi *chip,=
 struct sbxfi_port *port)
>  	if (port->tlb_index < 0)
>  		return;
>  	runtime =3D port->substream->runtime;
> -	start =3D port->tlb_index * SBXFI_PAGE_SIZE;
> -	loop =3D start + frames_to_bytes(runtime, runtime->buffer_size);
> +	start =3D port->start_addr;
> +	loop =3D start + port->buffer_bytes;
> =20
>  	switch (runtime->rate) {
>  	case 48000:
> @@ -1320,9 +1323,9 @@ static int sbxfi_playback_open(struct snd_pcm_sub=
stream *substream)
>  	set_rate_limit(chip, runtime);
>  	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
>  	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTE=
S,
> -				   128);
> +				   1024 /*128*/);
>  	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTE=
S,
> -				   128);
> +				   1024 /*128*/);
>  	return 0;
>  }
> =20
> @@ -1349,9 +1352,9 @@ static int sbxfi_capture_open(struct snd_pcm_subs=
tream *substream)
>  	set_rate_limit(chip, runtime);
>  	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
>  	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTE=
S,
> -				   128);
> +				   1024 /*128*/);
>  	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTE=
S,
> -				   128);
> +				   1024 /*128*/);
>  	return 0;
>  }
> =20
> @@ -1399,6 +1402,9 @@ static int sbxfi_playback_prepare(struct snd_pcm_=
substream *substream)
>  	port->frag_count =3D runtime->period_size;
>  	port->need_update =3D 0;
> =20
> +	port->start_addr =3D port->tlb_index * SBXFI_PAGE_SIZE;
> +	port->buffer_bytes =3D frames_to_bytes(runtime, runtime->buffer_size)=
;
> +
>  	sbxfi_setup_play_pitch(chip, port);
>  	sbxfi_setup_play_mixer(chip, port);
>  	sbxfi_setup_play_mapper(chip, port);
> @@ -1417,6 +1423,9 @@ static int sbxfi_capture_prepare(struct snd_pcm_s=
ubstream *substream)
>  	port->frag_count =3D runtime->period_size;
>  	port->need_update =3D 0;
> =20
> +	port->start_addr =3D port->tlb_index * SBXFI_PAGE_SIZE;
> +	port->buffer_bytes =3D frames_to_bytes(runtime, runtime->buffer_size)=
;
> +
>  	sbxfi_init_adc(chip, chip->capsrc, chip->micboost);
> =20
>  	sbxfi_setup_capture_mapper(chip, port);
> @@ -1477,10 +1486,12 @@ sbxfi_pcm_pointer(struct snd_pcm_substream *sub=
stream)
>  	unsigned int pos;
> =20
>  	pos =3D sbxfi_read(chip, SRCCA(port->src[0])) & 0x03ffffff;
> -	pos -=3D port->tlb_index * SBXFI_PAGE_SIZE;
> +	pos -=3D port->start_addr;
>  	/* The pointer is always 128 bytes ahead */
>  	if (pos >=3D CA_OFFSET)
>  		pos -=3D CA_OFFSET;
> +	else
> +		pos =3D pos + port->buffer_bytes - CA_OFFSET;
>  	pos =3D bytes_to_frames(runtime, pos);
>  	pos %=3D runtime->buffer_size;
>  	LOG(2, "POINTER =3D 0x%x\n", pos);
>
>  =20
Patch doesn't help. Though it really makes period and buffer to be=20
aligned to 1024.
I have discovered however that sound only gets corrupted if wine tries=20
to use alsa directly.
If it uses pulseaudio (it's eSound emulation), sound is fine. Other apps=20
(including MPlayer) with pulseaudio work just fine.
dmesg output with debug=3D2 for the case when wine uses alsa directly is=20
attached.

--------------010900050203060107040209
Content-Type: application/x-bzip;
 name="dmesg.out.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.out.bz2"

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
--------------010900050203060107040209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010900050203060107040209--
