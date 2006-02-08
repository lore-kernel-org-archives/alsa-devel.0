From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Envy24 -PSDIN(3) -bug1472 fix
Date: Wed, 8 Feb 2006 15:33:31 +0000
Message-ID: <200602081532.17040.gineera@aspect135.co.uk>
References: <200602030928.18467.gineera@aspect135.co.uk> <200602052115.52601.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L9g6Dt2lCvom61P"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602052115.52601.gineera@aspect135.co.uk>
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


--Boundary-00=_L9g6Dt2lCvom61P
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 05 February 2006 21:15, I wrote:
> > Re bug1472, Distortion noise:

> The attached patch does this in ice1712.c;  will this fix be able to make
> it into 1.0.11 final?  This is the last of my list of '6fire bugs/funnies so
> it would be good if they were all together in one release.
>
> bug1472-dmx6fire-limit-to-6ADCs.patch
>
> Summary: Disable unused ADCs & DACs on DMX6fire
>
> Change the value written to hardware configuration register of envy24 chip
> in the case of Terratec DMX6fire to restrict the active ADCs & DACs to 6.
>
> Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

As noted on bug-track, slight typo in patch; corrected version 3 attached here 
also.



--Boundary-00=_L9g6Dt2lCvom61P
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="bug1472-dmx6fire-limit-to-6ADCs-v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bug1472-dmx6fire-limit-to-6ADCs-v3.patch"

--- alsa-driver-1.0.11rc2/alsa-kernel/pci/ice1712/ice1712-orig.c	2006-02-01 22:56:53.000000000 +0000
+++ alsa-driver-1.0.11rc2/alsa-kernel/pci/ice1712/ice1712.c	2006-02-05 20:53:30.000000000 +0000
@@ -2388,7 +2390,11 @@
 	udelay(200);
 	outb(ICE1712_NATIVE, ICEREG(ice, CONTROL));
 	udelay(200);
-	pci_write_config_byte(ice->pci, 0x60, ice->eeprom.data[ICE_EEP1_CODEC]);
+	if (ice->eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) { /* Limit active ADCs and DACs to 6;  */
+		pci_write_config_byte(ice->pci, 0x60, 0x0a);       /* Note: DXR extension not supported */
+	} else {
+		pci_write_config_byte(ice->pci, 0x60, ice->eeprom.data[ICE_EEP1_CODEC]);
+	}
 	pci_write_config_byte(ice->pci, 0x61, ice->eeprom.data[ICE_EEP1_ACLINK]);
 	pci_write_config_byte(ice->pci, 0x62, ice->eeprom.data[ICE_EEP1_I2SID]);
 	pci_write_config_byte(ice->pci, 0x63, ice->eeprom.data[ICE_EEP1_SPDIF]);

--Boundary-00=_L9g6Dt2lCvom61P--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
