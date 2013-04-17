From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ASoC: max98088: Fix logging of hardware
	revision.
Date: Tue, 16 Apr 2013 20:02:34 -0700
Message-ID: <1366167754-14664-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f201.google.com (mail-gh0-f201.google.com
 [209.85.160.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B683260321
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 05:02:43 +0200 (CEST)
Received: by mail-gh0-f201.google.com with SMTP id r13so38811ghr.2
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 20:02:42 -0700 (PDT)
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
Cc: Dylan Reid <dgreid@chromium.org>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The hardware revision of the codec is based at 0x40.  Subtract that
before convering to ASCII.  The same as it is done for 98095.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/codecs/max98088.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 3a7b7fd..3eeada5 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -2024,7 +2024,7 @@ static int max98088_probe(struct snd_soc_codec *codec)
                        ret);
                goto err_access;
        }
-       dev_info(codec->dev, "revision %c\n", ret + 'A');
+       dev_info(codec->dev, "revision %c\n", ret - 0x40 + 'A');
 
        snd_soc_write(codec, M98088_REG_51_PWR_SYS, M98088_PWRSV);
 
-- 
1.8.1.3.605.g02339dd
