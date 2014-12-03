From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 16/20] ASoC: rsnd: remove un-necessary
 parameter from rsnd_src_start/stop()
Date: Wed, 3 Dec 2014 18:52:07 +0000
Message-ID: <20141203185207.GK7712@sirena.org.uk>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>
 <87k32h83sm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9162928320216026849=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48211260533
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 19:52:15 +0100 (CET)
In-Reply-To: <87k32h83sm.wl%kuninori.morimoto.gx@renesas.com>
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


--===============9162928320216026849==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Bm7/c0bURfYEv9c"
Content-Disposition: inline


--9Bm7/c0bURfYEv9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2014 at 08:07:28AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> rsnd_src_start/stop() requests struct rsnd_dai as parameter.
> but, it is not used, and become more complex in L/R error handling.
> Let's remove it.

Applied everything up to here, thanks.  I've not yet looked at the rest
of the patches.

--9Bm7/c0bURfYEv9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf1vWAAoJECTWi3JdVIfQ5ZkH/0nZMuo/erkUFvRiIbLxqMcG
VBNkINkQutOLitOLQJeyKYgS1FgdigTovM98SZ9JBROI+EaCkuKhNKAoMOZlDYYU
biUlK4CzBCaW16XJg0lLywQJHCtjd27WijjhfiaIzJChcJYF2KitVO5eap6aO1jP
U22My1oPDsyq9KVy8Zt35muyZyANsXhp1+9tVom91BjTwVt2Brd+pZT67FyI1wx6
aDhEK8fYKntZIv9s5sHSsCHJW39LR7ppqND/Xc3cgfhl8gT0c/JG+XOH5rUTj8C8
m3PCkZtKRAItkV+5mymtsFlByiuTlQ7gdjeEge8lpvb2d+GiYnDu/c3Bao4/yNM=
=EmKZ
-----END PGP SIGNATURE-----

--9Bm7/c0bURfYEv9c--

--===============9162928320216026849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9162928320216026849==--
