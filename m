From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/2] ASoC: topology: Check size mismatch of ABI
	objects before parsing
Date: Wed, 27 Apr 2016 14:52:56 +0800
Message-ID: <1461739976-30109-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 04B01265D01
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 08:50:00 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

If size mismatch of manifest, ABI headers or elements is found, stop
parsing topology info and return the error.

New fields may be append to the tail of ABI objects which will cause
object size to increase. If user space and kernel use different versions
of ABI, size mismatch will be detected here.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index e38664e..2261585 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1023,6 +1023,11 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
 
 		control_hdr = (struct snd_soc_tplg_ctl_hdr *)tplg->pos;
 
+		if (control_hdr->size != sizeof(*control_hdr)) {
+			dev_err(tplg->dev, "ASoC: invalid control size\n");
+			return -EINVAL;
+		}
+
 		switch (control_hdr->ops.info) {
 		case SND_SOC_TPLG_CTL_VOLSW:
 		case SND_SOC_TPLG_CTL_STROBE:
@@ -1499,6 +1504,11 @@ static int soc_tplg_dapm_widget_elems_load(struct soc_tplg *tplg,
 
 	for (i = 0; i < count; i++) {
 		widget = (struct snd_soc_tplg_dapm_widget *) tplg->pos;
+		if (widget->size != sizeof(*widget)) {
+			dev_err(tplg->dev, "ASoC: invalid widget size\n");
+			return -EINVAL;
+		}
+
 		ret = soc_tplg_dapm_widget_create(tplg, widget);
 		if (ret < 0) {
 			dev_err(tplg->dev, "ASoC: failed to load widget %s\n",
@@ -1651,8 +1661,6 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
 		return 0;
 
-	pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
-
 	if (soc_tplg_check_elem_count(tplg,
 		sizeof(struct snd_soc_tplg_pcm), count,
 		hdr->payload_size, "PCM DAI")) {
@@ -1662,7 +1670,13 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	}
 
 	/* create the FE DAIs and DAI links */
+	pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
 	for (i = 0; i < count; i++) {
+		if (pcm->size != sizeof(*pcm)) {
+			dev_err(tplg->dev, "ASoC: invalid pcm size\n");
+			return -EINVAL;
+		}
+
 		soc_tplg_pcm_create(tplg, pcm);
 		pcm++;
 	}
@@ -1682,6 +1696,11 @@ static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 		return 0;
 
 	manifest = (struct snd_soc_tplg_manifest *)tplg->pos;
+	if (manifest->size != sizeof(*manifest)) {
+		dev_err(tplg->dev, "ASoC: invalid manifest size\n");
+		return -EINVAL;
+	}
+
 	tplg->pos += sizeof(struct snd_soc_tplg_manifest);
 
 	if (tplg->comp && tplg->ops && tplg->ops->manifest)
@@ -1698,6 +1717,14 @@ static int soc_valid_header(struct soc_tplg *tplg,
 	if (soc_tplg_get_hdr_offset(tplg) >= tplg->fw->size)
 		return 0;
 
+	if (hdr->size != sizeof(*hdr)) {
+		dev_err(tplg->dev,
+			"ASoC: invalid header size for type %d at offset 0x%lx size 0x%zx.\n",
+			hdr->type, soc_tplg_get_hdr_offset(tplg),
+			tplg->fw->size);
+		return -EINVAL;
+	}
+
 	/* big endian firmware objects not supported atm */
 	if (hdr->magic == cpu_to_be32(SND_SOC_TPLG_MAGIC)) {
 		dev_err(tplg->dev,
-- 
2.5.0
