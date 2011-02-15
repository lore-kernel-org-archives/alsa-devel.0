From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 1/5] ASoC: sn95031: make playback rails depend
	on actual pins they control
Date: Tue, 15 Feb 2011 18:28:51 +0530
Message-ID: <1297774735-32184-2-git-send-email-vinod.koul@intel.com>
References: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B1CC103851
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 13:50:08 +0100 (CET)
In-Reply-To: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch makes the codec playback rails (headset and speaker) depend on
actual pins they control. This enables better power management of the codec

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/sn95031.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index d0b7802..9c3db0d 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -519,6 +519,8 @@ static const struct snd_soc_dapm_widget sn95031_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route sn95031_audio_map[] = {
 	/* headset and earpiece map */
+	{ "HPOUTL", NULL, "Headset Rail"},
+	{ "HPOUTR", NULL, "Headset Rail"},
 	{ "HPOUTL", NULL, "Headset Left Playback" },
 	{ "HPOUTR", NULL, "Headset Right Playback" },
 	{ "EPOUT", NULL, "Earpiece Playback" },
@@ -527,18 +529,16 @@ static const struct snd_soc_dapm_route sn95031_audio_map[] = {
 	{ "Earpiece Playback", NULL, "Headset Left Filter"},
 	{ "Headset Left Filter", NULL, "HSDAC Left"},
 	{ "Headset Right Filter", NULL, "HSDAC Right"},
-	{ "HSDAC Left", NULL, "Headset Rail"},
-	{ "HSDAC Right", NULL, "Headset Rail"},
 
 	/* speaker map */
+	{ "IHFOUTL", NULL, "Speaker Rail"},
+	{ "IHFOUTR", NULL, "Speaker Rail"},
 	{ "IHFOUTL", "NULL", "Speaker Left Playback"},
 	{ "IHFOUTR", "NULL", "Speaker Right Playback"},
 	{ "Speaker Left Playback", NULL, "Speaker Left Filter"},
 	{ "Speaker Right Playback", NULL, "Speaker Right Filter"},
 	{ "Speaker Left Filter", NULL, "IHFDAC Left"},
 	{ "Speaker Right Filter", NULL, "IHFDAC Right"},
-	{ "IHFDAC Left", NULL, "Speaker Rail"},
-	{ "IHFDAC Right", NULL, "Speaker Rail"},
 
 	/* vibra map */
 	{ "VIB1OUT", NULL, "Vibra1 Playback"},
-- 
1.7.2.3
