From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: soc-pcm: fix incorrect channels and
	sample_bits wiping off
Date: Tue, 19 Nov 2013 17:57:54 +0800
Message-ID: <1384855074-17596-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id D6A2C2610C7
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 10:57:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch wipes off the corresponding channels and sample_bits for codec_dai.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
@Mark Brown
Sir, I find the previous symmetry patch hasn't been merged into for-next.
So are you willing to apply this one or let me refine the previous PATCH
and resend that one?

 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e1c5a00..60d9cfb 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -452,8 +452,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 
 	if (!codec_dai->active) {
 		codec_dai->rate = 0;
-		cpu_dai->channels = 0;
-		cpu_dai->sample_bits = 0;
+		codec_dai->channels = 0;
+		codec_dai->sample_bits = 0;
 	}
 
 	/* Muting the DAC suppresses artifacts caused during digital
-- 
1.8.4
