From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: rt5659: Staticise rt5659_i2c_shutdown
Date: Tue, 12 Jan 2016 15:53:46 +0800
Message-ID: <1452585226.5282.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
 [209.85.220.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BDE9265312
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 08:53:51 +0100 (CET)
Received: by mail-pa0-f65.google.com with SMTP id pv5so26513622pac.0
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 23:53:51 -0800 (PST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 820d8fa..47c717f4 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4184,7 +4184,7 @@ static int rt5659_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-void rt5659_i2c_shutdown(struct i2c_client *client)
+static void rt5659_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5659_priv *rt5659 = i2c_get_clientdata(client);
 
-- 
2.1.4
