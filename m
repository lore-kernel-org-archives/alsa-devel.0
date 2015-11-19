From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 2/4] ASoC: sti: rename ST proprietary DT
	properties
Date: Thu, 19 Nov 2015 14:54:08 +0100
Message-ID: <1447941250-344-3-git-send-email-moise.gergaud@st.com>
References: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 1146E261552
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 14:54:28 +0100 (CET)
In-Reply-To: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
Cc: Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

"st," prefix has been added for ST proprietary DT properties.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 6 +++---
 sound/soc/sti/uniperif_reader.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 843f037..1e19a7c 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -989,7 +989,7 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	if (of_property_read_u32(pnode, "version", &player->ver) ||
+	if (of_property_read_u32(pnode, "st,version", &player->ver) ||
 	    player->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN) {
 		dev_err(dev, "Unknown uniperipheral version ");
 		return -EINVAL;
@@ -998,13 +998,13 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	if (player->ver >= SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
 		info->underflow_enabled = 1;
 
-	if (of_property_read_u32(pnode, "uniperiph-id", &info->id)) {
+	if (of_property_read_u32(pnode, "st,uniperiph-id", &info->id)) {
 		dev_err(dev, "uniperipheral id not defined");
 		return -EINVAL;
 	}
 
 	/* Read the device mode property */
-	if (of_property_read_string(pnode, "mode", &mode)) {
+	if (of_property_read_string(pnode, "st,mode", &mode)) {
 		dev_err(dev, "uniperipheral mode not defined");
 		return -EINVAL;
 	}
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 819eeaf..8a0eb20 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -316,7 +316,7 @@ static int uni_reader_parse_dt(struct platform_device *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	if (of_property_read_u32(node, "version", &reader->ver) ||
+	if (of_property_read_u32(node, "st,version", &reader->ver) ||
 	    reader->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN) {
 		dev_err(&pdev->dev, "Unknown uniperipheral version ");
 		return -EINVAL;
-- 
1.9.1
