From: Colin King <colin.king@canonical.com>
Subject: [PATCH 6/9] ASoC: nau8540: remove redundant variable osrate
Date: Wed,  1 Aug 2018 11:47:39 +0100
Message-ID: <20180801104742.4328-7-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jaya Kumar <jayakumar.alsa@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Olivier Moysan <olivier.moysan@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Variable osrate is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'osrate' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
2.17.1
