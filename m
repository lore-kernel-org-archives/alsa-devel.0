From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm0010: Up the completion timeout to
	20ms instead of 10ms
Date: Wed, 21 Nov 2012 10:47:44 +0000
Message-ID: <1353494864-29289-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2AF1E265CD2
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 11:49:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Increase timeout to be more reliable and avoid the chance of
missing interrupts during boot.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 4b68ea8..8ebb8da 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -614,7 +614,7 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	}
 
 	if (!wait_for_completion_timeout(&wm0010->boot_completion,
-					 msecs_to_jiffies(10)))
+					 msecs_to_jiffies(20)))
 		dev_err(codec->dev, "Failed to get interrupt from DSP\n");
 
 	spin_lock_irqsave(&wm0010->irq_lock, flags);
@@ -626,7 +626,7 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		goto abort;
 
 	if (!wait_for_completion_timeout(&wm0010->boot_completion,
-					 msecs_to_jiffies(10)))
+					 msecs_to_jiffies(20)))
 		dev_err(codec->dev, "Failed to get interrupt from DSP loader.\n");
 
 	spin_lock_irqsave(&wm0010->irq_lock, flags);
-- 
1.8.0
