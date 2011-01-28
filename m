From: Harsha Priya <priya.harsha@intel.com>
Subject: [PATCH 3/3] ASoC: mid-x86: Add support for capture in
	machine driver
Date: Fri, 28 Jan 2011 22:28:32 +0530
Message-ID: <1296233912-6490-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id E80F224335
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 17:43:49 +0100 (CET)
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
Cc: Harsha Priya <priya.harsha@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This configures the capture unused pins

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/mfld_machine.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 1a330be..7925851 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -182,6 +182,9 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_disable_pin(dapm, "LINEOUTR");
 	lo_dac = 3;
 	hs_switch = 0;
+	/* we dont use linein in this so set to NC */
+	snd_soc_dapm_disable_pin(dapm, "LINEINL");
+	snd_soc_dapm_disable_pin(dapm, "LINEINR");
 	return snd_soc_dapm_sync(dapm);
 }
 
-- 
1.7.3.4
