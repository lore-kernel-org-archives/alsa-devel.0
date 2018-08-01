From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 03/11] ASoC: rt5677: Mark expected switch fall-through
Date: Wed, 1 Aug 2018 14:50:20 -0500
Message-ID: <e23dbec89964bff8832d5ff4ae5a50fd1a6c185f.1533151956.git.gustavo@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533151956.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1271174 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/rt5677.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 8a0181a..922becf 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4417,6 +4417,7 @@ static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		break;
 	case 25:
 		slot_width_25 = 0x8080;
+		/* fall through */
 	case 24:
 		val |= (2 << 8);
 		break;
-- 
2.7.4
