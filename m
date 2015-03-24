From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: initialize debugfs in
 snd_soc_instantiate_card()
Date: Tue, 24 Mar 2015 10:48:39 -0700
Message-ID: <20150324174838.GZ17265@sirena.org.uk>
References: <87a8z341ao.wl%kuninori.morimoto.gx@renesas.com>
 <s5h8uemlwb6.wl-tiwai@suse.de>
 <87sicu3j4o.wl%kuninori.morimoto.gx@renesas.com>
 <s5hpp7ykd22.wl-tiwai@suse.de>
 <87oani3h4x.wl%kuninori.morimoto.gx@renesas.com>
 <87mw323h3p.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9021230829717018267=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C09F2605CE
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 18:48:10 +0100 (CET)
In-Reply-To: <87mw323h3p.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9021230829717018267==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xmHgJexE5s//CZci"
Content-Disposition: inline


--xmHgJexE5s//CZci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2015 at 09:01:00AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current soc_init_card_debugfs() is called from snd_soc_register_card()
> but, soc_cleanup_card_debugfs() is called from soc_cleanup_card_resources=
(),
> not from paired function.

Oh, and as I'm fairly sure I've said before please don't send new
patches in reply to existing threads - it makes things harder to follow.

--xmHgJexE5s//CZci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEaN2AAoJECTWi3JdVIfQcTsH/RlemShqODgYQ2QJNbzfPHGs
rnoCmp6wwteiXVPy+fvDSbzPD86F0+xiX54t0gRTrwQxDorjljoOuOucjpDQ8Dak
3WUL1oEKjf+8idZ+92DY4F2uVpmwxQYCLRf9ZC4Twu+ljG352yDoc2oy4uAsvnys
P0cAqeFT0dY1smWdYML1jRlxEoIrVTkiPaTkAAbMNdAOb83FEhzAan9hTpvkubVM
fDayhl/ozD7Q72wFnoc78PhBU43jSbqyzmvGxJVAcgWLjRGmR+C9KqysLumnOuf0
iidHWieUvaSlufiC3MZZ721t3AXNppQYTtgoGkBIcUWY9xiCob2X5TxHmca1YHI=
=TMjV
-----END PGP SIGNATURE-----

--xmHgJexE5s//CZci--

--===============9021230829717018267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9021230829717018267==--
