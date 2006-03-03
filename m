From: David Vrabel <dvrabel@arcom.com>
Subject: [PATCH] ALSA: CS5535: shorter delays when accessing AC'97 codec registers
Date: Fri, 03 Mar 2006 16:09:51 +0000
Message-ID: <44086A4F.1040403__13702.5700453252$1141402310$gmane$org@arcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060803090207050707030804"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from webapps.arcom.com (webapps.arcom.com [194.200.159.168])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 572FD1A9
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2006 17:09:53 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jayakumar.alsa@gmail.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060803090207050707030804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The 10 ms sleeps while waiting for AC'97 codec register reads/writes to
complete are excessive given the maxmium time is one AC'97 frame (~21 us).

With AC'97 codecs with integrated touchscreens (like the UCB1400) this
improves the interactive performance of the touchscreen.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------060803090207050707030804
Content-Type: text/plain;
 name="alsa-cs5535-quicker-ac97-register-accesses"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-cs5535-quicker-ac97-register-accesses"

ALSA: CS5535: shorter delays when accessing AC'97 codec registers

The 10 ms sleeps while waiting for AC'97 codec register reads/writes to
complete are excessive given the maxmium time is one AC'97 frame (~21 us).

With AC'97 codecs with integrated touchscreens (like the UCB1400) this
improves the interactive performance of the touchscreen.

Signed-off-by: David Vrabel <dvrabel@arcom.com>

Index: linux-2.6-working/sound/pci/cs5535audio/cs5535audio.c
===================================================================
--- linux-2.6-working.orig/sound/pci/cs5535audio/cs5535audio.c	2006-03-02 16:12:52.000000000 +0000
+++ linux-2.6-working/sound/pci/cs5535audio/cs5535audio.c	2006-03-03 15:47:30.000000000 +0000
@@ -62,7 +62,7 @@
 		tmp = cs_readl(cs5535au, ACC_CODEC_CNTL);
 		if (!(tmp & CMD_NEW))
 			break;
-		msleep(10);
+		udelay(1);
 	} while (--timeout);
 	if (!timeout)
 		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
@@ -80,14 +80,14 @@
 	regdata |= CMD_NEW;
 
 	cs_writel(cs5535au, ACC_CODEC_CNTL, regdata);
-	wait_till_cmd_acked(cs5535au, 500);
+	wait_till_cmd_acked(cs5535au, 50);
 
 	timeout = 50;
 	do {
 		val = cs_readl(cs5535au, ACC_CODEC_STATUS);
 		if ((val & STS_NEW) && reg == (val >> 24))
 			break;
-		msleep(10);
+		udelay(1);
 	} while (--timeout);
 	if (!timeout)
 		snd_printk(KERN_ERR "Failure reading cs5535 codec\n");

--------------060803090207050707030804--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
