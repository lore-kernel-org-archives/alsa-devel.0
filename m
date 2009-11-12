From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: Add jack_status_check callback function
Date: Thu, 12 Nov 2009 17:14:04 +0900
Message-ID: <4AFBC3CC.9070906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 8570B103866
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 09:14:09 +0100 (CET)
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KSZ00ET2LJGPZ@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 12 Nov 2009 17:14:04 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KSZ0079OLJGBB@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 12 Nov 2009 17:14:04 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The jack_status_check callback function is the interface to check the
status of the jack. Some target provides the method to distinguish what
is the jack inserted - headphone jack, microphone jack, tvout jack, etc,
so we can implement it using the jack_status_check function.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-jack.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9323dcb..f66773b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -333,6 +333,8 @@ struct snd_soc_jack_gpio {
 	int debounce_time;
 	struct snd_soc_jack *jack;
 	struct work_struct work;
+
+	int (*jack_status_check)(void);
 };
 #endif
 
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 1212414..3c07a94 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -163,6 +163,9 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 	else
 		report = 0;
 
+	if (gpio->jack_status_check)
+		report = gpio->jack_status_check();
+
 	snd_soc_jack_report(jack, report, gpio->report);
 }
 
-- 
1.6.0.4
