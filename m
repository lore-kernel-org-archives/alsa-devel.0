From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: topology: fix memory leaks on sm, se and sbe
Date: Thu, 27 Jun 2019 14:32:08 +0100
Message-ID: <20190627133208.9550-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Currently when a kstrdup fails the error exit paths don't free
the allocations for sm, se and sbe.  This can be fixed by assigning
kc[i].private_value to these before doing the ksrtdup so that the error
exit path will be able to free these objects.

Addresses-Coverity: ("Resource leak")
Fixes: 9f90af3a9952 ("ASoC: topology: Consolidate and fix asoc_tplg_dapm_widget_*_create flow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index fc1f1d6f9e92..dc463f1a9e24 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1326,10 +1326,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		dev_dbg(tplg->dev, " adding DAPM widget mixer control %s at %d\n",
 			mc->hdr.name, i);
 
+		kc[i].private_value = (long)sm;
 		kc[i].name = kstrdup(mc->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_sm;
-		kc[i].private_value = (long)sm;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = mc->hdr.access;
 
@@ -1412,10 +1412,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
 			ec->hdr.name);
 
+		kc[i].private_value = (long)se;
 		kc[i].name = kstrdup(ec->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_se;
-		kc[i].private_value = (long)se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = ec->hdr.access;
 
@@ -1524,10 +1524,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
 			be->hdr.name, be->hdr.access);
 
+		kc[i].private_value = (long)sbe;
 		kc[i].name = kstrdup(be->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_sbe;
-		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = be->hdr.access;
 
-- 
2.20.1
