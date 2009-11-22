From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 06/12] imx-ssi sound driver
Date: Sat, 21 Nov 2009 20:12:34 -0600
Message-ID: <ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f211.google.com (mail-fx0-f211.google.com
	[209.85.220.211])
	by alsa0.perex.cz (Postfix) with ESMTP id C3CDB1037FE
	for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2009 03:12:35 +0100 (CET)
Received: by fxm3 with SMTP id 3so4924010fxm.4
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2009 18:12:34 -0800 (PST)
In-Reply-To: <1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 19, 2009 at 9:48 AM, Sascha Hauer <s.hauer@pengutronix.de> wrot=
e:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> =A0arch/arm/plat-mxc/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/plat-mxc/include/mach/ssi.h | =A0 17 +
> =A0arch/arm/plat-mxc/ssi-fiq.S =A0 =A0 =A0 =A0 =A0| =A0134 ++++
> =A0sound/soc/imx/devdma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 80 ++
> =A0sound/soc/imx/devdma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0sound/soc/imx/imx-ssi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| 1349 ++++++++++++=
++++++++++++++++++++++
> =A0sound/soc/imx/imx-ssi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 24 +

Why did you write a new SSI driver when there already is one in sound/soc/f=
sl?

-- =

Timur Tabi
Linux kernel developer at Freescale
