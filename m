From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v3 13/16] ALSA: Oxygen: Modify suspend, resume,
	and cleanup functions
Date: Fri, 17 Jan 2014 19:08:32 +0400
Message-ID: <1389971315-3215-13-git-send-email-v1ron@mail.ru>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
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

When putting the card into suspended
mode, just disable the audio output. There is no
need to do more actions, since PCI slot will be
already disabled (AFAIK). When resume, we need to
restore erased registers of CS4245 from the
memory. When cleanup, just do the same as in
suspend.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index 953ef09..80fc099 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -197,20 +197,21 @@ void dg_init(struct oxygen *chip)
 		GPIO_HP_REAR | GPIO_INPUT_ROUTE);
 }
 
-static void dg_cleanup(struct oxygen *chip)
+void dg_suspend(struct oxygen *chip)
 {
 	oxygen_clear_bits16(chip, OXYGEN_GPIO_DATA, GPIO_OUTPUT_ENABLE);
 }
 
-static void dg_suspend(struct oxygen *chip)
+void dg_resume(struct oxygen *chip)
 {
-	dg_cleanup(chip);
+	cs4245_shadow_control(chip, CS4245_LOAD_FROM_SHADOW);
+	msleep(2500);
+	oxygen_set_bits16(chip, OXYGEN_GPIO_DATA, GPIO_OUTPUT_ENABLE);
 }
 
-static void dg_resume(struct oxygen *chip)
+void dg_cleanup(struct oxygen *chip)
 {
-	/*cs4245_registers_init(chip);*/
-	dg_output_enable(chip);
+	dg_suspend(chip);
 }
 
 void set_cs4245_dac_params(struct oxygen *chip,
-- 
1.7.10.4
