From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: rename unip player type into
	common player & reader type" to the asoc tree
Date: Tue, 12 Apr 2016 03:01:03 +0100
Message-ID: <E1apndX-0002Ki-0c@debutante>
References: <1460021136-27822-3-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 47E2B265335
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 04:01:08 +0200 (CEST)
In-Reply-To: <1460021136-27822-3-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: rename unip player type into common player & reader type

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

>From 5295a0dc31d5261ff64406ece25e8d9e91530d2e Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 7 Apr 2016 11:25:31 +0200
Subject: [PATCH] ASoC: sti: rename unip player type into common player &
 reader type

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif.h        | 19 ++++++++++++++-----
 sound/soc/sti/uniperif_player.c | 31 +++++++++++--------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 400788bc9190..75116ab3cbc0 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1219,6 +1219,15 @@
 #define UNIPERIF_FIFO_SIZE		70 /* FIFO is 70 cells deep */
 #define UNIPERIF_FIFO_FRAMES		4  /* FDMA trigger limit in frames */
 
+#define UNIPERIF_TYPE_IS_HDMI(p) \
+	((p)->info->type == SND_ST_UNIPERIF_TYPE_HDMI)
+#define UNIPERIF_TYPE_IS_PCM(p) \
+	((p)->info->type == SND_ST_UNIPERIF_TYPE_PCM)
+#define UNIPERIF_TYPE_IS_SPDIF(p) \
+	((p)->info->type == SND_ST_UNIPERIF_TYPE_SPDIF)
+#define UNIPERIF_TYPE_IS_IEC958(p) \
+	(UNIPERIF_TYPE_IS_HDMI(p) || \
+		UNIPERIF_TYPE_IS_SPDIF(p))
 /*
  * Uniperipheral IP revisions
  */
@@ -1237,10 +1246,10 @@ enum uniperif_version {
 };
 
 enum uniperif_type {
-	SND_ST_UNIPERIF_PLAYER_TYPE_NONE,
-	SND_ST_UNIPERIF_PLAYER_TYPE_HDMI,
-	SND_ST_UNIPERIF_PLAYER_TYPE_PCM,
-	SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF
+	SND_ST_UNIPERIF_TYPE_NONE,
+	SND_ST_UNIPERIF_TYPE_HDMI,
+	SND_ST_UNIPERIF_TYPE_PCM,
+	SND_ST_UNIPERIF_TYPE_SPDIF
 };
 
 enum uniperif_state {
@@ -1259,7 +1268,7 @@ enum uniperif_iec958_encoding_mode {
 
 struct uniperif_info {
 	int id; /* instance value of the uniperipheral IP */
-	enum uniperif_type player_type;
+	enum uniperif_type type;
 	int underflow_enabled;		/* Underflow recovery mode */
 };
 
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 7aca6b92f718..ab4310a1615e 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -26,15 +26,6 @@
 /*
  * Driver specific types.
  */
-#define UNIPERIF_PLAYER_TYPE_IS_HDMI(p) \
-	((p)->info->player_type == SND_ST_UNIPERIF_PLAYER_TYPE_HDMI)
-#define UNIPERIF_PLAYER_TYPE_IS_PCM(p) \
-	((p)->info->player_type == SND_ST_UNIPERIF_PLAYER_TYPE_PCM)
-#define UNIPERIF_PLAYER_TYPE_IS_SPDIF(p) \
-	((p)->info->player_type == SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF)
-#define UNIPERIF_PLAYER_TYPE_IS_IEC958(p) \
-	(UNIPERIF_PLAYER_TYPE_IS_HDMI(p) || \
-		UNIPERIF_PLAYER_TYPE_IS_SPDIF(p))
 
 #define UNIPERIF_PLAYER_CLK_ADJ_MIN  -999999
 #define UNIPERIF_PLAYER_CLK_ADJ_MAX  1000000
@@ -738,14 +729,14 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 	SET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(player, trigger_limit);
 
 	/* Uniperipheral setup depends on player type */
-	switch (player->info->player_type) {
-	case SND_ST_UNIPERIF_PLAYER_TYPE_HDMI:
+	switch (player->info->type) {
+	case SND_ST_UNIPERIF_TYPE_HDMI:
 		ret = uni_player_prepare_iec958(player, runtime);
 		break;
-	case SND_ST_UNIPERIF_PLAYER_TYPE_PCM:
+	case SND_ST_UNIPERIF_TYPE_PCM:
 		ret = uni_player_prepare_pcm(player, runtime);
 		break;
-	case SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF:
+	case SND_ST_UNIPERIF_TYPE_SPDIF:
 		ret = uni_player_prepare_iec958(player, runtime);
 		break;
 	default:
@@ -852,8 +843,8 @@ static int uni_player_start(struct uniperif *player)
 	 * will not take affect and hang the player.
 	 */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
-		if (UNIPERIF_PLAYER_TYPE_IS_IEC958(player))
-				SET_UNIPERIF_CTRL_SPDIF_FMT_ON(player);
+		if (UNIPERIF_TYPE_IS_IEC958(player))
+			SET_UNIPERIF_CTRL_SPDIF_FMT_ON(player);
 
 	/* Force channel status update (no update if clk disable) */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
@@ -1012,13 +1003,13 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	}
 
 	if (strcasecmp(mode, "hdmi") == 0)
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_HDMI;
+		info->type = SND_ST_UNIPERIF_TYPE_HDMI;
 	else if (strcasecmp(mode, "pcm") == 0)
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_PCM;
+		info->type = SND_ST_UNIPERIF_TYPE_PCM;
 	else if (strcasecmp(mode, "spdif") == 0)
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF;
+		info->type = SND_ST_UNIPERIF_TYPE_SPDIF;
 	else
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_NONE;
+		info->type = SND_ST_UNIPERIF_TYPE_NONE;
 
 	/* Save the info structure */
 	player->info = info;
@@ -1087,7 +1078,7 @@ int uni_player_init(struct platform_device *pdev,
 	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(player);
 	SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(player);
 
-	if (UNIPERIF_PLAYER_TYPE_IS_IEC958(player)) {
+	if (UNIPERIF_TYPE_IS_IEC958(player)) {
 		/* Set default iec958 status bits  */
 
 		/* Consumer, PCM, copyright, 2ch, mode 0 */
-- 
2.8.0.rc3
