From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC v2] Add checks for codec DAI number
	during match-up
Date: Thu, 12 Jun 2008 19:01:34 -0500
Message-ID: <1213315294-30548-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 2292E2436F
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 02:01:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lg@opensource.wolfsonmicro.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Update the Codec DAI matching scheme to take the DAI number into account, and
not just the name.  This is necessary for systems with multiple codecs that
use the Codec ID number to differentiate them.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/soc-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a88e3a0..cc543e6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -801,6 +801,7 @@ codec_dai:
 	/* yes, then check the codec_dai list */
 	list_for_each_entry(codec_dai, &codec_dai_list, list) {
 		if (!strcmp(config->codec_dai, codec_dai->name) &&
+		    (codec_dai->id == config->codec_num) &&
 		    try_module_get(codec_dai->dev->driver->owner)) {
 			dbg("ASoC %s %s: Match for %s %s\n",
 			    soc_card->name, config->name,
@@ -1767,6 +1768,7 @@ struct snd_soc_dai *snd_soc_register_codec_dai(
 	dai->playback = template->playback;
 	dai->capture = template->capture;
 	dai->name = template->name;
+	dai->id = template->id;
 	dai->ac97_control = template->ac97_control;
 	mutex_lock(&client_mutex);
 	list_add(&dai->list, &codec_dai_list);
-- 
1.5.5
