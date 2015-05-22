From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 2/5] ASoC: jack - add_gpiods accepts filled
	descriptors
Date: Fri, 22 May 2015 15:09:20 -0700
Message-ID: <1432332563-15447-3-git-send-email-dgreid@chromium.org>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f74.google.com (mail-qg0-f74.google.com
 [209.85.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id C14D9260426
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 00:10:55 +0200 (CEST)
Received: by qgdz60 with SMTP id z60so1014861qgd.1
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:10:54 -0700 (PDT)
In-Reply-To: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
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
Cc: lars@metafoo.de, zhengxing@rock-chips.com, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Allow for the desc field to be pre-filled when adding gpios to a jack.
This allows drivers to get the gpios and decide if they should be added
to the list or not.  Specifically this will allow the gpio jack driver
to add gpios based on device property specifications.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/soc-jack.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 9f60c25..171c429 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -315,8 +315,11 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			goto undo;
 		}
 
-		if (gpios[i].gpiod_dev) {
-			/* GPIO descriptor */
+		if (gpios[i].desc) {
+			/* Already have a GPIO descriptor. */
+			goto got_gpio;
+		} else if (gpios[i].gpiod_dev) {
+			/* Get a GPIO descriptor */
 			gpios[i].desc = gpiod_get_index(gpios[i].gpiod_dev,
 							gpios[i].name,
 							gpios[i].idx, GPIOD_IN);
@@ -344,7 +347,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 
 			gpios[i].desc = gpio_to_desc(gpios[i].gpio);
 		}
-
+got_gpio:
 		INIT_DELAYED_WORK(&gpios[i].work, gpio_work);
 		gpios[i].jack = jack;
 
-- 
2.2.1.62.g3f15098
