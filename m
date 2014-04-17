From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 1/6] sound: lx_core: Remove unused defines
Date: Thu, 17 Apr 2014 11:51:16 +0200
Message-ID: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id C8689265164
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 11:55:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, iwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Commit f9367f3fbe3c ("ALSA: lx6464es: Remove unused
function in pci/lx6464es/lx_core.c") removed the
lx_dsp_es_check_pipeline function that was the only user
of these defines.

Since they're useless now, simply remove them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/pci/lx6464es/lx_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 2d8e95e9fbe5..6a1d90a308ea 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -429,11 +429,6 @@ int lx_dsp_read_async_events(struct lx6464es *chip, u32 *data)
 	return ret;
 }
 
-#define CSES_TIMEOUT        100     /* microseconds */
-#define CSES_CE             0x0001
-#define CSES_BROADCAST      0x0002
-#define CSES_UPDATE_LDSV    0x0004
-
 #define PIPE_INFO_TO_CMD(capture, pipe)					\
 	((u32)((u32)(pipe) | ((capture) ? ID_IS_CAPTURE : 0L)) << ID_OFFSET)
 
-- 
1.9.1
