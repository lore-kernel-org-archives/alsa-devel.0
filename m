From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about struct snd_soc_dai() :: cpu_dai->codec
Date: Thu, 4 Aug 2016 11:28:26 +0100
Message-ID: <20160804102826.GU10376@sirena.org.uk>
References: <s5hpopy6dbi.wl-tiwai@suse.de>
 <20160728034643.GH9681@localhost>
 <579A6C1B.2060904@metafoo.de>
 <579AA39B.5030100@sakamocchi.jp>
 <884bd15f-da5e-49f5-73ee-d8173dc0720a@metafoo.de>
 <20160729160702.GK9681@localhost>
 <s5hy44k41oa.wl-tiwai@suse.de>
 <ab6b5a69-9d36-b4a5-0b8f-10a7dcf1ea40@sakamocchi.jp>
 <20160729220854.GN10376@sirena.org.uk>
 <5152607b-90ab-1675-6be8-986be880a8eb@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HPm2I89eDTDbofr6"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5152607b-90ab-1675-6be8-986be880a8eb@sakamocchi.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--HPm2I89eDTDbofr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2016 at 12:17:57PM +0900, Takashi Sakamoto wrote:
> On Jul 30 2016 07:08, Mark Brown wrote:

> > The card should be deinstantiated and reinstantiated whenever a
> > component driver unbinds and rebinds (respectively).  You'd need to
> > completely deregister the card to change the list of things it's
> > expecting currently.

> In a point of application interfaces, I guess that current implementation of
> ALSA soc part includes a bug that it's possible to unload codec or component
> modules when any ALSA character devices are opened. The framework has no
> codes to manage reference counting of character devices or loaded codecs,
> components.

Yes, exactly - we don't cope very well with that situation and we really
ought to but since it's hard to trigger without trying in practice it's
never been a priority.

--HPm2I89eDTDbofr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXoxjIAAoJECTWi3JdVIfQ5MAH/0BYqcNsqHtbLsI+nD6OIBlG
kpNy8SIVaNSyisPVHPNRuBy/DTnqwk+PHVvOlONOSopfM7MFCiOr8QHmeSFGvxXR
ueJA1HetQTjEBXBhqOz/07R18uaYUQgZnuboFIqzmiIqNjb/7wt6as0KAg4B5+2I
4lgB63BxUC3IeSUKu/ZGXzMmMbS9nC+1dGWh5QOLucxlPXm4MlN7YN9UHUUVj98y
EebZA1Rfl39ZzL9pDZ/+ZK8YHlPjexVa4hzD2/XbGJzQdXNmM8YdrzEryIgUwoAn
ZYGVE665S4aYJSkrEBn0f2JzDkg8XEwBjBKcwQgKt0ciuDwgQfiIT7k/EWfY6NU=
=Q6Da
-----END PGP SIGNATURE-----

--HPm2I89eDTDbofr6--
