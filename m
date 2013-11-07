From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] ALSA: cs4236: fix pnp_irq() error handling
Date: Thu, 7 Nov 2013 11:18:45 +0300
Message-ID: <20131107081845.GV21844@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 76843265483
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 09:18:54 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Bill Pemberton <wfp5p@virginia.edu>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

pnp_irq() returns an unsigned value so the error handling here doesn't
work.  I recently introduced a IORESOURCE_INVALID define to make this
less confusing.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This needs [patch 1/2] or it won't compile.  Can both patches go through
Andrew's tree?

diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 69614ac..9725843 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -293,7 +293,8 @@ static int snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev)
 	} else {
 		mpu_port[dev] = pnp_port_start(pdev, 0);
 		if (mpu_irq[dev] >= 0 &&
-		    pnp_irq_valid(pdev, 0) && pnp_irq(pdev, 0) >= 0) {
+		    pnp_irq_valid(pdev, 0) &&
+		    pnp_irq(pdev, 0) != IORESOURCE_INVALID) {
 			mpu_irq[dev] = pnp_irq(pdev, 0);
 		} else {
 			mpu_irq[dev] = -1;	/* disable interrupt */
