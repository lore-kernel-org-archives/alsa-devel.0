From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/3] ASoC: dapm:
	dapm_dai_get_connected_widgets: Fix missing mutex unlock
Date: Tue, 11 Aug 2015 21:37:59 +0200
Message-ID: <1439321881-29476-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-194.synserver.de (smtp-out-194.synserver.de
 [212.40.185.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EE4C26056B
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 21:38:06 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Make sure to unlock the DAPM mutex when dapm_widget_list_create() fails.

This means the function will now generate a trace_snd_soc_dapm_connected
event, even if the creation of the list fails. But that was the behavior
before the patch that introduced the unlock issue, so that should be fine.

Fixes: 1ce43acff0c0 ("ASoC: dapm: Simplify list creation in dapm_dai_get_connected_widgets()")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
New in v2
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7482c5d..c391bfe 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1191,7 +1191,7 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 
 	ret = dapm_widget_list_create(list, &widgets);
 	if (ret)
-		return ret;
+		paths = ret;
 
 	trace_snd_soc_dapm_connected(paths, stream);
 	mutex_unlock(&card->dapm_mutex);
-- 
2.1.4
