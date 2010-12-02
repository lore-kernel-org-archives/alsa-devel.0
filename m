From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Provide WM8731 microphone boost TLV
	information
Date: Thu,  2 Dec 2010 11:47:52 +0000
Message-ID: <1291290474-816-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F3271103A50
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:47:56 +0100 (CET)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 94e0cf3..c90e025 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -74,6 +74,7 @@ static const struct soc_enum wm8731_enum[] = {
 static const DECLARE_TLV_DB_SCALE(in_tlv, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(sidetone_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
+static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 2000, 0);
 
 static const struct snd_kcontrol_new wm8731_snd_controls[] = {
 
@@ -86,7 +87,7 @@ SOC_DOUBLE_R_TLV("Capture Volume", WM8731_LINVOL, WM8731_RINVOL, 0, 31, 0,
 		 in_tlv),
 SOC_DOUBLE_R("Line Capture Switch", WM8731_LINVOL, WM8731_RINVOL, 7, 1, 1),
 
-SOC_SINGLE("Mic Boost (+20dB)", WM8731_APANA, 0, 1, 0),
+SOC_SINGLE_TLV("Mic Boost Volume", WM8731_APANA, 0, 1, 0, mic_tlv),
 SOC_SINGLE("Mic Capture Switch", WM8731_APANA, 1, 1, 1),
 
 SOC_SINGLE_TLV("Sidetone Playback Volume", WM8731_APANA, 6, 3, 1,
-- 
1.7.1
