From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/9] ASoC: compress: dont aquire lock for draining states
Date: Tue, 27 Aug 2013 12:10:33 +0530
Message-ID: <1377585639-29516-4-git-send-email-vinod.koul@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: broonie@kernel.org, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Both draining and partial draning states will take a while getting executed. The
lock aquired will block the other operations like pause, stop etc which are
perfectly valid cmds during these states. So dont use mutex while invoking DSP
for these ops

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: <stable@vger.kernel.org>
---
 sound/soc/soc-compress.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 06a8000..800ee89 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -171,6 +171,16 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
+	/* for partial drain and drain cmd dont aquire lock while invoking DSP.
+	 * These calls will be blocked till these operation can complete while
+	 * will be a while. And during that app can invoke STOP, PAUSE etc
+	 */
+	if (cmd == SND_COMPR_TRIGGER_PARTIAL_DRAIN || cmd == SND_COMPR_TRIGGER_DRAIN) {
+		if (platform->driver->compr_ops &&
+					platform->driver->compr_ops->trigger)
+			return platform->driver->compr_ops->trigger(cstream, cmd);
+	}
+
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
 	if (platform->driver->compr_ops && platform->driver->compr_ops->trigger) {
-- 
1.7.0.4
