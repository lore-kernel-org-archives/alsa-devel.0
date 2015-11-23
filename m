From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: core: add a dapm sink widget
Date: Mon, 23 Nov 2015 21:22:30 +0530
Message-ID: <1448293951-32071-3-git-send-email-vinod.koul@intel.com>
References: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D493265824
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 16:48:47 +0100 (CET)
In-Reply-To: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

DAPM models various widgets but lacks a sink widget.
DSPs can have modules which take audio data, process it and are
capable of generating events thus acting as a sink of data.

To make the dapm graph complete for such paths we need a dapm
sink widget for these modules, so add a SND_SOC_DAPM_SINK to
declare such a widget.
This widget will be treated as SND_SOC_DAPM_EP_SINK endpoint in
the dapm graph

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dapm.h | 4 ++++
 sound/soc/soc-dapm.c     | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 7855cfe46b69..fe19dd3abb00 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -49,6 +49,9 @@ struct device;
 #define SND_SOC_DAPM_SIGGEN(wname) \
 {	.id = snd_soc_dapm_siggen, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
+#define SND_SOC_DAPM_SINK(wname) \
+{	.id = snd_soc_dapm_sink, .name = wname, .kcontrol_news = NULL, \
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_INPUT(wname) \
 {	.id = snd_soc_dapm_input, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
@@ -484,6 +487,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_aif_in,		/* audio interface input */
 	snd_soc_dapm_aif_out,		/* audio interface output */
 	snd_soc_dapm_siggen,		/* signal generator */
+	snd_soc_dapm_sink,
 	snd_soc_dapm_dai_in,		/* link to DAI structure */
 	snd_soc_dapm_dai_out,
 	snd_soc_dapm_dai_link,		/* link between two DAI structures */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3eba72c6f9dd..506677b12787 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3351,6 +3351,11 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->is_ep = SND_SOC_DAPM_EP_SOURCE;
 		w->power_check = dapm_always_on_check_power;
 		break;
+	case snd_soc_dapm_sink:
+		w->is_ep = SND_SOC_DAPM_EP_SINK;
+		w->power_check = dapm_always_on_check_power;
+		break;
+
 	case snd_soc_dapm_mux:
 	case snd_soc_dapm_demux:
 	case snd_soc_dapm_switch:
-- 
1.9.1
