From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: arizona: Add more clock rates
Date: Wed, 26 Sep 2012 19:01:23 +0100
Message-ID: <1348682484-18929-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 751D2262616
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2012 20:01:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some devices support additional clock rates.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 5764960..c03b65a 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -270,6 +270,9 @@ static unsigned int arizona_sysclk_48k_rates[] = {
 	12288000,
 	22579200,
 	49152000,
+	73728000,
+	98304000,
+	147456000,
 };
 
 static unsigned int arizona_sysclk_44k1_rates[] = {
@@ -277,6 +280,9 @@ static unsigned int arizona_sysclk_44k1_rates[] = {
 	11289600,
 	24576000,
 	45158400,
+	67737600,
+	90316800,
+	135475200,
 };
 
 static int arizona_set_opclk(struct snd_soc_codec *codec, unsigned int clk,
-- 
1.7.10.4
