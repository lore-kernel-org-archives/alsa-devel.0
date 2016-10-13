From: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Subject: [PATCH] sound/pci/asihpi: fix kernel memory disclosure
Date: Thu, 13 Oct 2016 14:36:41 +0200
Message-ID: <1476362201-58016-1-git-send-email-vlad@tsyrklevich.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B4F2B26640F
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 14:38:00 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id x23so6758713lfi.1
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 05:38:00 -0700 (PDT)
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
Cc: Vlad Tsyrklevich <vlad@tsyrklevich.net>
List-Id: alsa-devel@alsa-project.org

Some elements in hr are not cleared before being copied to user space,
leaking kernel heap memory to user space. For example, this happens in
the error handling code for the HPI_ADAPTER_DELETE case. Zero the memory
before it's copied.

Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
---
 sound/pci/asihpi/hpioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index d17937b..7e3aa50 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -111,7 +111,7 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return -EINVAL;
 
 	hm = kmalloc(sizeof(*hm), GFP_KERNEL);
-	hr = kmalloc(sizeof(*hr), GFP_KERNEL);
+	hr = kzalloc(sizeof(*hr), GFP_KERNEL);
 	if (!hm || !hr) {
 		err = -ENOMEM;
 		goto out;
-- 
2.7.0
