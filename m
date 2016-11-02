From: mengdong.lin@linux.intel.com
Subject: [PATCH v7 04/11] ASoC: topology: ABI - Add flags and
	private data to PCM
Date: Thu,  3 Nov 2016 01:03:34 +0800
Message-ID: <4b17e13ac1c24a6dab791c8fd9abf79f410e7d6e.1478071138.git.mengdong.lin@linux.intel.com>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C95F2666FA
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 18:02:11 +0100 (CET)
In-Reply-To: <cover.1478071138.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This is the remaining update to PCM ABI object of version 5.

The flags will be applied to FE (Front End) links and can also be used
by physical links. The private data is reserved for future extension, so
offset update will add the private data size.

Now user space is using ABI v4, and the previous patch "ASoC: topology:
make PCM backward compatible from ABI v4" can assure the backward
compatibility.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 69cae71..aeb4082 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -146,6 +146,11 @@
 #define SND_SOC_DAI_FORMAT_MSB          SND_SOC_DAI_FORMAT_LEFT_J
 #define SND_SOC_DAI_FORMAT_LSB          SND_SOC_DAI_FORMAT_RIGHT_J
 
+/* DAI link flags */
+#define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES         (1 << 0)
+#define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
+#define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
+
 /*
  * Block Header.
  * This header precedes all object and object arrays below.
@@ -456,6 +461,9 @@ struct snd_soc_tplg_pcm {
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
 	__le32 num_streams;	/* number of streams */
 	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
+	__le32 flag_mask;       /* bitmask of flags to configure */
+	__le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
+	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 2f9b64e..8baa176 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1676,6 +1676,24 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	return snd_soc_register_dai(tplg->comp, dai_drv);
 }
 
+static void set_link_flags(struct snd_soc_dai_link *link,
+		unsigned int flag_mask, unsigned int flags)
+{
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES)
+		link->symmetric_rates =
+			flags & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES ? 1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS)
+		link->symmetric_channels =
+			flags & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS ?
+			1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS)
+		link->symmetric_samplebits =
+			flags & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS ?
+			1 : 0;
+}
+
 /* create the FE DAI link */
 static int soc_tplg_link_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
@@ -1703,6 +1721,8 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 	link->dynamic = 1;
 	link->dpcm_playback = pcm->playback;
 	link->dpcm_capture = pcm->capture;
+	if (pcm->flag_mask)
+		set_link_flags(link, pcm->flag_mask, pcm->flags);
 
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_link_load(tplg, link);
@@ -1848,10 +1868,14 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 		/* create the FE DAIs and DAI links */
 		soc_tplg_pcm_create(tplg, _pcm);
 
+
+		/* offset by version-specific struct size and
+		 * real priv data size
+		 */
+		tplg->pos += pcm->size + _pcm->priv.size;
+
 		if (!abi_match)
 			kfree(_pcm); /* free the duplicated one */
-
-		tplg->pos += pcm->size; /* offset by version-specific size */
 	}
 
 	dev_dbg(tplg->dev, "ASoC: adding %d PCM DAIs\n", count);
-- 
2.7.4
