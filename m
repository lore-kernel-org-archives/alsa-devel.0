From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Rename struct and type
	for physical DAIs" to the asoc tree
Date: Fri, 04 Nov 2016 11:38:29 -0600
Message-ID: <E1c2iRh-0007CR-0R@finisterre>
References: <6f5e49eaf8a2b274ef400063d9296aa0286a309e.1476162939.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B35842674C4
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:38:43 +0100 (CET)
In-Reply-To: <6f5e49eaf8a2b274ef400063d9296aa0286a309e.1476162939.git.mengdong.lin@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Rename struct and type for physical DAIs

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

>From 3fbf793510c7628248a965972112fab958e6e3cf Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Thu, 3 Nov 2016 01:05:01 +0800
Subject: [PATCH] ASoC: topology: ABI - Rename struct and type for physical
 DAIs

Rename the ABI struct and type because they are for configuring physical
DAIs, not only backend DAIs since users may not need DPCM:
- Rename struct snd_soc_tplg_be_dai to snd_soc_tplg_dai.
- Rename type SND_SOC_TPLG_TYPE_BE_DAI to SND_SOC_TPLG_TYPE_DAI.

This code refactoring is backward compatible because:
- Both layout of the struct and type value has no change. Kernel can
  find the same type value and map to same data layout.
- This struct is not in ABI v4 at all. Now the user space uses ABI v4.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 15 ++++++++-------
 sound/soc/soc-topology.c  |  8 ++++----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index ed28ebc392d1..3c3fcc86b9f4 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -111,8 +111,8 @@
 #define SND_SOC_TPLG_TYPE_CODEC_LINK	9
 #define SND_SOC_TPLG_TYPE_BACKEND_LINK	10
 #define SND_SOC_TPLG_TYPE_PDATA		11
-#define SND_SOC_TPLG_TYPE_BE_DAI	12
-#define SND_SOC_TPLG_TYPE_MAX		SND_SOC_TPLG_TYPE_BE_DAI
+#define SND_SOC_TPLG_TYPE_DAI		12
+#define SND_SOC_TPLG_TYPE_MAX		SND_SOC_TPLG_TYPE_DAI
 
 /* vendor block IDs - please add new vendor types to end */
 #define SND_SOC_TPLG_TYPE_VENDOR_FW	1000
@@ -131,7 +131,7 @@
 #define SND_SOC_TPLG_TUPLE_TYPE_WORD	4
 #define SND_SOC_TPLG_TUPLE_TYPE_SHORT	5
 
-/* BE DAI flags */
+/* DAI flags */
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES         (1 << 0)
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
@@ -527,16 +527,17 @@ struct snd_soc_tplg_link_config {
 } __attribute__((packed));
 
 /*
- * Describes SW/FW specific features of BE DAI.
+ * Describes SW/FW specific features of physical DAI.
+ * It can be used to configure backend DAIs for DPCM.
  *
- * File block representation for BE DAI :-
+ * File block representation for physical DAI :-
  * +-----------------------------------+-----+
  * | struct snd_soc_tplg_hdr           |  1  |
  * +-----------------------------------+-----+
- * | struct snd_soc_tplg_be_dai        |  N  |
+ * | struct snd_soc_tplg_dai           |  N  |
  * +-----------------------------------+-----+
  */
-struct snd_soc_tplg_be_dai {
+struct snd_soc_tplg_dai {
 	__le32 size;            /* in bytes of this structure */
 	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* name - used to match */
 	__le32 dai_id;          /* unique ID - used to match */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index eea28ade5b32..a839dc857e0d 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2090,7 +2090,7 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
  * platform driver should specify the BE DAI name and ID for matching.
  */
 static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
-				  struct snd_soc_tplg_be_dai *be)
+				  struct snd_soc_tplg_dai *be)
 {
 	struct snd_soc_dai_link_component dai_component = {0};
 	struct snd_soc_dai *dai;
@@ -2145,7 +2145,7 @@ static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
 static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
 				      struct snd_soc_tplg_hdr *hdr)
 {
-	struct snd_soc_tplg_be_dai *be;
+	struct snd_soc_tplg_dai *be;
 	int count = hdr->count;
 	int i;
 
@@ -2154,7 +2154,7 @@ static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
 
 	/* config the existing BE DAIs */
 	for (i = 0; i < count; i++) {
-		be = (struct snd_soc_tplg_be_dai *)tplg->pos;
+		be = (struct snd_soc_tplg_dai *)tplg->pos;
 		if (be->size != sizeof(*be)) {
 			dev_err(tplg->dev, "ASoC: invalid BE DAI size\n");
 			return -EINVAL;
@@ -2328,7 +2328,7 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 		return soc_tplg_dapm_widget_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_PCM:
 		return soc_tplg_pcm_elems_load(tplg, hdr);
-	case SND_SOC_TPLG_TYPE_BE_DAI:
+	case SND_SOC_TPLG_TYPE_DAI:
 		return soc_tplg_be_dai_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_DAI_LINK:
 	case SND_SOC_TPLG_TYPE_BACKEND_LINK:
-- 
2.10.1
