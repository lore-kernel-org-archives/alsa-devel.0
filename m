From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl_esai: Fix incorrect xDC field width
	of xCCR registers
Date: Mon, 29 Dec 2014 16:13:51 -0800
Message-ID: <1419898431-11336-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f48.google.com (mail-yh0-f48.google.com
 [209.85.213.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D2F0026058F
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 01:14:27 +0100 (CET)
Received: by mail-yh0-f48.google.com with SMTP id i57so6853342yha.7
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 16:14:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, festevam@gmail.com, Xiubo.Lee@gmail.com, timur@tabi.org, linux-kernel@vger.kernel.org, a_bouin@yahoo.fr, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The xDC field should have 5 bit width according to Reference Manual.
Thus this patch fixes it.

Signed-off-by: Aurelien BOUIN <a_bouin@yahoo.fr>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

The patch was originally submitted by Aurelien BOUIN while in an
informal way. And he hasn't finished any re-submitting during the
past two weeks. Thus I create a new patch with his signed-off
included so as to fix the probelm as soon as possible, not sure
whether it's decent or not though.

--Nicolin

 sound/soc/fsl/fsl_esai.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
