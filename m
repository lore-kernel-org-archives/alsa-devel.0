From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 1/1] ASoC: sti: fix compilation warnings
Date: Wed, 9 Sep 2015 19:04:46 +0200
Message-ID: <1441818286-31400-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id F33522604FA
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 19:04:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add check on of_property_read_string return to avoid compilation warning.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 32 +++++++++++++++++++-------------
 sound/soc/sti/uniperif_reader.c |  6 +++++-
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index f6eefe1..d90a3fb 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -989,8 +989,8 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	of_property_read_u32(pnode, "version", &player->ver);
-	if (player->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN) {
+	if ((of_property_read_u32(pnode, "version", &player->ver)) ||
+	    (player->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN)) {
 		dev_err(dev, "Unknown uniperipheral version ");
 		return -EINVAL;
 	}
@@ -998,19 +998,25 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	if (player->ver >= SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
 		info->underflow_enabled = 1;
 
-	of_property_read_u32(pnode, "uniperiph-id", &info->id);
+	if (of_property_read_u32(pnode, "uniperiph-id", &info->id)) {
+		dev_err(dev, "uniperipheral id not defined");
+		return -EINVAL;
+	}
 
 	/* Read the device mode property */
-	of_property_read_string(pnode, "mode", &mode);
-
-	if (strcasecmp(mode, "hdmi") == 0)
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_HDMI;
-	else if (strcasecmp(mode, "pcm") == 0)
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_PCM;
-	else if (strcasecmp(mode, "spdif") == 0)
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF;
-	else
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_NONE;
+	if (!of_property_read_string(pnode, "mode", &mode)) {
+		if (strcasecmp(mode, "hdmi") == 0)
+			info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_HDMI;
+		else if (strcasecmp(mode, "pcm") == 0)
+			info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_PCM;
+		else if (strcasecmp(mode, "spdif") == 0)
+			info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF;
+		else
+			info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_NONE;
+	} else {
+		dev_err(dev, "uniperipheral mode not defined");
+		return -EINVAL;
+	}
 
 	/* Save the info structure */
 	player->info = info;
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index c502626..7ddbd14 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -316,7 +316,11 @@ static int uni_reader_parse_dt(struct platform_device *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	of_property_read_u32(node, "version", &reader->ver);
+	if ((of_property_read_u32(node, "version", &reader->ver)) ||
+	    (reader->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN)) {
+		dev_err(&pdev->dev, "Unknown uniperipheral version ");
+		return -EINVAL;
+	}
 
 	/* Save the info structure */
 	reader->info = info;
-- 
1.9.1
