From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 6/7] ASoC: samsung: i2s: Mark expected switch fall-through
Date: Fri, 3 Aug 2018 11:33:57 -0500
Message-ID: <6be766c659c7c31362c018b75970a0755ac756eb.1533312229.git.gustavo@embeddedor.com>
References: <cover.1533312229.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533312229.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1381093 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/samsung/i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index f914ed4..d6c62aa 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -710,6 +710,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (params_channels(params)) {
 	case 6:
 		val |= MOD_DC2_EN;
+		/* fall through */
 	case 4:
 		val |= MOD_DC1_EN;
 		break;
-- 
2.7.4
