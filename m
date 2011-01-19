From: Harsha Priya <priya.harsha@intel.com>
Subject: [PATCH 3/4] ASoC: mid-x86: Add support for capture in
	machine driver
Date: Wed, 19 Jan 2011 18:17:01 +0530
Message-ID: <1295441221-32132-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 176281039A6
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 13:32:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This configures the capture unused pins and sets
the DMIC cfg by default (also done by user)

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/mid-x86/mfld_machine.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 1a330be..1cd49a2 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -182,6 +182,13 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_disable_pin(dapm, "LINEOUTR");
 	lo_dac = 3;
 	hs_switch = 0;
+	/* we dont use linein in this so set to NC */
+	snd_soc_dapm_disable_pin(dapm, "LINEINL");
+	snd_soc_dapm_disable_pin(dapm, "LINEINR");
+	/* we are using DMICs here so configure how the clock and out pin is set */
+	snd_soc_write(codec, SN95031_DMICBUF0123, 0x85);
+	snd_soc_write(codec, SN95031_DMICBUF45, 0x02);
+	snd_soc_update_bits(codec, SN95031_DMICMUX, 0x7, 0x07);
 	return snd_soc_dapm_sync(dapm);
 }
 
-- 
1.7.2.3
