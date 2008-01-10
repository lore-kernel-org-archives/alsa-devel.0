From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/17] Initial WM8753 TLV support for capture
	mixer.
Date: Thu, 10 Jan 2008 13:17:10 +0000
Message-ID: <1199971035-13553-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-11-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 65CCA24588
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:19 +0100 (CET)
In-Reply-To: <1199971035-13553-11-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <lg@opensource.wolfsonmicro.com>

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8753.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index efced93..ba16375 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -48,6 +48,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 #include <asm/div64.h>
 
 #include "wm8753.h"
@@ -258,6 +259,8 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
+
 static const struct snd_kcontrol_new wm8753_snd_controls[] = {
 SOC_DOUBLE_R("PCM Volume", WM8753_LDAC, WM8753_RDAC, 0, 255, 0),
 
@@ -287,8 +290,8 @@ SOC_SINGLE("Bass Volume", WM8753_BASS, 0, 15, 1),
 SOC_SINGLE("Treble Volume", WM8753_TREBLE, 0, 15, 1),
 SOC_ENUM("Treble Cut-off", wm8753_enum[2]),
 
-SOC_DOUBLE("Sidetone Capture Volume", WM8753_RECMIX1, 0, 4, 7, 1),
-SOC_SINGLE("Voice Sidetone Capture Volume", WM8753_RECMIX2, 0, 7, 1),
+SOC_DOUBLE_TLV("Sidetone Capture Volume", WM8753_RECMIX1, 0, 4, 7, 1, rec_mix_tlv),
+SOC_SINGLE_TLV("Voice Sidetone Capture Volume", WM8753_RECMIX2, 0, 7, 1, rec_mix_tlv),
 
 SOC_DOUBLE_R("Capture Volume", WM8753_LINVOL, WM8753_RINVOL, 0, 63, 0),
 SOC_DOUBLE_R("Capture ZC Switch", WM8753_LINVOL, WM8753_RINVOL, 6, 1, 0),
-- 
1.5.3.8
