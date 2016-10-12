From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: line6: fix a crash in line6_hwdep_write()
Date: Wed, 12 Oct 2016 09:21:40 +0300
Message-ID: <20161012062140.GT12841@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Andrej Krutak <dev@andree.sk>
Cc: Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kbuild test robot <fengguang.wu@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The error checking here is messed up so we could end up dereferencing
-EFAULT.

Fixes: a16039cbf1a1 ('ALSA: line6: Add hwdep interface to access the POD control messages')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 14e587e..90009c0 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -604,8 +604,8 @@ line6_hwdep_write(struct snd_hwdep *hwdep, const char __user *data, long count,
 	}
 
 	data_copy = memdup_user(data, count);
-	if (IS_ERR(ERR_PTR))
-		return -ENOMEM;
+	if (IS_ERR(data_copy))
+		return PTR_ERR(data_copy);
 
 	rv = line6_send_raw_message(line6, data_copy, count);
 
