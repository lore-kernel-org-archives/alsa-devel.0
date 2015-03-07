From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Remove unnecessary device_remove_file()
Date: Sat,  7 Mar 2015 19:35:08 +0100
Message-ID: <1425753308-28695-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-248.synserver.de (smtp-out-006.synserver.de
 [212.40.185.6]) by alsa0.perex.cz (Postfix) with ESMTP id 6B9B926063E
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 19:35:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since commit d29697dc3b92 ("ASoC: Add sysfs entries via static attribute
groups") the sysfs attributes of the rtd are manged by the device core and
there is no need to manually call device_remove_file() anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5c0658d..161af04 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1410,7 +1410,6 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
-		device_remove_file(rtd->dev, &dev_attr_codec_reg);
 		device_unregister(rtd->dev);
 		rtd->dev_registered = 0;
 	}
-- 
1.8.0
