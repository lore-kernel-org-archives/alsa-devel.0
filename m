From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 1/4] ALSA: core: use dev_to_snd_card
Date: Mon, 28 Dec 2015 22:47:10 +0800
Message-ID: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m50-138.163.com (m50-138.163.com [123.125.50.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 542D92652B0
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2015 15:47:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc: Geliang Tang <geliangtang@163.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use dev_to_snd_card() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 sound/core/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 20f37fb..fcb84e1 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -639,7 +639,7 @@ static ssize_t
 card_id_show_attr(struct device *dev,
 		  struct device_attribute *attr, char *buf)
 {
-	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
+	struct snd_card *card = dev_to_snd_card(dev);
 	return snprintf(buf, PAGE_SIZE, "%s\n", card->id);
 }
 
@@ -647,7 +647,7 @@ static ssize_t
 card_id_store_attr(struct device *dev, struct device_attribute *attr,
 		   const char *buf, size_t count)
 {
-	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
+	struct snd_card *card = dev_to_snd_card(dev);
 	char buf1[sizeof(card->id)];
 	size_t copy = count > sizeof(card->id) - 1 ?
 					sizeof(card->id) - 1 : count;
@@ -679,7 +679,7 @@ static ssize_t
 card_number_show_attr(struct device *dev,
 		     struct device_attribute *attr, char *buf)
 {
-	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
+	struct snd_card *card = dev_to_snd_card(dev);
 	return snprintf(buf, PAGE_SIZE, "%i\n", card->number);
 }
 
-- 
2.5.0
