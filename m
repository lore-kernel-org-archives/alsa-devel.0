From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
	match function
Date: Fri, 29 May 2015 18:35:03 +0100
Message-ID: <20150529173503.GQ21577@sirena.org.uk>
References: <s5h617f29os.wl-tiwai@suse.de>
 <20150526133256.GQ21577@sirena.org.uk>
 <s5hr3q3cv77.wl-tiwai@suse.de>
 <20150526194316.GY21577@sirena.org.uk>
 <s5hfv6ieero.wl-tiwai@suse.de>
 <20150527183406.GM21577@sirena.org.uk>
 <s5hpp5lde48.wl-tiwai@suse.de>
 <20150528195359.GG21577@sirena.org.uk>
 <s5hk2vsasjz.wl-tiwai@suse.de> <20150529081544.GC3140@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1272642757280408868=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A998260714
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 19:35:12 +0200 (CEST)
In-Reply-To: <20150529081544.GC3140@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1272642757280408868==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="grGpQMk/ccQQb7wU"
Content-Disposition: inline


--grGpQMk/ccQQb7wU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 01:45:44PM +0530, Vinod Koul wrote:

> well userspace parsing is only for the pin mapping and changes which
> users want to do on their systems. For basic things the default graph
> will be read by existing HDA parser and codec driver will create
> widgets based on that. The generic HDA codec library should do most and
> the HDA ASoC codecs should do device specfic work (like existing
> patch_xxx)

So we *are* planning to continue to use the existing CODEC support but
with some different interfacing on top of it?

> > And it's the reason I suggested for pending merge until the codec side
> > is ready.  We need the topology stuff merged at first, then HDA-codec
> > driver together with user-space side.

> I dont mind if code doesnt get merged into next merge window and put
> in one after that. But in needs to get accepted is some topic branch
> so that subsequent series can be  psted and reviewed, merged. Btw
> users will not see unless we have machine driver. I will add the
> disable feature after this series, so no user conflicts occur

I need to have another look through.  TBH I suspect it would be easier
with something that was more of a minimum viable prototype than with a
part of the system - with something like this it's as much the overall
shape of the solution that's being reviewed as anything else.

> Now that we have debated this and I guess all have the big picture
> here, how do we go about this. Do you guys need changes in this series
> or this is good for now?

Like I say I really need to review it again, and I'm still not entirely
convinced I understand what's going on well enough.

--grGpQMk/ccQQb7wU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVaKNGAAoJECTWi3JdVIfQWZ4H/1JA+q94tYnZVZdSkGin5NxR
s5t3ahOhpl1Wv52jEC15Mjm2WRJh++y8u6LO+jwhlPPQt0aCDVRTDJmPIe7eWddf
bZRbnAhGULCAUWKe+F16epWaobd53ZjgIHb4hXJRm6PbbgEfczplLNHbSeS0hXdc
l+Um50hqIu24UiHeCh0U5N4tLDzogNc3gz3GWwIybdbsAr+lP+gqSBeLuYt8GLG5
Wm49kRq55GaKoFggEBdB4+FgbVJ0Vj0dUq0FNVok+oqU9b0sPSEVHEk2cC8olAzO
FBtJ25PwAkNdf6V+Y11hgKaM13uq8o1aNYWuac3/luOIMu+6C8y7qV4XNTNQEaY=
=DEGx
-----END PGP SIGNATURE-----

--grGpQMk/ccQQb7wU--

--===============1272642757280408868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1272642757280408868==--
