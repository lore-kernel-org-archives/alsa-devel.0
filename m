From: Timo Hirvonen <tihirvon@ee.oulu.fi>
Subject: via82xx calc_linear_pos bug
Date: Fri, 23 Jul 2004 18:47:30 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090597651.3258.3.camel@onion.home.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-jgoCpsZlDH3WDis0Sx7y"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-jgoCpsZlDH3WDis0Sx7y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

After playing about 10-20 seconds snd_pcm_status_get_avail returns too
large value (1972895704, 1972895664 ..).

Tested kernels:

	2.6.7-mm1	works
	2.6.7-mm2	broken
	2.6.8-rc1-mm1	broken

lspci -v 
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 50)
        Subsystem: VIA Technologies, Inc.: Unknown device 4161
        Flags: medium devsel, IRQ 22
        I/O ports at e800
        Capabilities: [c0] Power Management version 2

Attached patch (against 2.6.8-rc1-mm1) changes calc_linear_pos to the
state it was in 2.6.7-mm1.

I don't understand the code so this might not be right solution to this
problem but it seems to work.

--=-jgoCpsZlDH3WDis0Sx7y
Content-Disposition: attachment; filename=via82xx-calc_linear_pos.patch
Content-Type: text/x-patch; name=via82xx-calc_linear_pos.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- sound/pci/via82xx.c.orig	2004-07-23 16:16:23.000000000 +0300
+++ sound/pci/via82xx.c	2004-07-23 16:16:40.000000000 +0300
@@ -715,11 +715,7 @@ static inline unsigned int calc_linear_p
 	unsigned int size, res;
 
 	size = viadev->idx_table[idx].size;
-	/* FIXME: is this always true? */
-	if (count)
-		res = viadev->idx_table[idx].offset + size - count;
-	else
-		res = viadev->idx_table[idx].offset;
+	res = viadev->idx_table[idx].offset + size - count;
 
 	/* check the validity of the calculated position */
 	if (size < count || (res < viadev->lastpos && (res >= viadev->bufsize2 || viadev->lastpos < viadev->bufsize2))) {

--=-jgoCpsZlDH3WDis0Sx7y--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
