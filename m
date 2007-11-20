From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Initial WM8753 TLV support for capture mixer.
Date: Tue, 20 Nov 2007 09:25:37 +0000
Message-ID: <1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A034224A03
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:42:36 +0100 (CET)
In-Reply-To: <1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: liam.girdwood@opensource.wolfsonmicro.com, Liam Girdwood <liam@localhost.localdomain>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam@localhost.localdomain>

---
 sound/soc/codecs/wm8753.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index efced93..8f2a6d1 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -48,6 +48,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 #include <asm/div64.h>
 
 #include "wm8753.h"
@@ -258,6 +259,11 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static const unsigned int rec_mix_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0,7, TLV_DB_LINEAR_ITEM(-1500, 600),
+};
+
 static const struct snd_kcontrol_new wm8753_snd_controls[] = {
 SOC_DOUBLE_R("PCM Volume", WM8753_LDAC, WM8753_RDAC, 0, 255, 0),
 
@@ -287,8 +293,8 @@ SOC_SINGLE("Bass Volume", WM8753_BASS, 0, 15, 1),
 SOC_SINGLE("Treble Volume", WM8753_TREBLE, 0, 15, 1),
 SOC_ENUM("Treble Cut-off", wm8753_enum[2]),
 
-SOC_DOUBLE("Sidetone Capture Volume", WM8753_RECMIX1, 0, 4, 7, 1),
-SOC_SINGLE("Voice Sidetone Capture Volume", WM8753_RECMIX2, 0, 7, 1),
+SOC_DOUBLE_TLV("Sidetone Capture Volume", WM8753_RECMIX1, 0, 4, 7, 1, rec_mix_tlv),
+SOC_SINGLE_TLV("Voice Sidetone Capture Volume", WM8753_RECMIX2, 0, 7, 1, rec_mix_tlv),
 
 SOC_DOUBLE_R("Capture Volume", WM8753_LINVOL, WM8753_RINVOL, 0, 63, 0),
 SOC_DOUBLE_R("Capture ZC Switch", WM8753_LINVOL, WM8753_RINVOL, 6, 1, 0),
-- 
1.5.3.5
