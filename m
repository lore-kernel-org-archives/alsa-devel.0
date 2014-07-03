From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: adau1701: fix adau1701_reg_read()
Date: Thu,  3 Jul 2014 16:51:36 +0200
Message-ID: <1404399096-4056-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FCEA261A49
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 16:51:43 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id u56so371263wes.21
 for <alsa-devel@alsa-project.org>; Thu, 03 Jul 2014 07:51:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix a long standing bug in the read register routing of adau1701.
The bytes arrive in the buffer in big-endian, so the result has to be
shifted before and-ing the bytes in the loop.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/adau1701.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index defb277..15feb12 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -240,8 +240,10 @@ static int adau1701_reg_read(void *context, unsigned int reg,
 
 	*value = 0;
 
-	for (i = 0; i < size; i++)
-		*value |= recv_buf[i] << (i * 8);
+	for (i = 0; i < size; i++) {
+		*value <<= 8;
+		*value |= recv_buf[i];
+	}
 
 	return 0;
 }
-- 
1.9.3
