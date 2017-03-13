From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: fsl: constify snd_soc_ops structures
Date: Tue, 14 Mar 2017 00:42:22 +0530
Message-ID: <1489432342-4328-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A3C89266B13
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 20:12:34 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id b5so19146045pgg.1
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 12:12:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_soc_ops structures as const as they are only stored
in the ops field of a snd_soc_dai_link structure. This field is
of type const, so snd_soc_ops structures having this property
can be made const too.

The following .o files did not compile:
sound/soc/fsl/{p1022_rdk.c/p1022_ds.c/mpc8610_hpcd.c}

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/fsl/eukrea-tlv320.c   | 2 +-
 sound/soc/fsl/imx-mc13783.c     | 2 +-
 sound/soc/fsl/mpc8610_hpcd.c    | 2 +-
 sound/soc/fsl/mx27vis-aic32x4.c | 2 +-
 sound/soc/fsl/p1022_ds.c        | 2 +-
 sound/soc/fsl/p1022_rdk.c       | 2 +-
 sound/soc/fsl/phycore-ac97.c    | 2 +-
 sound/soc/fsl/wm1133-ev1.c      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 883087f..84ef638 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -64,7 +64,7 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops eukrea_tlv320_snd_ops = {
+static const struct snd_soc_ops eukrea_tlv320_snd_ops = {
 	.hw_params	= eukrea_tlv320_hw_params,
 };
 
diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index bb04590..9d19b80 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -48,7 +48,7 @@ static int imx_mc13783_hifi_hw_params(struct snd_pcm_substream *substream,
 	return snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 16);
 }
 
-static struct snd_soc_ops imx_mc13783_hifi_ops = {
+static const struct snd_soc_ops imx_mc13783_hifi_ops = {
 	.hw_params = imx_mc13783_hifi_hw_params,
 };
 
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index ddf49f3..a639b52 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -174,7 +174,7 @@ static int mpc8610_hpcd_machine_remove(struct snd_soc_card *card)
 /**
  * mpc8610_hpcd_ops: ASoC machine driver operations
  */
-static struct snd_soc_ops mpc8610_hpcd_ops = {
+static const struct snd_soc_ops mpc8610_hpcd_ops = {
 	.startup = mpc8610_hpcd_startup,
 };
 
diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index 198eeb3..d7ec3d2 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -73,7 +73,7 @@ static int mx27vis_aic32x4_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops mx27vis_aic32x4_snd_ops = {
+static const struct snd_soc_ops mx27vis_aic32x4_snd_ops = {
 	.hw_params	= mx27vis_aic32x4_hw_params,
 };
 
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index a1f780e..41c623c 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -184,7 +184,7 @@ static int p1022_ds_machine_remove(struct snd_soc_card *card)
 /**
  * p1022_ds_ops: ASoC machine driver operations
  */
-static struct snd_soc_ops p1022_ds_ops = {
+static const struct snd_soc_ops p1022_ds_ops = {
 	.startup = p1022_ds_startup,
 };
 
diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index d4d88a8..4afbdd6 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -188,7 +188,7 @@ static int p1022_rdk_machine_remove(struct snd_soc_card *card)
 /**
  * p1022_rdk_ops: ASoC machine driver operations
  */
-static struct snd_soc_ops p1022_rdk_ops = {
+static const struct snd_soc_ops p1022_rdk_ops = {
 	.startup = p1022_rdk_startup,
 };
 
diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index ae403c2..66fb6c4 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -23,7 +23,7 @@
 
 static struct snd_soc_card imx_phycore;
 
-static struct snd_soc_ops imx_phycore_hifi_ops = {
+static const struct snd_soc_ops imx_phycore_hifi_ops = {
 };
 
 static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index b454972..cdaf163 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -139,7 +139,7 @@ static int wm1133_ev1_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops wm1133_ev1_ops = {
+static const struct snd_soc_ops wm1133_ev1_ops = {
 	.hw_params = wm1133_ev1_hw_params,
 };
 
-- 
2.7.4
