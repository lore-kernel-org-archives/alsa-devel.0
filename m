From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: mixart: Fix kerneldoc comments
Date: Mon, 10 Nov 2014 17:32:34 +0100
Message-ID: <1415637155-20918-4-git-send-email-tiwai@suse.de>
References: <1415637155-20918-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DEDD262606
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 17:32:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4283CABE7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 16:32:41 +0000 (UTC)
In-Reply-To: <1415637155-20918-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/mixart/mixart_hwdep.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/mixart/mixart_hwdep.c b/sound/pci/mixart/mixart_hwdep.c
index 581e1e74863c..9996a4dead0f 100644
--- a/sound/pci/mixart/mixart_hwdep.c
+++ b/sound/pci/mixart/mixart_hwdep.c
@@ -37,10 +37,11 @@
 /**
  * wait for a value on a peudo register, exit with a timeout
  *
- * @param mgr pointer to miXart manager structure
- * @param offset unsigned pseudo_register base + offset of value
- * @param value value
- * @param timeout timeout in centisenconds
+ * @mgr: pointer to miXart manager structure
+ * @offset: unsigned pseudo_register base + offset of value
+ * @is_egal: wait for the equal value
+ * @value: value
+ * @timeout: timeout in centisenconds
  */
 static int mixart_wait_nice_for_register_value(struct mixart_mgr *mgr,
 					       u32 offset, int is_egal,
-- 
2.1.3
