From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] ASoC: topology: Use kcalloc instead of
 kzalloc for array allocation
Date: Wed, 05 Aug 2015 22:34:22 +0800
Message-ID: <1438785262.9624.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 37E99265DFD
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 16:34:29 +0200 (CEST)
Received: by pabxd6 with SMTP id xd6so19960754pab.2
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2015 07:34:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Also remove unnecessary memset.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: One more kcalloc conversion in soc_tplg_dapm_widget_dmixer_create
 sound/soc/soc-topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 4dadb5e..e4b7fc6 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1069,7 +1069,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 	struct snd_soc_tplg_mixer_control *mc;
 	int i, err;
 
-	kc = kzalloc(sizeof(*kc) * num_kcontrols, GFP_KERNEL);
+	kc = kcalloc(num_kcontrols, sizeof(*kc), GFP_KERNEL);
 	if (kc == NULL)
 		return NULL;
 
@@ -1250,7 +1250,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 	struct snd_kcontrol_new *kc;
 	int i, err;
 
-	kc = kzalloc(sizeof(*kc) * count, GFP_KERNEL);
+	kc = kcalloc(count, sizeof(*kc), GFP_KERNEL);
 	if (!kc)
 		return NULL;
 
@@ -1273,7 +1273,6 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
 			be->hdr.name, be->hdr.access);
 
-		memset(kc, 0, sizeof(*kc));
 		kc[i].name = be->hdr.name;
 		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-- 
2.1.0
