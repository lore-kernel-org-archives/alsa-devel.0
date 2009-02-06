From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.29-rc3][PATCH 1/2] ASoC: TLV320AIC3X: Fix
	kcontrol's private value use in put callback
Date: Fri,  6 Feb 2009 12:01:04 +0200
Message-ID: <1233914465-2767-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 780B0244E9
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 11:01:04 +0100 (CET)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	n16A0x3X023496
	for <alsa-devel@alsa-project.org>; Fri, 6 Feb 2009 12:01:02 +0200
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
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Function snd_soc_dapm_put_volsw_aic3x misuses the kcontrol's private value
by still accessing it as bitfields even SOC_SINGLE_VALUE constructs it
as a pointer into struct soc_mixer_control after the commit
4eaa9819dc08d7bfd1065ce530e31b18a119dcaf.

This was causing arbitrary register writes when touching the controls
defined with SOC_DAPM_SINGLE_AIC3X.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index b47a749..aea0cb7 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -165,10 +165,13 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int mask = (kcontrol->private_value >> 16) & 0xff;
-	int invert = (kcontrol->private_value >> 24) & 0x01;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	int max = mc->max;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = mc->invert;
 	unsigned short val, val_mask;
 	int ret;
 	struct snd_soc_dapm_path *path;
-- 
1.5.6.5
