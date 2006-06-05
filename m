From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Add support for Yamaha AICA sound on SEGA
	Dreamcast
Date: Mon, 5 Jun 2006 12:53:18 +0300
Message-ID: <20060605095318.GA30339@linux-sh.org>
References: <1149201071.9032.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1154212127=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp1.pp.htv.fi (smtp1.pp.htv.fi [213.243.153.37])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A3C9151
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jun 2006 11:53:20 +0200 (MEST)
In-Reply-To: <1149201071.9032.13.camel@localhost.localdomain>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1154212127==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2006 at 11:31:11PM +0100, Adrian McMenamin wrote:
>    obj-y +=3D last.o
> diff -ruN a/linux-2.6.16.14/sound/sh/aica.c b/linux-2.6.16.14/sound/sh/ai=
ca.c
> --- a/linux-2.6.16.14/sound/sh/aica.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/linux-2.6.16.14/sound/sh/aica.c	2006-06-01 23:01:39.000000000 +0100
> @@ -0,0 +1,692 @@
> +/*
> +* This code is licenced under=20
> +* the General Public Licence
> +* version 2
> +*
> +* Copyright Adrian McMenamin 2005, 2006
> +* <adrian@mcmen.demon.co.uk>
> +* See also http://newgolddream.dyndns.info/cgi-bin/cvsweb
> +*=20
> +*
> +* This program is free software; you can redistribute it and/or modify
> +* it under the terms of version 2 of the GNU General Public License as p=
ublished by
> +* the Free Software Foundation.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
> +* You should have received a copy of the GNU General Public License
> +* along with this program; if not, write to the Free Software
> +* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
> +*
> +*/
> +
> +
Superfluous whitespace still..

> +/* Simple platform device */
> +static struct platform_device *pd;
> +static struct resource aica_memory_space[2] =3D {
> +	{
> +	 	.name =3D "AICA ARM CONTROL",
> +	 	.start =3D ARM_RESET_REGISTER,
> +	 	.flags =3D IORESOURCE_MEM,
> +	 	.end =3D ARM_RESET_REGISTER + 3,
> +	 },
> +	{
> +	 	.name =3D "AICA Sound RAM",
> +	 	.start =3D SPU_MEMORY_BASE,
> +	 	.flags =3D IORESOURCE_MEM,
> +	 	.end =3D SPU_MEMORY_BASE + 0x200000 - 1,
> +	 },
> +};
> +
This is still a bit broken. These resources should be part of the
platform device defined by the board-specific dreamcast code (see for
example what things like microdev do for smc91x for an example), incase
there are other AICA users in the future.

> +/* SPU specific functions */
> +/* spu_write_wait - wait for G2-SH FIFO to clear */
> +static inline void spu_write_wait(void)
> +{
> +	int time_count;
> +	time_count =3D 0;
> +	while (1) {
> +		if (!(readl(G2_FIFO) & 0x11))
> +			break;
> +		/* To ensure hardware failure doesn't wedge kernel */
> +		time_count++;
> +		if (time_count > 0x10000)
> +			break;
> +	}
> +}
> +
> +/* spu_memset - write to memory in SPU address space */
> +static void spu_memset(uint32_t toi, uint32_t what, int length)
> +{
> +	int i;
> +	snd_assert(length % 4 =3D=3D 0, return);
> +	spu_write_wait();
> +	for (i =3D 0; i < length; i++) {
> +		writel(what, toi + SPU_MEMORY_BASE);
> +		toi++;
> +		if (i && !(i % 8))
> +			spu_write_wait();
> +	}
> +}
> +
You should not have the memory base hardcoded as you can already fetch it
=66rom the memory resource. You should have an IORESOURCE_IO for the
control registers, and an IORESOURCE_MEM for the SPU RAM, then fetch
those from the platform device resources accordingly so that these remain
configurable from the board-specific code.

> +/* spu_memload - write to SPU address space */
> +static void spu_memload(uint32_t toi, void __iomem * from, int length)
> +{
> +	uint32_t __iomem *froml =3D from;
> +	uint32_t __iomem *to =3D
> +	    (uint32_t __iomem *) (SPU_MEMORY_BASE + toi);

Same here. Again, you really want your own spu_readl()/spu_writel() that
hides this for you.

> +/* spu_disable - set spu registers to stop sound output */
> +static void spu_disable(void)
> +{
> +	int i;
> +	uint32_t regval;
> +	spu_write_wait();
> +	regval =3D readl(ARM_RESET_REGISTER);
> +	regval |=3D 1;
> +	spu_write_wait();
> +	writel(regval, ARM_RESET_REGISTER);

Same thing here..

> +	for (i =3D 0; i < 64; i++) {
> +		spu_write_wait();
> +		regval =3D readl(SPU_REGISTER_BASE + (i * 0x80));
> +		regval =3D (regval & ~0x4000) | 0x8000;
> +		spu_write_wait();
> +		writel(regval, SPU_REGISTER_BASE + (i * 0x80));
> +	}

And here..

> +/* Halt the sound processor,
> +   clear the memory,
> +   load some default ARM7 code,
> +   and then restart ARM7
> +*/

Please use more conventional commenting styles, as opposed to inventing
your own.

> +static void spu_init(void)

This can probably be inlined..

> +/* aica_chn_start - write to spu to start playback */
> +static void aica_chn_start(void)
> +{
> +	spu_write_wait();
> +	writel(AICA_CMD_KICK | AICA_CMD_START,
> +	       (uint32_t *) AICA_CONTROL_POINT);
> +}
> +
> +/* aica_chn_halt - write to spu to halt playback */
> +static void aica_chn_halt(void)
> +{
> +	spu_write_wait();
> +	writel(AICA_CMD_KICK | AICA_CMD_STOP,
> +	       (uint32_t *) AICA_CONTROL_POINT);
> +}
> +
These too.

> +static void startup_aica(struct snd_card_aica *dreamcastcard)
> +{
> +	spu_memload(AICA_CHANNEL0_CONTROL_OFFSET,
> +		    (uint8_t *) dreamcastcard->channel,
> +		    sizeof(struct aica_channel));
> +	aica_chn_start();
> +	return;
> +}
> +
Pointless return.

> +/* TO DO: set up to handle more than one pcm instance */
> +static int __init snd_aicapcmchip(struct snd_card_aica
> +				  *dreamcastcard, int pcm_index)
> +{
> +	struct snd_pcm *pcm;
> +	int err;
> +	/* AICA has no capture ability */
> +	if ((err =3D
> +	     snd_pcm_new(dreamcastcard->card, "AICA PCM", pcm_index, 1, 0,
> +			 &pcm)) < 0)
> +		return err;

Again, move the assignment out of the if context.

> +static int aica_pcmvolume_put(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_card_aica *dreamcastcard;
> +	dreamcastcard =3D kcontrol->private_data;
> +	if (unlikely(!dreamcastcard->channel)) {
> +		return -ETXTBSY;	/* too soon */
> +	} else
> +	    if (unlikely(dreamcastcard->channel->vol =3D=3D
> +			 ucontrol->value.integer.value[0]))
> +		return 0;
> +	else {

This if/else mess is still painful to read, and your indentation level is
broken, which doesn't make it any easier to follow. If you're returning
anyways, then just kill the else in both cases.

> +/* Fill up the members of the embedded device structure */
> +static void populate_dreamcastaicadev(struct device *dev)
> +{
> +	dev->bus =3D &platform_bus_type;
> +	dev->driver =3D &aica_driver;
> +	driver_register(dev->driver);
> +	device_bind_driver(dev);
> +}
> +
This is still not something you should be doing yourself, use
the platform_driver instead.

> +static int __devinit add_aicamixer_controls(struct snd_card_aica
> +					    *dreamcastcard)
> +{
> +	int err;
> +	err =3D snd_ctl_add
> +	    (dreamcastcard->card,
> +	     snd_ctl_new1(&snd_aica_pcmvolume_control, dreamcastcard));

More mangled whitespace. indent may have been responsible for it, you're
still the one submitting the patch.

> +	return 0;
> +      freepcm:
> +      freedreamcast:

goto labels are still in bizzarely indented locations.

> +static void __exit aica_exit(void)
> +{
> +	struct device_driver *drv =3D (&pd->dev)->driver;
> +	flush_workqueue(aica_queue);
> +	destroy_workqueue(aica_queue);
> +	device_release_driver(&pd->dev);
> +	driver_unregister(drv);
> +	platform_device_unregister(pd);

Your driver model handling really needs to be reworked a bit..

> +	/* Kill any sound still playing and reset ARM7 to safe state */
> +	spu_init();

Perhaps spu_reset() is a bit more sensible of a name, spu_init() is a bit
non-sensical to call from an exit routine..

> diff -ruN a/linux-2.6.16.14/sound/sh/Kconfig b/linux-2.6.16.14/sound/sh/K=
config
> --- a/linux-2.6.16.14/sound/sh/Kconfig	1970-01-01 01:00:00.000000000 +0100
> +++ b/linux-2.6.16.14/sound/sh/Kconfig	2006-06-01 22:59:14.000000000 +0100
> @@ -0,0 +1,15 @@
> +menu "SH (Super-H) devices"
> +       depends on SND!=3Dn && SUPERH
> +
Please just use SuperH, it's not hyphenated, and it's more readable than
just SH.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEg/8O1K+teJFxZ9wRAo22AJ9WZsoy7YjhBgHYdRQjsFOIbFVNLACgghLp
MKu1ApfP1gzMt6zlt1Qz5L8=
=u2DA
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--


--===============1154212127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1154212127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1154212127==--
