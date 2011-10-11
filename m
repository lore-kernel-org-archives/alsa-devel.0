From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v3 0/3] ARM: mxs: add recording support for
	saif
Date: Tue, 11 Oct 2011 21:39:24 +0800
Message-ID: <CAA+hA=Sf=TKeQxLUAuExi9jTmFk=d653FdBjacD3jK7tPG88ew@mail.gmail.com>
References: <1317052353-6029-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ED5FB1038EB
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 15:39:28 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so6581488ggn.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 06:39:28 -0700 (PDT)
In-Reply-To: <1317052353-6029-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>, s.hauer@pengutronix.de, w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2011/9/26 Dong Aisheng <b29396@freescale.com>:
> Changes since v2:
> =A0* separate clkmux code into another patch according to Uwe
> =A0* add lock according to Wolfram
> =A0* Other minus fixes suggested by Uwe and Wolfram.
> =A0* remove Wolfram's fix saif clock setting patch which is in v2 series
> =A0 since Wolfram will reform the clock code and send it out himself.
> =A0 For test purpose, user still needs that patch. People can get it
> =A0 from v2 series.
> =A0 The patch is:
> =A0 [PATCH v2 3/3] arm: mxs: disable clock-gates when setting saif-clocks
>
> The patches are based on imx-features branch since commit:
> f4f01e31835f.
>
> Changes since v1:
> The main changes are move mach-specific code(clkmux in DIGCTL) from
> saif driver to mach-specific layer based on Wolfram's suggestion.
>
> Note that the last patch is a RFC patch and sent out for testing
> since without that patch the saif may not work.
>
> Dong Aisheng (3):
> =A0ARM: mxs: add saif clkmux functions
> =A0ARM: mx28evk: add platform data for saif
> =A0ARM: mx28evk: set a initial clock rate for saif

Any comments for this?

Regards
Dong Aisheng

> =A0arch/arm/mach-mxs/clock-mx28.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 67 +++++++++++++++++++++++
> =A0arch/arm/mach-mxs/devices-mx28.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A03 +-
> =A0arch/arm/mach-mxs/devices/platform-mxs-saif.c =A0 | =A0 =A05 +-
> =A0arch/arm/mach-mxs/include/mach/common.h =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0arch/arm/mach-mxs/include/mach/devices-common.h | =A0 =A04 +-
> =A0arch/arm/mach-mxs/include/mach/digctl.h =A0 =A0 =A0 =A0 | =A0 21 +++++=
++
> =A0arch/arm/mach-mxs/mach-mx28evk.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
16 +++++-
> =A07 files changed, 112 insertions(+), 6 deletions(-)
> =A0create mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
