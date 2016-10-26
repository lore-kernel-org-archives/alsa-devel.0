From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti-sas: enable fast io for regmap" to
	the asoc tree
Date: Wed, 26 Oct 2016 11:45:54 +0100
Message-ID: <E1bzLiU-0005Jp-3f@debutante>
References: <1477320177-30130-8-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A56C126697D
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:46:04 +0200 (CEST)
In-Reply-To: <1477320177-30130-8-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti-sas: enable fast io for regmap

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

>From 7e235deb69dc7b1c4b5e1ac63a3157ef98ceeff3 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Mon, 24 Oct 2016 16:42:57 +0200
Subject: [PATCH] ASoC: sti-sas: enable fast io for regmap

Some registers accesses are done in atomic context.
Enable fast io to use spinlock instead of mutex to protect access.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sti-sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 7b31ee9b82bc..d6e00c77edcd 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -424,7 +424,7 @@ static const struct snd_soc_dai_ops stih407_dac_ops = {
 static const struct regmap_config stih407_sas_regmap = {
 	.reg_bits = 32,
 	.val_bits = 32,
-
+	.fast_io = true,
 	.max_register = STIH407_AUDIO_DAC_CTRL,
 	.reg_defaults = stih407_sas_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(stih407_sas_reg_defaults),
-- 
2.8.1
