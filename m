From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Use params_width instead of
	open-coded" to the asoc tree
Date: Wed, 24 Feb 2016 13:15:36 +0900
Message-ID: <E1aYQrQ-0000rn-Vl@finisterre>
References: <1456210393.15964.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 853FC2665DE
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 05:15:43 +0100 (CET)
In-Reply-To: <1456210393.15964.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, anish kumar <yesanishhere@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Use params_width instead of open-coded

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

>From 9dcc72efae313472d1d719e91b23e2bea3513789 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 23 Feb 2016 14:53:13 +0800
Subject: [PATCH] ASoC: max9867: Use params_width instead of open-coded

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 4fb6fc7188c7..f371a52fe29d 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -207,10 +207,9 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 		unsigned long int bclk_rate, pclk_bclk_ratio;
 		int bclk_value;
 
-		bclk_rate = params_rate(params) * 2 *
-			snd_pcm_format_width(params_format(params));
+		bclk_rate = params_rate(params) * 2 * params_width(params);
 		pclk_bclk_ratio = max9867->pclk/bclk_rate;
-		switch (snd_pcm_format_width(params_format(params))) {
+		switch (params_width(params)) {
 		case 8:
 		case 16:
 			switch (pclk_bclk_ratio) {
-- 
2.7.0
