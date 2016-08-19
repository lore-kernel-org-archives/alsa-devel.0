From: mengdong.lin@linux.intel.com
Subject: [PATCH 05/13] ASoC: topology: ABI - Add private data
	to PCM
Date: Fri, 19 Aug 2016 18:13:15 +0800
Message-ID: <dcbcbb23cc2c006d98339af53a1dedc41dbfecc5.1471599648.git.mengdong.lin@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E1FE266A11
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:07:24 +0200 (CEST)
In-Reply-To: <cover.1471599648.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Add private data to PCM (Frontend DAI & DAI link) for future extension.
Revise offset update for PCM with private data.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 39be708..c75ed4f 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -460,6 +460,7 @@ struct snd_soc_tplg_pcm {
 	__le32 trigger[2];	/* SND_SOC_DPCM_TRIGGER_ trigger flag for playback & capture */
 	__le32 flag_mask;       /* bitmask of flags to configure */
 	__le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
+	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 1f89a2a..b71abad 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1711,19 +1711,18 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	}
 
 	/* create the FE DAIs and DAI links */
-	pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
 	for (i = 0; i < count; i++) {
+		pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
 		if (pcm->size != sizeof(*pcm)) {
 			dev_err(tplg->dev, "ASoC: invalid pcm size\n");
 			return -EINVAL;
 		}
 
 		soc_tplg_pcm_create(tplg, pcm);
-		pcm++;
+		tplg->pos += (sizeof(*pcm) + pcm->priv.size);
 	}
 
 	dev_dbg(tplg->dev, "ASoC: adding %d PCM DAIs\n", count);
-	tplg->pos += sizeof(struct snd_soc_tplg_pcm) * count;
 
 	return 0;
 }
-- 
2.5.0
