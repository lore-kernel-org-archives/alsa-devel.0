From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 5/5] snd-ice1712: Fix resume on ice1724
Date: Thu, 20 Sep 2012 20:37:55 +0200
Message-ID: <1348166275-13203-6-git-send-email-linux@rainbow-software.org>
References: <1348166275-13203-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 773D6265B8D
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 20:39:07 +0200 (CEST)
In-Reply-To: <1348166275-13203-1-git-send-email-linux@rainbow-software.org>
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
Cc: broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

set_pro_rate() is called from hw_params() but not from prepare(), breaking running PCM on suspend/resume.
Call it from prepare() if PCM was suspended to fix the problem.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/ice1712/ice1724.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 0eb7ec6..ade3354 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -783,6 +783,13 @@ static int snd_vt1724_playback_pro_prepare(struct snd_pcm_substream *substream)
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	unsigned char val;
 	unsigned int size;
+	int err;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_SUSPENDED) {
+		err = snd_vt1724_set_pro_rate(ice, substream->runtime->rate, 0);
+		if (err < 0)
+			return err;
+	}
 
 	spin_lock_irq(&ice->reg_lock);
 	val = (8 - substream->runtime->channels) >> 1;
@@ -853,6 +860,13 @@ static int snd_vt1724_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	const struct vt1724_pcm_reg *reg = substream->runtime->private_data;
+	int err;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_SUSPENDED) {
+		err = snd_vt1724_set_pro_rate(ice, substream->runtime->rate, 0);
+		if (err < 0)
+			return err;
+	}
 
 	spin_lock_irq(&ice->reg_lock);
 	outl(substream->runtime->dma_addr, ice->profi_port + reg->addr);
-- 
Ondrej Zary
