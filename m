From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Add support for TLV bytes
	control
Date: Sat, 15 Aug 2015 09:10:21 -0700
Message-ID: <20150815161021.GH10748@sirena.org.uk>
References: <2758b949231d10b23f1c8285fb3923db06fb1a46.1439345293.git.mengdong.lin@intel.com>
 <20150814191742.GJ10748@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D0537@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8474569025037921801=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BFF626510A
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 18:10:30 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8480D0537@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8474569025037921801==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QC2OnzLPmgM3Ncx9"
Content-Disposition: inline


--QC2OnzLPmgM3Ncx9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 03:04:53PM +0000, Lin, Mengdong wrote:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@kernel.org]

Please fix your mail client to word wrap within paragraphs, your
messages are quite hard to read.  It also seems to be rewriting quoted
material :/

> > Having two different classes of bespoke handlers like this both called bespoke
> > handlers seems like it's going to lead to problems - either bringing the
> > interfaces closer together or naming them in a way that clarifies their
> > meaning seems better.  Instead of just calling them "bespoke handlers" we
> > should probably just call them handlers for whatever kind of control they're
> > for and probably bind them first rather than second so we're doing more
> > specific to less specific handling.
> > That way drivers can also have specific handling for things the topology data
> > didn't anticipate they'd need it for which seems like it might come in handy.

> Are you suggesting that we bind bespoke handlers at first and then the
> standard handlers?  Since the bespoke handlers means more
> vendor-specific handling that need to be taken care at first.

Yes, that's what I'm suggesting.  Why would this mean any additional
work?  Either things have custom handlers or they don't...

--QC2OnzLPmgM3Ncx9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz2RsAAoJECTWi3JdVIfQTDAH/1t31p0sB2wh/urDjTAJz0m5
HvwL3IRH18X/AtPm0/EqIaLPtJ/soaQUzkGoygnqNF/ksqOVM8Mqv+HZrM3g6EWS
+DgabRb+32LX2DbDp3NDHHnqKvci1KaJuN6EwHEUKsx3My1LifP5MTLtMvkvtC6A
XTyxawpzYWrwd8032AhErgNSmRXUAyHc194+JwdSuqZRabi3MRTTzGhkdzOcIoru
fUqr+1MQe0GSMGWXp2OFbzbfXzno8D4O7FUpia4ww0ZL/2ruqmrhoNbfWNqpoP5e
OeAnm37axxe7QyTt76s80tBaWplzPUELzt+sfuztgglOk4vWJKgQJCDBFUOvhzA=
=G+P7
-----END PGP SIGNATURE-----

--QC2OnzLPmgM3Ncx9--

--===============8474569025037921801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8474569025037921801==--
