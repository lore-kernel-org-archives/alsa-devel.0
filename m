From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] fm801: convert struct description to kernel-doc
Date: Mon, 19 May 2014 14:07:28 +0300
Message-ID: <1400497648-32005-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DD9626520A
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 13:07:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Just move field descriptions to the struct description in the kernel-doc
format. There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/fm801.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index e8910d0..529f5f4 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -158,21 +158,27 @@ MODULE_PARM_DESC(radio_nr, "Radio device numbers");
 #define FM801_GPIO_GS3		(1<<15)
 #define FM801_GPIO_GS(x)	(1<<(12+(x)))
 	
-/*
-
+/**
+ * struct fm801 - describes FM801 chip
+ * @port:		I/O port number
+ * @multichannel:	multichannel support
+ * @secondary:		secondary codec
+ * @secondary_addr:	address of the secondary codec
+ * @tea575x_tuner:	tuner access method & flags
+ * @ply_ctrl:		playback control
+ * @cap_ctrl:		capture control
  */
-
 struct fm801 {
 	int irq;
 
-	unsigned long port;	/* I/O port number */
-	unsigned int multichannel: 1,	/* multichannel support */
-		     secondary: 1;	/* secondary codec */
-	unsigned char secondary_addr;	/* address of the secondary codec */
-	unsigned int tea575x_tuner;	/* tuner access method & flags */
+	unsigned long port;
+	unsigned int multichannel: 1,
+		     secondary: 1;
+	unsigned char secondary_addr;
+	unsigned int tea575x_tuner;
 
-	unsigned short ply_ctrl; /* playback control */
-	unsigned short cap_ctrl; /* capture control */
+	unsigned short ply_ctrl;
+	unsigned short cap_ctrl;
 
 	unsigned long ply_buffer;
 	unsigned int ply_buf;
-- 
2.0.0.rc2
