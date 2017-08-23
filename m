From: Colin King <colin.king@canonical.com>
Subject: [PATCH] sound/oss/pss: fix spelling mistake:
	"compoents" -> "components"
Date: Wed, 23 Aug 2017 23:49:34 +0100
Message-ID: <20170823224934.12385-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E23D266A7C
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 00:49:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, David Howells <dhowells@redhat.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in MODULE_PARM_DESC text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/oss/pss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/pss.c b/sound/oss/pss.c
index 33c3a442e162..951b14dec73a 100644
--- a/sound/oss/pss.c
+++ b/sound/oss/pss.c
@@ -1156,7 +1156,7 @@ MODULE_PARM_DESC(pss_cdrom_port, "Set the PSS CDROM port i/o base (0x340 or othe
 module_param(pss_enable_joystick, bool, 0);
 MODULE_PARM_DESC(pss_enable_joystick, "Enables the PSS joystick port (1 to enable, 0 to disable)");
 module_param(pss_no_sound, bool, 0);
-MODULE_PARM_DESC(pss_no_sound, "Configure sound compoents (0 - no, 1 - yes)");
+MODULE_PARM_DESC(pss_no_sound, "Configure sound components (0 - no, 1 - yes)");
 module_param(pss_keep_settings, bool, 0);
 MODULE_PARM_DESC(pss_keep_settings, "Keep hardware setting at driver unloading (0 - no, 1 - yes)");
 module_param(pss_firmware, charp, 0);
-- 
2.14.1
