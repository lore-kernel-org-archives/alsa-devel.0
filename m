From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: stac9708 additions
Date: Tue, 17 Jun 2003 05:49:04 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030617104904.GE16568@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


Hi,

Attached patch adds some stac9708 features that I found missing.  The
name of the 4-speaker stereo probably does not conform to policy, but I
couldn't figure out what to name it. :)  Any suggestions?

These options were found while working on the upcoming au88x0 driver
currently on savannah.

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="ac97.diff"

diff -ur /home/nemesis/src/linux/aureal/alsa/alsa-driver-0.9.4/sound/pci/ac97/ac97_codec.c sound/pci/ac97/ac97_codec.c
--- /home/nemesis/src/linux/aureal/alsa/alsa-driver-0.9.4/sound/pci/ac97/ac97_codec.c	2003-05-31 09:15:01.000000000 -0500
+++ sound/pci/ac97/ac97_codec.c	2003-06-15 06:42:33.000000000 -0500
@@ -743,6 +743,12 @@
 AC97_DOUBLE("Sigmatel Surround Playback Volume", AC97_HEADPHONE, 8, 0, 31, 1)
 };
 
+static const snd_kcontrol_new_t snd_ac97_sigmatel_4speaker =
+AC97_SINGLE("Sigmatel 4-Speaker Stereo Playback Switch", AC97_SIGMATEL_DAC2INVERT, 2, 1, 0);
+
+static const snd_kcontrol_new_t snd_ac97_sigmatel_phaseinvert =
+AC97_SINGLE("Sigmatel Surround Phase Inversion Playback Switch", AC97_SIGMATEL_DAC2INVERT, 3, 1, 0);
+
 static const snd_kcontrol_new_t snd_ac97_sigmatel_controls[] = {
 AC97_SINGLE("Sigmatel DAC 6dB Attenuate", AC97_SIGMATEL_ANALOG, 1, 1, 0),
 AC97_SINGLE("Sigmatel ADC 6dB Attenuate", AC97_SIGMATEL_ANALOG, 0, 1, 0)
@@ -1872,6 +1878,12 @@
 		if (snd_ac97_try_bit(ac97, AC97_SIGMATEL_ANALOG, 0))
 			if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_sigmatel_controls[1], ac97))) < 0)
 				return err;
+		if (snd_ac97_try_bit(ac97, AC97_SIGMATEL_DAC2INVERT, 2))
+			if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_sigmatel_4speaker, ac97))) < 0)
+				return err;
+		if (snd_ac97_try_bit(ac97, AC97_SIGMATEL_DAC2INVERT, 3))
+			if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_sigmatel_phaseinvert, ac97))) < 0)
+				return err;
 		break;
 	case AC97_ID_ALC650:
 		/* detect ALC650 rev.E of later */

--RnlQjJ0d97Da+TV1--


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
