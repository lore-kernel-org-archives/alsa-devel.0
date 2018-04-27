From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: cs46xx: fix spelling mistake: "amplifer"
	-> "amplifier"
Date: Fri, 27 Apr 2018 20:02:45 +0100
Message-ID: <20180427190245.16861-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E9ED267412
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 21:02:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in module parameter description text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/cs46xx/cs46xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index 655fbea1692c..4910d3f46d4b 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -58,7 +58,7 @@ MODULE_PARM_DESC(id, "ID string for the CS46xx soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable CS46xx soundcard.");
 module_param_array(external_amp, bool, NULL, 0444);
-MODULE_PARM_DESC(external_amp, "Force to enable external amplifer.");
+MODULE_PARM_DESC(external_amp, "Force to enable external amplifier.");
 module_param_array(thinkpad, bool, NULL, 0444);
 MODULE_PARM_DESC(thinkpad, "Force to enable Thinkpad's CLKRUN control.");
 module_param_array(mmap_valid, bool, NULL, 0444);
-- 
2.17.0
