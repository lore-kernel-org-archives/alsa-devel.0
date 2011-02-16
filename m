From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH v3] ASoC: Add Freescale SGTL5000 codec
	support
Date: Wed, 16 Feb 2011 16:20:37 -0600
Message-ID: <AANLkTi=xvpWqnChvyJvDVjCK8dH3rfd75e0c43x8a1JP@mail.gmail.com>
References: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 40B13103870
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 23:21:18 +0100 (CET)
Received: by fxm5 with SMTP id 5so1862168fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 14:21:17 -0800 (PST)
In-Reply-To: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhaoming.zeng@freescale.com
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, zengzm.kernel@gmail.com, linuxzsc@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 15, 2011 at 4:56 PM,  <zhaoming.zeng@freescale.com> wrote:
> From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
>
> Add Freescale SGTL5000 codec support

Please provide a description of this part.  What is it, what features
does it have, etc.

> @@ -176,6 +177,9 @@ config SND_SOC_MAX98088
> =A0config SND_SOC_PCM3008
> =A0 =A0 =A0 =A0tristate
>
> +config SND_SOC_SGTL5000
> + =A0 =A0 =A0 tristate
> +

Please provide some kind of descriptive text here.

> + =A0 =A0 =A0 l =3D l < 0x3c ? 0x3c : l;
> + =A0 =A0 =A0 l =3D l > 0xfc ? 0xfc : l;
> + =A0 =A0 =A0 r =3D r < 0x3c ? 0x3c : r;
> + =A0 =A0 =A0 r =3D r > 0xfc ? 0xfc : r;

Use the clamp() macro instead.

> +
> + =A0 =A0 =A0 /* revert it */
> + =A0 =A0 =A0 l =3D 0xfc - l;
> + =A0 =A0 =A0 r =3D 0xfc - r;

I think you mean "invert it".  "revert" means to undo a change.

> + =A0 =A0 =A0 if (mute)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, SGTL5000_CHIP_AD=
CDAC_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adcdac_ctrl=
, adcdac_ctrl);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, SGTL5000_CHIP_AD=
CDAC_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adcdac_ctrl=
, 0);

How about:

snd_soc_update_bits(codec, SGTL5000_CHIP_ADCDAC_CTRL, adcdac_ctrl,
mute ? adcdac_ctrl : 0);

> +static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t st=
ate)
> +{
> + =A0 =A0 =A0 sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> + =A0 =A0 =A0 return 0;
> +}

#ifdef CONFIG_PM ?


> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* copy DAP default values to default value array.
> + =A0 =A0 =A0 =A0* sgtl5000 register space has a big hole, merge it
> + =A0 =A0 =A0 =A0* at init phase makes life easy.
> + =A0 =A0 =A0 =A0* FIXME: should we drop 'const' of sgtl5000_regs?
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 memcpy((void *)(&sgtl5000_regs[0] + (SGTL5000_DAP_REG_OFFSE=
T >> 1)),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgtl5000_dap_regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3a);

I don't think you need the "(void *)"

And what is 0x3a?

> +MODULE_DESCRIPTION("ASoC sgtl5000 driver");
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");

Please consider putting your name here, so that people know who the
real author is.

> diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
> new file mode 100644
> index 0000000..7f24655
> --- /dev/null
> +++ b/sound/soc/codecs/sgtl5000.h
> @@ -0,0 +1,403 @@
> +/*
> + * sgtl5000.h - SGTL5000 audio codec interface

This whole file should probably be merged into sgtl5000.c, since that
file is the only file that #includes sgtl5000.h.  No point in having a
header file that is only included by one other file.

> + *
> + * Copyright 2008-2009 Freescale Semiconductor, Inc.

So the header file is copyright 2009, but the source file is copyright 2011?

> + *
> + * =A0This program is free software; you can redistribute =A0it and/or m=
odify it
> + * =A0under =A0the terms of =A0the GNU General =A0Public License as publ=
ished by the
> + * =A0Free Software Foundation; =A0either version 2 of the =A0License, o=
r (at your
> + * =A0option) any later version.

Also, the header file is "GPL v2 or later", but the source file is
"GPL v2 only".  Pick one or the other, but don't use both.  I'm
surprised your patch was approved by the PPP legal review.

-- =

Timur Tabi
Linux kernel developer at Freescale
