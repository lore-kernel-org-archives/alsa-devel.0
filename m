From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: byt-rt5640: Set card as fully
	routed
Date: Thu,  2 Oct 2014 13:29:09 +0300
Message-ID: <1412245749-17983-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1412245749-17983-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 128DD261555
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 12:29:23 +0200 (CEST)
In-Reply-To: <1412245749-17983-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Jan-Michael Brummer <jan.brummer@tabos.org>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Although it's not known does current version of byt-rt5640 cover all
possible variants it is better to set the fully_routed flag on in order to
disable unused codecs pins in known machines and get regression from
machines that use different routing than the default one.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index a9619b4201f9..88ad57fc58b2 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -209,6 +209,7 @@ static struct snd_soc_card byt_rt5640_card = {
 	.num_dapm_widgets = ARRAY_SIZE(byt_rt5640_widgets),
 	.dapm_routes = byt_rt5640_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(byt_rt5640_audio_map),
+	.fully_routed = true,
 };
 
 static int byt_rt5640_probe(struct platform_device *pdev)
-- 
2.1.0
