From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] ASoC: sun4i-codec: Remove spaces before tabs.
Date: Sat, 25 Feb 2017 12:39:48 +0200
Message-ID: <1488019188-15408-1-git-send-email-codrut.cristian.grosu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: maxime.ripard@free-electrons.com, perex@perex.cz, tiwai@suse.com, wens@csie.org
Cc: robh@kernel.org, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, dannym@scratchpost.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Codrut Grosu <codrut.cristian.grosu@gmail.com>, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index c3aab10..7ba6849 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1139,8 +1139,8 @@ static int sun4i_codec_dai_probe(struct snd_soc_dai *dai)
 		.stream_name	= "Capture",
 		.channels_min	= 1,
 		.channels_max	= 2,
-		.rates 		= SUN4I_CODEC_RATES,
-		.formats 	= SUN4I_CODEC_FORMATS,
+		.rates		= SUN4I_CODEC_RATES,
+		.formats	= SUN4I_CODEC_FORMATS,
 		.sig_bits	= 24,
 	 },
 };
-- 
1.9.1
