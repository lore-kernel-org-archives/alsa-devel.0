From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Check size mismatch of ABI
	objects before parsing" to the asoc tree
Date: Wed, 27 Apr 2016 17:34:42 +0100
Message-ID: <E1avSQE-0004Jr-HL@debutante>
References: <1461739976-30109-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 805FA266633
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 18:34:49 +0200 (CEST)
In-Reply-To: <1461739976-30109-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Check size mismatch of ABI objects before parsing

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 06eb49f72fa57f5a49acdf9f4af84d2d326513b3 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Wed, 27 Apr 2016 14:52:56 +0800
Subject: [PATCH] ASoC: topology: Check size mismatch of ABI objects before
 parsing

If size mismatch of manifest, ABI headers or elements is found, stop
parsing topology info and return the error.

New fields may be append to the tail of ABI objects which will cause
object size to increase. If user space and kernel use different versions
of ABI, size mismatch will be detected here.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 0224a6458f3b..29ae3d3a0f8a 100644
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
@@ -1652,8 +1662,6 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
 		return 0;
 
-	pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
-
 	if (soc_tplg_check_elem_count(tplg,
 		sizeof(struct snd_soc_tplg_pcm), count,
 		hdr->payload_size, "PCM DAI")) {
@@ -1663,7 +1671,13 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
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
@@ -1683,6 +1697,11 @@ static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 		return 0;
 
 	manifest = (struct snd_soc_tplg_manifest *)tplg->pos;
+	if (manifest->size != sizeof(*manifest)) {
+		dev_err(tplg->dev, "ASoC: invalid manifest size\n");
+		return -EINVAL;
+	}
+
 	tplg->pos += sizeof(struct snd_soc_tplg_manifest);
 
 	if (tplg->comp && tplg->ops && tplg->ops->manifest)
@@ -1699,6 +1718,14 @@ static int soc_valid_header(struct soc_tplg *tplg,
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
2.8.0.rc3
