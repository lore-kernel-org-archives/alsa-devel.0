From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: Intel: sst: fix to spelling mistake: "susupend" -> "suspend"
Date: Fri,  2 Sep 2016 09:45:25 +0100
Message-ID: <20160902084525.8646-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_err message and replace "cant"
with "can't"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/atom/sst/sst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index 498b5f7..9b6e273 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -442,7 +442,7 @@ static int intel_sst_suspend(struct device *dev)
 		struct stream_info *stream = &ctx->streams[i];
 
 		if (stream->status == STREAM_RUNNING) {
-			dev_err(dev, "stream %d is running, cant susupend, abort\n", i);
+			dev_err(dev, "stream %d is running, can't suspend, abort\n", i);
 			return -EBUSY;
 		}
 	}
-- 
2.9.3
