From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: cmi8238: Use IS_ENABLED()
Date: Mon, 15 May 2017 11:32:55 +0200
Message-ID: <20170515093255.21132-2-tiwai@suse.de>
References: <20170515093255.21132-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F40DE2673AE
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:32:58 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CCB59AC0D
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 09:32:58 +0000 (UTC)
In-Reply-To: <20170515093255.21132-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Simplify the ifdef conditions with IS_ENABLED() macro.
No functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/cmi8328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/cmi8328.c b/sound/isa/cmi8328.c
index 8e1756c3b9bb..d09e456107ad 100644
--- a/sound/isa/cmi8328.c
+++ b/sound/isa/cmi8328.c
@@ -26,7 +26,7 @@ MODULE_AUTHOR("Ondrej Zary <linux@rainbow-software.org>");
 MODULE_DESCRIPTION("C-Media CMI8328");
 MODULE_LICENSE("GPL");
 
-#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
+#if IS_ENABLED(CONFIG_GAMEPORT)
 #define SUPPORT_JOYSTICK 1
 #endif
 
-- 
2.12.2
