From: Joe Perches <joe@perches.com>
Subject: [PATCH] hda_intel.c - Consolidate bitfields
Date: Wed, 15 Apr 2009 12:20:58 -0700
Message-ID: <1239823258.26340.232.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.perches.com (136-022.dsl.LABridge.com [206.117.136.22])
	by alsa0.perex.cz (Postfix) with ESMTP id D61651037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 21:21:02 +0200 (CEST)
Received: from [192.168.1.151] ([192.168.1.151])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id MAA27923
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 12:20:48 -0700
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Previously sent to linux-kernel.

Commit fa00e046b41663cbda9b1affc0594669e5f14219
added a new bitfield not adjacent to other
bitfields in the same struct.  Moved the new one.

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bc882f8..21e99cf 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -312,7 +312,6 @@ struct azx_dev {
 	unsigned int period_bytes; /* size of the period in bytes */
 	unsigned int frags;	/* number for period in the play buffer */
 	unsigned int fifo_size;	/* FIFO size */
-	unsigned int start_flag: 1;	/* stream full start flag */
 	unsigned long start_jiffies;	/* start + minimum jiffies */
 	unsigned long min_jiffies;	/* minimum jiffies before position is valid */
 
@@ -333,6 +332,7 @@ struct azx_dev {
 	unsigned int opened :1;
 	unsigned int running :1;
 	unsigned int irq_pending :1;
+	unsigned int start_flag: 1;	/* stream full start flag */
 	/*
 	 * For VIA:
 	 *  A flag to ensure DMA position is 0
