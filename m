From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: Intel: remove set but not used variable 'stage_type'
Date: Tue, 25 Dec 2018 11:55:47 +0000
Message-ID: <1545738947-93207-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning:
 variable 'stage_type' set but not used [-Wunused-but-set-variable]

It never used since commit ba57f68235cf ("ASoC: Intel: create haswell folder
and move haswell platform files in")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 31fcdf12..a3c374e 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -666,13 +666,12 @@ static int hsw_module_message(struct sst_hsw *hsw, u32 header)
 
 static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
 {
-	u32 stream_msg, stream_id, stage_type;
+	u32 stream_msg, stream_id;
 	struct sst_hsw_stream *stream;
 	int handled = 0;
 
 	stream_msg = msg_get_stream_type(header);
 	stream_id = msg_get_stream_id(header);
-	stage_type = msg_get_stage_type(header);
 
 	stream = get_stream_by_id(hsw, stream_id);
 	if (stream == NULL)
