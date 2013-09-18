From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 19:34:01 +0100
Message-ID: <20130918183401.GG21013@sirena.org.uk>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
 <20130918094158.GL21013@sirena.org.uk>
 <CAOesGMj52_xcKS4q54i_gw_T2xWt=c6rwBtP9Ds2LbytjRuNKQ@mail.gmail.com>
 <20130918153842.GA21013@sirena.org.uk>
 <20130918165334.GA26446@quad.lixom.net>
 <20130918172858.GE21013@sirena.org.uk>
 <20130918173620.GA28143@quad.lixom.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6530599635428140879=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 636552608EC
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 20:34:12 +0200 (CEST)
In-Reply-To: <20130918173620.GA28143@quad.lixom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============6530599635428140879==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tJKub4+frm2HVP3B"
Content-Disposition: inline


--tJKub4+frm2HVP3B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2013 at 10:36:20AM -0700, Olof Johansson wrote:
> On Wed, Sep 18, 2013 at 06:28:58PM +0100, Mark Brown wrote:

> > I'd have expected the folks doing the allyesconfig builds to have
> > complained then...

> Allyes will probably turn on CONFIG_ACPI and thus reference the variable
> in the struct device.

Yeah, I was thinking of OF which isn't available on all architectures.
Perhaps it is on every architecture people tend to do this stuff on
though.

> With the new of_match_ptr() and ACPI_PTR() you get rid of the
> ifdef in struct device for those, but you still want it around
> MODULE_DEVICE_TABLE() and the actual definition of the match table.

Hrm, perhaps that was what was supposed to happen - have
MODULE_DEVICE_TABLE() create the appropriate eliminateable static
reference so the compiler can figure things out and we don't need the
ifdefs.  It'd certainly be nice to elimiante more of these ifdefs.

--tJKub4+frm2HVP3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOfIWAAoJELSic+t+oim9HIAP/0By9kgOijqxD8MhbN6+jTME
wPuKXsIXIRt6/DjbXoYS3EVFHWLP/eoWhUK+gKPjuYexpWfa0aQJVYOl1N+wwLtN
jdWPFlZlBG4WRkkFkC3+GE4xGZQTFuP/4XSebSKaNR9Q5SJuRwmaP/3gFcV2qJbl
54CdRUtSGM/hDVPefeCzET/wB2/gZhFtdNQ4hbyq47YJHi/T9rbsOdNS5/rnm08Z
Y5vZqGFAafsbyNiT/D8pjfu5k7h55/Qz46jcx2RKU2aix8TuLYkHbLBB9Vs/iyiA
rjryD2cwlgQpOpbUXWbAfxQkXNsnxECbfAtCE3huDLG1EPK3r/AYAIAygxrok5Yb
e2itJ/vrwqDckhoqLdZ3CxoAeHle45VQM2CPq1aBfciR/bLiq/xcVgtlVUUNYIb3
Gt+KrKma3Su8OrD4BJzziqy4OY5knrYqg1RN/LkGqjHzYnVvNH44rPM+eW8mVXGX
LHj+/UXPksHYabdMIAUBenYpyLB3a9C36yWpl2p1vyuOx98ISfE2kTWTBGBE2gUt
wbfLnrpJxYreM0C5nGig/7Ew6B/sly9JgsBttLVeMycTcoLAk+gkgCP3Yfr23wZI
EzT3SF/dlJwKXBVNkPNNw3m+PHZEkWnRMM8ClZ1DjEYTviRHqdbAiyMgyLQaN9ha
/fElctyxUnSIE1CQS/jK
=DVqf
-----END PGP SIGNATURE-----

--tJKub4+frm2HVP3B--

--===============6530599635428140879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6530599635428140879==--
