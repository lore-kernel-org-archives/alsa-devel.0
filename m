From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix pcm stream context restore
	crash
Date: Mon, 19 May 2014 11:14:23 +0300
Message-ID: <1400487263-3951-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id CBB2B265172
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 10:15:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Strasser <kevin.strasser@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kevin Strasser <kevin.strasser@intel.com>

In some cases the pcm stream is closed while context has been
scheduled to be restored, causing a null pointer deref panic.
Cancel work to ensure stream does not get freed while work is
still active/pending.

Also, restoring the pcm context can be safely skipped after the
stream has been stopped. Check if pcm stream is still running
before restoring stream context to help pending work finish
more quickly in stream close path.

Signed-off-by: Kevin Strasser <kevin.strasser@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
For topic/intel branch since fixes issue in recently added suspend/resume
code.
---
 sound/soc/intel/sst-baytrail-pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 6242ccce2bb7..3af38576e91e 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -164,7 +164,8 @@ static void sst_byt_pcm_work(struct work_struct *work)
 	struct sst_byt_pcm_data *pcm_data =
 		container_of(work, struct sst_byt_pcm_data, work);
 
-	sst_byt_pcm_restore_stream_context(pcm_data->substream);
+	if (snd_pcm_running(pcm_data->substream))
+		sst_byt_pcm_restore_stream_context(pcm_data->substream);
 }
 
 static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
@@ -277,6 +278,7 @@ static int sst_byt_pcm_close(struct snd_pcm_substream *substream)
 
 	dev_dbg(rtd->dev, "PCM: close\n");
 
+	cancel_work_sync(&pcm_data->work);
 	mutex_lock(&pcm_data->mutex);
 	ret = sst_byt_stream_free(byt, pcm_data->stream);
 	if (ret < 0) {
-- 
2.0.0.rc2
