From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: set iec958 channel status sampling
	freq" to the asoc tree
Date: Wed, 25 Nov 2015 13:00:02 +0000
Message-ID: <E1a1Zg2-0002p5-4i@debutante>
References: <1448370996-30224-2-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 609AC26156A
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 14:00:13 +0100 (CET)
In-Reply-To: <1448370996-30224-2-git-send-email-moise.gergaud@st.com>
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

   ASoC: sti: set iec958 channel status sampling freq

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

>From 0d3f3c9a48d758454b0f57ca3eccd9ea3f6a4724 Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Tue, 24 Nov 2015 14:16:35 +0100
Subject: [PATCH] ASoC: sti: set iec958 channel status sampling freq

Previously, the iec958 channels status sampling freq was set only if not
already set. It means that it is not updated for next PCM sessions.
With this patch, we ensure the iec958 channels status sampling freq is set
to the runtime rate for each PCM session.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 843f037a317d..148bcd7dbf03 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -251,8 +251,7 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	 * set one.
 	 */
 	mutex_lock(&player->ctrl_lock);
-	if (runtime && (player->stream_settings.iec958.status[3]
-					== IEC958_AES3_CON_FS_NOTID)) {
+	if (runtime) {
 		switch (runtime->rate) {
 		case 22050:
 			player->stream_settings.iec958.status[3] =
-- 
2.6.2
