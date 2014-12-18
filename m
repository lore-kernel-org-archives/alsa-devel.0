From: Aurelien Bouin <a_bouin@yahoo.fr>
Subject: [PATCH v2] ASoC: fsl_esai: Fix ESAI_xCCR_xDC_WIDTH
 definition
Date: Thu, 18 Dec 2014 16:37:51 +0000 (UTC)
Message-ID: <302670613.333771.1418920671738.JavaMail.yahoo@jws11119.mail.ir2.yahoo.com>
Reply-To: Aurelien Bouin <a_bouin@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm19-vm3.bullet.mail.ir2.yahoo.com
 (nm19-vm3.bullet.mail.ir2.yahoo.com [212.82.96.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EE25261A0E
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 17:38:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "patch@alsa-project.org" <patch@alsa-project.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

>From 9bcae891b8fe7a42cbc2cd88319f7bd4ab44d012 Mon Sep 17 00:00:00 2001
From: Aurelien BOUIN <a_bouin@yahoo.fr>
Date: Thu, 18 Dec 2014 15:14:53 +0100
Subject: [PATCH 1/1] According to the mx6 reference manual the TDC and RDC
field of registers ESAI_TCCR and ESAI_RCCR have a width of 5 bits, not 4

Signed-off-by: Aurelien BOUIN <a_bouin@yahoo.fr>

diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
index 91a550f..5e793bb 100644
--- a/sound/soc/fsl/fsl_esai.h
+++ b/sound/soc/fsl/fsl_esai.h
@@ -302,7 +302,7 @@
#define ESAI_xCCR_xFP_MASK    (((1 << ESAI_xCCR_xFP_WIDTH) - 1) << ESAI_xCCR_xFP_SHIFT)
#define ESAI_xCCR_xFP(v)    ((((v) - 1) << ESAI_xCCR_xFP_SHIFT) & ESAI_xCCR_xFP_MASK)
#define ESAI_xCCR_xDC_SHIFT     9
-#define ESAI_xCCR_xDC_WIDTH    4
+#define ESAI_xCCR_xDC_WIDTH    5
#define ESAI_xCCR_xDC_MASK    (((1 << ESAI_xCCR_xDC_WIDTH) - 1) << ESAI_xCCR_xDC_SHIFT)
#define ESAI_xCCR_xDC(v)    ((((v) - 1) << ESAI_xCCR_xDC_SHIFT) & ESAI_xCCR_xDC_MASK)
#define ESAI_xCCR_xPSR_SHIFT    8
-- 
1.9.1
