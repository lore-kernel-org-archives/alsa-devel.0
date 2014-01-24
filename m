From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 18/19] ALSA: Oxygen: Modify High-pass filter
	control
Date: Fri, 24 Jan 2014 16:18:19 +0400
Message-ID: <1390565900-3337-18-git-send-email-v1ron@mail.ru>
References: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
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
Cc: alsa-devel@alsa-project.org, Roman Volkov <v1ron@mail.ru>
List-Id: alsa-devel@alsa-project.org

Change the 'put' function of the High-pass filter control to use the new
SPI functions.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg_mixer.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg_mixer.c b/sound/pci/oxygen/xonar_dg_mixer.c
index d6ececb..4b80675 100644
--- a/sound/pci/oxygen/xonar_dg_mixer.c
+++ b/sound/pci/oxygen/xonar_dg_mixer.c
@@ -327,6 +327,8 @@ static int input_sel_put(struct snd_kcontrol *ctl,
 	return changed;
 }
 
+/* ADC High-pass filter */
+
 static int hpf_info(struct snd_kcontrol *ctl, struct snd_ctl_elem_info *info)
 {
 	static const char *const names[2] = { "Active", "Frozen" };
@@ -356,8 +358,10 @@ static int hpf_put(struct snd_kcontrol *ctl, struct snd_ctl_elem_value *value)
 	if (value->value.enumerated.item[0])
 		reg |= CS4245_HPF_FREEZE;
 	changed = reg != data->cs4245_shadow[CS4245_ADC_CTRL];
-	if (changed)
-		cs4245_write(chip, CS4245_ADC_CTRL, reg);
+	if (changed) {
+		data->cs4245_shadow[CS4245_ADC_CTRL] = reg;
+		cs4245_write_spi(chip, CS4245_ADC_CTRL);
+	}
 	mutex_unlock(&chip->mutex);
 	return changed;
 }
-- 
1.7.10.4
