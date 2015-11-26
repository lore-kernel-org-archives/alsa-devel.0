From: pascal.huerst@gmail.com
Subject: [PATCH] ASoC: sigmadsp: Add check for return value of
	i2c_master_send
Date: Thu, 26 Nov 2015 14:00:15 +0100
Message-ID: <1448542815-14197-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F5A12619FB
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 14:00:52 +0100 (CET)
Received: by wmvv187 with SMTP id v187so30479014wmv.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 05:00:51 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Pascal Huerst <pascal.huerst@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Pascal Huerst <pascal.huerst@gmail.com>

i2c_master_send returns the number of bytes transmitted, which leads
to an error in the firmware download function. Check for the return
value and only return it directly, if it is an actual error number.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
---
 sound/soc/codecs/sigmadsp-i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sigmadsp-i2c.c b/sound/soc/codecs/sigmadsp-i2c.c
index 21ca3a5..d374c18 100644
--- a/sound/soc/codecs/sigmadsp-i2c.c
+++ b/sound/soc/codecs/sigmadsp-i2c.c
@@ -31,7 +31,10 @@ static int sigmadsp_write_i2c(void *control_data,

 	kfree(buf);

-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }

 static int sigmadsp_read_i2c(void *control_data,
--
2.4.3
