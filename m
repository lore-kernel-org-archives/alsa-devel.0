From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Fri, 13 Dec 2013 13:49:06 +0000
Message-ID: <20131213134906.GD11044@sirena.org.uk>
References: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
 <20131213130443.GY11044@sirena.org.uk> <52AB0BBD.2020001@ti.com>
 <52AB0EC8.5020802@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1701198735626798697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EBEA8261606
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 14:49:09 +0100 (CET)
In-Reply-To: <52AB0EC8.5020802@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1701198735626798697==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IQ2ZtBPOZQVGoXc0"
Content-Disposition: inline


--IQ2ZtBPOZQVGoXc0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2013 at 02:42:32PM +0100, Lars-Peter Clausen wrote:

> Normally you'd expect the I2S core to only put the 24 bits of data onto the
> bus for both S24_3LE and S24_LE (it might add necessary trailing padding if
> the bit clocks per frame is > 24). A CODEC driver should really not have to
> care about the in memory layout of the data since all it will see is a
> serialized bit stream. I think ideally we wouldn't check for params_format()
> but rather for snd_pcm_format_width(params_format()).

Yes, that would be a much better approach.  In fact, let me go attack
that...

--IQ2ZtBPOZQVGoXc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqxBOAAoJELSic+t+oim9hPMP/jVSOh1qVS31TSlHjhqSvHSn
B+fm1MUUO8jko2HKJWJivNfqOrKqktFsFr2eXFK+qAAB+dcYNMYVQL+a+Khw9UUm
hflFlkPb1uv9VmKLphlYbcnaz7xVO7CVcEepk6AVvXmWIYL+NV+Gr1Xu0dOMCn3p
FIAozTm+xXVlDTRwZb1g8QYH6JsdOX9d+/L2vqAjvxN3UTv2gpKsTL9Yqwry7dRo
4PT/OVhUbCAFlQJCyCaSav7GXAkG6lzE73RxKGHRRcysH8ymcqe9RflcWU4CXkbF
c0xLIsdEuXHJjVWqlqfO+0/8Ymdl3kfuenegxrJRf42UbGCwr5+1M7gxVuL6k6C9
mt/vuTJDS/VKthO6C88okDN/mNqYoEck/ZeoqknAW0WU/eluDGkSc8Slya94Yn4d
cbbUEj/7tQkUMF1zhaESApEY2wlR+phexdQDyHGyGtnoaQZ2HqIxWxpGZ5w/rGVf
Cppf7QNOOkJYCQ4fp2kEsbRvPkOqN52pDEqvns/kVWFje6AlZZW51h16L5qz+qN6
Ej+o7SDL3YkTxDEj1gI1B4fyaEZ3UnGRelsqmV8vHrksmIsW/NARSKToAa2S8GU6
flV4OXPysMAqrbF+vNETBbs1It1ZtFxFhU0FY+IyOEMN1nPaBUvPL6SZGbMToX1G
FghxoSwbWo7M3XrjPggg
=8y1k
-----END PGP SIGNATURE-----

--IQ2ZtBPOZQVGoXc0--

--===============1701198735626798697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1701198735626798697==--
