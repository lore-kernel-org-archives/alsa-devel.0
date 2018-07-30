From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8988: fix typo in rate constraints"
	to the asoc tree
Date: Mon, 30 Jul 2018 12:04:36 +0100 (BST)
Message-ID: <20180730110436.24A8A1124216@debutante.sirena.org.uk>
References: <20180728123017.GA28930@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A1C1C267763
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 13:04:36 +0200 (CEST)
In-Reply-To: <20180728123017.GA28930@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8988: fix typo in rate constraints

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

>From c9c9780d8fa526a124933134a7e4041fa09662f6 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Sat, 28 Jul 2018 14:30:17 +0200
Subject: [PATCH] ASoC: wm8988: fix typo in rate constraints

Remove duplicated entry and add missing zero in rate constraints.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8988.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 62200117444b..6e52c6a8bab3 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -522,7 +522,7 @@ static inline int get_coeff(int mclk, int rate)
 /* The set of rates we can generate from the above for each SYSCLK */
 
 static const unsigned int rates_12288[] = {
-	8000, 12000, 16000, 24000, 24000, 32000, 48000, 96000,
+	8000, 12000, 16000, 24000, 32000, 48000, 96000,
 };
 
 static const struct snd_pcm_hw_constraint_list constraints_12288 = {
@@ -540,7 +540,7 @@ static const struct snd_pcm_hw_constraint_list constraints_112896 = {
 };
 
 static const unsigned int rates_12[] = {
-	8000, 11025, 12000, 16000, 22050, 2400, 32000, 41100, 48000,
+	8000, 11025, 12000, 16000, 22050, 24000, 32000, 41100, 48000,
 	48000, 88235, 96000,
 };
 
-- 
2.18.0
