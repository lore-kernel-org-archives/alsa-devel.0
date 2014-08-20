From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: sst-haswell-pcm: Move controls and
	DAPM elements to component
Date: Wed, 20 Aug 2014 13:08:48 +0200
Message-ID: <1408532929-26978-4-git-send-email-lars@metafoo.de>
References: <1408532929-26978-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-032.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 064BC2656E5
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 13:08:57 +0200 (CEST)
In-Reply-To: <1408532929-26978-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The sst-haswell-pcm driver registers both a snd_soc_component and a
snd_soc_platform and expects that the DAPM widgets for the DAIs registered by
component are added to the DAPM context of the platform. This requires us to
have a hack in the ASoC core which does so. Moving the DAPM elements over to
the component allows us to remove this hack.

While we are at it also move the controls over to the component. The controls
don't need the platform for anything other than snd_soc_platform_get_drvdata(),
this can easily be replaced by snd_soc_component_get_drvdata(). As the long
term goal is to register only a single component this is a step in the right
direction.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/intel/sst-haswell-pcm.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 1de0958..33fc5c3 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -138,11 +138,10 @@ static inline unsigned int hsw_ipc_to_mixer(u32 value)
 static int hsw_stream_volume_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_component_get_drvdata(cmpnt);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct hsw_priv_data *pdata =
-		snd_soc_platform_get_drvdata(platform);
 	struct hsw_pcm_data *pcm_data = &pdata->pcm[mc->reg];
 	struct sst_hsw *hsw = pdata->hsw;
 	u32 volume;
@@ -176,11 +175,10 @@ static int hsw_stream_volume_put(struct snd_kcontrol *kcontrol,
 static int hsw_stream_volume_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_component_get_drvdata(cmpnt);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct hsw_priv_data *pdata =
-		snd_soc_platform_get_drvdata(platform);
 	struct hsw_pcm_data *pcm_data = &pdata->pcm[mc->reg];
 	struct sst_hsw *hsw = pdata->hsw;
 	u32 volume;
@@ -208,8 +206,8 @@ static int hsw_stream_volume_get(struct snd_kcontrol *kcontrol,
 static int hsw_volume_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
-	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_component_get_drvdata(cmpnt);
 	struct sst_hsw *hsw = pdata->hsw;
 	u32 volume;
 
@@ -233,8 +231,8 @@ static int hsw_volume_put(struct snd_kcontrol *kcontrol,
 static int hsw_volume_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
-	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_component_get_drvdata(cmpnt);
 	struct sst_hsw *hsw = pdata->hsw;
 	unsigned int volume = 0;
 
@@ -839,16 +837,16 @@ static struct snd_soc_platform_driver hsw_soc_platform = {
 	.ops		= &hsw_pcm_ops,
 	.pcm_new	= hsw_pcm_new,
 	.pcm_free	= hsw_pcm_free,
-	.controls	= hsw_volume_controls,
-	.num_controls	= ARRAY_SIZE(hsw_volume_controls),
-	.dapm_widgets	= widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(widgets),
-	.dapm_routes	= graph,
-	.num_dapm_routes	= ARRAY_SIZE(graph),
 };
 
 static const struct snd_soc_component_driver hsw_dai_component = {
-	.name		= "haswell-dai",
+	.name = "haswell-dai",
+	.controls = hsw_volume_controls,
+	.num_controls = ARRAY_SIZE(hsw_volume_controls),
+	.dapm_widgets = widgets,
+	.num_dapm_widgets = ARRAY_SIZE(widgets),
+	.dapm_routes = graph,
+	.num_dapm_routes = ARRAY_SIZE(graph),
 };
 
 static int hsw_pcm_dev_probe(struct platform_device *pdev)
-- 
1.8.0
