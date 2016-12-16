From: mengdong.lin@linux.intel.com
Subject: [RFC PATCH 2/2] ASoC: Intel: Use DMI name for sound
	card long name in Broadwell machine driver
Date: Fri, 16 Dec 2016 10:51:12 +0800
Message-ID: <92fa36740f6bafbbdcbaf56c2edd56bcd182df21.1481856472.git.mengdong.lin@linux.intel.com>
References: <cover.1481856472.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 00E21266726
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 03:48:42 +0100 (CET)
In-Reply-To: <cover.1481856472.git.mengdong.lin@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Intel Broadwell machine driver will call API snd_soc_set_dmi_name() to use
DMI info to make the sound card long name.

Here are the changed long name for two Broadwell-based machines:
             short name & driver name   long name
WilsonBeach:       broadwell-rt286      broadwell-rt286-Intel-Wilson-Beach
Dell XPS-13(2015): broadwell-rt286      broadwell-rt286-Dell-XPS

The card short name has no change, and ASoC will use the card name as the
card driver name.

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
