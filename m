From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8540: remove redundant variable osrate" to the asoc
 tree
Date: Wed,  1 Aug 2018 12:17:07 +0100 (BST)
Message-ID: <20180801111707.B6E6A1124241@debutante.sirena.org.uk>
References: <20180801104742.4328-7-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180801104742.4328-7-colin.king@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, kernel-janitors@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org, Jaya Kumar <jayakumar.alsa@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8540: remove redundant variable osrate

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

>From d101f9b96ee08f0454989bc3adb10e6cf7f3f953 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 1 Aug 2018 11:47:39 +0100
Subject: [PATCH] ASoC: nau8540: remove redundant variable osrate

Variable osrate is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'osrate' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8540.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 17104f8dc1a9..e3c8cd17daf2 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -362,11 +362,8 @@ static const struct snd_soc_dapm_route nau8540_dapm_routes[] = {
 
 static int nau8540_clock_check(struct nau8540 *nau8540, int rate, int osr)
 {
-	int osrate;
-
 	if (osr >= ARRAY_SIZE(osr_adc_sel))
 		return -EINVAL;
-	osrate = osr_adc_sel[osr].osr;
 
 	if (rate * osr > CLK_ADC_MAX) {
 		dev_err(nau8540->dev, "exceed the maximum frequency of CLK_ADC\n");
-- 
2.18.0
