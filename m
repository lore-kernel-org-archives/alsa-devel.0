From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Allow use sleeping gpio in soc-jack
Date: Thu, 10 Feb 2011 17:22:23 +0200
Message-ID: <1297351343-17297-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6A8932454A
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 16:22:25 +0100 (CET)
Received: by fxm5 with SMTP id 5so1602412fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 07:22:25 -0800 (PST)
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

It is safe to use sleeping gpio in snd_soc_jack_gpio_detect as it is not
called from interrupt context. This avoids WARN_ON from __gpio_get_value
if sleeping gpio is registered for jack.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Only compile tested.
---
 sound/soc/soc-jack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 99dbaf7..4579ee0 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -240,7 +240,7 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 	int enable;
 	int report;
 
-	enable = gpio_get_value(gpio->gpio);
+	enable = gpio_get_value_cansleep(gpio->gpio);
 	if (gpio->invert)
 		enable = !enable;
 
-- 
1.7.2.3
