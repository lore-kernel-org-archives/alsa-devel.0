From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH 3/4] ASoC: Blackfin: ADAU1373 eval board
	support
Date: Wed, 10 Aug 2011 13:27:14 +0800
Message-ID: <CAHG8p1CuiJws=wSKrfAiY9E=rne=taPP-semYZQJWuHn19398w@mail.gmail.com>
References: <1312948364-2587-1-git-send-email-lars@metafoo.de>
	<1312948364-2587-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B2617244E7
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 07:27:15 +0200 (CEST)
Received: by qyk35 with SMTP id 35so471932qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 09 Aug 2011 22:27:14 -0700 (PDT)
In-Reply-To: <1312948364-2587-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> +config SND_SOC_BFIN_EVAL_ADAU1373
> + =A0 =A0 =A0 tristate "Support for the EVAL-ADAU1373 board on Blackfin e=
val boards"
> + =A0 =A0 =A0 depends on SND_BF5XX_I2S
> + =A0 =A0 =A0 select SND_BF5XX_SOC_I2S
> + =A0 =A0 =A0 select SND_SOC_ADAU1373
> + =A0 =A0 =A0 select I2C

Is it better to use depends on I2C?

> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y if you want to add support for the Analog Devices=
 EVAL-ADAU1373
> + =A0 =A0 =A0 =A0 board connected to one of the Blackfin evaluation board=
s like the
> + =A0 =A0 =A0 =A0 BF5XX-STAMP or BF5XX-EZKIT.
