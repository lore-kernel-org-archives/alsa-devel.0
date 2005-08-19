From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Compulab sound device
Date: Fri, 19 Aug 2005 06:51:08 -0700 (PDT)
Message-ID: <20050819135108.3863.qmail@web54606.mail.yahoo.com>
References: <1124457861.2861.251.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1124457861.2861.251.camel@cearnarfon>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> You might want to back port from ALSA kernel CVS as
> this has some
> updates to pxa2xx-ac97.c for PM and ac97 warm
> resets.=20

Ok. I will to do that.


>=20
> Has sound/pci/ac97/ac97_codec.c and
> sound/arm/pxa2xx-pcm.c been built ?
> They are both required form pxa2xx ac97 audio.=20

yes they have been built.=20
[crc088@ linux-2.6.7]$ ls sound/arm/
built-in.o     Makefile.rej   pxa2xx-pcm.o         =20
snd-pxa2xx-ac97.o
Kconfig        pxa2xx-ac97.c  sa11xx-uda1341.c     =20
snd-pxa2xx-pcm.ko
Kconfig.orig   pxa2xx-ac97.o  snd-pxa2xx-ac97.ko   =20
snd-pxa2xx-pcm.mod.c
Makefile       pxa2xx-pcm.c   snd-pxa2xx-ac97.mod.c=20
snd-pxa2xx-pcm.mod.o
Makefile.orig  pxa2xx-pcm.h   snd-pxa2xx-ac97.mod.o=20
snd-pxa2xx-pcm.o

[crc088@ linux-2.6.7]$ ls sound/pci/ac97/
ac97_codec.c               .ac97_pcm.o.cmd
ac97_codec.c.orig          ac97_proc.c
ac97_codec.c.rej           ac97_proc.o
ac97_codec.o               .ac97_proc.o.cmd
.ac97_codec.o.cmd          ak4531_codec.c
ac97_id.h                  built-in.o
ac97_local.h               .built-in.o.cmd
ac97_patch.c               Makefile
ac97_patch.c.orig          snd-ac97-codec.ko
ac97_patch.c.rej           .snd-ac97-codec.ko.cmd
ac97_patch.h               snd-ac97-codec.mod.c
ac97_patch.o               snd-ac97-codec.mod.o
.ac97_patch.o.cmd          .snd-ac97-codec.mod.o.cmd
ac97_pcm.c                 snd-ac97-codec.o
ac97_pcm.o                 .snd-ac97-codec.o.cmd



> This means that snd-pxa2xx-pcm.ko has not been
> inserted. It's built from
> pxa2xx-pcm.c

I cant even insmod snd-pxa2xx-pcm. It gives me the
following error.=20

[root@ARMCore sound1]$ insmod snd-pxa2xx-pcm.ko
snd_pxa2xx_pcm: Unknown symbol dma_mmap_writecombine
insmod: error inserting 'snd-pxa2xx-pcm.ko': -1
Unknown symbol in module
=20
=20
> This relates to sound/arm/pxa2xx-ac97.c
>=20
> You should have the following rules in
> sound/arm/Makefile:-
>=20
> snd-pxa2xx-pcm-objs :=3D pxa2xx-pcm.o
> snd-pxa2xx-ac97-objs :=3D pxa2xx-ac97.o
>=20
> obj-$(CONFIG_SND_PXA2xx_PCM) +=3D snd-pxa2xx-pcm.o
> obj-$(CONFIG_SND_PXA2xx_AC97) +=3D snd-pxa2xx-ac97.o
>=20
> and the following options in sound/arm/Kconfig
>=20
> config SND_PXA2xx_AC97
> 	tristate "AC97 driver for the Intel PXA2xx chip"
> 	depends on ARCH_PXA && SND
> 	select SND_PXA2xx_PCM
> 	select SND_AC97_CODEC
> 	help
> 	  Say Y or M if you want to support any AC97 codec
> attached to
> 	  the PXA2xx AC97 interface.
>=20
> config SND_PXA2xx_PCM
> 	tristate
> 	select SND_PCM
> 	help
> 	  Generic PCM module for PXA2xx
>=20
I really got all those above in Makefile and Kconfig.
Serious, I have checked a thousand times before make
modules modules_install.

Regards,
Raymond

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
