From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: topology: Use kcalloc instead of kzalloc
 for array allocation
Date: Wed, 05 Aug 2015 17:57:12 +0800
Message-ID: <1438768632.27904.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id CC42B265CC5
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 11:57:18 +0200 (CEST)
Received: by pacgq8 with SMTP id gq8so31925154pac.3
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2015 02:57:17 -0700 (PDT)
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
 sound/soc/soc-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 4dadb5e..a5eb48e 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
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
