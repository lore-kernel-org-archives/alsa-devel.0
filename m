From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Edirol DA-2496
Date: Mon, 13 Oct 2003 17:34:22 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310131726440.1354-200000@studcom.urz.uni-halle.de>
References: <s5h4qyd5hqn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_rTJ1UfVNrDSx85Nq50/yRQ)"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h4qyd5hqn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonatan de la Torre <jonatandelatorre@ono.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_rTJ1UfVNrDSx85Nq50/yRQ)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Takashi Iwai wrote:
> Jonatan de la Torre wrote:
> >
> > Ice1712 has 128 pins,
> > Which among them should I test?

If you really want to: the GPIO pins; but this should not yet be
necessary.

> did you try to add the id as delta 1010LT?

Probably not yet.

Jonatan, please save the attached file to your disk, go to the
alsa-kernel/pci/ice1712 directory, and run the command

	patch -p0 < patchfile

(with the correct path to the patchfile), then recompile and reinstall
the driver.


HTH
Clemens

--Boundary_(ID_rTJ1UfVNrDSx85Nq50/yRQ)
Content-id: <Pine.HPX.4.33n.0310131734220.1354@studcom.urz.uni-halle.de>
Content-type: TEXT/PLAIN; charset=US-ASCII; name=patchfile
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=patchfile
Content-description: 

--- delta.c.org	2003-10-13 17:19:35.343829000 +0200
+++ delta.c	2003-10-13 17:24:35.686566000 +0200
@@ -435,6 +435,7 @@
 		break;
 	case ICE1712_SUBDEVICE_DELTA1010:
 	case ICE1712_SUBDEVICE_DELTA1010LT:
+	case 0xce164010:
 		ice->num_total_dacs = 8;
 		break;
 	}
@@ -444,6 +445,7 @@
 	case ICE1712_SUBDEVICE_AUDIOPHILE:
 	case ICE1712_SUBDEVICE_DELTA410:
 	case ICE1712_SUBDEVICE_DELTA1010LT:
+	case 0xce164010:
 		if ((err = snd_i2c_bus_create(ice->card, "ICE1712 GPIO 1", NULL, &ice->i2c)) < 0) {
 			snd_printk("unable to create I2C bus\n");
 			return err;
@@ -488,6 +490,7 @@
 		err = snd_ice1712_akm4xxx_init(ak, &akm_delta410, &akm_delta410_priv, ice);
 		break;
 	case ICE1712_SUBDEVICE_DELTA1010LT:
+	case 0xce164010:
 		err = snd_ice1712_akm4xxx_init(ak, &akm_delta1010lt, &akm_delta1010lt_priv, ice);
 		break;
 	case ICE1712_SUBDEVICE_DELTA66:
@@ -539,6 +542,7 @@
 			return err;
 		break;
 	case ICE1712_SUBDEVICE_DELTA1010LT:
+	case 0xce164010:
 		err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_ice1712_delta1010lt_wordclock_select, ice));
 		if (err < 0)
 			return err;
@@ -570,6 +574,7 @@
 	/* ak4524 controls */
 	switch (ice->eeprom.subvendor) {
 	case ICE1712_SUBDEVICE_DELTA1010LT:
+	case 0xce164010:
 	case ICE1712_SUBDEVICE_AUDIOPHILE:
 	case ICE1712_SUBDEVICE_DELTA410:
 	case ICE1712_SUBDEVICE_DELTA44:
@@ -630,5 +635,11 @@
 		snd_ice1712_delta_init,
 		snd_ice1712_delta_add_controls,
 	},
+	{
+		0xce164010,
+		"Edirol DA-2496",
+		snd_ice1712_delta_init,
+		snd_ice1712_delta_add_controls,
+	},
 	{ } /* terminator */
 };

--Boundary_(ID_rTJ1UfVNrDSx85Nq50/yRQ)--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
