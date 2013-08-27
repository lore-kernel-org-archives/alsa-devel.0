From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: dapm: Fix marking widgets dirty
 when a route is added
Date: Tue, 27 Aug 2013 15:33:02 +0100
Message-ID: <20130827143302.GN10783@sirena.org.uk>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5855493453289365742=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B373C2651D8
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:33:08 +0200 (CEST)
In-Reply-To: <1377611461-3638-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5855493453289365742==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EqVOK5mkaJAMmtSx"
Content-Disposition: inline


--EqVOK5mkaJAMmtSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 03:50:54PM +0200, Lars-Peter Clausen wrote:
> The current calls to dapm_mark_dirty() in snd_soc_dapm_add_path() are on a path
> that is only reached if the sink widget is either a mixer or a mux. Move the
> calls further up so they are called for all widget types.

Applied, thanks.

--EqVOK5mkaJAMmtSx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHLiaAAoJELSic+t+oim9WxQQAI/rle9B6p/g+3azYgtcTWvB
zK8vARoKt24wRzukU7KzWtBpj57vEyKlWS3/t2Egc2j1S//NjdPIxySdBfC5rit/
n1Vr/9Ob4mgo/RMJCs2i5/JZ0tgthgfyH+dLANyh085xJj3Lw1Fx8TLj7VyDHdvU
jICjVdlpIY6ZozInq8wwab+hFn9B8SRKlRCgh2hNWnkSbLfesvXo+PagC3txcbZs
Y7T+Epwzh6Zww5ZDFYfqTEyNeKGjmNFa67HhaRHcm8FSUfsgxCmcZp8cz+Dgw4aC
5fBZ8DlwRwWVUh+kP3Y/wtcfwF2YAkLlLxZbdZxS74XXo75WdcBh4pVlm9FPH5Fc
zUjjrKTWtFdhbAztItDTQ3ITZHsdlBntiWOhSo6XxwH6/W4DuwckjZzBFKxO2wCm
uAbU0I0IEBQ7o1Z1zny9txmjv6gbtfty8psvV6y+XK/owT/iIsblNyK3DR2TIMaS
IOUfSATRoqJqjp1/4FiWU2OSHnoZXh0k9iCQlmEuBHXf7eph2hKxc6UI7B7xWbU9
2DIb9twJ/lX++u5V3Ihl5ceDJ0Z7A4g6JzGN9cDbJyk+Bjq80gj6tOFm0uwW1aXQ
8PJeFKeyxmo+wkNOmg2nMQT2gAK6NTiee4txIq3bMKRYVZ60GVwRpe5/GDy9/Ixh
jOf14P7zNZyeg05GiHzM
=4UPT
-----END PGP SIGNATURE-----

--EqVOK5mkaJAMmtSx--

--===============5855493453289365742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5855493453289365742==--
