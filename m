From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] 2/3 miro: MPU-401 error action bugfix
Date: Fri, 24 Jun 2005 01:02:12 +0200
Message-ID: <20050623230212.GA3294@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 2358321E
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 00:59:49 +0200 (MEST)
Received: from ml by tuba with local (Exim 4.50)
	id 1Dlai4-0000rw-SV
	for alsa-devel@alsa-project.org; Fri, 24 Jun 2005 01:02:12 +0200
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

An if statement which executes snd_mpu401_uart_new() doesn't run the 
correct action if it fails. A line with an error message was missing.
The patch completes the if statement by adding a message.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="miro_mpu401.patch"

--- isa/opti9xx/miro.c.1_miro_pcm20revE	Thu Jun 23 21:56:34 2005
+++ isa/opti9xx/miro.c	Fri Jun 24 00:16:27 2005
@@ -1330,6 +1330,7 @@
 		if ((error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
 				miro->mpu_port, 0, miro->mpu_irq, SA_INTERRUPT,
 				&rmidi)))
+			snd_printk("no MPU-401 device at 0x%lx?\n", miro->mpu_port);
 
 	/* the aci mixer is muted after reset */
 

--82I3+IH0IqGh5yIs--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
