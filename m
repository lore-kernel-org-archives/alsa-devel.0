From: mengdong.lin@linux.intel.com
Subject: [PATCH 3/4] topology: Remove unused variables
Date: Wed, 18 Nov 2015 02:23:19 -0500
Message-ID: <c5ce2ce885b6fa68391a9e66c6b675beb2ce5a43.1447825540.git.mengdong.lin@linux.intel.com>
References: <cover.1447825540.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EC6A02654CE
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 08:07:36 +0100 (CET)
In-Reply-To: <cover.1447825540.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Fix gcc warning when -Wunused-variable is set.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 4b7c058..d90a9ea 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -58,7 +58,6 @@ static int tplg_build_pcm_caps(snd_tplg_t *tplg, struct tplg_elem *elem)
 	struct tplg_elem *ref_elem = NULL;
 	struct snd_soc_tplg_pcm *pcm;
 	struct snd_soc_tplg_stream_caps *caps;
-	struct snd_soc_tplg_stream *stream;
 	unsigned int i;
 
 	pcm = elem->pcm;
@@ -273,7 +272,7 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg, snd_config_t *cfg,
 	struct tplg_elem *elem = private;
 	struct snd_soc_tplg_pcm *pcm;
 	const char *id, *value;
-	int err, stream;
+	int stream;
 
 	pcm = elem->pcm;
 
@@ -384,7 +383,6 @@ int tplg_parse_be(snd_tplg_t *tplg,
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	const char *id, *val = NULL;
-	int err;
 
 	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_BE);
 	if (!elem)
@@ -438,7 +436,6 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	const char *id, *val = NULL;
-	int err;
 
 	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_CC);
 	if (!elem)
-- 
2.5.0
