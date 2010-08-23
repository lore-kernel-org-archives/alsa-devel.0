From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: omap: rx51: Use gpio_set_value_cansleep
	for speaker amp control
Date: Mon, 23 Aug 2010 10:36:41 +0300
Message-ID: <1282549001-10391-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 89DB52442E
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 09:36:10 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2943804ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 00:36:09 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Speaker amplifier is controlled by TWL4030 GPIO which may sleep. Therefore
use gpio_set_value_cansleep to get rid of runtime warning that is introduced
after the commit 9c4ba94 and to get a stack trace if ever executing this
code in atomic context.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/rx51.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index d1d8098..04b5723 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -146,9 +146,9 @@ static int rx51_spk_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpio_set_value(RX51_SPEAKER_AMP_TWL_GPIO, 1);
+		gpio_set_value_cansleep(RX51_SPEAKER_AMP_TWL_GPIO, 1);
 	else
-		gpio_set_value(RX51_SPEAKER_AMP_TWL_GPIO, 0);
+		gpio_set_value_cansleep(RX51_SPEAKER_AMP_TWL_GPIO, 0);
 
 	return 0;
 }
-- 
1.7.1
