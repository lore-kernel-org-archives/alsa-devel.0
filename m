From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Tue, 6 Oct 2015 11:34:03 +0100
Message-ID: <20151006103403.GH12635@sirena.org.uk>
References: <cover.1443605139.git.mengdong.lin@intel.com>
 <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
 <20151002165907.GU12635@sirena.org.uk>
 <1443809055.10986.10.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B84FF3F@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9171694912257261953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E85052650DA
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 12:35:04 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F84B84FF3F@shsmsx102.ccr.corp.intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Kp, Jeeja" <jeeja.kp@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Patel,
 Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9171694912257261953==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rlf4BENhpGjTu/yY"
Content-Disposition: inline


--rlf4BENhpGjTu/yY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2015 at 08:55:58AM +0000, Lin, Mengdong wrote:

> > > OK, so this means that every DAI link name is going to become an ABI
> > > too if there's a topology in there.  Not a problem but we'll need to
> > > watch out for that on review...  I wonder if I can make some automated
> > > checker thing.

> Do you mean we need to check if a DAI link name is already used, or if it's a valid string?

No, I mean that if someone changes a name it'll invalidate topology
files that reference that name.

> Is there any naming convention for a DAI link?

Not really.

--rlf4BENhpGjTu/yY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE6OVAAoJECTWi3JdVIfQOBMH/RQqbx3FD/OTdCHtBGxUrUc5
AB7/K/TpUzjvGH0dqLkqAtcdu1fmYwjPZyeG8Od6NI43ePcBNQMXl08u10J3Sevo
5xzAjM0gJJiwoT9Sq8k9HR4ETm+GYeTve41zPapBKSD18bs49HmP9XoEhsCW7Vo/
M30impPbuNoArZk1HZtOcvqZLqn6U6LLRBntxH0TQN1GfTNzX4RwTDq75t+vYRKh
UVgai8pbT5zxv0nhs0Tf5kW/z9BtofCDC+cVaHsC+rf6Ecc6xew19G4Z3o/YN6R2
NqvtETyEG9GzWLdjSGDldjtGfBgk6GVdQEB9Kcnm44vaVH0BSNX7GxVfiEcO2jo=
=xZdK
-----END PGP SIGNATURE-----

--rlf4BENhpGjTu/yY--

--===============9171694912257261953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9171694912257261953==--
