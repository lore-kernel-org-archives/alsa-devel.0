From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 13/20] sound/gus_pcm: remove interruptible_sleep_on_timeout() usage
Date: Wed, 2 Feb 2005 11:50:13 -0800
Message-ID: <20050202195013.GR2546__35538.1944952116$1107374051$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5EC92201
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2005 20:50:22 +0100 (MET)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j12JoFnr011424
	for <alsa-devel@alsa-project.org>; Wed, 2 Feb 2005 14:50:15 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j12JoFGL125586
	for <alsa-devel@alsa-project.org>; Wed, 2 Feb 2005 14:50:15 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j12JoFx0028666
	for <alsa-devel@alsa-project.org>; Wed, 2 Feb 2005 14:50:15 -0500
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

Hello,

Please consider applying.

Description: Replace deprecated interruptible_sleep_on_timeout() with
wait_event_timeout(). Code is not identical, as the current sleeping system is 1
jiffy at a time checking atomic_read()'s return every iteration. Patch is
compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/sound/isa/gus/gus_pcm.c	2005-01-26 11:19:06.000000000 -0800
+++ 2.6.11-rc2-kj/sound/isa/gus/gus_pcm.c	2005-02-02 11:34:20.000000000 -0800
@@ -697,16 +697,10 @@ static int snd_gf1_pcm_playback_close(sn
 	snd_gus_card_t *gus = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	gus_pcm_private_t *pcmp = runtime->private_data;
-	unsigned long jiffies_old;
+	
+	if (!wait_event_timeout(pcmp->sleep, (atomic_read(&pcmp->dma_count) <= 0), 2*HZ))
+		snd_printk("gf1 pcm - serious DMA problem\n");
 
-	jiffies_old = jiffies;
-	while (atomic_read(&pcmp->dma_count) > 0) {
-		interruptible_sleep_on_timeout(&pcmp->sleep, 1);
-		if ((signed long)(jiffies - jiffies_old) > 2*HZ) {
-			snd_printk("gf1 pcm - serious DMA problem\n");
-			break;
-		}
-	}
 	snd_gf1_dma_done(gus);	
 	return 0;
 }


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
