From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v4 3/4] ASoC: dapm: support mixer controls with
	mute at non-zero value
Date: Sat, 14 May 2016 23:09:40 +0200
Message-ID: <1463260181-21344-4-git-send-email-peda@axentia.se>
References: <1463260181-21344-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0101.outbound.protection.outlook.com [104.47.0.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 484202650CC
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 23:14:49 +0200 (CEST)
In-Reply-To: <1463260181-21344-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Misbah Ullah Khan <Misbahk@danlawinc.com>, Kumar Gala <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

The max9860 codec has a mixer control field that has its mute/disable at
the wrong end of the scale. I.e. you turn the volume up and up, and then
as the final step the volume is off. This does not sit well with DAPM,
which assumes the mute/off is at the minimum value.

Add support for such backwards controls with code that searches TLV ranges
for the mute value and use that as trigger for DAPM off.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/soc-dapm.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c4464858bf01..8a1131781339 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -42,6 +42,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 
 #include <trace/events/asoc.h>
 
@@ -722,16 +723,46 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 	return -ENODEV;
 }
 
+static int dapm_find_tlv_mute(const unsigned int *tlv)
+{
+	int cnt;
+	const unsigned int *range;
+
+	if (!tlv || tlv[0] != SNDRV_CTL_TLVT_DB_RANGE)
+		return 0;
+
+	cnt = tlv[1] / sizeof(unsigned int);
+
+	/*
+	 * Each group of six values should be
+	 * { start end type len min step/mute }
+	 */
+	for (range = &tlv[2]; cnt >= 6; cnt -= 6, range += 6) {
+		if (range[2] != SNDRV_CTL_TLVT_DB_SCALE)
+			return 0; /* wrong type, terminate */
+		if (range[3] != 2 * sizeof(unsigned int))
+			return 0; /* wrong len, terminate */
+		if (!(range[5] & TLV_DB_SCALE_MUTE))
+			continue; /* no mute in this range */
+		return range[0]; /* start of this range is the mute value */
+	}
+
+	return 0;
+}
+
 /* set up initial codec paths */
 static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
 {
+	const struct snd_kcontrol_new *kcontrol_new
+		= &p->sink->kcontrol_news[i];
 	struct soc_mixer_control *mc = (struct soc_mixer_control *)
-		p->sink->kcontrol_news[i].private_value;
+		kcontrol_new->private_value;
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	unsigned int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
+	int mute_value = dapm_find_tlv_mute(kcontrol_new->tlv.p);
 	unsigned int val;
 
 	if (reg != SND_SOC_NOPM) {
@@ -739,7 +770,7 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
 		val = (val >> shift) & mask;
 		if (invert)
 			val = max - val;
-		p->connect = !!val;
+		p->connect = val != mute_value;
 	} else {
 		p->connect = 0;
 	}
@@ -3045,6 +3076,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
+	int mute_value = dapm_find_tlv_mute(kcontrol->tlv.p);
 	unsigned int val;
 	int connect, change, reg_change = 0;
 	struct snd_soc_dapm_update update;
@@ -3056,7 +3088,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 			 kcontrol->id.name);
 
 	val = (ucontrol->value.integer.value[0] & mask);
-	connect = !!val;
+	connect = val != mute_value;
 
 	if (invert)
 		val = max - val;
-- 
2.1.4
