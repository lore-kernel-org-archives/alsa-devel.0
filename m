From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH RESEND] ASoC: cs42l73: Fix clear wrong bits in
 cs42l73_set_dai_fmt
Date: Tue, 29 Nov 2011 19:47:38 +0800
Message-ID: <1322567258.2456.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 42D2F244C2
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 12:47:51 +0100 (CET)
Received: by ggnv1 with SMTP id v1so3477674ggn.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 03:47:47 -0800 (PST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

What we want is to clear BIT[5:4](PCM_MODE_MASK) and BIT[3](PCM_BIT_ORDER) bits,
but current code clears BIT[2:0].

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
---
This patch was sent on http://comments.gmane.org/gmane.linux.alsa.devel/91501
and Brian replied "tested and acked" for both patches.
[PATCH 1/2] ASoC: cs42l73: Unify the way to define bits of register is already merged,
but [PATCH 2/2] ASoC: cs42l73: Fix clear wrong bits in cs42l73_set_dai_fmt is missed.

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
