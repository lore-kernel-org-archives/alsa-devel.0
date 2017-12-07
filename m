From: <jiada_wang@mentor.com>
Subject: [PATCH v1 1/2] ASoC: rsnd: ssi: fix race condition in rsnd_ssi_pointer_update
Date: Thu, 7 Dec 2017 00:22:35 -0800
Message-ID: <1512634956-17760-2-git-send-email-jiada_wang@mentor.com>
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

Currently there is race condition between set of byte_pos and wrap
it around when new buffer starts. If .pointer is called in-between
it will result in inconsistent pointer position be returned
from .pointer callback.

This patch increments buffer pointer atomically to avoid this issue.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reviewed-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
---
 sound/soc/sh/rcar/ssi.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index fece1e5f..cbf3bf3 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -446,25 +446,29 @@ static bool rsnd_ssi_pointer_update(struct rsnd_mod *mod,
 				    int byte)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	bool ret = false;
+	int byte_pos;
 
-	ssi->byte_pos += byte;
+	byte_pos = ssi->byte_pos + byte;
 
-	if (ssi->byte_pos >= ssi->next_period_byte) {
+	if (byte_pos >= ssi->next_period_byte) {
 		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 
 		ssi->period_pos++;
 		ssi->next_period_byte += ssi->byte_per_period;
 
 		if (ssi->period_pos >= runtime->periods) {
-			ssi->byte_pos = 0;
+			byte_pos = 0;
 			ssi->period_pos = 0;
 			ssi->next_period_byte = ssi->byte_per_period;
 		}
 
-		return true;
+		ret = true;
 	}
 
-	return false;
+	WRITE_ONCE(ssi->byte_pos, byte_pos);
+
+	return ret;
 }
 
 /*
@@ -838,7 +842,7 @@ static int rsnd_ssi_pointer(struct rsnd_mod *mod,
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 
-	*pointer = bytes_to_frames(runtime, ssi->byte_pos);
+	*pointer = bytes_to_frames(runtime, READ_ONCE(ssi->byte_pos));
 
 	return 0;
 }
-- 
1.7.9.5
