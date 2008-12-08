From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/8] ASoC: TWL4030: Add DAPM event handler for
	output MUX selection
Date: Mon,  8 Dec 2008 10:09:03 +0200
Message-ID: <1228723748-22911-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 57360103834
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 09:09:36 +0100 (CET)
In-Reply-To: <1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/twl4030.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 11a6610..6e7b5fc 100644
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
1.6.0.3
