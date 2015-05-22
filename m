From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
	match function
Date: Fri, 22 May 2015 18:41:06 +0100
Message-ID: <20150522174106.GV21577@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-2-git-send-email-vinod.koul@intel.com>
 <20150522125634.GX21391@sirena.org.uk>
 <s5hwq00enw8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1004938069717444942=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D83826041D
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 19:41:14 +0200 (CEST)
In-Reply-To: <s5hwq00enw8.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1004938069717444942==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wiqv+dddIdXsNRUi"
Content-Disposition: inline


--Wiqv+dddIdXsNRUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2015 at 03:35:03PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > I'm sorry but I still don't entirely understand what this is supposed to
> > do.  It *looks* like it's trying to create a bus for HDA with this:

> > but it's not actually defining a driver model bus type (though it does
> > use driver_register()) and I'd expect the bus type to be provided by the
> > generic HDA code.  Looking (fairly quickly admittedly) at the HDA code
> > it's not entirely obvious how it all fits together and the changelog for
> > that just talks about moving code around.

> The bus is already defined in sound/hda.  There, the actual binding is

I see there's a bus_type defined there but this is calling raw
device_register() and providing a match function so it seems like
there's something missing or an abstraction problem.  I'd expect a bus
to be providing things like match functions and bus specific
registration functions.

This is all setting off alarm bells, both the code and the very
aggressive pushing.

> done in each hda driver specifics, i.e. in sound/soc/hda and
> sound/pci/hda.  It's the way to allow binding completely different
> drivers for the very same PCI ID.

I don't really understand this, sorry.  What impact would HDA bus
implementation have on PCI device drivers (by the time you're
registering HDA devices presumably the PCI device will already be
enumerated)? =20

Having two drivers for the same PCI function doesn't sound like an
*obviously* good idea (as we discussed recently) but that's a bit of a
separate thing.

--Wiqv+dddIdXsNRUi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVX2oyAAoJECTWi3JdVIfQeHMH+wchtDvJPtxXJr2h/WcmT3mm
OWYPJKOdzJ20ScRMcUq99T7c8ekbPfR4sFbqchUto0S1LPwI4TJLOjWihhsW/aK4
+POaaqYuVrr0OtQ1+MPMr3s4cZ3wlclAG7bamvhw6976VqoUVxd9RtZDTx6US7DP
hVsfMpOL63Df7rfp6rwM7k1/MbScFU+at10sWgHrWSndRL2y22i/RlwZ3QK1zKNj
iw1x3FuMP3sfEJBqlFMTLnelHETzv7ywU7tngXJxOZgrJDdtVNo9ZcePYAFST8gf
fP73btsaW0LB9MRh/+avDv2601YXNhVrh0Tu4PCss6Au8wfIR6ypBzO1qHcyfiY=
=CQXD
-----END PGP SIGNATURE-----

--Wiqv+dddIdXsNRUi--

--===============1004938069717444942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1004938069717444942==--
