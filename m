From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 2/2] ASoC: Intel: Use DMI name for sound
	card long name in Broadwell machine driver
Date: Tue, 10 Jan 2017 14:43:01 +0800
Message-ID: <4488bf420b4d6769005293d779f8731d8779defe.1484030246.git.mengdong.lin@linux.intel.com>
References: <cover.1484030246.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D1BEA2671B9
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 07:39:56 +0100 (CET)
In-Reply-To: <cover.1484030246.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Intel Broadwell machine driver will call API snd_soc_set_dmi_name() to
use DMI info to make the sound card long name.

For example, here are the changed long name for two Broadwell-based
machines:
Dell XPS-13(2015): DellInc..XPS139343.01.0310JH
Intel WilsonBeach: Intel Corp..BroadwellClientplatform.0.1.WilsonBeachSDS

They still share the same card name "broadwell-rt286".

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 5bb64d1..cda73bb 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -266,6 +266,8 @@ static int broadwell_audio_probe(struct platform_device *pdev)
 {
 	broadwell_rt286.dev = &pdev->dev;
 
+	snd_soc_set_dmi_name(&broadwell_rt286, NULL);
+
 	return devm_snd_soc_register_card(&pdev->dev, &broadwell_rt286);
 }
 
-- 
2.5.0
