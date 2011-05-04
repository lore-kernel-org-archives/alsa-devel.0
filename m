From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 17/19] ASoC: mrst_machine: make MIC2
	pseudo-differential
Date: Wed, 04 May 2011 21:46:19 +0800
Message-ID: <20110504134619.32443.43341.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C1E4103991
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:44:55 +0200 (CEST)
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

The Moorestown uses MIC2 pseudo-differential configuration.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/mrst_machine.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/mrst_machine.c b/sound/soc/mid-x86/mrst_machine.c
index 5f19df5..7ea5bc5 100644
--- a/sound/soc/mid-x86/mrst_machine.c
+++ b/sound/soc/mid-x86/mrst_machine.c
@@ -163,6 +163,9 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
 	/* DMIC configuration: mono output to PCM2 */
 	snd_soc_update_bits(codec, UPD9976_MICCTRL, BIT(1)|BIT(0), 0x1);
 
+	/* Set MIC2 to pseudo-differential */
+	snd_soc_update_bits(codec, UPD9976_MICSELVOL, BIT(4), BIT(4));
+
 	ret = snd_soc_dapm_new_controls(dapm,
 					mrst_audio_widgets,
 					ARRAY_SIZE(mrst_audio_widgets));
