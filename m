From: <jiada_wang@mentor.com>
Subject: [PATCH v2 2/2] ASoC: rsnd: ssi: remove unnesessary period_pos
Date: Thu, 7 Dec 2017 00:22:36 -0800
Message-ID: <1512634956-17760-3-git-send-email-jiada_wang@mentor.com>
References: <1512634956-17760-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512634956-17760-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>
List-Id: alsa-devel@alsa-project.org

From: Jiada Wang <jiada_wang@mentor.com>

period_pos can always be calculated by byte_pos and
byte_per_period, there is no reason to maintain this
variable in rsnd_dai_stream.
Further more, if the passed 'byte' amount to
rsnd_ssi_pointer_update() is more than byte_per_period.
the calculation of next_period_byte isn't correct.

This patch removes period_pos from rsnd_ssi and calculates
next_period_byte with consideration of actual byte_pos value.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/ssi.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index cbf3bf3..f212024 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -80,7 +80,6 @@ struct rsnd_ssi {
 	unsigned int usrcnt;
 
 	int byte_pos;
-	int period_pos;
 	int byte_per_period;
 	int next_period_byte;
 };
@@ -421,7 +420,6 @@ static void rsnd_ssi_pointer_init(struct rsnd_mod *mod,
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 
 	ssi->byte_pos		= 0;
-	ssi->period_pos		= 0;
 	ssi->byte_per_period	= runtime->period_size *
 				  runtime->channels *
 				  samples_to_bytes(runtime, 1);
@@ -453,13 +451,12 @@ static bool rsnd_ssi_pointer_update(struct rsnd_mod *mod,
 
 	if (byte_pos >= ssi->next_period_byte) {
 		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+		int period_pos = byte_pos / ssi->byte_per_period;
 
-		ssi->period_pos++;
-		ssi->next_period_byte += ssi->byte_per_period;
+		ssi->next_period_byte = (period_pos + 1) * ssi->byte_per_period;
 
-		if (ssi->period_pos >= runtime->periods) {
+		if (period_pos >= runtime->periods) {
 			byte_pos = 0;
-			ssi->period_pos = 0;
 			ssi->next_period_byte = ssi->byte_per_period;
 		}
 
-- 
1.7.9.5
