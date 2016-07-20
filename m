From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 2/3] topology: Add ATTRIBUTE_UNUSED for
	unused parameters to fix compiler warning
Date: Wed, 20 Jul 2016 09:53:03 +0800
Message-ID: <a7e37a7e0f820c93b03f7a07a645d760a254962f.1468979281.git.mengdong.lin@linux.intel.com>
References: <cover.1468979281.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C0674265CA8
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2016 03:47:59 +0200 (CEST)
In-Reply-To: <cover.1468979281.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, liam.r.girdwood@intel.com, o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This commit adds ATTRIBUTE_UNUSED to the unused parameter 'tplg' for
function tplg_parse_streams() and tplg_parse_fe_dai(). These two functions
need to keep 'tplg' as ops for tplg_parse_compound().

The compiler warnings below are fixed:

pcm.c: In function 'tplg_parse_streams':
pcm.c:262:43: warning: unused parameter 'tplg' [-Wunused-parameter]
 static int tplg_parse_streams(snd_tplg_t *tplg, snd_config_t *cfg,
                                           ^
pcm.c: In function 'tplg_parse_fe_dai':
pcm.c:324:42: warning: unused parameter 'tplg' [-Wunused-parameter]
 static int tplg_parse_fe_dai(snd_tplg_t *tplg, snd_config_t *cfg,

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 281e6ef..0a90cb9 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -259,8 +259,8 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg,
 }
 
 /* Parse the caps and config of a pcm stream */
-static int tplg_parse_streams(snd_tplg_t *tplg, snd_config_t *cfg,
-	void *private)
+static int tplg_parse_streams(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
+			      snd_config_t *cfg, void *private)
 {
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
@@ -321,8 +321,8 @@ static int tplg_parse_streams(snd_tplg_t *tplg, snd_config_t *cfg,
 }
 
 /* Parse name and id of a front-end DAI (ie. cpu dai of a FE DAI link) */
-static int tplg_parse_fe_dai(snd_tplg_t *tplg, snd_config_t *cfg,
-	void *private)
+static int tplg_parse_fe_dai(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
+			     snd_config_t *cfg, void *private)
 {
 	struct tplg_elem *elem = private;
 	struct snd_soc_tplg_pcm *pcm = elem->pcm;
-- 
2.5.0
