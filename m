From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Explicitly clear WM8993 ramp controls on
	power down
Date: Tue, 14 Dec 2010 11:27:40 +0000
Message-ID: <1292326060-13913-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C9CB245B2
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 12:27:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This helps ensure that the ramp logic is reset when powering back up.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 77b1d44..15f34a2 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1030,6 +1030,12 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 				    WM8993_VMID_SEL_MASK | WM8993_BIAS_ENA,
 				    0);
 
+		snd_soc_update_bits(codec, WM8993_ANTIPOP2,
+				    WM8993_STARTUP_BIAS_ENA |
+				    WM8993_VMID_BUF_ENA |
+				    WM8993_VMID_RAMP_MASK |
+				    WM8993_BIAS_SRC, 0);
+
 #ifdef CONFIG_REGULATOR
                /* Post 2.6.34 we will be able to get a callback when
                 * the regulators are disabled which we can use but
-- 
1.7.1
