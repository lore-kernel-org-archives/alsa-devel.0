From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/9] ASoC: Always run default suspend/resume
	code
Date: Thu,  4 Sep 2014 19:44:07 +0200
Message-ID: <1409852652-27939-5-git-send-email-lars@metafoo.de>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 323382656BE
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 19:44:43 +0200 (CEST)
In-Reply-To: <1409852652-27939-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

We do a bit more than just running the callbacks during suspend and resume
these days (e.g. call regcache_mark_dirty() during suspend). But this is
only when suspend and resume callbacks are specified for the driver,
otherwise nothing is done. This means that drivers which don't want to do
anything special during suspend and resume, but still want the standard
operations to run, need to provide empty suspend and resume callback
functions (rather than no callbacks). This patch updates the suspend and
resume code to always run standard sequence regardless of whether suspend
and resume handlers are provided.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e7c8b11..cf89325 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -637,7 +637,7 @@ int snd_soc_suspend(struct device *dev)
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
 		/* If there are paths active then the CODEC will be held with
 		 * bias _ON and should not be suspended. */
-		if (!codec->suspended && codec->driver->suspend) {
+		if (!codec->suspended) {
 			switch (codec->dapm.bias_level) {
 			case SND_SOC_BIAS_STANDBY:
 				/*
@@ -651,8 +651,10 @@ int snd_soc_suspend(struct device *dev)
 						"ASoC: idle_bias_off CODEC on over suspend\n");
 					break;
 				}
+
 			case SND_SOC_BIAS_OFF:
-				codec->driver->suspend(codec);
+				if (codec->driver->suspend)
+					codec->driver->suspend(codec);
 				codec->suspended = 1;
 				codec->cache_sync = 1;
 				if (codec->component.regmap)
@@ -726,11 +728,12 @@ static void soc_resume_deferred(struct work_struct *work)
 		 * left with bias OFF or STANDBY and suspended so we must now
 		 * resume.  Otherwise the suspend was suppressed.
 		 */
-		if (codec->driver->resume && codec->suspended) {
+		if (codec->suspended) {
 			switch (codec->dapm.bias_level) {
 			case SND_SOC_BIAS_STANDBY:
 			case SND_SOC_BIAS_OFF:
-				codec->driver->resume(codec);
+				if (codec->driver->resume)
+					codec->driver->resume(codec);
 				codec->suspended = 0;
 				break;
 			default:
-- 
1.8.0
