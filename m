From: Aurelien BOUIN <a_bouin@yahoo.fr>
Subject: [[PATCH] ALSA: In Freescale ESAI driver xDxDC bits in
	xCCR registers is 5 bits width not 4
Date: Thu, 18 Dec 2014 15:31:21 +0100
Message-ID: <1418913081-14439-1-git-send-email-a_bouin@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm1-vm5.bullet.mail.ir2.yahoo.com
 (nm1-vm5.bullet.mail.ir2.yahoo.com [212.82.96.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EF5E2605E9
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 15:32:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, festevam@gmail.com, Aurelien BOUIN <a_bouin@yahoo.fr>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Aurelien BOUIN <a_bouin@yahoo.fr>

diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
index 91a550f..5e793bb 100644
--- a/sound/soc/fsl/fsl_esai.h
+++ b/sound/soc/fsl/fsl_esai.h
@@ -302,7 +302,7 @@
 #define ESAI_xCCR_xFP_MASK	(((1 << ESAI_xCCR_xFP_WIDTH) - 1) << ESAI_xCCR_xFP_SHIFT)
 #define ESAI_xCCR_xFP(v)	((((v) - 1) << ESAI_xCCR_xFP_SHIFT) & ESAI_xCCR_xFP_MASK)
 #define ESAI_xCCR_xDC_SHIFT     9
-#define ESAI_xCCR_xDC_WIDTH	4
+#define ESAI_xCCR_xDC_WIDTH	5
 #define ESAI_xCCR_xDC_MASK	(((1 << ESAI_xCCR_xDC_WIDTH) - 1) << ESAI_xCCR_xDC_SHIFT)
 #define ESAI_xCCR_xDC(v)	((((v) - 1) << ESAI_xCCR_xDC_SHIFT) & ESAI_xCCR_xDC_MASK)
 #define ESAI_xCCR_xPSR_SHIFT	8
-- 
1.9.1
