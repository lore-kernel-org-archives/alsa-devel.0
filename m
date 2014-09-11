From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] pcmcia: Add pcmcia_request_threaded_irq()
Date: Thu, 11 Sep 2014 16:00:20 +0200
Message-ID: <1410444025-22772-2-git-send-email-tiwai@suse.de>
References: <1410444025-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A94F226575C
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:00:32 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2C0EAAD07
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 14:00:30 +0000 (UTC)
In-Reply-To: <1410444025-22772-1-git-send-email-tiwai@suse.de>
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

Allow pcmcia drivers to use threaded irq handlers.  The existing
pcmcia_request_irq() helper is calling the new function just with
NULL thread_fn.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/pcmcia/pcmcia_resource.c | 11 ++++++-----
 include/pcmcia/ds.h              |  7 +++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index e8c19def1b0f..5c2039125aff 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -695,22 +695,23 @@ EXPORT_SYMBOL(pcmcia_request_io);
  * call free_irq() themselfves, too. Also, only %IRQF_SHARED capable IRQ
  * handlers are allowed.
  */
-int __must_check pcmcia_request_irq(struct pcmcia_device *p_dev,
-				    irq_handler_t handler)
+int __must_check pcmcia_request_threaded_irq(struct pcmcia_device *p_dev,
+					     irq_handler_t handler,
+					     irq_handler_t thread_fn)
 {
 	int ret;
 
 	if (!p_dev->irq)
 		return -EINVAL;
 
-	ret = request_irq(p_dev->irq, handler, IRQF_SHARED,
-			p_dev->devname, p_dev->priv);
+	ret = request_threaded_irq(p_dev->irq, handler, thread_fn, IRQF_SHARED,
+				   p_dev->devname, p_dev->priv);
 	if (!ret)
 		p_dev->_irq = 1;
 
 	return ret;
 }
-EXPORT_SYMBOL(pcmcia_request_irq);
+EXPORT_SYMBOL(pcmcia_request_threaded_irq);
 
 
 /**
diff --git a/include/pcmcia/ds.h b/include/pcmcia/ds.h
index 2d56e428506c..6ff5524bec12 100644
--- a/include/pcmcia/ds.h
+++ b/include/pcmcia/ds.h
@@ -216,8 +216,11 @@ pcmcia_request_exclusive_irq(struct pcmcia_device *p_dev,
 	return __pcmcia_request_exclusive_irq(p_dev, handler);
 }
 
-int __must_check pcmcia_request_irq(struct pcmcia_device *p_dev,
-				irq_handler_t handler);
+int __must_check pcmcia_request_threaded_irq(struct pcmcia_device *p_dev,
+					     irq_handler_t handler,
+					     irq_handler_t thread_fn);
+#define pcmcia_request_irq(pdev, handler) \
+	pcmcia_request_threaded_irq(pdev, handler, NULL)
 
 int pcmcia_enable_device(struct pcmcia_device *p_dev);
 
-- 
2.1.0
