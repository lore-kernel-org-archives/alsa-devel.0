From: mengdong.lin@linux.intel.com
Subject: [PATCH 5/5] topology: ABI - Add sig_bits to stream caps
Date: Mon,  3 Oct 2016 23:04:34 +0800
Message-ID: <641a853abcc2db1832bd7839649cfa9b95977d1b.1475505267.git.mengdong.lin@linux.intel.com>
References: <cover.1475505267.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 15162266B91
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 17:03:56 +0200 (CEST)
In-Reply-To: <cover.1475505267.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Add sig_bits to stream caps and also add it to stream caps template
of C API.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 2f88e83..752ce16 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -248,6 +248,7 @@ struct snd_soc_tplg_stream_caps {
 	__le32 period_size_max;	/* max period size bytes */
 	__le32 buffer_size_min;	/* min buffer size bytes */
 	__le32 buffer_size_max;	/* max buffer size bytes */
+	__le32 sig_bits;        /* number of bits of content */
 } __attribute__((packed));
 
 /*
diff --git a/include/topology.h b/include/topology.h
index f98894f..eec4a05 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -876,6 +876,7 @@ struct snd_tplg_stream_caps_template {
 	unsigned int period_size_max;	/*!< max period size bytes */
 	unsigned int buffer_size_min;	/*!< min buffer size bytes */
 	unsigned int buffer_size_max;	/*!< max buffer size bytes */
+	unsigned int sig_bits; /*!< number of bits of content */
 };
 
 /** \struct snd_tplg_pcm_template
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 65f7102..850704c 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -754,6 +754,7 @@ static void tplg_add_stream_caps(struct snd_soc_tplg_stream_caps *caps,
 	caps->period_size_max = caps_tpl->period_size_max;
 	caps->buffer_size_min = caps_tpl->buffer_size_min;
 	caps->buffer_size_max = caps_tpl->buffer_size_max;
+	caps->sig_bits = caps_tpl->sig_bits;
 }
 
 int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
-- 
2.5.0
