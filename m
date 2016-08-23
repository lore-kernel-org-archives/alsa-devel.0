From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rsrc-card: rename rsrc-card to
 simple-dpcm-card phase2
Date: Tue, 23 Aug 2016 11:41:40 +0100
Message-ID: <20160823104140.GY22076@sirena.org.uk>
References: <87vaz8t4bu.wl%kuninori.morimoto.gx@renesas.com>
 <87shuct48p.wl%kuninori.morimoto.gx@renesas.com>
 <20160817105603.GK9347@sirena.org.uk>
 <874m6dv60c.wl%kuninori.morimoto.gx@renesas.com>
 <87wpj9473x.wl%kuninori.morimoto.gx@renesas.com>
 <20160822165149.GR22076@sirena.org.uk>
 <87fupwibpe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6865162755176647086=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 522FC266A0A
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 12:41:49 +0200 (CEST)
In-Reply-To: <87fupwibpe.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6865162755176647086==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tln/wzp9jsNjmSUr"
Content-Disposition: inline


--Tln/wzp9jsNjmSUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2016 at 12:22:05AM +0000, Kuninori Morimoto wrote:

> Ahh sorry, my explanation was not good.
> Lager/Koelsch boards itself is very common board.
> But, the "user of board specific compatible" is only my test environment.
> It was created as 1st prototype. Now, normal user can use generic
> compatible (= without specific board name).
> I will create and send removing patch which has explanation.

I see.  The other thing you can do there is keep the compatibles but
just handle them the same as the generic one.

--Tln/wzp9jsNjmSUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvChjAAoJECTWi3JdVIfQsyEH/23w8AWFVcq8xxrZLKEQZApO
JR/Vv7D0B0xSdWyokFRtVFlngW8Ev3GPeq9P2bVw6lW18JZpicbzZPwfT6/x0iw4
hvS9bMsGDFLhv6pytAbAiGDl3cVEHiQ+abYo70ScrGJfAN9WOWnfXVJd3jQQGy1K
LMgF7y24JKJNWSpNqXFwj2kyHkquUOITGneypxx+fHdmn1VkeNy4JaU0LdF9WK4e
vTkFJ/UMyvMOVinV7Gucvh0JKDR6Oa/Z3YSKMcIwv4SGjwLOcuXt8xGO72hC75UX
NKvwfG5GkOUNsyNaSQ8dKgEKyC1qvUPPa9t749ocJnM7kXBlN8kiLAEPEqttTPs=
=l63Y
-----END PGP SIGNATURE-----

--Tln/wzp9jsNjmSUr--

--===============6865162755176647086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6865162755176647086==--
