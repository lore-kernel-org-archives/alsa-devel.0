From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/14] ALSA: seq: Handle the device directly
Date: Mon,  2 Feb 2015 11:24:35 +0100
Message-ID: <1422872678-4815-12-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 77CE7260511
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 06C9DAD70
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:40 +0000 (UTC)
In-Reply-To: <1422872678-4815-1-git-send-email-tiwai@suse.de>
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

Like the previous change for the timer device, this patch changes the
device management for the ALSA sequencer device using the struct
device directly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 225c73152ee9..65b320ec66f1 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2571,6 +2571,8 @@ static const struct file_operations snd_seq_f_ops =
 	.compat_ioctl =	snd_seq_ioctl_compat,
 };
 
+static struct device seq_dev;
+
 /* 
  * register sequencer device 
  */
@@ -2578,12 +2580,18 @@ int __init snd_sequencer_device_init(void)
 {
 	int err;
 
+	snd_device_initialize(&seq_dev, NULL);
+	dev_set_name(&seq_dev, "seq");
+
 	if (mutex_lock_interruptible(&register_mutex))
 		return -ERESTARTSYS;
 
-	if ((err = snd_register_device(SNDRV_DEVICE_TYPE_SEQUENCER, NULL, 0,
-				       &snd_seq_f_ops, NULL, "seq")) < 0) {
+	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_SEQUENCER, NULL, 0,
+					  &snd_seq_f_ops, NULL,
+					  &seq_dev, NULL, NULL);
+	if (err < 0) {
 		mutex_unlock(&register_mutex);
+		put_device(&seq_dev);
 		return err;
 	}
 	
@@ -2600,4 +2608,5 @@ int __init snd_sequencer_device_init(void)
 void __exit snd_sequencer_device_done(void)
 {
 	snd_unregister_device(SNDRV_DEVICE_TYPE_SEQUENCER, NULL, 0);
+	put_device(&seq_dev);
 }
-- 
2.2.2
