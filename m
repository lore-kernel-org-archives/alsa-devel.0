From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add headset detection
	function
Date: Mon, 8 Jul 2013 12:26:44 +0100
Message-ID: <20130708112644.GR27646@sirena.org.uk>
References: <1373265189-24917-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3970482551663107567=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7833C265345
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 13:27:12 +0200 (CEST)
In-Reply-To: <1373265189-24917-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3970482551663107567==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pui3hWVk1jPQ/Or6"
Content-Disposition: inline


--Pui3hWVk1jPQ/Or6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 02:33:09PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> Add headset detection function to rt5640 codec driver.

No, use the standard soc-jack framework for reporting accessories.

--Pui3hWVk1jPQ/Or6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2qHxAAoJELSic+t+oim9jlUP/RzyoCZat/3DYt93gXAC0jCs
OiDaqBtb4z92D8Q1NDxVZiBVoSulSuEMbv+eyGGE/oEaPVqba32hTrCFZMQ/Ehpz
LVsZ9on5iTMGAmssGS9fFctBWPJeGgxsbA6qFFELOP1X/Pea6GPxfPAs+BwYFKUk
48Nwvlk0mrQglcOjEwffgECbLWFaT9Ync69Nvql3WIcHgmwDo1pq1t1lK4+MgXtR
qioKQj21hOh+ZaxoBHNmxgs/+I3f4PMAhBMDU3R9S89p1mJ7hx3fzO4bzSMKVvfP
S4kgzfNoWyMsZt9r+Ayyu3LPiPthAsg9Ue+p+3vxEd1uOCewPen+4G25PBmM44jO
PTVwBn3m5rSFkdq26qb47wWe1yi2/usantCcHTbPQAqX20tem6bgnKozsXeogK8V
EgHuNklEycIT+00KfGCDPLIPGEk2pp0X/07SdY+PRSKQo279NTx+rIeMURFatB1E
ttpvVVJqOKZUoJvdrXu4nnBFHXhxl6YQFI07ANmF18qxAbCeoa6Q6LEzaKu9qN3w
Vygn0jxZK05+l5loVeb6Yijshuu8rUC4t0zrblmlMh2XprR0YxhYK6fCR/IdHNQN
W0uAqk9Qgy3qZhyw0lzDISU9/HdwP5Jv/eX3jZLNTXOvFkL5sdEjop/B1sNyDNci
o2psbn/F4BcVRGAFwSJ7
=d2C5
-----END PGP SIGNATURE-----

--Pui3hWVk1jPQ/Or6--

--===============3970482551663107567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3970482551663107567==--
