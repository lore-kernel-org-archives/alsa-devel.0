From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] atmel: set "channel A event" output to debug
Date: Tue, 8 Jun 2010 08:57:13 +0200
Message-ID: <AANLkTiktFx3HpskOEwcCLbH_8COD8-wXkXL1Suvy9SuR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CDA2510380F
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 08:57:15 +0200 (CEST)
Received: by gwaa18 with SMTP id a18so78646gwa.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2010 23:57:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sedji.gaouaou@atmel.com, nicolas.ferre@atmel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: b/sound/atmel/ac97c.c
===================================================================
--- a/sound/atmel/ac97c.c	2010-06-01 15:28:23.000000000 +0200
+++ b/sound/atmel/ac97c.c	2010-06-03 15:20:43.000000000 +0200
@@ -657,7 +657,7 @@
 	if (sr & AC97C_SR_CAEVT) {
 		struct snd_pcm_runtime *runtime;
 		int offset, next_period, block_size;
-		dev_info(&chip->pdev->dev, "channel A event%s%s%s%s%s%s\n",
+		dev_dbg(&chip->pdev->dev, "channel A event%s%s%s%s%s%s\n",
 				casr & AC97C_CSR_OVRUN   ? " OVRUN"   : "",
 				casr & AC97C_CSR_RXRDY   ? " RXRDY"   : "",
 				casr & AC97C_CSR_UNRUN   ? " UNRUN"   : "",
