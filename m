From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ASoC: core: Fix warning while make xmldocs caused by soc-ops.c
Date: Wed, 11 Nov 2015 08:25:12 +0900
Message-ID: <1447197912-13508-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch fix following warning while "make xmldocs".

.//sound/soc/soc-ops.c:415: warning: No description found
for parameter 'ucontrol'
.//sound/soc/soc-ops.c:415: warning: Excess function parameter
'uinfo' description in 'snd_soc_put_volsw_sx'

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index ecd38e5..2f67ba6 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -404,7 +404,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
 /**
  * snd_soc_put_volsw_sx - double mixer set callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a double mixer control that spans 2 registers.
  *
-- 
2.6.2.402.g2635c2b
