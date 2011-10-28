From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Leave input audio data bit length
 settings untouched in wm8711_set_dai_fmt
Date: Fri, 28 Oct 2011 15:17:56 +0800
Message-ID: <1319786276.2401.1.camel@phoenix>
References: <1319771281.3944.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9FC6F2479A
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Oct 2011 09:18:07 +0200 (CEST)
Received: by ywp31 with SMTP id 31so4079396ywp.38
	for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2011 00:18:07 -0700 (PDT)
In-Reply-To: <1319771281.3944.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Current implementation in wm8711_set_dai_fmt always clear BIT[3:2]
(the Input Audio Data Bit Length Select) of WM8711_IFACE(07h) register.
Input Audio Data Bit Length Select bits are set by wm8711_hw_params,
we should leave BIT[3:2] untouched in wm8711_set_dai_fmt.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8711.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 8ba49d8..076bdb9 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -232,7 +232,7 @@ static int wm8711_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 iface = 0;
+	u16 iface = snd_soc_read(codec, WM8711_IFACE) & 0x000c;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-- 
1.7.5.4
