From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Bug 1472-wrong register value in my patch
Date: Fri, 24 Mar 2006 09:46:24 +0000
Message-ID: <200603240946.24547.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w/7IEWcTUydeFs9"
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_w/7IEWcTUydeFs9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have just discovered I made an error in the register value set in 'Limit 
dmx6fire to 6 dacs' patch (bug1472).  The value set should be '2a' not '0a' 
as in the original patch, which unintentionally disables the 2nd MPU 401 
UART.  Sorry about that.  Diff is attached for reference.

bug1472-ice1712.c-corr-reg-val.diff

Correct config register value in previous patch

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_w/7IEWcTUydeFs9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bug1472-ice1712.c-corr-reg-val.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bug1472-ice1712.c-corr-reg-val.diff"

--- alsa-kernel/pci/ice1712/ice1712.c-179	2006-03-20 22:16:21.000000000 +0000
+++ alsa-kernel/pci/ice1712/ice1712.c	2006-03-24 09:08:38.000000000 +0000
@@ -2399,7 +2399,7 @@
 	if (ice->eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE && !ice->dxr_enable) {
                 /* Limit active ADCs and DACs to 6;  */
                 /* Note: DXR extension not supported */
-		pci_write_config_byte(ice->pci, 0x60, 0x0a);
+		pci_write_config_byte(ice->pci, 0x60, 0x2a);
 	} else {
 		pci_write_config_byte(ice->pci, 0x60, ice->eeprom.data[ICE_EEP1_CODEC]);
 	}

--Boundary-00=_w/7IEWcTUydeFs9--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
