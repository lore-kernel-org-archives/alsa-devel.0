From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ASoC: topology: Fix not to keep a reference to
	tplg fw
Date: Thu, 26 Nov 2015 19:41:00 +0530
Message-ID: <1448547060-32749-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 60BF72665A0
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 09:40:12 +0100 (CET)
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
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

During element creation, the name of some of the elements point
to memory referenced in tplg fw. If the tplg fw is released after
tplg is parsed by framework, kernel panic happens during creation
of elements while card initialization.

Issue is caught with id#87b5ed8ecb9fe05a696e1c0b53c7a49ea66432c1

So create a copy of the memory and assign to names instead.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-topology.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 6963ba2..61eb1de 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -709,7 +709,7 @@ static int soc_tplg_dbytes_create(struct soc_tplg *tplg, unsigned int count,
 			be->hdr.name, be->hdr.access);
 
 		memset(&kc, 0, sizeof(kc));
-		kc.name = be->hdr.name;
+		kc.name = kstrdup(be->hdr.name, GFP_KERNEL);
 		kc.private_value = (long)sbe;
 		kc.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc.access = be->hdr.access;
@@ -789,7 +789,7 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, unsigned int count,
 			mc->hdr.name, mc->hdr.access);
 
 		memset(&kc, 0, sizeof(kc));
-		kc.name = mc->hdr.name;
+		kc.name = kstrdup(mc->hdr.name, GFP_KERNEL);
 		kc.private_value = (long)sm;
 		kc.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc.access = mc->hdr.access;
@@ -935,7 +935,7 @@ static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 			ec->hdr.name, ec->items);
 
 		memset(&kc, 0, sizeof(kc));
-		kc.name = ec->hdr.name;
+		kc.name = kstrdup(ec->hdr.name, GFP_KERNEL);
 		kc.private_value = (long)se;
 		kc.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc.access = ec->hdr.access;
@@ -1105,8 +1105,8 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
 			return -EINVAL;
 
-		route.source = elem->source;
-		route.sink = elem->sink;
+		route.source = kstrdup(elem->source, GFP_KERNEL);
+		route.sink = kstrdup(elem->sink, GFP_KERNEL);
 		route.connected = NULL; /* set to NULL atm for tplg users */
 		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0)
 			route.control = NULL;
@@ -1149,7 +1149,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		dev_dbg(tplg->dev, " adding DAPM widget mixer control %s at %d\n",
 			mc->hdr.name, i);
 
-		kc[i].name = mc->hdr.name;
+		kc[i].name = kstrdup(mc->hdr.name, GFP_KERNEL);
 		kc[i].private_value = (long)sm;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = mc->hdr.access;
@@ -1228,7 +1228,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 	dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
 		ec->hdr.name);
 
-	kc->name = ec->hdr.name;
+	kc->name = kstrdup(ec->hdr.name, GFP_KERNEL);
 	kc->private_value = (long)se;
 	kc->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	kc->access = ec->hdr.access;
@@ -1330,7 +1330,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
 			be->hdr.name, be->hdr.access);
 
-		kc[i].name = be->hdr.name;
+		kc[i].name = kstrdup(be->hdr.name, GFP_KERNEL);
 		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = be->hdr.access;
-- 
1.9.1
