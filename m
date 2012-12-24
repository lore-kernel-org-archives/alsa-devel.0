From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: Fix 'may be used uninitialized'
	warnings
Date: Mon, 24 Dec 2012 15:55:38 -0200
Message-ID: <1356371738-15997-2-git-send-email-festevam@gmail.com>
References: <1356371738-15997-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f181.google.com (mail-gg0-f181.google.com
 [209.85.161.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B1FC261640
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 18:56:04 +0100 (CET)
Received: by mail-gg0-f181.google.com with SMTP id s6so1259151ggc.12
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 09:56:03 -0800 (PST)
In-Reply-To: <1356371738-15997-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following build warnings:

sound/soc/codecs/wm_hubs.c: In function 'hp_event':
sound/soc/codecs/wm_hubs.c:321:11: warning: 'reg_r' may be used uninitialized in this function [-Wuninitialized]
sound/soc/codecs/wm_hubs.c:251:13: note: 'reg_r' was declared here
sound/soc/codecs/wm_hubs.c:322:11: warning: 'reg_l' may be used uninitialized in this function [-Wuninitialized]
sound/soc/codecs/wm_hubs.c:251:6: note: 'reg_l' was declared here

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm_hubs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 867ae97..a2ea687 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -248,7 +248,7 @@ static void enable_dc_servo(struct snd_soc_codec *codec)
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	struct wm_hubs_dcs_cache *cache;
 	s8 offset;
-	u16 reg_l, reg_r, dcs_cfg, dcs_reg;
+	u16 reg_l = 0, reg_r = 0, dcs_cfg, dcs_reg;
 
 	switch (hubs->dcs_readback_mode) {
 	case 2:
-- 
1.7.9.5
