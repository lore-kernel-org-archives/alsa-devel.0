From: Vignesh Babu BM <vignesh.babu@wipro.com>
Subject: [KJ][PATCH] is_power_of_2 in rtctimer.c
Date: Wed, 21 Feb 2007 18:50:21 +0530
Message-ID: <1172064021.6127.84.camel__19002.4401098073$1172064319$gmane$org@wriver-t81fb058.linuxcoe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from wip-ectls-mx1.wipro.com (wip-ectls-mx1.wipro.com
	[203.91.193.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 046A818E
	for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2007 14:23:05 +0100 (MET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Kernel Janitors List <kernel-janitors@lists.osdl.org>
Cc: alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


Replacing (n & (n-1)) in the context of power of 2 checks
with is_power_of_2

Signed-off-by: vignesh babu <vignesh.babu@wipro.com>
--- 
diff --git a/sound/core/rtctimer.c b/sound/core/rtctimer.c
index 9f7b32e..7cd5e8f 100644
--- a/sound/core/rtctimer.c
+++ b/sound/core/rtctimer.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
+#include <linux/log2.h>
 #include <sound/core.h>
 #include <sound/timer.h>
 
@@ -129,7 +130,7 @@ static int __init rtctimer_init(void)
 	struct snd_timer *timer;
 
 	if (rtctimer_freq < 2 || rtctimer_freq > 8192 ||
-	    (rtctimer_freq & (rtctimer_freq - 1)) != 0) {
+	    !is_power_of_2(rtctimer_freq)) {
 		snd_printk(KERN_ERR "rtctimer: invalid frequency %d\n",
 			   rtctimer_freq);
 		return -EINVAL;

-- 
Regards,  
Vignesh Babu BM  
_____________________________________________________________  
"Why is it that every time I'm with you, makes me believe in magic?"


The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email.
 
www.wipro.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
