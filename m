From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/4] ASoC: topology: Add topology UAPI header.
Date: Tue, 21 Apr 2015 16:03:42 +0100
Message-ID: <20150421150342.GJ22845@sirena.org.uk>
References: <1429217295.7100.19.camel@loki>
 <20150420213048.GT14892@sirena.org.uk>
 <1429609673.3793.14.camel@loki> <s5hlhhlztnr.wl-tiwai@suse.de>
 <1429620227.3793.31.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1071837593315878677=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F1D7261493
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 17:03:52 +0200 (CEST)
In-Reply-To: <1429620227.3793.31.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1071837593315878677==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOmey7/79ja+7F5w"
Content-Disposition: inline


--BOmey7/79ja+7F5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 01:43:47PM +0100, Liam Girdwood wrote:
> On Tue, 2015-04-21 at 12:02 +0200, Takashi Iwai wrote:
> > At Tue, 21 Apr 2015 10:47:53 +0100,

> > > > Not got a massively strong opinion here but given that we have ABI
> > > > versioning can we just skip the 128 bytes of reserved space in most of
> > > > the structs?  Doesn't seem to be doing much except making the files
> > > > bigger.

> > > We had a similar discussion in Nuremburg last week, the intention is to
> > > keep the size of the structures constant so wont dont break older
> > > kernels with newer userspace ABIs etc.

> > Maybe a question is whether the size is sensible.  But the argument
> > here was "memory is cheap nowadays".

> Ok, we can reduce the size here. I think Vinod wanted at least 4 * 4
> byte words (i.e. 16 bytes) minimum IIRC, what about 16 bytes ? That
> would give us at least 4 new members for the future ?

That's sounding like an awfully small number if we're trying to be
infititely future proof (obviously the default value for that is 640k!).
We'd also need to go through and give *all* the structures padding.  How
about just adding length fields instead with a rule that if the
structure is bigger than you know about just ignore anything at the end?

--BOmey7/79ja+7F5w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNmbNAAoJECTWi3JdVIfQpwgH/RdOP9/DMAvP0OmSh/m2JTOZ
xOWo7X7stiUqEdhCVNL4zmDjPkSlLZAtj1VjdpWrsU4nCh8Q3t04iOfEK/BNp3C4
PfTn4UuYS/syw+dIsUVPUxxyZ7oYQyAUrDYNYIoXfBbEYj6GZGusmi0b2J8u0ZJQ
Jtlx8HJ9Pdzkbz7GdfTFLtExh+/IX+N951tf7vUOEmdegb556SR/VDJEepHhkcI6
PPSfXlJCvj86oiTaaex9vfrr1beQi3a+07pNxnSlZSm3D2dNGh2CXein737T77o3
U6PQMHMd3esVsx8Xs1UH4weckfGTivBN+JjolL1zMgFLPnMZYhCmfqJUyPQfhcc=
=LzJ/
-----END PGP SIGNATURE-----

--BOmey7/79ja+7F5w--

--===============1071837593315878677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1071837593315878677==--
