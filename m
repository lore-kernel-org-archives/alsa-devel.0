From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] gusextreme: Fix build errors
Date: Sun,  9 Nov 2008 20:32:40 +0200
Message-ID: <1226255560-8735-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by alsa0.perex.cz (Postfix) with ESMTP id BD09124349
	for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2008 19:32:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

gusextreme depends on opl3 support. Add the approriate select to Kconfig.
Also remove the unnecessary hwdep select.

Relevant build errors:
ERROR: "snd_opl3_hwdep_new" [sound/isa/gus/snd-gusextreme.ko] undefined!
ERROR: "snd_opl3_create" [sound/isa/gus/snd-gusextreme.ko] undefined!

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 sound/isa/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 660beb4..ce0aa04 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -211,7 +211,7 @@ config SND_GUSCLASSIC
 
 config SND_GUSEXTREME
 	tristate "Gravis UltraSound Extreme"
-	select SND_HWDEP
+	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
 	help
-- 
1.5.6.4
