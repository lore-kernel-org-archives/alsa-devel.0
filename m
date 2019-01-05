From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 21/21] ASoC: rl6437a: use __be32 for a __be32 buf
Date: Fri,  4 Jan 2019 20:02:49 -0600
Message-ID: <20190105020249.8639-22-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

The buf in rl6347a_hw_read is __be32.

Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rl6347a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rl6347a.c b/sound/soc/codecs/rl6347a.c
index 8f571cf8edd4..c0d729b45277 100644
--- a/sound/soc/codecs/rl6347a.c
+++ b/sound/soc/codecs/rl6347a.c
@@ -64,8 +64,8 @@ int rl6347a_hw_read(void *context, unsigned int reg, unsigned int *value)
 	struct i2c_client *client = context;
 	struct i2c_msg xfer[2];
 	int ret;
-	__be32 be_reg;
-	unsigned int index, vid, buf = 0x0;
+	__be32 be_reg, buf = 0x0;
+	unsigned int index, vid;
 
 	/* handle index registers */
 	if (reg <= 0xff) {
-- 
2.17.1
