From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [linuxsh-dev] AICA driver for dreamcast
Date: Sun, 28 May 2006 22:32:11 +0300
Message-ID: <20060528193211.GA10078@linux-sh.org>
References: <1148841646.9224.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0481482920=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp2.pp.htv.fi (smtp2.pp.htv.fi [213.243.153.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2B42918F
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 21:32:14 +0200 (MEST)
In-Reply-To: <1148841646.9224.19.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@alsa-project.org, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0481482920==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

It's getting better, but still a ways to go..

On Sun, May 28, 2006 at 07:40:46PM +0100, Adrian McMenamin wrote:
> static int index =3D -1;
> static char *id;
> static int enable =3D 1;
>=20
> module_param(index, int, 0444);
> MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
> module_param(id, charp, 0444);
> MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
> module_param(enable, bool, 0644);
> MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
>=20
I'm not sure I see what the point of id and enable are. id doesn't appear
to be used at all, and enable seems superfluous.

> /* Spinlocks */
> static DEFINE_SPINLOCK(spu_memlock);
>=20
>=20
Whitespace damage.

> /* Simple platform device */
> static struct platform_device *pd;
> static struct resource aica_memory_space[2] =3D {
> 	{
> 	 .name =3D "AICA ARM CONTROL",
> 	 .start =3D ARM_RESET_REGISTER,
> 	 .flags =3D IORESOURCE_MEM,
> 	 .end =3D ARM_RESET_REGISTER + 4,
> 	 },
> 	{

Weird formatting, stick with tabs.

> 	 .name =3D "AICA Sound RAM",
> 	 .start =3D SPU_MEMORY_BASE,
> 	 .flags =3D IORESOURCE_MEM,
> 	 .end =3D SPU_MEMORY_BASE + 0x200000,
> 	 },
> };
>=20
That looks like an off-by-1 bug, you probably want:

	.end =3D SPU_MEMORY_BASE + 0x200000 - 1,

> /* spu_memset - write to memory in SPU address space */
> static void spu_memset(uint32_t toi, void __iomem * what, int length)
> {
> 	uint32_t *to =3D (uint32_t *) (SPU_MEMORY_BASE + toi);

You should really make your own spu_writel() that do this for you, so you
don't have the same silly casting all over the place.

> 	int i;
> 	snd_assert(length % 4 =3D=3D 0, return);
> 	spu_write_wait();
> 	for (i =3D 0; i < length; i++) {
> 		spin_lock(&spu_memlock);
> 		writel(what, to);
> 		spin_unlock(&spu_memlock);

What exactly are you trying to accomplish with this lock?
spu_write_wait() is already going to synchronize access, isn't it?
If you're trying to do mutual exclusion for the entire write, this
implementation certainly isn't going to work either..

> static void spu_init(void)
> {
> 	spu_disable();
> 	spu_memset(0, 0, 0x200000 / 4);
> 	/* Put ARM7 in endless loop */
> 	ctrl_outl(0xea000002, SPU_MEMORY_BASE);
> 	spu_enable();
> 	schedule();
> }
>=20
Why are you schedule()'ing away? You're also calling this before the
firmware loader, any delay you're hoping to accomplish will already be
handled there.

You can probably also inline this..

> /* aica_chn_start - write to spu to start playback */
> inline static void aica_chn_start(void)

static inline void..

> {
> 	spu_write_wait();
> 	spin_lock(&spu_memlock);
> 	writel(AICA_CMD_KICK | AICA_CMD_START,
> 	       (uint32_t *) AICA_CONTROL_POINT);
> 	spin_unlock(&spu_memlock);
> }
>=20
More useless locking, and another reason to have your own spu_writel(),
so you don't end up duplicating this all over the place..

> /* aica_chn_halt - write to spu to halt playback */
> inline static void aica_chn_halt(void)
> {
> 	spu_write_wait();
> 	spin_lock(&spu_memlock);
> 	writel(AICA_CMD_KICK | AICA_CMD_STOP,
> 	       (uint32_t *) AICA_CONTROL_POINT);
> 	spin_unlock(&spu_memlock);
> }
>=20
Likewise.

> /* ALSA code below */
> static struct snd_pcm_hardware snd_pcm_aica_playback_hw =3D {
> 	.info =3D (SNDRV_PCM_INFO_NONINTERLEAVED),.formats =3D
> 	    (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
> 	     SNDRV_PCM_FMTBIT_IMA_ADPCM),

Magical formatting.

> 	.rates =3D SNDRV_PCM_RATE_8000_48000,
> 	.rate_min =3D 8000,.rate_max =3D 48000,

Likewise.

> 		if (err < 0)
> 			break;

unlikely().

> 	substream =3D (struct snd_pcm_substream *) timer_var;

Whitespace damage.

> 	runtime =3D substream->runtime;
> 	dreamcastcard =3D substream->pcm->private_data;
> 	/* Have we played out an additional period? */
> 	play_period =3D
> 	    frames_to_bytes(runtime,
> 			    readl
> 			    (AICA_CONTROL_CHANNEL_SAMPLE_NUMBER)) /
> 	    AICA_PERIOD_SIZE;

Likewise.

> 	if (play_period =3D=3D dreamcastcard->current_period) {
> 		/* reschedule the timer */
> 		dreamcastcard->timer.expires =3D jiffies + 1;
> 		add_timer(&(dreamcastcard->timer));

Use mod_timer().

> static void startup_aica(struct snd_card_aica *dreamcastcard)
> {
> 	spu_memload(AICA_CHANNEL0_CONTROL_OFFSET,
> 		    (uint8_t *) dreamcastcard->channel,
> 		    sizeof(struct aica_channel));
> 	aica_chn_start();
> 	return;

Useless return.
> }
>=20
>=20
>=20
Whitespace damage.

> static void spu_begin_dma(struct snd_pcm_substream *substream)
> {
> 	int buffer_size;
> 	struct snd_pcm_runtime *runtime;
> 	long dma_flags;

Unused variable?

> 	struct snd_card_aica *dreamcastcard;
> 	dreamcastcard =3D substream->pcm->private_data;
> 	runtime =3D substream->runtime;
> 	buffer_size =3D frames_to_bytes(runtime, runtime->buffer_size);
> 	if (runtime->channels > 1)
> 		dreamcastcard->channel->flags |=3D 0x01;
> 	aica_dma_transfer(runtime->channels, buffer_size, substream);
> 	dreamcastcard->clicks =3D
> 	    buffer_size / (AICA_PERIOD_SIZE * runtime->channels);
> 	startup_aica(dreamcastcard);
> 	/* Timer may already be running - if so delete it */
> 	if (dreamcastcard->timer.data)
> 		del_timer(&dreamcastcard->timer);
> 	init_timer(&(dreamcastcard->timer));
> 	dreamcastcard->timer.data =3D (unsigned long) substream;
> 	dreamcastcard->timer.function =3D aica_period_elapsed;
> 	dreamcastcard->timer.expires =3D jiffies + 4;
> 	add_timer(&(dreamcastcard->timer));

That's silly, use mod_timer().

> }
>=20
>=20
>=20
You seem to be taking all of your line breaks and putting them after the
function, rather than throughout it.

> /* TO DO: set up to handle more than one pcm instance */
> static int __init snd_aicapcmchip(struct snd_card_aica
> 				  *dreamcastcard, int pcm_index)
> {
> 	struct snd_pcm *pcm;
> 	int err;
> 	/* AICA has no capture ability */
> 	if ((err =3D
> 	     snd_pcm_new(dreamcastcard->card, "AICA PCM", pcm_index, 1, 0,
> 			 &pcm)) < 0)
> 		return err;

Magical line formatting again.. kernel convention is also

	err =3D snd_pcm_new(...);
	if (unlikely(err < 0))
		return err;

> 	/* Allocate the DMA buffers */
> 	err =3D
> 	    snd_pcm_lib_preallocate_pages_for_all(pcm,
> 						  SNDRV_DMA_TYPE_CONTINUOUS,
> 						  snd_dma_continuous_data
> 						  (GFP_KERNEL),
> 						  AICA_BUFFER_SIZE,
> 						  AICA_BUFFER_SIZE);
> 	return err;
> }
>=20
Why not just return snd_pcm_lib_preallocate_pages_for_all(...); ?

> static int aica_pcmvolume_get(struct snd_kcontrol *kcontrol,
> 			      struct snd_ctl_elem_value *ucontrol)
> {
> 	struct snd_card_aica *dreamcastcard;
> 	dreamcastcard =3D kcontrol->private_data;
> 	if (!dreamcastcard->channel)
> 		return -ETXTBSY;	/* we've not yet been set up */

unlikely()..

> 			      struct snd_ctl_elem_value *ucontrol)
> {
> 	struct snd_card_aica *dreamcastcard;
> 	dreamcastcard =3D kcontrol->private_data;
> 	if (!dreamcastcard->channel) {
> 		snd_printk("No channel yet\n");
> 		return -ETXTBSY;	/* too soon */
> 	} else
> 	    if (dreamcastcard->channel->vol =3D=3D
> 		ucontrol->value.integer.value[0])
> 		return 0;
> 	else {

Please do something about this if/else readability..

> static struct snd_kcontrol_new snd_aica_pcmvolume_control __devinitdata =
=3D {
> 	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
> 	.name =3D "PCM Playback Volume",
> 	.index =3D 0,.info =3D aica_pcmvolume_info,
> 	.get =3D aica_pcmvolume_get,
> 	.put =3D aica_pcmvolume_put
> };

More magical formatting.

> static struct device_driver aica_driver =3D {
> 	.name =3D "AICA",.bus =3D &platform_bus_type,
> 	.remove =3D remove_dreamcastcard,
> };
>=20
And again.

> /* Fill up the members of the embedded device structure */
> static void populate_dreamcastaicadev(struct device *dev)
> {
> 	dev->bus =3D &platform_bus_type;
> 	dev->driver =3D &aica_driver;
> 	driver_register(dev->driver);
> 	device_bind_driver(dev);
> }
>=20
Er, no. Go with a platform_device directly, there's no need for this kind
of blatant abuse of the driver model.

> static int load_aica_firmware()
                                ^void
> {
> 	int err;
> 	err =3D 0;
> 	spu_init();
> 	const struct firmware *fw_entry;

Declarations _before_ code please..

> 	err =3D request_firmware(&fw_entry, "aica_firmware.bin", &pd->dev);
> 	if (err)
> 		return err;

unlikely()? scheduling away before this seems pointless.

> static int __devinit add_aicamixer_controls(struct snd_card_aica
> 					    *dreamcastcard)
> {
> 	int err;
> 	err =3D snd_ctl_add
> 	    (dreamcastcard->card,
> 	     snd_ctl_new1(&snd_aica_pcmvolume_control, dreamcastcard));
> 	if (err < 0) {
> 		snd_printk
> 		    ("AICA sound: Could not add PCM volume control\n");
> 		return err;
> 	}
> 	err =3D snd_ctl_add
> 	    (dreamcastcard->card,
> 	     snd_ctl_new1(&snd_aica_pcmswitch_control, dreamcastcard));
> 	if (err < 0) {
> 		snd_printk
> 		    ("AICA sound: Could not add PCM switch control\n");
> 		return err;
> 	}
> 	return 0;
> }
>=20
Whitespace damage..

> 	pd =3D platform_device_register_simple(dreamcastcard->card->driver,
> 					     -1, aica_memory_space, 2);

As has already been pointed out, this is going away, new drivers should
not be using this.

> 	    ("ALSA Driver for Yamaha AICA Super Intelligent Sound Processor\n");
> 	return 0;
>       freepcm:
>       freedreamcast:

Why are there two goto labels for the same thing, and why are they in a
magical location?

> 	snd_card_free(dreamcastcard->card);
> 	if (pd) {
> 		struct device_driver *drv =3D (&pd->dev)->driver;
> 		device_release_driver(&pd->dev);
> 		driver_unregister(drv);
> 		platform_device_unregister(pd);
> 		pd =3D NULL;
> 	}

More driver model abuse..

> 	kfree(dreamcastcard);
> 	return err;
> }
>=20
> static void __exit aica_exit(void)
> {
> 	struct device_driver *drv =3D (&pd->dev)->driver;
> 	device_release_driver(&pd->dev);
> 	driver_unregister(drv);
> 	platform_device_unregister(pd);
> 	/* Kill any sound still playing and reset ARM7 to safe state */
> 	spu_init();
> 	return;

Superfluous return.

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEefq61K+teJFxZ9wRAkiQAJ0aUSJDDeAMsV57t0YpYa65r8vVfACeJ7Z2
yjT5e9GcpCCXLc/4UtBJZrg=
=+Q+C
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--


--===============0481482920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0481482920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0481482920==--
