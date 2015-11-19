From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: rename ST proprietary DT
	properties" to the asoc tree
Date: Thu, 19 Nov 2015 19:56:42 +0000
Message-ID: <E1ZzVJy-0006TX-P7@debutante>
References: <1447941250-344-3-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48D3F26153C
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 20:56:53 +0100 (CET)
In-Reply-To: <1447941250-344-3-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: rename ST proprietary DT properties

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

>From f9f51973d3a8559731a228e91ac29792b43046a5 Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 19 Nov 2015 14:54:08 +0100
Subject: [PATCH] ASoC: sti: rename ST proprietary DT properties

"st," prefix has been added for ST proprietary DT properties.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 6 +++---
 sound/soc/sti/uniperif_reader.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 843f037a317d..1e19a7c6b7e8 100644
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
index 819eeafdf6b4..8a0eb2050169 100644
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
2.6.2
