From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] ASoC: txx9aclc: dynamically allocate dmaengine
	devname
Date: Thu, 25 Jun 2009 22:36:58 +0900
Message-ID: <1245937018-4830-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 981F710386B
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 15:37:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use kasprintf to allocate temporary devname string instead of a
fixed size string.
This fixes "FIXME" introduced on removal of BUS_ID_SIZE.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 sound/soc/txx9/txx9aclc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 938a58a..efed64b 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -297,15 +297,17 @@ static int txx9aclc_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 static bool filter(struct dma_chan *chan, void *param)
 {
 	struct txx9aclc_dmadata *dmadata = param;
-	char devname[20 + 2]; /* FIXME: old BUS_ID_SIZE + 2 */
+	char *devname;
+	bool found = false;
 
-	snprintf(devname, sizeof(devname), "%s.%d", dmadata->dma_res->name,
+	devname = kasprintf(GFP_KERNEL, "%s.%d", dmadata->dma_res->name,
 		(int)dmadata->dma_res->start);
 	if (strcmp(dev_name(chan->device->dev), devname) == 0) {
 		chan->private = &dmadata->dma_slave;
-		return true;
+		found = true;
 	}
-	return false;
+	kfree(devname);
+	return found;
 }
 
 static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
-- 
1.5.6.5
