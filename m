From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Tue, 5 Sep 2006 20:24:55 +0100
Message-ID: <20060905192453.GA2537@tarte.seehuhn.de>
References: <s5hlkp96qfm.wl%tiwai@suse.de>
	<20060903155357.GA10408@tarte.seehuhn.de>
	<s5hveo4kl5q.wl%tiwai@suse.de>
	<20060904111303.GA24842@localhost.localdomain>
	<20060904174121.GA4736@quiche.seehuhn.de>
	<s5hpsebjxkf.wl%tiwai@suse.de>
	<20060904192738.GA16291@tarte.seehuhn.de>
	<s5h8xkyk631.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0980705198=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xkyk631.wl%tiwai@suse.de>
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


--===============0980705198==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

I do not completely understand the suggested test, do I just blindly
follow your suggestions.  I am sorry about the absence of more
intelligent contributions from my side here.

On Tue, Sep 05, 2006 at 11:36:50AM +0200, Takashi Iwai wrote:
> > I tried the following.  My amixer output is at the end of the mail for
> > reference.  first I created two shell scripts:
> >=20
> > -- s1.sh -------------------------------------------------------------
> > #! /bin/sh
> > amixer set "PCM Capture Gain" 2
> > amixer set "PCM Capture Gain" 0
> > amixer set "PCM" 0
> > amixer set "PCM" 80%
> > ----------------------------------------------------------------------
> >=20
> > -- s2.sh -------------------------------------------------------------
> > #! /bin/sh
> > amixer set "PCM Capture Gain" 0
> > amixer set "PCM Capture Gain" 2
> > amixer set "PCM" 0
> > amixer set "PCM" 80%
> > ----------------------------------------------------------------------
> >=20
> > and then I run the following command on the shell
> >=20
> >     while true; do ./s1.sh; sleep 1; ./s2.sh; sleep 1; done
> >=20
> > While this was running I recorded a wav file with arecord.  The volume
> > of the recorded file was extremely low (is this normal?) so I
> > normalised it with audacity.  I looked at the wave form in audacity
> > and I played the normalised file with alsamixer.
>=20
> In s2.sh, use a higher value for "PCM Capture Gain", such as 20.
> If the volume is still low, then IPGA is not independent.

I used 'amixer set "PCM Capture Gain" 20' now in s2.sh only.  Was this
the plan?  Result: there is now an audible crack when s2.sh is
executed, but the volume before and after the cracks still seems to be
the same.

I also tried something else: when I alternate between
----------------------------------------------------------------------
amixer set "PCM Capture Gain" 0
amixer set "PCM Capture Gain" 20
amixer set "PCM" 0
amixer set "PCM" 80%
----------------------------------------------------------------------
and
----------------------------------------------------------------------
amixer set "PCM" 0
amixer set "PCM" 80%
amixer set "PCM Capture Gain" 0
amixer set "PCM Capture Gain" 20
----------------------------------------------------------------------
the recording has alternating load and quiete stretches.  Whatever this
might tell us about the ADC, it looks like a bug to me: the order of
setting the two controls shouldn't matter.  Or am I confused again?

I hope this helps,
Jochen
--=20
http://seehuhn.de/

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE/c8Ff+iD8yEbECURAiDfAJ9dEBVKmTK4KI2BIwrt8L8IOpkQPACgjkZD
QtFfT3/Nd0f99d2fAGg4Hhc=
=Kyr+
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--


--===============0980705198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0980705198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0980705198==--
