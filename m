From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Thu, 7 Sep 2006 11:29:54 +0100
Message-ID: <20060907102954.GA17846@localhost.localdomain>
References: <s5hlkp96qfm.wl%tiwai@suse.de>
	<20060903155357.GA10408@tarte.seehuhn.de>
	<s5hveo4kl5q.wl%tiwai@suse.de>
	<20060904111303.GA24842@localhost.localdomain>
	<20060904174121.GA4736@quiche.seehuhn.de>
	<s5hpsebjxkf.wl%tiwai@suse.de>
	<20060904192738.GA16291@tarte.seehuhn.de>
	<s5h8xkyk631.wl%tiwai@suse.de>
	<20060905192453.GA2537@tarte.seehuhn.de>
	<s5hr6yokmym.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1535759978=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hr6yokmym.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1535759978==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Thu, Sep 07, 2006 at 12:09:05PM +0200, Takashi Iwai wrote:
> > > > -- s1.sh ----------------------------------------------------------=
---
> > > > #! /bin/sh
> > > > amixer set "PCM Capture Gain" 2
> > > > amixer set "PCM Capture Gain" 0
> > > > amixer set "PCM" 0
> > > > amixer set "PCM" 80%
> > > > -------------------------------------------------------------------=
---
> > > >=20
> > > > -- s2.sh ----------------------------------------------------------=
---
> > > > #! /bin/sh
> > > > amixer set "PCM Capture Gain" 0
> > > > amixer set "PCM Capture Gain" 2
> > > > amixer set "PCM" 0
> > > > amixer set "PCM" 80%
> > > > -------------------------------------------------------------------=
---

> > I used 'amixer set "PCM Capture Gain" 20' now in s2.sh only.  Was this
> > the plan?  Result: there is now an audible crack when s2.sh is
> > executed, but the volume before and after the cracks still seems to be
> > the same.
>=20
> The crack doesn't matter seriously, but just the volume.

The volume is the same.

Why is everything assigned twice (e.g. first 0 then 2) in this test?

> > I also tried something else: when I alternate between
> > ----------------------------------------------------------------------
> > amixer set "PCM Capture Gain" 0
> > amixer set "PCM Capture Gain" 20
> > amixer set "PCM" 0
> > amixer set "PCM" 80%
> > ----------------------------------------------------------------------
> > and
> > ----------------------------------------------------------------------
> > amixer set "PCM" 0
> > amixer set "PCM" 80%
> > amixer set "PCM Capture Gain" 0
> > amixer set "PCM Capture Gain" 20
> > ----------------------------------------------------------------------
> > the recording has alternating load and quiete stretches.  Whatever this
> > might tell us about the ADC, it looks like a bug to me: the order of
> > setting the two controls shouldn't matter.  Or am I confused again?
>=20
> Well, assume that "PCM Capture" and "PCM Capture Gain" are
> independent.  If so, the above two should result in the same state.
>=20
> If it's not independent but the register 4 & 5 take single values
> (that was the behavior of your original implementation), the above two
> cases must make a clear difference: in the former case, the gain is
> below 0dB, and in the latter it's +10dB.  Was it so through your
> tests?

Yes, the recording had alternating load and quite stretches,
corresponding to the two settings.

So both tests seem to indicate that for the AK5365 registers 4 and 5
take only a single value.  Correct?

> Also, it's possible that I did make a silly mistake.  Put a debug
> printk around ak->ops.write() in snd_akm4xxx_write() to check what
> values are written to register 4 and 5.

I will try this in the evening.

Many thanks,
Jochen
--=20
http://seehuhn.de/

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE//Sif+iD8yEbECURAs9eAKCevONfxJMFMG9Xd0gVtSIfgdh9WwCeMZqS
ttW1WXgTFkxrS8wIP+yHrwo=
=32h4
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--


--===============1535759978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1535759978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1535759978==--
