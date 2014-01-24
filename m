From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 04/19] ALSA: Oxygen: Export
	oxygen_update_dac_routing symbol
Date: Fri, 24 Jan 2014 16:18:05 +0400
Message-ID: <1390565900-3337-4-git-send-email-v1ron@mail.ru>
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

When the user switches the output from stereo to multichannel
or vice versa, the driver needs to update the channel routing.
Instead of creating additional subroutines, I better export existing
oxygen_update_dac_routing symbol from the oxygen mixer
and call this function. It calls model.adjust_dac_routing()
and my function does the work.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/oxygen_mixer.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index c0dbb52..5988e04 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -190,6 +190,7 @@ void oxygen_update_dac_routing(struct oxygen *chip)
 	if (chip->model.update_center_lfe_mix)
 		chip->model.update_center_lfe_mix(chip, chip->dac_routing > 2);
 }
+EXPORT_SYMBOL(oxygen_update_dac_routing);
 
 static int upmix_put(struct snd_kcontrol *ctl, struct snd_ctl_elem_value *value)
 {
-- 
1.7.10.4
