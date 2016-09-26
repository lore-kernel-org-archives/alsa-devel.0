From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 3/5] ASOC: sst-bxt-da7219_max98357a: fix
	obsoleted initializers for array
Date: Tue, 27 Sep 2016 07:45:09 +0900
Message-ID: <1474929911-6005-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1474929911-6005-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8B3DA266E2C
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 00:45:28 +0200 (CEST)
In-Reply-To: <1474929911-6005-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sparse reports below warnings.

bxt_da7219_max98357a.c:250:9: warning: obsolete array initializer, use C99 syntax
bxt_da7219_max98357a.c:275:9: warning: obsolete array initializer, use C99 syntax
bxt_da7219_max98357a.c:290:9: warning: obsolete array initializer, use C99 syntax
bxt_da7219_max98357a.c:304:9: warning: obsolete array initializer, use C99 syntax
bxt_da7219_max98357a.c:317:9: warning: obsolete array initializer, use C99 syntax

There's no need to use obsoleted way. This commit fixes it.

Fixes: 723bad3fef8b ("ASoC: Intel: Add Broxton-P Dialog Maxim machine driver")
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3774b11..49b65d4 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -255,7 +255,7 @@ static struct snd_soc_ops broxton_da7219_ops = {
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_dais[] = {
 	/* Front End DAI links */
-	[BXT_DPCM_AUDIO_PB]
+	[BXT_DPCM_AUDIO_PB] =
 	{
 		.name = "Bxt Audio Port",
 		.stream_name = "Audio",
@@ -271,7 +271,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &broxton_da7219_fe_ops,
 	},
-	[BXT_DPCM_AUDIO_CP]
+	[BXT_DPCM_AUDIO_CP] =
 	{
 		.name = "Bxt Audio Capture Port",
 		.stream_name = "Audio Record",
@@ -286,7 +286,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &broxton_da7219_fe_ops,
 	},
-	[BXT_DPCM_AUDIO_REF_CP]
+	[BXT_DPCM_AUDIO_REF_CP] =
 	{
 		.name = "Bxt Audio Reference cap",
 		.stream_name = "Refcap",
@@ -300,7 +300,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	[BXT_DPCM_AUDIO_HDMI1_PB]
+	[BXT_DPCM_AUDIO_HDMI1_PB] =
 	{
 		.name = "Bxt HDMI Port1",
 		.stream_name = "Hdmi1",
@@ -313,7 +313,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	[BXT_DPCM_AUDIO_HDMI2_PB]
+	[BXT_DPCM_AUDIO_HDMI2_PB] =
 	{
 		.name = "Bxt HDMI Port2",
 		.stream_name = "Hdmi2",
@@ -326,7 +326,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
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
