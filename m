From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/4] ALSA: oxygen: do not create useless S/PDIF
	controls
Date: Fri, 16 Jan 2015 22:14:18 +0100
Message-ID: <54B97F2A.60309@ladisch.de>
References: <54B97EEB.8060108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A2C1C2604F2
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 22:15:13 +0100 (CET)
In-Reply-To: <54B97EEB.8060108@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cards without S/PDIF output do not need those controls.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/pci/oxygen/oxygen_mixer.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index 5988e04..2f698a9 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -786,6 +786,9 @@ static const struct snd_kcontrol_new controls[] = {
 		.get = upmix_get,
 		.put = upmix_put,
 	},
+};
+
+static const struct snd_kcontrol_new spdif_output_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, SWITCH),
@@ -1073,6 +1076,12 @@ int oxygen_mixer_init(struct oxygen *chip)
 	err = add_controls(chip, controls, ARRAY_SIZE(controls));
 	if (err < 0)
 		return err;
+	if (chip->model.device_config & PLAYBACK_1_TO_SPDIF) {
+		err = add_controls(chip, spdif_output_controls,
+				   ARRAY_SIZE(spdif_output_controls));
+		if (err < 0)
+			return err;
+	}
 	if (chip->model.device_config & CAPTURE_1_FROM_SPDIF) {
 		err = add_controls(chip, spdif_input_controls,
 				   ARRAY_SIZE(spdif_input_controls));
