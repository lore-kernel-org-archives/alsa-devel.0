From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/18] ASoC: TWL4030: Add DAPM event handler
	for output MUX selection
Date: Tue,  9 Dec 2008 14:01:27 +0000
Message-ID: <1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF29F103841
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:45 +0100 (CET)
In-Reply-To: <1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

DAPM event handler is set to filter out invalid MUX settings
for certain outputs.
Earpiece:
 - 0 = Off
 - 1 = DACL1
 - 2 = DACL2
 - 3 = *** Invalid ***
 - 4 = DACR1

PreDriveL/R:
 - 0 = Off/Off
 - 1 = DACL1/DACR1
 - 2 = DACL2/DACR2
 - 3 = *** Invalid/Invalid ***
 - 4 = DACR2/DACL2

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 4293ec7..9d10783 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -190,6 +190,30 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 }
 
+static int outmixer_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int ret = 0;
+	int val;
+
+	switch (e->reg) {
+	case TWL4030_REG_PREDL_CTL:
+	case TWL4030_REG_PREDR_CTL:
+	case TWL4030_REG_EAR_CTL:
+		val = w->value >> e->shift_l;
+		if (val == 3) {
+			printk(KERN_WARNING
+			"Invalid MUX setting for register 0x%02x (%d)\n",
+			      e->reg, val);
+			ret = -1;
+		}
+		break;
+	}
+
+	return ret;
+}
+
 /*
  * Some of the gain controls in TWL (mostly those which are associated with
  * the outputs) are implemented in an interesting way:
-- 
1.5.6.5
