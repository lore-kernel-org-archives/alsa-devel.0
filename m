From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: check return of of_property_read"
	to the asoc tree
Date: Thu, 10 Sep 2015 11:49:52 +0100
Message-ID: <E1ZZzQO-00010a-Mv@finisterre>
References: <1441871155-18240-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CA4A2614D3
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 12:50:05 +0200 (CEST)
In-Reply-To: <1441871155-18240-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: check return of of_property_read

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3a0e27d84bb9abac5e39dc71706768a88c72cb71 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Thu, 10 Sep 2015 09:45:55 +0200
Subject: [PATCH] ASoC: sti: check return of of_property_read

Add check on of_property_read to return error when
DT required property is not defined.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.5.0
