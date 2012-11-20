From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 05/10] ASoC: kirkwood-i2s: more pause-mode fixes
Date: Tue, 20 Nov 2012 12:19:13 +0000
Message-ID: <E1TamnJ-0007XP-1S@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 7D309265370
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:19:15 +0100 (CET)
In-Reply-To: <20121120121726.GN3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Liam Girdwood <lrg@ti.com>, Rabeeh Khoury <rabeeh@solid-run.com>
List-Id: alsa-devel@alsa-project.org

Don't even momentarily set the pause status when starting the channel;
if we do, we should check the busy bit to ensure that we comply with
the spec.  In any case, it isn't necessary; we will not active on a
START event so there is no need to pause the DMA.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 826306d..1d5db48 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -205,10 +205,6 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		/* stop audio, enable interrupts */
-		ctl |= KIRKWOOD_PLAYCTL_PAUSE;
-		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
-
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
 		value |= KIRKWOOD_INT_CAUSE_PLAY_BYTES;
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
@@ -269,11 +265,6 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		/* stop audio, enable interrupts */
-		value = readl(priv->io + KIRKWOOD_RECCTL);
-		value |= KIRKWOOD_RECCTL_PAUSE;
-		writel(value, priv->io + KIRKWOOD_RECCTL);
-
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
 		value |= KIRKWOOD_INT_CAUSE_REC_BYTES;
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
-- 
1.7.4.4
