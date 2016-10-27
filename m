From: mengdong.lin@linux.intel.com
Subject: [PATCH 02/22] topology: Parse sig_bits of stream caps
Date: Thu, 27 Oct 2016 15:11:28 +0800
Message-ID: <86df240bbe358f40076bd8723fe81352f8d52052.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id F363826688A
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:10:13 +0200 (CEST)
In-Reply-To: <cover.1477549962.git.mengdong.lin@linux.intel.com>
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

Add sig_bits to stream caps template of C API and parse it.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 0675b52..ccd8401 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -848,6 +848,7 @@ struct snd_tplg_stream_caps_template {
 	unsigned int period_size_max;	/*!< max period size bytes */
 	unsigned int buffer_size_min;	/*!< min buffer size bytes */
 	unsigned int buffer_size_max;	/*!< max buffer size bytes */
+	unsigned int sig_bits;		/*!< number of bits of content */
 };
 
 /** \struct snd_tplg_pcm_template
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 0a90cb9..6fdf047 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -572,6 +572,7 @@ static void tplg_add_stream_caps(struct snd_soc_tplg_stream_caps *caps,
 	caps->period_size_max = caps_tpl->period_size_max;
 	caps->buffer_size_min = caps_tpl->buffer_size_min;
 	caps->buffer_size_max = caps_tpl->buffer_size_max;
+	caps->sig_bits = caps_tpl->sig_bits;
 }
 
 int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
-- 
2.5.0
