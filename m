From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH] sound/korg1212: remove sleep_on*() usage
Date: Wed, 26 Jan 2005 11:44:00 -0800
Message-ID: <20050126194400.GF3593__25723.2543467127$1106769449$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3F7A91E8
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2005 20:44:07 +0100 (MET)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j0QJi23e002946
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2005 14:44:02 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0QJi2hu264406
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2005 14:44:02 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j0QJi2Fp001712
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2005 14:44:02 -0500
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, kernel-janitors@lists.osdl.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please consider applying.

Description: Directly use wait-queues instead of the deprecated
sleep_on_timeout(). Since the sleep in this function is unconditional,
wait_event_timeout() does not appear to be appropriate. Patch is
compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/sound/pci/korg1212/korg1212.c	2005-01-24 09:34:24.000000000 -0800
+++ 2.6.11-rc2-kj/sound/pci/korg1212/korg1212.c	2005-01-26 10:50:44.000000000 -0800
@@ -620,11 +620,14 @@ static void snd_korg1212_SendStop(korg12
 
 static void snd_korg1212_SendStopAndWait(korg1212_t *korg1212)
 {
+	DEFINE_WAIT(wait);
 	unsigned long flags;
 	spin_lock_irqsave(&korg1212->lock, flags);
 	snd_korg1212_SendStop(korg1212);
 	spin_unlock_irqrestore(&korg1212->lock, flags);
-	sleep_on_timeout(&korg1212->wait, (HZ * 3) / 2);
+	prepare_to_wait(&korg1212->wait, &wait, TASK_UNINTERRUPTIBLE);
+	schedule_timeout((HZ * 3) / 2);
+	finish_wait(&korg1212->wait, &wait);
 }
 
 /* timer callback for checking the ack of stop request */
@@ -1243,7 +1246,8 @@ static irqreturn_t snd_korg1212_interrup
 
 static int snd_korg1212_downloadDSPCode(korg1212_t *korg1212)
 {
-
+	DEFINE_WAIT(wait);
+	unsigned long i;
 #if K1212_DEBUG_LEVEL > 0
         K1212_DEBUG_PRINTK("K1212_DEBUG: DSP download is starting... [%s]\n", stateName[korg1212->cardState]);
 #endif
@@ -1267,9 +1271,12 @@ static int snd_korg1212_downloadDSPCode(
 	if (rc) K1212_DEBUG_PRINTK("K1212_DEBUG: Start DSP Download RC = %d [%s]\n", rc, stateName[korg1212->cardState]);
 #endif
 
-	if (! sleep_on_timeout(&korg1212->wait, HZ * CARD_BOOT_TIMEOUT))
+	prepare_to_wait(&korg1212->wait, &wait, TASK_UNINTERRUPTIBLE);
+	i = schedule_timeout(HZ * CARD_BOOT_TIMEOUT);
+	finish_wait(&korg1212->wait, &wait);
+	if (i == 0) 
 		return -EBUSY; /* timeout */
-
+	
 	snd_korg1212_OnDSPDownloadComplete(korg1212);
 
         return 0;


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
