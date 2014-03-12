From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Fix use after free
Date: Wed, 12 Mar 2014 08:34:39 +0100
Message-ID: <1394609679-10045-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-106.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 167DD260859
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 08:34:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

Freeing the current list element while iterating over the list will cause a use
after free since the iterator function will still use the current element to
look up the next. Use list_for_each_safe() and remove the element from the list
before freeing it to avoid this.

Fixes: 1438c2f60b ("ASoC: Add a per component dai list")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f67cef4..dac616d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3928,11 +3928,12 @@ static inline char *fmt_multiple_name(struct device *dev,
  */
 static void snd_soc_unregister_dais(struct snd_soc_component *component)
 {
-	struct snd_soc_dai *dai;
+	struct snd_soc_dai *dai, *_dai;
 
-	list_for_each_entry(dai, &component->dai_list, list) {
+	list_for_each_entry_safe(dai, _dai, &component->dai_list, list) {
 		dev_dbg(component->dev, "ASoC: Unregistered DAI '%s'\n",
 			dai->name);
+		list_del(&dai->list);
 		kfree(dai->name);
 		kfree(dai);
 	}
-- 
1.8.0
