From: Ashley Clark <aclark@ghoti.org>
Subject: Adds HDA support for Intel D945Pvs board subdevice id 0x0707
Date: Sun, 9 Apr 2006 19:42:28 -0500
Message-ID: <EB97D297-97AD-4BF3-9829-E19865591315@ghoti.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-6-966307627
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
List-Id: alsa-devel@alsa-project.org


--Apple-Mail-6-966307627
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Sorry about the last message, not sure if it had the attachment in it.

Signed-Off-By: Ashley Clark <aclark@ghoti.org>

Summary: Adds HDA support for Intel D945Pvs board with subdevice id  
0x0707

This patch adds the entry for the 5-stack pin-config for the STAC  
chip on the Intel D945Pvs board with subdevice id 0x0707.

With this patch against 1.0.11rc4 in the linux kernel 2.6.17-rc1, I'm  
able to successfully output over the optical port and analog ports.

Ashley Clark

--Apple-Mail-6-966307627
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-mac-type=42494E41;
	x-unix-mode=0644;
	x-mac-creator=68446D70;
	name="sigmatel.diff"
Content-Disposition: attachment;
	filename=sigmatel.diff

--- patch_sigmatel.c.aclark     2006-04-09 14:49:38.000000000 -0500
+++ patch_sigmatel.c    2006-04-09 15:38:35.000000000 -0500
@@ -310,6 +310,9 @@
          .pci_subdevice = 0x0b0b,
          .config = STAC_D945GTP3 },    /* Intel D945PSN - 3 Stack, 9221 A1 */
        { .pci_subvendor = PCI_VENDOR_ID_INTEL,
+         .pci_subdevice = 0x0707,
+         .config = STAC_D945GTP5 },    /* Intel D945PSV - 5 Stack */
+       { .pci_subvendor = PCI_VENDOR_ID_INTEL,
          .pci_subdevice = 0x0404,
          .config = STAC_D945GTP5 },    /* Intel D945GTP - 5 Stack */
        { .pci_subvendor = PCI_VENDOR_ID_INTEL,

--Apple-Mail-6-966307627
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




--Apple-Mail-6-966307627--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
