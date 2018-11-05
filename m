From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6afe-dai: constify
	snd_soc_dai_ops structures" to the asoc tree
Date: Mon,  5 Nov 2018 11:58:44 +0000 (GMT)
Message-ID: <20181105115844.ACB431124D98@debutante.sirena.org.uk>
References: <1540647284-26728-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3142678DA
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:58:45 +0100 (CET)
In-Reply-To: <1540647284-26728-3-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6afe-dai: constify snd_soc_dai_ops structures

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7dfcd9d727c3e69ecb51c0bb4d54b3d46de98e87 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 27 Oct 2018 15:34:43 +0200
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: constify snd_soc_dai_ops structures

The snd_soc_dai_ops structures are only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 60ff4a2d3577..a07a4538d5cf 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -561,13 +561,13 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"QUAT_MI2S_TX", NULL, "Quaternary MI2S Capture"},
 };
 
-static struct snd_soc_dai_ops q6hdmi_ops = {
+static const struct snd_soc_dai_ops q6hdmi_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6hdmi_hw_params,
 	.shutdown	= q6afe_dai_shutdown,
 };
 
-static struct snd_soc_dai_ops q6i2s_ops = {
+static const struct snd_soc_dai_ops q6i2s_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6i2s_hw_params,
 	.set_fmt	= q6i2s_set_fmt,
@@ -575,14 +575,14 @@ static struct snd_soc_dai_ops q6i2s_ops = {
 	.set_sysclk	= q6afe_mi2s_set_sysclk,
 };
 
-static struct snd_soc_dai_ops q6slim_ops = {
+static const struct snd_soc_dai_ops q6slim_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6slim_hw_params,
 	.shutdown	= q6afe_dai_shutdown,
 	.set_channel_map = q6slim_set_channel_map,
 };
 
-static struct snd_soc_dai_ops q6tdm_ops = {
+static const struct snd_soc_dai_ops q6tdm_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.shutdown	= q6afe_dai_shutdown,
 	.set_sysclk	= q6afe_mi2s_set_sysclk,
-- 
2.19.0.rc2
