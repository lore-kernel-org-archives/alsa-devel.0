From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 18/19] ASoC: upd9976: add capture volume for
	analog inputs
Date: Wed, 04 May 2011 21:46:24 +0800
Message-ID: <20110504134624.32443.39421.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 3729E10397E
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:45:01 +0200 (CEST)
In-Reply-To: <20110504133756.32443.6282.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/upd9976.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index f345db1..6fc9902 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -110,6 +110,11 @@ static int upd9976_mic2_bias_event(struct snd_soc_dapm_widget *widget,
  */
 static DECLARE_TLV_DB_SCALE(mixer_tlv, -2500, 100, 0);
 
+/*
+ * Analog Volume: from -25 dB to 6 dB in 1 dB steps.
+ */
+static DECLARE_TLV_DB_SCALE(analog_tlv, -2500, 100, 0);
+
 static const struct snd_kcontrol_new upd9976_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Headphone & Speaker Volume",
 			 UPD9976_HPSPRLVOL, UPD9976_HPSPRRVOL,
@@ -117,6 +122,9 @@ static const struct snd_kcontrol_new upd9976_snd_controls[] = {
 	SOC_SINGLE("Internal Mic Switch", UPD9976_DMICCTRL1, 6, 1, 0),
 	SOC_DOUBLE_R("Analog Mic Switch", UPD9976_LILSEL, UPD9976_LIRSEL,
 		     6, 1, 0),
+	SOC_DOUBLE_R_TLV("Analog Capture Volume",
+			 UPD9976_LILSEL, UPD9976_LILSEL,
+			 0, 0x1f, 1, analog_tlv),
 };
 
 static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_left_controls[] = {
