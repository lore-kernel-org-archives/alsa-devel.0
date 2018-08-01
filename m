From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 02/11] ASoC: rt5640: Mark expected switch fall-through
Date: Wed, 1 Aug 2018 14:49:13 -0500
Message-ID: <797d14078a5e024360e27285f5f61d6319041d21.1533151956.git.gustavo@embeddedor.com>
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

Addresses-Coverity-ID: 1056547 ("Missing break in switch")
Addresses-Coverity-ID: 1056548 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/rt5640.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 8bf8d36..2777014 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1665,6 +1665,7 @@ static int get_sdp_info(struct snd_soc_component *component, int dai_id)
 			break;
 		case RT5640_IF_113:
 			ret |= RT5640_U_IF1;
+			/* fall through */
 		case RT5640_IF_312:
 		case RT5640_IF_213:
 			ret |= RT5640_U_IF2;
@@ -1680,6 +1681,7 @@ static int get_sdp_info(struct snd_soc_component *component, int dai_id)
 			break;
 		case RT5640_IF_223:
 			ret |= RT5640_U_IF1;
+			/* fall through */
 		case RT5640_IF_123:
 		case RT5640_IF_321:
 			ret |= RT5640_U_IF2;
-- 
2.7.4
