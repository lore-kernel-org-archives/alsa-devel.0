From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH V2 1/1] ASoC: sti: check return of
	of_property_read
Date: Thu, 10 Sep 2015 09:45:55 +0200
Message-ID: <1441871155-18240-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 97858260502
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 09:52:48 +0200 (CEST)
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

Add check on of_property_read to return error when
DT required property is not defined.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 14 ++++++++++----
 sound/soc/sti/uniperif_reader.c |  6 +++++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index f6eefe1..843f037 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -989,8 +989,8 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	of_property_read_u32(pnode, "version", &player->ver);
-	if (player->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN) {
+	if (of_property_read_u32(pnode, "version", &player->ver) ||
+	    player->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN) {
 		dev_err(dev, "Unknown uniperipheral version ");
 		return -EINVAL;
 	}
@@ -998,10 +998,16 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	if (player->ver >= SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
 		info->underflow_enabled = 1;
 
-	of_property_read_u32(pnode, "uniperiph-id", &info->id);
+	if (of_property_read_u32(pnode, "uniperiph-id", &info->id)) {
+		dev_err(dev, "uniperipheral id not defined");
+		return -EINVAL;
+	}
 
 	/* Read the device mode property */
-	of_property_read_string(pnode, "mode", &mode);
+	if (of_property_read_string(pnode, "mode", &mode)) {
+		dev_err(dev, "uniperipheral mode not defined");
+		return -EINVAL;
+	}
 
 	if (strcasecmp(mode, "hdmi") == 0)
 		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_HDMI;
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index c502626..f791239 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -316,7 +316,11 @@ static int uni_reader_parse_dt(struct platform_device *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	of_property_read_u32(node, "version", &reader->ver);
+	if (of_property_read_u32(node, "version", &reader->ver) ||
+	    reader->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN) {
+		dev_err(&pdev->dev, "Unknown uniperipheral version ");
+		return -EINVAL;
+	}
 
 	/* Save the info structure */
 	reader->info = info;
-- 
1.9.1
