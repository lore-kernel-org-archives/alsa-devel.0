From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: ssm4567: Remove duplicated else-if branch
Date: Wed,  1 Oct 2014 10:15:57 -0700
Message-ID: <1412183757-26843-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f201.google.com (mail-ie0-f201.google.com
 [209.85.223.201])
 by alsa0.perex.cz (Postfix) with ESMTP id DDDCC2604C9
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 19:16:27 +0200 (CEST)
Received: by mail-ie0-f201.google.com with SMTP id rl12so49241iec.4
 for <alsa-devel@alsa-project.org>; Wed, 01 Oct 2014 10:16:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lars@metafoo.de, dan.carpenter@oracle.com
Cc: alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/ssm4567.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 1dadacb..4b5c17f 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -173,8 +173,6 @@ static int ssm4567_hw_params(struct snd_pcm_substream *substream,
 		dacfs = SSM4567_DAC_FS_32000_48000;
 	else if (rate >= 64000 && rate <= 96000)
 		dacfs = SSM4567_DAC_FS_64000_96000;
-	else if (rate >= 64000 && rate <= 96000)
-		dacfs = SSM4567_DAC_FS_64000_96000;
 	else if (rate >= 128000 && rate <= 192000)
 		dacfs = SSM4567_DAC_FS_128000_192000;
 	else
-- 
2.1.0.rc2.206.gedb03e5
