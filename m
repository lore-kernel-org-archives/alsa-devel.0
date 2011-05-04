From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 19/19] ASoC: upd9976: add capture volume for
	DMIC
Date: Wed, 04 May 2011 21:46:29 +0800
Message-ID: <20110504134629.32443.12908.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 3275E103937
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:45:06 +0200 (CEST)
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
 sound/soc/codecs/upd9976.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index 6fc9902..a35b891 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -115,6 +115,11 @@ static DECLARE_TLV_DB_SCALE(mixer_tlv, -2500, 100, 0);
  */
 static DECLARE_TLV_DB_SCALE(analog_tlv, -2500, 100, 0);
 
+/*
+ * DMIC Volume: from -63 dB to 1 dB in 1 db steps.
+ */
+static DECLARE_TLV_DB_SCALE(dmic_tlv, -6300, 100, 1);
+
 static const struct snd_kcontrol_new upd9976_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Headphone & Speaker Volume",
 			 UPD9976_HPSPRLVOL, UPD9976_HPSPRRVOL,
@@ -125,6 +130,8 @@ static const struct snd_kcontrol_new upd9976_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Analog Capture Volume",
 			 UPD9976_LILSEL, UPD9976_LILSEL,
 			 0, 0x1f, 1, analog_tlv),
+	SOC_SINGLE_TLV("Internal Mic Capture Volume",
+		       UPD9976_DMICCTRL1, 0, 0x3f, 1, dmic_tlv),
 };
 
 static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_left_controls[] = {
