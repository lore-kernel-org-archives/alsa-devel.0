From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [PATCH] sound/pci/riptide or drivers/base/firmware:
	Fix a possible sleep-in-atomic bug
Date: Mon,  9 Oct 2017 10:13:16 +0800
Message-ID: <1507515196-3241-1-git-send-email-baijiaju1990@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E313266CE2
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 04:10:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mcgrof@kernel.org, gregkh@linuxfoundation.org, perex@perex.cz, tiwai@suse.com, dhowells@redhat.com, bhumirks@gmail.com, fabf@skynet.be
Cc: alsa-devel@alsa-project.org, Jia-Ju Bai <baijiaju1990@163.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The riptide driver may sleep under a spinlock, and the function call path is:
snd_riptide_prepare (acquire the spinlock)
  setsampleformat
    sendcmd
      riptide_reset
        try_to_load_firmware
          request_firmware
            _request_firmware (drivers/base/firmware_class.c)
              _request_firmware_prepare
                kzalloc(GFP_KERNEL) --> may sleep

To fix it, GFP_KERNEL is replaced with GFP_ATOMIC in _request_firmware_prepare.
This bug is found by my static analysis tool and my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 drivers/base/firmware_class.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 4b57cf5..d89f676 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -1138,7 +1138,7 @@ static inline void kill_pending_fw_fallback_reqs(bool only_kill_custom) { }
 	struct firmware_buf *buf;
 	int ret;
 
-	*firmware_p = firmware = kzalloc(sizeof(*firmware), GFP_KERNEL);
+	*firmware_p = firmware = kzalloc(sizeof(*firmware), GFP_ATOMIC);
 	if (!firmware) {
 		dev_err(device, "%s: kmalloc(struct firmware) failed\n",
 			__func__);
-- 
1.7.9.5
