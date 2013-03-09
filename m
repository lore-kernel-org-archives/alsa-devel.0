From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 6/7] ALSA: hdspm - Add ALSA controls to read
	the TCO LTC state
Date: Sun, 10 Mar 2013 00:37:26 +0100
Message-ID: <1362872247-29029-7-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-6-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362872247-29029-6-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch adds new ALSA controls to query the LTC state from userspace.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 9b5382f..f5ef788 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2927,6 +2927,112 @@ static int snd_hdspm_get_autosync_ref(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+
+
+#define HDSPM_TCO_VIDEO_INPUT_FORMAT(xname, xindex) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READ |\
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
+	.info = snd_hdspm_info_tco_video_input_format, \
+	.get = snd_hdspm_get_tco_video_input_format, \
+}
+
+static int snd_hdspm_info_tco_video_input_format(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = {"No video", "NTSC", "PAL"};
+	ENUMERATED_CTL_INFO(uinfo, texts);
+	return 0;
+}
+
+static int snd_hdspm_get_tco_video_input_format(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status;
+	int ret = 0;
+
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	status = hdspm_read(hdspm, HDSPM_RD_TCO + 4);
+	switch (status & (HDSPM_TCO1_Video_Input_Format_NTSC |
+			HDSPM_TCO1_Video_Input_Format_PAL)) {
+	case HDSPM_TCO1_Video_Input_Format_NTSC:
+		/* ntsc */
+		ret = 1;
+		break;
+	case HDSPM_TCO1_Video_Input_Format_PAL:
+		/* pal */
+		ret = 2;
+		break;
+	default:
+		/* no video */
+		ret = 0;
+		break;
+	}
+	ucontrol->value.enumerated.item[0] = ret;
+	return 0;
+}
+
+
+
+#define HDSPM_TCO_LTC_FRAMES(xname, xindex) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READ |\
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
+	.info = snd_hdspm_info_tco_ltc_frames, \
+	.get = snd_hdspm_get_tco_ltc_frames, \
+}
+
+static int snd_hdspm_info_tco_ltc_frames(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = {"No lock", "24 fps", "25 fps", "29.97 fps",
+				"30 fps"};
+	ENUMERATED_CTL_INFO(uinfo, texts);
+	return 0;
+}
+
+static int hdspm_tco_ltc_frames(struct hdspm *hdspm)
+{
+	u32 status;
+	int ret = 0;
+
+	status = hdspm_read(hdspm, HDSPM_RD_TCO + 4);
+	if (status & HDSPM_TCO1_LTC_Input_valid) {
+		switch (status & (HDSPM_TCO1_LTC_Format_LSB |
+					HDSPM_TCO1_LTC_Format_MSB)) {
+		case 0:
+			/* 24 fps */
+			ret = 1;
+			break;
+		case HDSPM_TCO1_LTC_Format_LSB:
+			/* 25 fps */
+			ret = 2;
+			break;
+		case HDSPM_TCO1_LTC_Format_MSB:
+			/* 25 fps */
+			ret = 3;
+			break;
+		default:
+			/* 30 fps */
+			ret = 4;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int snd_hdspm_get_tco_ltc_frames(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = hdspm_tco_ltc_frames(hdspm);
+	return 0;
+}
+
 #define HDSPM_TOGGLE_SETTING(xname, xindex) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
 	.name = xname, \
-- 
1.7.10.4
