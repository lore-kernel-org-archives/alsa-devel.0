From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 2/3] ASoC: Intel: add drain_notify support
Date: Thu, 15 May 2014 21:38:16 +0530
Message-ID: <1400170097-7653-3-git-send-email-vinod.koul@intel.com>
References: <1400170097-7653-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CD1E261B14
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 18:23:28 +0200 (CEST)
In-Reply-To: <1400170097-7653-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds the support to implement drain_notify in Intels mfld driver

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-mfld-platform-compress.c |   11 +++++++++++
 sound/soc/intel/sst-mfld-platform.h          |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-compress.c b/sound/soc/intel/sst-mfld-platform-compress.c
index 16d79fb..5c3e234 100644
--- a/sound/soc/intel/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/sst-mfld-platform-compress.c
@@ -38,6 +38,15 @@ static void sst_compr_fragment_elapsed(void *arg)
 		snd_compr_fragment_elapsed(cstream);
 }
 
+static void sst_drain_notify(void *arg)
+{
+	struct snd_compr_stream *cstream = (struct snd_compr_stream *)arg;
+
+	pr_debug("drain notify by driver\n");
+	if (cstream)
+		snd_compr_drain_notify(cstream);
+}
+
 static int sst_platform_compr_open(struct snd_compr_stream *cstream)
 {
 
@@ -143,6 +152,8 @@ static int sst_platform_compr_set_params(struct snd_compr_stream *cstream,
 
 	cb.param = cstream;
 	cb.compr_cb = sst_compr_fragment_elapsed;
+	cb.drain_cb_param = cstream;
+	cb.drain_notify = sst_drain_notify;
 
 	retval = stream->compr_ops->open(&str_params, &cb);
 	if (retval < 0) {
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 3ea4fee..6c5e7dc 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -104,6 +104,8 @@ struct sst_stream_params {
 struct sst_compress_cb {
 	void *param;
 	void (*compr_cb)(void *param);
+	void *drain_cb_param;
+	void (*drain_notify)(void *param);
 };
 
 struct compress_sst_ops {
-- 
1.7.0.4
