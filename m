From: yegorslists@googlemail.com
Subject: [PATCH] davinci-mcasp: don't configure AFSX direction
	in DIT mode
Date: Fri,  1 Mar 2013 11:34:50 +0100
Message-ID: <1362134090-8751-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.visionsystems.de (ns.vscom.de [62.145.30.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 34A86265DE3
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 11:35:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mporter@ti.com, Yegor Yefremov <yegorslists@googlemail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Yegor Yefremov <yegorslists@googlemail.com>

AFSX won't be used in DIT mode. The related pins are AHCLKX and
the data pins.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 sound/soc/davinci/davinci-mcasp.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 9321e5c..90a9b99 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -772,9 +772,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 /* S/PDIF */
 static void davinci_hw_dit_param(struct davinci_audio_dev *dev)
 {
-	/* Set the PDIR for Serialiser as output */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG, AFSX);
-
 	/* TXMASK for 24 bits */
 	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0x00FFFFFF);
 
-- 
1.7.7
