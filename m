From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: hdac_hdmi: Configure pin verbs for MST"
	to the asoc tree
Date: Thu, 16 Feb 2017 19:04:42 +0000
Message-ID: <E1ceRMA-0007dy-5n@debutante>
References: <1484589477-7630-17-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EFCFF2670C1
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 20:04:50 +0100 (CET)
In-Reply-To: <1484589477-7630-17-git-send-email-jeeja.kp@intel.com>
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

   ASoc: hdac_hdmi: Configure pin verbs for MST

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

>From 1b46ebd136b3ad334762d6e66b0b96b432680e50 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 7 Feb 2017 19:09:47 +0530
Subject: [PATCH] ASoc: hdac_hdmi: Configure pin verbs for MST

To enable stream on a specific port of a MST capable pin, the port
needs to be selected before we configure the pin widget verb.

When port is selected, all the pin widget verb controlling the sink
device operation will be directed to selected port. So add port
selection before configuring the pin widget verb.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index c5527e81a490..6cf86a0a118c 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -448,6 +448,9 @@ static int hdac_hdmi_query_port_connlist(struct hdac_ext_device *hdac,
 		return -EINVAL;
 	}
 
+	if (hdac_hdmi_port_select_set(hdac, port) < 0)
+		return -EIO;
+
 	port->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
 			port->mux_nids, HDA_MAX_CONNECTIONS);
 	if (port->num_mux_nids == 0)
@@ -687,6 +690,10 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,
 	if (!pcm)
 		return -EIO;
 
+	/* set the device if pin is mst_capable */
+	if (hdac_hdmi_port_select_set(edev, port) < 0)
+		return -EIO;
+
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		hdac_hdmi_set_power_state(edev, port->pin->nid, AC_PWRST_D0);
@@ -775,6 +782,11 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,
 		kc  = w->kcontrols[0];
 
 	mux_idx = dapm_kcontrol_get_value(kc);
+
+	/* set the device if pin is mst_capable */
+	if (hdac_hdmi_port_select_set(edev, port) < 0)
+		return -EIO;
+
 	if (mux_idx > 0) {
 		snd_hdac_codec_write(&edev->hdac, port->pin->nid, 0,
 			AC_VERB_SET_CONNECT_SEL, (mux_idx - 1));
-- 
2.11.0
