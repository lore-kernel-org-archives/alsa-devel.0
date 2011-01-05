From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use reg_def_copy
 instead of reg_cache_default
Date: Wed, 5 Jan 2011 15:04:31 -0600
Message-ID: <AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id BF699243BD
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 22:05:14 +0100 (CET)
Received: by fxm5 with SMTP id 5so14804414fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 13:05:11 -0800 (PST)
In-Reply-To: <1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 2, 2010 at 10:11 AM, Dimitris Papastamos
<dp@opensource.wolfsonmicro.com> wrote:
> Make sure to use codec->reg_def_copy instead of codec_drv->reg_cache_defa=
ult
> wherever necessary. =A0This change is necessary because in the next patch=
 we
> move the cache initialization code outside snd_soc_register_codec() and b=
y that
> time any data marked as __devinitconst such as the original reg_cache_def=
ault
> array might have already been freed by the kernel.

This commit breaks cs4270.c:

Cirrus Logic CS4270 ALSA SoC Codec Driver
cs4270-codec 0-004f: found device at i2c address 4F
cs4270-codec 0-004f: hardware revision 3
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc001646c
Oops: Kernel access of bad area, sig: 11 [#1]
MPC86xx HPCD
last sysfs file:
Modules linked in:
NIP: c001646c LR: c006cef8 CTR: 00000001
REGS: ef03dd20 TRAP: 0300   Not tainted  (2.6.37-rc3-02080-g8e7bd55)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22044028  XER: 20000000
DAR: 00000000, DSISR: 40000000
TASK =3D ef038000[1] 'swapper' THREAD: ef03c000
GPR00: 00000000 ef03ddd0 ef038000 ef2bb9e0 fffffffc 00000008 ef2bb9dc 00000=
001
GPR08: 2e302d30 00000000 fffffffe 00000006 22044082 100a38d4 00000000 3ffe7=
388
GPR16: 00000000 3f9a6378 00000000 3ffe6210 3ffe6210 3ffe6210 00000000 00000=
000
GPR24: c03c0560 ef03de20 c043c968 ef03de00 ef3da220 00000000 ef2bb9e0 00000=
008
NIP [c001646c] memcpy+0x1c/0x9c
LR [c006cef8] kmemdup+0x3c/0x54
Call Trace:
[ef03ddd0] [c006cee4] kmemdup+0x28/0x54 (unreliable)
[ef03ddf0] [c0250664] snd_soc_register_codec+0x278/0x390
[ef03de70] [c0256514] cs4270_i2c_probe+0xb0/0x178
[ef03de90] [c021c8a8] i2c_device_probe+0xec/0x114
[ef03deb0] [c01af400] driver_probe_device+0xa0/0x1a8
[ef03ded0] [c01af5c4] __driver_attach+0xbc/0xc0
[ef03def0] [c01aea90] bus_for_each_dev+0x70/0xac
[ef03df20] [c01af20c] driver_attach+0x24/0x34
[ef03df30] [c01ae314] bus_add_driver+0x1b8/0x298
[ef03df60] [c01af928] driver_register+0x88/0x158
[ef03df80] [c021cd38] i2c_register_driver+0x4c/0xa4
[ef03dfa0] [c040fffc] cs4270_init+0x2c/0x3c
[ef03dfb0] [c0003f6c] do_one_initcall+0x15c/0x1c4
[ef03dfe0] [c03f31e0] kernel_init+0xc0/0x164
[ef03dff0] [c001086c] kernel_thread+0x4c/0x68
Instruction dump:
38c60001 4200fff0 4e800020 7c032040 418100a0 54a7e8ff 38c3fffc 3884fffc
41820028 70c00003 7ce903a6 40820054 <80e40004> 85040008 90e60004 95060008
---[ end trace 40d01772bfab46f2 ]---
Kernel panic - not syncing: Attempted to kill init!

Which is this line:

> @@ -3463,6 +3464,19 @@ int snd_soc_register_codec(struct device *dev,
>
> =A0 =A0 =A0 =A0/* allocate CODEC register cache */
> =A0 =A0 =A0 =A0if (codec_drv->reg_cache_size && codec_drv->reg_word_size)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_size =3D codec_drv->reg_cache_size * co=
dec_drv->reg_word_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* it is necessary to make a copy of the de=
fault register cache
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* because in the case of using a compres=
sion type that requires
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the default register cache to be marke=
d as __devinitconst the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* kernel might have freed the array by t=
he time we initialize
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the cache.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 codec->reg_def_copy =3D kmemdup(codec_drv->=
reg_cache_default,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 reg_size, GFP_KERNEL);

Unlike all the other codec drivers, the CS4270 driver does not
initialize codec_drv->reg_cache_default, so the pointer is NULL during
the kmemdup() call.

What is the criteria for defining reg_cache_default?  Many drivers
don't define it:

$ grep -c reg_cache_default *.c | grep \:0
88pm860x-codec.c:0
ac97.c:0
ad1836.c:0
ad73311.c:0
ads117x.c:0
ak4104.c:0
alc5623.c:0
cq93vc.c:0
cs4270.c:0
cs42l51.c:0
cx20442.c:0
l3.c:0
max9877.c:0
pcm3008.c:0
spdif_transciever.c:0
tlv320aic26.c:0
tpa6130a2.c:0
wl1273.c:0
wm2000.c:0
wm8350.c:0
wm8400.c:0
wm8727.c:0
wm8994-tables.c:0
wm_hubs.c:0

-- =

Timur Tabi
Linux kernel developer at Freescale
