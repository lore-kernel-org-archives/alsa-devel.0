From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: Fix typo in kernel doc comment for
	snd_soc_put_volsw_sx()
Date: Wed, 28 Oct 2015 16:40:18 +0100
Message-ID: <1446046818-19234-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DDBC5261A80
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 16:40:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Spotted by kbuild bot:
 sound/soc/soc-ops.c:415: warning: No description found for parameter 'ucontrol'
 sound/soc/soc-ops.c:415: warning: Excess function parameter 'uinfo' description in 'snd_soc_put_volsw_sx'

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index ecd38e52285a..2f67ba6d7a8f 100644
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
2.6.2
