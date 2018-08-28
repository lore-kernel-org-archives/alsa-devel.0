From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] [ALSA] seq: add error check in
	snd_seq_system_client_init()
Date: Tue, 28 Aug 2018 11:46:34 +0300
Message-ID: <20180828084634.5tlvwgc6znrqixro@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id C1A572676BD
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 10:46:47 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Static checkers complain that snd_seq_create_kernel_client() can return
-EBUSY here so we need to have some error handling.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/core/seq/seq_system.c b/sound/core/seq/seq_system.c
index 8ce1d0b40dce..3b89b0adad6a 100644
--- a/sound/core/seq/seq_system.c
+++ b/sound/core/seq/seq_system.c
@@ -134,6 +134,10 @@ int __init snd_seq_system_client_init(void)
 
 	/* register client */
 	sysclient = snd_seq_create_kernel_client(NULL, 0, "System");
+	if (sysclient < 0) {
+		kfree(port);
+		return sysclient;
+	}
 
 	/* register timer */
 	strcpy(port->name, "Timer");
