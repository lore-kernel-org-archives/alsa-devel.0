From: mengdong.lin@linux.intel.com
Subject: [PATCH 4/4] ASoC: topology: Set CPU DAI name and
	enable DPCM by default for FE link
Date: Tue, 19 Apr 2016 13:12:50 +0800
Message-ID: <c80352fa0ae3d1f881ea8ea15f474314ad63e3ae.1461042239.git.mengdong.lin@linux.intel.com>
References: <cover.1461042239.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E9D61265D3C
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 07:10:06 +0200 (CEST)
In-Reply-To: <cover.1461042239.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

When creating a FE link, the cpu_dai_name will come from topology and
dpcm will be enabled by default.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index bdbfcef..ca5f828 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1586,6 +1586,7 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	return snd_soc_register_dai(tplg->comp, dai_drv);
 }
 
+/* create the FE DAI link */
 static int soc_tplg_link_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
@@ -1600,6 +1601,15 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 	link->stream_name = pcm->pcm_name;
 	link->id = pcm->pcm_id;
 
+	link->cpu_dai_name = pcm->dai_name;
+	link->codec_name = "snd-soc-dummy";
+	link->codec_dai_name = "snd-soc-dummy-dai";
+
+	/* enable DPCM */
+	link->dynamic = 1;
+	link->dpcm_playback = pcm->playback;
+	link->dpcm_capture = pcm->capture;
+
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_link_load(tplg, link);
 	if (ret < 0) {
-- 
2.5.0
