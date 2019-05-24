From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: cx2072x: remove redundant assignment to pulse_len
Date: Fri, 24 May 2019 22:44:19 +0100
Message-ID: <20190524214419.25075-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Simon Ho <simon.ho@conexant.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Variable pulse_len is being initialized to 1 however this value is
never read and pulse_len is being re-assigned later in a switch
statement.  Clean up the code by removing the redundant initialization.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 23d2b25fe04c..c11a585bbf70 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -679,7 +679,7 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 	int is_right_j = 0;
 	int is_frame_inv = 0;
 	int is_bclk_inv = 0;
-	int pulse_len = 1;
+	int pulse_len;
 	int frame_len = cx2072x->frame_size;
 	int sample_size = cx2072x->sample_size;
 	int i2s_right_slot;
-- 
2.20.1
