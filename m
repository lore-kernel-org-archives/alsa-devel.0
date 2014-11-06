From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6 v3] ASoC: rsnd: move DVC_DVUER settings
 under rsnd_dvc_volume_update()
Date: Thu, 6 Nov 2014 17:05:08 +0000
Message-ID: <20141106170508.GS8509@sirena.org.uk>
References: <87egtp2g05.wl%kuninori.morimoto.gx@gmail.com>
 <87egti46j7.wl%kuninori.morimoto.gx@gmail.com>
 <87bnom46ha.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2292268182274843975=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AEA372652AC
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 18:05:23 +0100 (CET)
In-Reply-To: <87bnom46ha.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2292268182274843975==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PyTGrrL9CIKSRohn"
Content-Disposition: inline


--PyTGrrL9CIKSRohn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2014 at 08:27:18PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> We need to Enable/Disable DVC_DVUER register if we set
> DVCp_ZCMCR, DVCp_VRCTR, DVCp_VRPDR, DVCp_VRDBR,
> DVCp_VOL0R, DVCp_VOL1R, DVCp_VOL2R, DVCp_VOL3R,
> DVCp_VOL4R, DVCp_VOL5R, DVCp_VOL6R, DVCp_VOL7R
> and, these are controlled under rsnd_dvc_volume_update().
> This patch moves DVC_DVUER settings to it.

Applied, thanks.

--PyTGrrL9CIKSRohn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW6pDAAoJECTWi3JdVIfQncUIAIG4e/2HEN2jBDM76tx2wqm9
m9O1GEvgS22ewOREgOleM86Jn1CqFM66Gs5VuRwxPwdwI/Rynh9eRES/RvDswD6M
RGiXDeQLVO1yuKFfMLZupZNkBm+FfmALGSL3/i20NLNGCTIHw0rw1mHEHVFHMSj5
QrVhNaQZxa4GFqbIdvm+d8txswTHLKDGnyV5G8WkEuAznNsWN91XuNa9hXCsqD4Q
PI+ZLRgACIt6gpqGJHyvDaQN1Ns60i/32E/YgqZ57Em1eswH7BCgwG6WdCBvv8IY
9iFKWn24vYNz9TpZ3DFx4/YBpaGx+kgVOVfT7jxt/SUWFogNYctStNTvYve4gcc=
=PzSP
-----END PGP SIGNATURE-----

--PyTGrrL9CIKSRohn--

--===============2292268182274843975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2292268182274843975==--
