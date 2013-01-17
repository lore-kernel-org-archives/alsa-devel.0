From: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm2200: Set system clock control
	register is adsp structs
Date: Thu, 17 Jan 2013 13:11:47 +0000
Message-ID: <1358428307-30196-2-git-send-email-crattray@opensource.wolfsonmicro.com>
References: <1358428307-30196-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF2552651BC
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 14:12:14 +0100 (CET)
In-Reply-To: <1358428307-30196-1-git-send-email-crattray@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@ti.com, Chris Rattray <crattray@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allows ADSP control code to set the dsp clock rate to match the
sys clock rate.

Signed-off-by: Chris Rattray <crattray@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 5259ebd..0181444 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2205,6 +2205,9 @@ static int wm2200_i2c_probe(struct i2c_client *i2c,
 		wm2200->dsp[i].num = i + 1;
 		wm2200->dsp[i].dev = &i2c->dev;
 		wm2200->dsp[i].regmap = wm2200->regmap;
+		wm2200->dsp[i].sysclk_reg = WM2200_CLOCKING_3;
+		wm2200->dsp[i].sysclk_mask = WM2200_SYSCLK_FREQ_MASK;
+		wm2200->dsp[i].sysclk_shift =  WM2200_SYSCLK_FREQ_SHIFT;
 	}
 
 	wm2200->dsp[0].base = WM2200_DSP1_CONTROL_1;
-- 
1.7.2.5
