From: Matthias Reichl <hias@horus.com>
Subject: [PATCH] ASoC: core: Don't defer probe on optional,
	NULL components
Date: Tue, 15 Jan 2019 17:51:07 +0100
Message-ID: <20190115165107.5551-1-hias@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
 by alsa0.perex.cz (Postfix) with ESMTP id B106826743C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:51:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Ajit Pandey <ajitp@codeaurora.org>, Rohit kumar <rohitkr@codeaurora.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

cpu and platform are optional components in DAI links. For example
codec-codec links usually have no platform set.

Call snd_soc_find_component only if the name or of_node of
a cpu or platform is set. Otherwise it will return NULL and
soc_init_dai_link bails out immediately with -EPROBE_DEFER,
meaning registering a card with NULL cpu or platform in DAI links
can never succeed.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 sound/soc/soc-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b680c673c553..aae450ba4f08 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1135,7 +1135,8 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Defer card registartion if platform dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->platform->of_node, link->platform->name))
+	if ((link->platform->of_node || link->platform->name) &&
+	    !soc_find_component(link->platform->of_node, link->platform->name))
 		return -EPROBE_DEFER;
 
 	/*
@@ -1154,7 +1155,8 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Defer card registartion if cpu dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+	if ((link->cpu_of_node || link->cpu_name) &&
+	    !soc_find_component(link->cpu_of_node, link->cpu_name))
 		return -EPROBE_DEFER;
 
 	/*
-- 
2.19.2
