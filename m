From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: cs42l73: Fix clear wrong bits in
 cs42l73_set_dai_fmt
Date: Fri, 18 Nov 2011 16:06:42 +0800
Message-ID: <1321603602.7338.5.camel@phoenix>
References: <1321603513.7338.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C12D103823
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 09:06:48 +0100 (CET)
Received: by yenr9 with SMTP id r9so186574yen.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 00:06:47 -0800 (PST)
In-Reply-To: <1321603513.7338.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

What we want is to clear BIT[5:4](PCM_MODE_MASK) and BIT[3](PCM_BIT_ORDER) bits,
but current code clears BIT[2:0].

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l73.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 0306e72..a2af595 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1024,7 +1024,8 @@ static int cs42l73_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	}
 
 	if (spc & SPDIF_PCM) {
-		spc &= (31 << 3);	/* Clear PCM mode, set MSB->LSB */
+		/* Clear PCM mode, clear PCM_BIT_ORDER bit for MSB->LSB */
+		spc &= ~(PCM_MODE_MASK | PCM_BIT_ORDER);
 		switch (format) {
 		case SND_SOC_DAIFMT_DSP_B:
 			if (inv == SND_SOC_DAIFMT_IB_IF)
-- 
1.7.5.4
