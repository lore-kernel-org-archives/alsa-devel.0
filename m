From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: set dmaen->chan = NULL when
	error case
Date: Wed, 15 Apr 2015 17:05:40 +0100
Message-ID: <20150415160540.GR6023@sirena.org.uk>
References: <87oams7elr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4815370105853884201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E56E26068F
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 18:05:45 +0200 (CEST)
In-Reply-To: <87oams7elr.wl%kuninori.morimoto.gx@renesas.com>
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


--===============4815370105853884201==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GCWBOFkugzEtwVYF"
Content-Disposition: inline


--GCWBOFkugzEtwVYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 06:00:45AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> rsnd_dmaen_quit() is assuming dmaen->chan is NULL if it failed
> to get DMAEngine channel. but, current dmaen->chan might have
> error value when error case (this driver is checking it by IS_ERR_OR_NULL=
())

Applied, thanks.

--GCWBOFkugzEtwVYF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVLoxTAAoJECTWi3JdVIfQaywH/RDpJF38oa3/n1Q1N419ZKHG
F4axU4VJ6wZtJapaC64sYiaULd+iW0daxMs9Cpk1zzVhvXWuHXW77ueHW+IbJds4
YnCYhMdJf0nC0cDLQBIEUU6b04h+AkEz9t4PCcldQSKF+V92i3c7GxuS5z9nK01D
tofBJpmcDglKd24kVBOVbsm2bH3q8MnR6kYsmPZKFZzYaxW02SK7+e1PxJTtNsdX
1zky+EdM7WRbfonb1m4Ou5GwYP9Tjt/OFJ07N9vPYYk4npeQDGo5inlmaMCBJ5JZ
Gya6Siu+Mkyo4bOUK2lGUazPesV5XVUTe3trH9ylnStbVXgZF+BjLVuwdH3hjDI=
=cMQA
-----END PGP SIGNATURE-----

--GCWBOFkugzEtwVYF--

--===============4815370105853884201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4815370105853884201==--
