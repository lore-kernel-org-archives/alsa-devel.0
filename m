From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH] AMD Au1x00: AC'97 controller is memory mapped
Date: Tue, 21 Mar 2006 00:17:34 +0300
Message-ID: <441F1BEE.8080307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010809000202010604080600"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jordan Crouse <jordan.crouse@amd.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010809000202010604080600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    AMD Au1x00 ALSA driver erroneously calls request_region() for AC'97 
controller registers -- the controller is actually memory mapped at addresses
0x10000000 thru 0x100FFFFF.

WBR, Sergei



--------------010809000202010604080600
Content-Type: text/plain;
 name="Au1x00-ALSA-AC97-memory-mapped.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1x00-ALSA-AC97-memory-mapped.patch"

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 6d8f8b3..aa9c5d5 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -561,12 +561,13 @@ snd_au1000_ac97_new(struct snd_au1000 *a
 		.read = snd_au1000_ac97_read,
 	};
 
-	if ((au1000->ac97_res_port = request_region(AC97C_CONFIG,
-	       		sizeof(struct au1000_ac97_reg), "Au1x00 AC97")) == NULL) {
+	if ((au1000->ac97_res_port = request_mem_region(CPHYSADDR(AC97C_CONFIG),
+	       		0x100000, "Au1x00 AC97")) == NULL) {
 		snd_printk(KERN_ERR "ALSA AC97: can't grap AC97 port\n");
 		return -EBUSY;
 	}
-	au1000->ac97_ioport = (struct au1000_ac97_reg *) au1000->ac97_res_port->start;
+	au1000->ac97_ioport = (struct au1000_ac97_reg *)
+		KSEG1ADDR(au1000->ac97_res_port->start);
 
 	spin_lock_init(&au1000->ac97_lock);
 


--------------010809000202010604080600--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
