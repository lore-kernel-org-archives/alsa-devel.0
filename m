From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/12] ASoC: Create codec DAPM widgets before
	calling the codecs probe function
Date: Thu,  5 May 2011 16:59:09 +0200
Message-ID: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id 1B9CD103832
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

This allows to create DAPM routes depending on those widgets in the codecs probe
function.
This is helpful when supporting similar codecs with minor differences in the DAPM
routing with the same driver.

Something similar has already been done for cards in commit a841ebb9(ASoC: Create
card DAPM widgets early so they can be used in callbacks)

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 133edeb..a477e21 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1495,6 +1495,10 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	soc_init_codec_debugfs(codec);
 
+	if (driver->dapm_widgets)
+		snd_soc_dapm_new_controls(&codec->dapm, driver->dapm_widgets,
+					  driver->num_dapm_widgets);
+
 	if (driver->probe) {
 		ret = driver->probe(codec);
 		if (ret < 0) {
@@ -1508,9 +1512,6 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	if (driver->controls)
 		snd_soc_add_controls(codec, driver->controls,
 				     driver->num_controls);
-	if (driver->dapm_widgets)
-		snd_soc_dapm_new_controls(&codec->dapm, driver->dapm_widgets,
-					  driver->num_dapm_widgets);
 	if (driver->dapm_routes)
 		snd_soc_dapm_add_routes(&codec->dapm, driver->dapm_routes,
 					driver->num_dapm_routes);
-- 
1.7.2.5
