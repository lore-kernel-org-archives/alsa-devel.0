From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: mixart_core: Mark expected switch
	fall-through
Date: Wed, 8 Aug 2018 17:11:48 -0500
Message-ID: <20180808221148.GA1864@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com
 [192.185.148.214])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FAE82678C4
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2018 00:12:06 +0200 (CEST)
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
 by gateway34.websitewelcome.com (Postfix) with ESMTP id 61C2228CE9
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 17:12:05 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced the code comment with
a proper "fall through" annotation, which is what GCC is expecting
to find.

Addresses-Coverity-ID: 114889 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/pci/mixart/mixart_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/mixart/mixart_core.c b/sound/pci/mixart/mixart_core.c
index 46c292b..71776bf 100644
--- a/sound/pci/mixart/mixart_core.c
+++ b/sound/pci/mixart/mixart_core.c
@@ -540,7 +540,7 @@ irqreturn_t snd_mixart_threaded_irq(int irq, void *dev_id)
 				dev_err(&mgr->pci->dev,
 					"canceled notification %x !\n", msg);
 			}
-			/* no break, continue ! */
+			/* fall through */
 		case MSG_TYPE_ANSWER:
 			/* answer or notification to a message we are waiting for*/
 			mutex_lock(&mgr->msg_lock);
-- 
2.7.4
