From: Jan Nikitenko <jan.nikitenko@gmail.com>
Subject: [PATCH] ALSA: hda - fix cirrus dac/beep coefs setup
Date: Fri, 10 Sep 2010 07:42:53 +0200
Message-ID: <4C89C55D.4090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E34F1038F2
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 07:45:17 +0200 (CEST)
Received: by fxm11 with SMTP id 11so1527171fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Sep 2010 22:45:16 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix copy&paste bug in cirrus coefs setup, that caused bogus value
in DAC_CFG that should have gone to BEEP_CFG.
The problem could be noticed with 'Headphone' output getting audible
volume ramp in the beginning of sound playback.

Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>
---
 sound/pci/hda/patch_cirrus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 350ee8a..7d5c074 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -966,7 +966,7 @@ static struct hda_verb cs_coef_init_verbs[] = {
 	  | 0x0400 /* Disable Coefficient Auto increment */
 	  )},
 	/* Beep */
-	{0x11, AC_VERB_SET_COEF_INDEX, IDX_DAC_CFG},
+	{0x11, AC_VERB_SET_COEF_INDEX, IDX_BEEP_CFG},
 	{0x11, AC_VERB_SET_PROC_COEF, 0x0007}, /* Enable Beep thru DAC1/2/3 */

 	{} /* terminator */
-- 
1.7.1.1
