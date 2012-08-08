From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: [PATCH] ASoC: Davinci: McASP: Flush the FIFO before
	enabling
Date: Wed, 8 Aug 2012 20:40:31 +0530
Message-ID: <1344438632-2604-2-git-send-email-gururaja.hebbar@ti.com>
References: <1344438632-2604-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 02683266250
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 16:55:17 +0200 (CEST)
In-Reply-To: <1344438632-2604-1-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tony@atomide.com, lrg@ti.com, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, gururaja.hebbar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

FIFO should be flushed before it is enabled for the first time.
This fixes the I/O errors reported by the ASoC core on a fresh boot

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
This patch was tested on AM18x Board and is based on repo at 
http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;
a=shortlog;h=refs/heads/for-3.6

:100644 100644 95441bf... ce5e5cd... M	sound/soc/davinci/davinci-mcasp.c
 sound/soc/davinci/davinci-mcasp.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 95441bf..ce5e5cd 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -380,14 +380,20 @@ static void mcasp_start_tx(struct davinci_audio_dev *dev)
 static void davinci_mcasp_start(struct davinci_audio_dev *dev, int stream)
 {
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (dev->txnumevt)	/* enable FIFO */
+		if (dev->txnumevt) {	/* enable FIFO */
+			mcasp_clr_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+								FIFO_ENABLE);
 			mcasp_set_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
 								FIFO_ENABLE);
+		}
 		mcasp_start_tx(dev);
 	} else {
-		if (dev->rxnumevt)	/* enable FIFO */
+		if (dev->rxnumevt) {	/* enable FIFO */
+			mcasp_clr_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+								FIFO_ENABLE);
 			mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
 								FIFO_ENABLE);
+		}
 		mcasp_start_rx(dev);
 	}
 }
-- 
1.7.1
