From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] wm8974: fix a wrong bit definition
Date: Thu, 17 Dec 2009 14:51:35 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0912171441260.5991@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id A08C6243AE
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 14:51:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The wm8974 datasheet defines BUFIOEN as bit 2.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

no idea if this would break anything, so, please test. Maybe the correct 
fix would be to actually use a correct name for bit 4, but who wants to 
enable Mic bias when putting bias into standby?...

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index eff2933..fb99433 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -47,7 +47,7 @@ static const u16 wm8974_reg[WM8974_CACHEREGNUM] = {
 };
 
 #define WM8974_POWER1_BIASEN  0x08
-#define WM8974_POWER1_BUFIOEN 0x10
+#define WM8974_POWER1_BUFIOEN 0x04
 
 struct wm8974_priv {
 	struct snd_soc_codec codec;
