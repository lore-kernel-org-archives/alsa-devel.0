From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: Use strlcpy() for copying in
 snd_soc_info_enum_double()
Date: Mon, 28 Oct 2013 09:25:28 -0700
Message-ID: <20131028162528.GE13643@sirena.org.uk>
References: <1382966510-13075-1-git-send-email-tiwai@suse.de>
 <1382966510-13075-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9137485231439213015=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5E42616A6
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 17:25:49 +0100 (CET)
In-Reply-To: <1382966510-13075-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9137485231439213015==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 02:21:46PM +0100, Takashi Iwai wrote:
> The provided texts aren't guaranteed to be in the fixed size.
> Spotted by coverity CID 139318.

Applied, thanks.

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbo/uAAoJELSic+t+oim9r40P/0NeFFP3GGl5Tg5WNarCYFVm
R17LshwzwjbA/34rRhZGleVwGXNkMVLK7kk3QzaOkN/89Oii1wjoRYieNsboSA6r
YesfhDpR9CZnHHV2rURZ2AVikMdIyKvz1m8rSOCU4IZtS3ctTlUsSJjuS9TasO1R
2cbB5McsM4MyPXVi1WjcBlvnNo7OJze/tvMqDVeeJACeYjnfg1OyJ7EgoUcVlN8L
4dUfGWuwon9JQIdnnBz5Ep+qmPUs9f8VgJn0EzQJLMKUiF80pXAEvLRwgEDl0Bv+
AGD4NI5LDB/8CC+jpdEwzCHj9Y40vpG8WdB1OuZzvK4kFPvs0lO3ZWsJXO7UEjq1
7MGl3srJ6I7q45CqXbds4vMK0ebLvbIE9+uSiIQdHpSE66O85zMzBdQQSylC2oDz
dqy9qC3S23CQmdz+OBdEQss/SUmh/pv76ffoLaLoOGr+XxnJzvYnZGpKOJluu6ad
Vlhaeoe9YeYTcVD3bxbNn6HZJPRkrvFMvotQRjUJg4VQtD57mUUwPT0Rz5SwPuK6
7o4ZPyEMLJSekgClr8y+Mp5Glh9Kmm1cKLxvlwNTHjy9yuUphzUS2rMjnzfQKuLa
FDvPI2cupY0Fc4FwtTqFkJmZqUbJOezkLbGBlFWgVhg5c9/qacaEyhfyFkZ/mFwI
f4jUl0cdyiwhpSGTNuOR
=qnyA
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--

--===============9137485231439213015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9137485231439213015==--
