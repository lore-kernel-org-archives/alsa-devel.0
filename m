From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Mon, 08 Oct 2012 18:52:26 +0200
Message-ID: <87ehl86h4l.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5hzk4ja5hz.wl%tiwai@suse.de> <87pq5fiklg.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de> <87haqrijiz.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de> <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
 <87ehl96ifc.fsf@dex.adm.naquadah.org> <s5h7gr1gc7o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8519130027383689743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 967002625E0
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 18:53:17 +0200 (CEST)
In-Reply-To: <s5h7gr1gc7o.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
 08 Oct 2012 18:28:27 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============8519130027383689743==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08 2012, Takashi Iwai wrote:

> Yep, as David pointed out, the beep control overrides the amp setup.
> And your previous result suggested that we shouldn't use this beep
> path either (except for unmuting it), otherwise you get a noise
> again.
>
> So, the patch below is the revised version.  It removes the beep
> control but still opens the path to NID 0x1d.

It does remove the beep control, and I think it therefore break the beep
functionnality: I've no sound when echoing '\a'. But that's likely to be
expected anyhow. :-/

But yeah, definitely, I've no noise anymore in this case with this
patch.

Now, I can still make the noise come back when "speaker" or "master" is
muted. This is definitely not a side effect of your patch, I just didn't
raise it before.



This diff is between "no noise" (=3D just loaded the module with your
patch) and "noise with master muted":

diff -u /tmp/no-noise.txt /tmp/noise-master-mute.txt
=2D-- /tmp/no-noise.txt	2012-10-08 18:36:44.601047347 +0200
+++ /tmp/noise-master-mute.txt	2012-10-08 18:37:02.221050163 +0200
@@ -3,7 +3,7 @@
 !!ALSA Information Script v 0.4.61
 !!################################

=2D!!Script ran on: Mon Oct  8 16:36:44 UTC 2012
+!!Script ran on: Mon Oct  8 16:37:02 UTC 2012


 !!Linux Distribution
@@ -260,7 +260,7 @@
     ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
   Control: name=3D"Speaker Phantom Jack", index=3D0, device=3D0
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
=2D  Amp-Out vals:  [0x00 0x00]
+  Amp-Out vals:  [0x80 0x80]
   Pincap 0x00010050: OUT EAPD Balanced
   EAPD 0x2: EAPD
   Pin Default 0x90170110: [Fixed] Speaker at Int N/A




This diff is between "no noise" (=3D just loaded the module with your
patch) and "noise with speaker muted":

diff -u /tmp/no-noise.txt /tmp/noise-speaker-mute.txt
=2D-- /tmp/no-noise.txt	2012-10-08 18:36:44.601047347 +0200
+++ /tmp/noise-speaker-mute.txt	2012-10-08 18:37:10.913051519 +0200
@@ -3,7 +3,7 @@
 !!ALSA Information Script v 0.4.61
 !!################################

=2D!!Script ran on: Mon Oct  8 16:36:44 UTC 2012
+!!Script ran on: Mon Oct  8 16:37:10 UTC 2012


 !!Linux Distribution
@@ -260,7 +260,7 @@
     ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
   Control: name=3D"Speaker Phantom Jack", index=3D0, device=3D0
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
=2D  Amp-Out vals:  [0x00 0x00]
+  Amp-Out vals:  [0x80 0x80]
   Pincap 0x00010050: OUT EAPD Balanced
   EAPD 0x2: EAPD
   Pin Default 0x90170110: [Fixed] Speaker at Int N/A



Now, I've discovered one more thing, don't know if you know. This is how
I managed to REALLY mute the speakers, the noise, everything (even
playing a sound file with everything unmuted makes no sound):

% diff -u /tmp/sound.txt /tmp/no-sound-at-all.txt
=2D-- /tmp/sound.txt	2012-10-08 18:48:02.605161041 +0200
+++ /tmp/no-sound-at-all.txt	2012-10-08 18:47:50.453158964 +0200
@@ -3,7 +3,7 @@
 !!ALSA Information Script v 0.4.61
 !!################################
=20
=2D!!Script ran on: Mon Oct  8 16:48:02 UTC 2012
+!!Script ran on: Mon Oct  8 16:47:50 UTC 2012
=20
=20
 !!Linux Distribution
@@ -267,7 +267,7 @@
     Conn =3D Analog, Color =3D Unknown
     DefAssociation =3D 0x1, Sequence =3D 0x0
     Misc =3D NO_PRESENCE
=2D  Pin-ctls: 0x40: OUT
+  Pin-ctls: 0x00:
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=3DD0, actual=3DD0
   Connection: 2



When doing that, I cannot hear anything, because it seems to disconnect
the speakers. My idea would be to set this pin to 0x00 instead of 0x40
when "Speakers" are set to mute (I don't know about master though).
WDYT?

Attached all the files.


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=noise-master-mute.txt.gz
Content-Transfer-Encoding: base64

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
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=noise-speaker-mute.txt.gz
Content-Transfer-Encoding: base64

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
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=no-noise.txt.gz
Content-Transfer-Encoding: base64

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
L025C0epH5N+lkpYOfvbtcL/ABxou1HPQwAA
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=no-sound-at-all.txt.gz
Content-Transfer-Encoding: base64

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
asJdOEP9kPCzUMDK6R+t5f4PtWZH1chDAAA=
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=sound.txt.gz
Content-Transfer-Encoding: base64

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
U8LPQgErp3+4lvs/EdBSEMxDAAA=
--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



This sound card seems really weird. :)

=2D-=20
Julien Danjou
# Free Software hacker & freelance
# http://julien.danjou.info

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQcwTKAAoJEGEbqVCLeKXC+SkP/1WrMD1SxLpGim01h4NnmsJA
tYJTq/di/S/0jmOUxv8WsJTNJ1sTM1SebZCE4reo8q+wUN/w1k5g84BAerS+19YK
ven/e6B9guyqYcRSpqryzMi6d0RmD7WYUMIRD7YZFcqWConroCRT8Qde19B01rWJ
u8gfVSKFfDj3BDUWe9mkImj7OLhEdPy51frmjQIESckp9wwbtWuvljkQekuqFEqO
ScAMiWwvGKsxZgZOAOY7xAkWmb8/FwCrVX1OIIhiN3NaN0OprLuGLOBTyU9VFUaM
zUcMuZmbCRFTR7wAeJcCqj5Y34WxPNq9N8YbwbKjhsCAYYwurAQt2lBPyYTNVji7
VqVcsNV2v37IpX21G8Xcv9Ls5WW3K4a3bSP/zx0OS+4+8erIUNwYP4U2WA9Mmxcn
pdOhNX0X+dUeK0vwMFZuzNgKLVlMzxuygfSMAFym3Hm1dr6KgFu49tMpIKLcXAcj
F5Gyk4i6ml5FpGUI8C7IAZ+1pi9T0iYvpRqGG0N8O0jKOKPUxu5TaAWwfpLFJNde
2EXLkoFzlVzlfmGVkDJ7m+vuw7PI1IUo9Yl+M9o8ZDx+id8E6jPt0h7OAHE/iC+W
WPL0gV1OTZy/qrKxGGgmzL60GkOSLvHnpWt44tq+mtV8rE0b0Ju0S2beiEZw12Gx
MkmEapDwzCFt2t39tljB
=rDzX
-----END PGP SIGNATURE-----
--==-=-=--

--===============8519130027383689743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8519130027383689743==--
