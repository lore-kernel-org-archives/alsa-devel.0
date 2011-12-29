From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: Remove unused control type from
	wm8978 driver
Date: Thu, 29 Dec 2011 11:49:10 +0000
Message-ID: <1325159355-31686-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 726D924706
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 12:49:23 +0100 (CET)
In-Reply-To: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8978.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 0b1f7ad..2ba8f8c 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -50,7 +50,6 @@ static const u16 wm8978_reg[WM8978_CACHEREGNUM] = {
 
 /* codec private data */
 struct wm8978_priv {
-	enum snd_soc_control_type control_type;
 	unsigned int f_pllout;
 	unsigned int f_mclk;
 	unsigned int f_256fs;
-- 
1.7.7.3
