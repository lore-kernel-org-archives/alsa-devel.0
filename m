From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: soc-sst-bxt-rt298: fix obsoleted
	initializers for array
Date: Tue, 26 Jul 2016 22:41:54 +0900
Message-ID: <1469540517-32466-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id EA0ED268138
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 15:42:02 +0200 (CEST)
In-Reply-To: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

Sparse reports below warnings.

bxt_rt298.c:275:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:290:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:304:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:317:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:331:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:344:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:357:9: warning: obsolete array initializer, use C99 syntax

There's no need to use obsoleted way. This commit fixes it.

Fixed: 76016322ec56 ('ASoC: Intel: Add Broxton-P machine driver')
CC: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/intel/boards/bxt_rt298.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 253d7bf..d610bdc 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -271,7 +271,7 @@ static const struct snd_soc_ops broxton_rt286_fe_ops = {
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_rt298_dais[] = {
 	/* Front End DAI links */
-	[BXT_DPCM_AUDIO_PB]
+	[BXT_DPCM_AUDIO_PB] =
 	{
 		.name = "Bxt Audio Port",
 		.stream_name = "Audio",
@@ -286,7 +286,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &broxton_rt286_fe_ops,
 	},
-	[BXT_DPCM_AUDIO_CP]
+	[BXT_DPCM_AUDIO_CP] =
 	{
 		.name = "Bxt Audio Capture Port",
 		.stream_name = "Audio Record",
@@ -300,7 +300,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &broxton_rt286_fe_ops,
 	},
-	[BXT_DPCM_AUDIO_REF_CP]
+	[BXT_DPCM_AUDIO_REF_CP] =
 	{
 		.name = "Bxt Audio Reference cap",
 		.stream_name = "refcap",
@@ -313,7 +313,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	[BXT_DPCM_AUDIO_DMIC_CP]
+	[BXT_DPCM_AUDIO_DMIC_CP] =
 	{
 		.name = "Bxt Audio DMIC cap",
 		.stream_name = "dmiccap",
@@ -327,7 +327,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.dynamic = 1,
 		.ops = &broxton_dmic_ops,
 	},
-	[BXT_DPCM_AUDIO_HDMI1_PB]
+	[BXT_DPCM_AUDIO_HDMI1_PB] =
 	{
 		.name = "Bxt HDMI Port1",
 		.stream_name = "Hdmi1",
@@ -340,7 +340,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	[BXT_DPCM_AUDIO_HDMI2_PB]
+	[BXT_DPCM_AUDIO_HDMI2_PB] =
 	{
 		.name = "Bxt HDMI Port2",
 		.stream_name = "Hdmi2",
@@ -353,7 +353,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	[BXT_DPCM_AUDIO_HDMI3_PB]
+	[BXT_DPCM_AUDIO_HDMI3_PB] =
 	{
 		.name = "Bxt HDMI Port3",
 		.stream_name = "Hdmi3",
-- 
2.7.4
