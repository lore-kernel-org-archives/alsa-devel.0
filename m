From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2 10/10] ASoC: mrst_machine: add initial
 config to machine driver
Date: Fri, 06 May 2011 13:46:49 +0800
Message-ID: <20110506054649.26312.81715.stgit@localhost>
References: <20110506053852.26312.79083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D9E1103AA5
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 07:45:22 +0200 (CEST)
In-Reply-To: <20110506053852.26312.79083.stgit@localhost>
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

On Moorestown, DMIC's output is set to PCM2 mono.
And the Moorestown uses MIC2 pseudo-differential configuration.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/mrst_machine.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/mrst_machine.c b/sound/soc/mid-x86/mrst_machine.c
index eb52a2b..806d18c 100644
--- a/sound/soc/mid-x86/mrst_machine.c
+++ b/sound/soc/mid-x86/mrst_machine.c
@@ -91,6 +91,12 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
+	/* DMIC configuration: mono output to PCM2 */
+	snd_soc_update_bits(codec, UPD9976_MICCTRL, BIT(1)|BIT(0), 0x1);
+
+	/* Set MIC2 to pseudo-differential */
+	snd_soc_update_bits(codec, UPD9976_MICSELVOL, BIT(4), BIT(4));
+
 	snd_soc_dapm_nc_pin(dapm, "LINEINL");
 	snd_soc_dapm_nc_pin(dapm, "LINEINR");
 	snd_soc_dapm_nc_pin(dapm, "LINEOUTL");
