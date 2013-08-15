From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: core: allow SND_DMAENGINE_PCM use from
	modules
Date: Thu, 15 Aug 2013 16:03:52 +0200
Message-ID: <1376575432-30354-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 2190B261ABC
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 16:03:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

When users of SND_DMAENGINE_PCM are built as module, the config symbol
SND_DMAENGINE_PCM must be tristate, otherwise the linker will fail.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 sound/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 94ce1c4..313f22e 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -7,7 +7,7 @@ config SND_PCM
 	select SND_TIMER
 
 config SND_DMAENGINE_PCM
-	bool
+	tristate
 
 config SND_HWDEP
 	tristate
-- 
1.8.3.1
