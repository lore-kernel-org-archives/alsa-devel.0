From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 7/7] ASoC: sh: FSI:: don't check platform_get_irq's return value against zero
Date: Wed, 16 Dec 2009 17:10:09 +0100
Message-ID: <1260979809-24811-7-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1260979809-24811-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934979AbZLPQMd@vger.kernel.org>
In-Reply-To: <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Vrabel <dvrabel@arcom.com>, Greg Kroah-Hartman <gregkh@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Paul Mundt <lethal@linux-sh.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

platform_get_irq returns -ENXIO on failure, so !irq was probably
always true.  Better use (int)irq <=3D 0.  Note that a return value of
zero is still handled as error even though this could mean irq0.

This is a followup to 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 that
changed the return value of platform_get_irq from 0 to -ENXIO on error.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: David Vrabel <dvrabel@arcom.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/sh/fsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 9c49c11..42813b8 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -876,7 +876,7 @@ static int fsi_probe(struct platform_device *pdev)
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq =3D platform_get_irq(pdev, 0);
-	if (!res || !irq) {
+	if (!res || (int)irq <=3D 0) {
 		dev_err(&pdev->dev, "Not enough FSI platform resources.\n");
 		ret =3D -ENODEV;
 		goto exit;
--=20
1.6.5.2
