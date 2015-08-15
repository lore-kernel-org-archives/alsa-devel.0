From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: Intel: Skylake: Add topology
 core init and handlers
Date: Sat, 15 Aug 2015 10:00:58 -0700
Message-ID: <20150815170058.GK10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-6-git-send-email-subhransu.s.prusty@intel.com>
 <20150814220313.GW10748@sirena.org.uk>
 <20150815141658.GF13546@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1047532247525971618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D8F432654BD
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 19:01:09 +0200 (CEST)
In-Reply-To: <20150815141658.GF13546@localhost>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1047532247525971618==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPcTO7KkkZ/DEnPS"
Content-Disposition: inline


--PPcTO7KkkZ/DEnPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 07:46:58PM +0530, Vinod Koul wrote:
> On Fri, Aug 14, 2015 at 11:03:13PM +0100, Mark Brown wrote:

> > > +	/* Index is for each config load */
> > > +	ret = snd_soc_tplg_component_load(&platform->component, &skl_tplg_ops, fw, 0);

> > Which index?

> The last arg of snd_soc_tplg_component_load() is id which is set as
> tplg.req_index = id;

> So the comment tries to explain how last 0 index is added. We have only one
> load so we will be always 0 index

Your comment isn't explaining that at all, sorry - it's making things
less clear.  It's peering into the implementation to translate ID to
index and even with s/id/index/ it's begging the question "ID/index is
what for each component load?".  If you're adding a comment here I'd
expect to see something like "Use the same ID each time because..."
which explains something that isn't in the code.

--PPcTO7KkkZ/DEnPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz3BKAAoJECTWi3JdVIfQqgkH/i8Q978pwYVk7gBGJyO7gEja
FOiHT8GB0feCaZmRx8Am9eKmD+XMmA4w6v8YjcWk7c1fVJ1GIutpZTvNrRz+0U45
HruqthFLaw6eZj6OxzxOIfJsVaKolA7+VtxrfzWbc1RWlxpuDMkyhII/8YiZAxQJ
VhHhooaPb8DtOohR65mZTCclge4z4S7W+cOW7BM/ZucGo3lXVFLzCGAdGqgnSAUE
djSIj+ijed1yt5I5t542pJBDoN2MIA9AD/kSWng0MJ44GHAyXfliYD2cBCSIbk1A
r9nfl81pipv5cNCmFTW2uxnP73uoyNIhQih5rJ83tI/Rj5muLdiAarwZlauHS2A=
=fHPw
-----END PGP SIGNATURE-----

--PPcTO7KkkZ/DEnPS--

--===============1047532247525971618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1047532247525971618==--
