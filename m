From: Magnus Sandin <magnus@sandin.cx>
Subject: [PATCH] LG K1 Express Laptop
Date: Mon, 14 Aug 2006 23:44:55 +0200
Message-ID: <44E0EED7.3040402@sandin.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090609030807030005090409"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090609030807030005090409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The attached patch will unset the S/PDIF-in bit (on LG K1 Express
Laptops only) in the vendor specific register 0x7A of the Realtek ALC655
chip.

Without this patch, there where no sound on the LG K1 Express model:
K1-2333V laptop at all.

Regards
// Magnus Sandin


--------------090609030807030005090409
Content-Type: text/x-patch;
 name="alsa-lg_k1_express.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lg_k1_express.patch"

diff -Nru alsa-kernel/pci/ac97/ac97_patch.c alsa-kernel-patched/pci/ac97/ac97_patch.c
--- alsa-kernel/pci/ac97/ac97_patch.c   2006-08-14 22:13:17.000000000 +0200
+++ alsa-kernel-patched/pci/ac97/ac97_patch.c   2006-08-14 23:20:32.000000000 +0200
@@ -2210,6 +2210,9 @@
                if (ac97->subsystem_vendor == 0x1462 &&
                    ac97->subsystem_device == 0x0131) /* MSI S270 laptop */
                        val &= ~(1 << 1); /* Pin 47 is EAPD (for internal speaker) */
+               else if (ac97->subsystem_vendor == 0x1462 &&
+                        ac97->subsystem_device == 0x0161) /* LG K1 Express Laptop */
+                       val &= ~(1 << 1); /* Pin 47 is EAPD (for internal speaker) */
                else
                        val |= (1 << 1); /* Pin 47 is spdif input pin */
        }

--------------090609030807030005090409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------090609030807030005090409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------090609030807030005090409--
