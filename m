From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] Sound, SoC,
 WM9090: Remove unused variable 'wm9090' from wm9090_i2c_remove()
Date: Sat, 28 Jan 2012 00:57:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1201280055410.13952@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115])
	by alsa0.perex.cz (Postfix) with ESMTP id EA1F8103840
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2012 00:57:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The variable 'wm9090' is assigned to but never used, so let's just
remove it.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/soc/codecs/wm9090.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

	compile teste only

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 41ebe0d..db1ba30 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -655,10 +655,7 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 
 static int __devexit wm9090_i2c_remove(struct i2c_client *i2c)
 {
-	struct wm9090_priv *wm9090 = i2c_get_clientdata(i2c);
-
 	snd_soc_unregister_codec(&i2c->dev);
-
 	return 0;
 }
 
-- 
1.7.8.4


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
