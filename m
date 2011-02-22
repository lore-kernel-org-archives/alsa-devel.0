From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Pass the jack to jack notifiers
Date: Tue, 22 Feb 2011 20:44:22 +0000
Message-ID: <1298407462-2311-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 027FC1037FB
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 21:44:24 +0100 (CET)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We're currently not passing anything and this will make the card and so on
more discoverable.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-jack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 1382251..fcab80b 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -101,7 +101,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	}
 
 	/* Report before the DAPM sync to help users updating micbias status */
-	blocking_notifier_call_chain(&jack->notifier, status, NULL);
+	blocking_notifier_call_chain(&jack->notifier, status, jack);
 
 	snd_soc_dapm_sync(dapm);
 
-- 
1.7.2.3
