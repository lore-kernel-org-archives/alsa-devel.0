From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/6] ASoC: Intel: Skylake: free codec
	objects on removal
Date: Tue, 15 Mar 2016 16:22:30 +0530
Message-ID: <20160315105230.GH13211@localhost>
References: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
 <1458035836-1843-3-git-send-email-vinod.koul@intel.com>
 <20160315100743.GM2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2852289156053974893=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DB63265474
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 11:48:14 +0100 (CET)
In-Reply-To: <20160315100743.GM2566@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2852289156053974893==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2016 at 10:07:43AM +0000, Mark Brown wrote:
> On Tue, Mar 15, 2016 at 03:27:12PM +0530, Vinod Koul wrote:
>=20
> > +/*
> > + * codec destructor
> > + */
> > +static void skl_codecs_remove(struct hdac_ext_bus *ebus)
> > +{
> > +	snd_hdac_ext_bus_device_remove(ebus);
> > +}
>=20
> > +	skl_codecs_remove(ebus);
>=20
> Why the wrapper here?

IIRC Shameless copy of old HDA code, but yes I don't think we need this,
I will update this one.

Thanks for pointing out.

--=20
~Vinod

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5+luAAoJEHwUBw8lI4NHp18P/2z1EbQ1W7KBQ4ZqWnDkkAB4
J9wekvl6JZfkOIfol0Oyip56KmzaMRjOWKzjtLfmzh/IZsFNauICE0MH8luqZtte
Ln2ZcfQy/OqCVTWm8NWhY9FMmN/vHtvb7yNwKPtmSvbhNNB3XChzYelMgYG6su6O
NMlE6cWW6LWQtrSFwC93bbMk/gKux7Cn9f74i6RdHGwp30PgOjiY5EtJjuhVSn1K
wd/8wgYefIf9JUJ8XqScyuiKkkqNNaLODp1C4JJPzHLmcC5zGIX9MeXrBgs3YMu/
2xfA8lu9/Me0wZMItri1SDbbuy3ZKYl93xfv7cexDyjTNIDZcJfzLSqJCKrpU396
5GCH58RJi7NY8ejwrsVBRLjhpxtJ7YbLE73f0n/xp/E+Pa6x569heDimbf+aADiQ
O420h6jJ3YGgV1+WjoQx3ohfu9a0N7iyTdqKGAud2MAKFNq730m3B+Y890keBTrt
JYJa8KihNFB8THx33PNMNR830yAzSvlXUIwkW4VbBf+4PzxpsmpYvbKUZhOiyUts
OxnfdfFMYWLMnuy+EZfiLCXHE1kVykjs65KT/6BdAO0Ijv4YFwkfA+0cMuXfmg5V
+H9831w2+T+MZTLnjuh3qBosg2+5cYDuKQLJUi+fv4ADt7RDUGql6w4RIm3IcAAk
XB/4uT56UAnLDyZ+n/GF
=wVpA
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--

--===============2852289156053974893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2852289156053974893==--
