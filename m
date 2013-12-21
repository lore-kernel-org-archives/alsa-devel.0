From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: pcm1792a: Remove redundant
	of_match_ptr helper
Date: Sat, 21 Dec 2013 13:45:47 +0530
Message-ID: <1387613747-22784-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A9269262600
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 09:19:05 +0100 (CET)
Received: by mail-pb0-f45.google.com with SMTP id rp16so3546376pbb.4
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 00:19:04 -0800 (PST)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org

'pcm1792a_of_match' is always compiled in. Hence the
helper macro is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/pcm1792a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 7146653a8e16..f4d9b769bcda 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -244,7 +244,7 @@ static struct spi_driver pcm1792a_codec_driver = {
 	.driver = {
 		.name = "pcm1792a",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(pcm1792a_of_match),
+		.of_match_table = pcm1792a_of_match,
 	},
 	.id_table = pcm1792a_spi_ids,
 	.probe = pcm1792a_spi_probe,
-- 
1.7.9.5
