From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: VIA 8233A - Patch included
Date: Mon, 10 Feb 2003 09:21:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302100922.00046.tais.hansen@osd.dk>
References: <200302100621.HAA13634@www1.pobox.sk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fE2R+4TL4QVVOYF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200302100621.HAA13634@www1.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: p z oooo <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_fE2R+4TL4QVVOYF
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 10 February 2003 07:21, p z oooo wrote:
> There is bug in via82xx.c. VIA8233A is wrongly detected as VIA8233
> and then not working.

You're the man! You've found the bug I've been cursing for days now.

Takashi, I've attached a patch for you. Now the sound works like a charm=20
again! :)

=2D --=20
Regards,
Tais M. Hansen
OSD

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iQIVAwUBPkdhJIIvLOJqwYc4AQJqARAAosj0rw3+qHGPuRCuHeI9nE1ktNNrCZcY
Dq4bpUKB7fyttuocKeT8cAJdeArE7B7/NJ+uW9FpAsUPH1KP0qwTmRJHww0EHOuq
mW2A1QIwvjl/csoCYRlSHrRStq2a2to/Igv7IxKJOTE7hz+L+iiV+7NLaCogFywT
Mi3Fr6VNkkInqCm2vPdIsOiTUrwS9630l7KqXshmd8bqx193ZS3rgFQgGb327IBj
xrF50b0GqrIGU+UwGN50mmgrcHwfFWfh+8r6os59dFvslzQeh3+QY3Xhungm1emR
SfLMNtU0AvZmQNDF8t9b5B5UERHXFjO3yS0lsTptVd5CxXko11ShehqAqYBuIUuF
f83habq4Sy6Mv65QuaTGLwDNwieycI1RFSbwEgii1CNwcHlEVUb9v9XP1Yhz+U1P
rQQRKPp7rlxsNWF5VYdIBUIJlCny2UWYQOrPdVDzrfi5wfvGPWztCGU920YtQwrK
ohZ3Hb8x+sDMP4MZmJaydwCQoTu5h5wmsYhTKP6jyQPw6vgb7Z7pmrLzLa51og8k
vpKOl0kNA9GbbsN+gv78Ie3hLEW4hDPV20NQa+lh8CFga05namp1GAdHvJA0QOY+
9m2k+rLZMwIjQF74BZLmXu6i+txWPwrjRVK8akV/2CY2+lC9dABz/unoDlRo1v/m
Wq34yrsQRQ4=3D
=3DvWEn
=2D----END PGP SIGNATURE-----

--Boundary-00=_fE2R+4TL4QVVOYF
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="via82xx.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="via82xx.c.patch"

Index: via82xx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/via82xx.c,v
retrieving revision 1.24
diff -u -4 -p -r1.24 via82xx.c
--- via82xx.c	7 Feb 2003 11:38:53 -0000	1.24
+++ via82xx.c	10 Feb 2003 08:18:35 -0000
@@ -1861,9 +1861,9 @@ static int __devinit snd_via82xx_probe(s
 				strcpy(card->shortname, via823x_cards[i].name);
 				break;
 			}
 		}
-		if (chip_type == VIA_REV_8233A)
+		if (chip_type == TYPE_VIA8233A)
 			strcpy(card->driver, "VIA8233A");
 		else
 			strcpy(card->driver, "VIA8233");
 		break;
@@ -1883,9 +1883,9 @@ static int __devinit snd_via82xx_probe(s
 		if ((err = snd_via686_pcm_new(chip)) < 0 ||
 		    (err = snd_via686_init_misc(chip, dev)) < 0)
 			goto __error;
 	} else {
-		if (chip_type == VIA_REV_8233A) {
+		if (chip_type == TYPE_VIA8233A) {
 			if ((err = snd_via8233a_pcm_new(chip)) < 0)
 				goto __error;
 		} else {
 			if ((err = snd_via8233_pcm_new(chip)) < 0)

--Boundary-00=_fE2R+4TL4QVVOYF--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
