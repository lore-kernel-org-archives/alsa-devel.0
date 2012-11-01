From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/2] hda: Cirrus: Fix coefficient index for
	beep configuration
Date: Thu,  1 Nov 2012 13:42:37 +0100
Message-ID: <1351773758-1010-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1351773758-1010-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61]) by alsa0.perex.cz (Postfix) with ESMTP id 73BD026257C
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 13:42:48 +0100 (CET)
In-Reply-To: <1351773758-1010-1-git-send-email-alexander.stein@systec-electronic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sound/pci/hda/patch_cirrus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 61a7113..3b7d67a 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -1107,7 +1107,7 @@ static const struct hda_verb cs_coef_init_verbs[] = {
 	  | 0x0400 /* Disable Coefficient Auto increment */
 	  )},
 	/* Beep */
-	{0x11, AC_VERB_SET_COEF_INDEX, IDX_DAC_CFG},
+	{0x11, AC_VERB_SET_COEF_INDEX, IDX_BEEP_CFG},
 	{0x11, AC_VERB_SET_PROC_COEF, 0x0007}, /* Enable Beep thru DAC1/2/3 */
 
 	{} /* terminator */
-- 
1.7.8.6
