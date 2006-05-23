From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: DMX6fire  Consumer AC97 not used
Date: Tue, 23 May 2006 10:45:35 +0100
Message-ID: <200605231037.14170.gineera@aspect135.co.uk>
References: <200605221450.14491.gineera@aspect135.co.uk> <s5hverykvd1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/mtcElIvcd2qzjp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hverykvd1.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_/mtcElIvcd2qzjp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 22 May 2006 15:05, you wrote:
> At Mon, 22 May 2006 14:52:08 +0100,
>
> Alan Horstmann wrote:
> > Another little 'tidy-up':
> >
> > Have always had the following log message with DMX6fire:
> >
> >  linux kernel: Consumer PCM code does not work well at the moment --jk
> >  linux kernel: ALSA ac97_codec.c:1671: AC'97 0:0 does not respond - RES=
ET
> >  linux kernel: ALSA ac97_codec.c:1682: AC'97 0:0 access is not valid
> > [0xffffffff], removing mixer.
> >  linux kernel: ice1712: cannot initialize ac97 for consumer, skipped
> >
> > and thought the last 3 were due to the first.  However, after comparing
> > DMX6fire with STDSP24 card, it seems to me that the 6fire doesn't have =
an
> > AC97 chip, nor anywhere to connect to one in the standard front box, and
> > the W2K drivers from Terratec don't support it.  It is remotely possible
> > that other extension boxes may use it -but they do not have alsa support
> > at present.
> >
> > BUT the eeprom data has it enabled.  As the value is checked at several
> > places in the code, the attached patch changes the stored value for this
> > and the previous 'Limit ADACs to 6' bits.
> >
> > As a result, the log now shows no evidence of ice1712 driver at all, so=
 I
> > added 'init...done' as in the attached 'init-message' patch.  It may be
> > the wrong place, or not wanted at all, so I kept it separate from the
> > AC97 patch. Hope it's OK in this case to attach both here.
>
> Please don't put such printk.  We don't put any info print at probe
> unless any problem exists.

OK, it's your call on this.  To me it is useful to log major system events =
to=20
look back and see what was happening; there is plenty of much less useful=20
messsages in the logs, including IP addresses, every root login, and every=
=20
second that I don't have a CD in the drive! (need to fix that).  The au8820=
=20
driver does a similar init message.

> Otherwise the change looks OK to get merged, but please fold the
> comment within 80 columns.

Amended AC97 patch attached.

Alan

ice1712.c-disable-6fire-AC97-2.patch

Summary: =A0Disable AC97 for DMX6fire

Consumer AC97 is not used by the Terratec DMX6fire, but eeprom bit indicate=
s=20
it is; change the stored value to disable failing consumer mode.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_/mtcElIvcd2qzjp
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ice1712.c-disable-6fire-AC97-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ice1712.c-disable-6fire-AC97-2.patch"

--- alsa-driver-1.0.11-orig/alsa-kernel/pci/ice1712/ice1712.c	2006-04-18 12:38:03.000000000 +0100
+++ alsa-driver-1.0.11/alsa-kernel/pci/ice1712/ice1712.c	2006-05-22 22:43:38.000000000 +0100
@@ -2398,13 +2398,13 @@
 	udelay(200);
 	outb(ICE1712_NATIVE, ICEREG(ice, CONTROL));
 	udelay(200);
-	if (ice->eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE && !ice->dxr_enable) {
-                /* Limit active ADCs and DACs to 6;  */
-                /* Note: DXR extension not supported */
-		pci_write_config_byte(ice->pci, 0x60, 0x2a);
-	} else {
-		pci_write_config_byte(ice->pci, 0x60, ice->eeprom.data[ICE_EEP1_CODEC]);
-	}
+	if (ice->eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE && !ice->dxr_enable)
+		/*  Set eeprom value to limit active ADCs and DACs to 6;
+		 *  Also disable AC97 as no hardware in standard 6fire card/box
+		 *  Note: DXR extensions are not currently supported
+		 */
+		ice->eeprom.data[ICE_EEP1_CODEC] = 0x3a;
+	pci_write_config_byte(ice->pci, 0x60, ice->eeprom.data[ICE_EEP1_CODEC]);
 	pci_write_config_byte(ice->pci, 0x61, ice->eeprom.data[ICE_EEP1_ACLINK]);
 	pci_write_config_byte(ice->pci, 0x62, ice->eeprom.data[ICE_EEP1_I2SID]);
 	pci_write_config_byte(ice->pci, 0x63, ice->eeprom.data[ICE_EEP1_SPDIF]);

--Boundary-00=_/mtcElIvcd2qzjp--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
