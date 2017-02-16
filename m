From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Add machine pin widget for
	each port" to the asoc tree
Date: Thu, 16 Feb 2017 19:04:18 +0000
Message-ID: <E1ceRLm-0007Vh-6q@debutante>
References: <1484589477-7630-25-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B51D267044
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 20:04:26 +0100 (CET)
In-Reply-To: <1484589477-7630-25-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Add machine pin widget for each port

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

>From 0324e51b5ba405cd2d66e9e95430f6b9562d0ac0 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 7 Feb 2017 19:09:55 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Add machine pin widget for each port

Represent each port as machine DAPM pin widget. This helps in
enable/disable pin when monitor is connected/disconnected in case pcm
is rendered to multiple ports.

Create machine pin widgets  and pin switch kcontrol for each port and
report based on the pin status

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 130 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/hdac_hdmi.h |   2 +
 2 files changed, 132 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 0f2c1e823281..0a5510a3a8e1 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -95,6 +95,9 @@ struct hdac_hdmi_port {
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
 	struct hdac_hdmi_eld eld;
+	const char *jack_pin;
+	struct snd_soc_dapm_context *dapm;
+	const char *output_pin;
 };
 
 struct hdac_hdmi_pcm {
@@ -149,6 +152,11 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 {
 	struct hdac_ext_device *edev = port->pin->edev;
 
+	if (is_connect)
+		snd_soc_dapm_enable_pin(port->dapm, port->jack_pin);
+	else
+		snd_soc_dapm_disable_pin(port->dapm, port->jack_pin);
+
 	if (is_connect) {
 		/*
 		 * Report Jack connect event when a device is connected
@@ -174,6 +182,8 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 		if (pcm->jack_event > 0)
 			pcm->jack_event--;
 	}
+
+	snd_soc_dapm_sync(port->dapm);
 }
 
 /* MST supported verbs */
@@ -1059,6 +1069,7 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 					SND_SOC_DAPM_POST_PMD);
 			if (ret < 0)
 				return ret;
+			pin->ports[j].output_pin = widgets[i].name;
 			i++;
 		}
 	}
@@ -1557,6 +1568,125 @@ static struct snd_pcm *hdac_hdmi_get_pcm_from_id(struct snd_soc_card *card,
 	return NULL;
 }
 
+/* create jack pin kcontrols */
+static int create_fill_jack_kcontrols(struct snd_soc_card *card,
+				    struct hdac_ext_device *edev)
+{
+	struct hdac_hdmi_pin *pin;
+	struct snd_kcontrol_new *kc;
+	char kc_name[NAME_SIZE], xname[NAME_SIZE];
+	char *name;
+	int i = 0, j;
+	struct snd_soc_codec *codec = edev->scodec;
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+
+	kc = devm_kcalloc(codec->dev, hdmi->num_ports,
+				sizeof(*kc), GFP_KERNEL);
+
+	if (!kc)
+		return -ENOMEM;
+
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		for (j = 0; j < pin->num_ports; j++) {
+			snprintf(xname, sizeof(xname), "hif%d-%d Jack",
+						pin->nid, pin->ports[j].id);
+			name = devm_kstrdup(codec->dev, xname, GFP_KERNEL);
+			if (!name)
+				return -ENOMEM;
+			snprintf(kc_name, sizeof(kc_name), "%s Switch", xname);
+			kc[i].name = devm_kstrdup(codec->dev, kc_name,
+							GFP_KERNEL);
+			if (!kc[i].name)
+				return -ENOMEM;
+
+			kc[i].private_value = (unsigned long)name;
+			kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+			kc[i].access = 0;
+			kc[i].info = snd_soc_dapm_info_pin_switch;
+			kc[i].put = snd_soc_dapm_put_pin_switch;
+			kc[i].get = snd_soc_dapm_get_pin_switch;
+			i++;
+		}
+	}
+
+	return snd_soc_add_card_controls(card, kc, i);
+}
+
+int hdac_hdmi_jack_port_init(struct snd_soc_codec *codec,
+			struct snd_soc_dapm_context *dapm)
+{
+	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pin *pin;
+	struct snd_soc_dapm_widget *widgets;
+	struct snd_soc_dapm_route *route;
+	char w_name[NAME_SIZE];
+	int i = 0, j, ret;
+
+	widgets = devm_kcalloc(dapm->dev, hdmi->num_ports,
+				sizeof(*widgets), GFP_KERNEL);
+
+	if (!widgets)
+		return -ENOMEM;
+
+	route = devm_kcalloc(dapm->dev, hdmi->num_ports,
+				sizeof(*route), GFP_KERNEL);
+	if (!route)
+		return -ENOMEM;
+
+	/* create Jack DAPM widget */
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		for (j = 0; j < pin->num_ports; j++) {
+			snprintf(w_name, sizeof(w_name), "hif%d-%d Jack",
+						pin->nid, pin->ports[j].id);
+
+			ret = hdac_hdmi_fill_widget_info(dapm->dev, &widgets[i],
+					snd_soc_dapm_spk, NULL,
+					w_name, NULL, NULL, 0, NULL, 0);
+			if (ret < 0)
+				return ret;
+
+			pin->ports[j].jack_pin = widgets[i].name;
+			pin->ports[j].dapm = dapm;
+
+			/* add to route from Jack widget to output */
+			hdac_hdmi_fill_route(&route[i], pin->ports[j].jack_pin,
+					NULL, pin->ports[j].output_pin, NULL);
+
+			i++;
+		}
+	}
+
+	/* Add Route from Jack widget to the output widget */
+	ret = snd_soc_dapm_new_controls(dapm, widgets, hdmi->num_ports);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dapm_add_routes(dapm, route, hdmi->num_ports);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dapm_new_widgets(dapm->card);
+	if (ret < 0)
+		return ret;
+
+	/* Add Jack Pin switch Kcontrol */
+	ret = create_fill_jack_kcontrols(dapm->card, edev);
+
+	if (ret < 0)
+		return ret;
+
+	/* default set the Jack Pin switch to OFF */
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		for (j = 0; j < pin->num_ports; j++)
+			snd_soc_dapm_disable_pin(pin->ports[j].dapm,
+						pin->ports[j].jack_pin);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hdac_hdmi_jack_port_init);
+
 int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 				struct snd_soc_jack *jack)
 {
diff --git a/sound/soc/codecs/hdac_hdmi.h b/sound/soc/codecs/hdac_hdmi.h
index bf7edb3227d2..dfc3a9cf7199 100644
--- a/sound/soc/codecs/hdac_hdmi.h
+++ b/sound/soc/codecs/hdac_hdmi.h
@@ -4,4 +4,6 @@
 int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm,
 				struct snd_soc_jack *jack);
 
+int hdac_hdmi_jack_port_init(struct snd_soc_codec *codec,
+			struct snd_soc_dapm_context *dapm);
 #endif /* __HDAC_HDMI_H__ */
-- 
2.11.0
