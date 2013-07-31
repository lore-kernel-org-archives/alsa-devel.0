From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: No need to use strncmp()
Date: Wed, 31 Jul 2013 09:44:13 +0100
Message-ID: <1375260253-23376-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 540E92610B1
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 10:49:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d68a486..9f60894 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2309,7 +2309,7 @@ struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 		return NULL;
 
 	list_for_each_entry(kctl, &card->controls, list)
-		if (!strncmp(kctl->id.name, name, sizeof(kctl->id.name)))
+		if (!strcmp(kctl->id.name, name))
 			return kctl;
 	return NULL;
 }
@@ -3056,7 +3056,7 @@ int snd_soc_limit_volume(struct snd_soc_codec *codec,
 		return -EINVAL;
 
 	list_for_each_entry(kctl, &card->controls, list) {
-		if (!strncmp(kctl->id.name, name, sizeof(kctl->id.name))) {
+		if (!strcmp(kctl->id.name, name)) {
 			found = 1;
 			break;
 		}
-- 
1.8.3.4
