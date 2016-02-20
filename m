From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] ASoC: max9867: Make max9867_i2c_id NULL
	terminated
Date: Sat, 20 Feb 2016 10:53:15 +0800
Message-ID: <1455936795.19371.1.camel@ingics.com>
References: <1455936752.19371.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id B1C33266AFE
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 03:53:20 +0100 (CET)
Received: by mail-pf0-f171.google.com with SMTP id x65so60907586pfb.1
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 18:53:20 -0800 (PST)
In-Reply-To: <1455936752.19371.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max9867.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 5a8481b..70b5406 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -512,6 +512,7 @@ static int max9867_i2c_remove(struct i2c_client *client)
 
 static const struct i2c_device_id max9867_i2c_id[] = {
 	{ "max9867", 0 },
+	{ }
 };
 
 static const struct of_device_id max9867_of_match[] = {
-- 
2.1.4
