From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/2] ASoC: Intel: Use DMI name for sound card
	long name in Broadwell machine driver
Date: Wed, 21 Dec 2016 21:04:27 +0800
Message-ID: <30c7d2ce1baa8565a7be043d9919d60ea96995e7.1482324245.git.mengdong.lin@linux.intel.com>
References: <cover.1482324245.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DC5DB26058A
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2016 14:01:49 +0100 (CET)
In-Reply-To: <cover.1482324245.git.mengdong.lin@linux.intel.com>
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

Here are the changed long name for two Broadwell-based machines:
Dell XPS-13(2015): broadwell-rt286-Dell Inc.-XPS 13 9343-0310JH

Intel WilsonBeach:
broadwell-rt286-Intel Corp.-Broadwell Client platform-Wilson Beach SDS

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
