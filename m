From: Ondrej Zary <linux@rainbow-software.org>
Subject: cmi8330: fix MPU-401 PnP init copy&paste bug
Date: Sat, 27 Jun 2009 16:17:08 +0200
Message-ID: <200906271617.09778.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail.atlantis.sk [80.94.52.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 93778246F1
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 16:17:19 +0200 (CEST)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Fix copy&paste bug in PnP MPU-401 initialization.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.30-orig/sound/isa/cmi8330.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-test/sound/isa/cmi8330.c	2009-06-27 13:37:56.000000000 +0200
@@ -338,7 +338,7 @@
 		return -EBUSY;
 
 	acard->mpu = pnp_request_card_device(card, id->devs[2].id, NULL);
-	if (acard->play == NULL)
+	if (acard->mpu == NULL)
 		return -EBUSY;
 
 	pdev = acard->cap;

-- 
Ondrej Zary
