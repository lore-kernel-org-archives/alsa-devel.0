From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: kirkwood-i2s: fix a compilation
	warning
Date: Tue, 16 Jul 2013 11:14:41 +0100
Message-ID: <20130716101441.GG22506@sirena.org.uk>
References: <20130716084747.04625f29@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0409541901101602445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F6FC26165C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 12:14:45 +0200 (CEST)
In-Reply-To: <20130716084747.04625f29@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============0409541901101602445==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 08:47:47AM +0200, Jean-Francois Moine wrote:
> In the function kirkwood_set_rate, when the rate cannot be satisfied
> by the internal nor by an external clock, the clock source in undefined:

Applied, thanks.

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5R0NAAoJELSic+t+oim9MBsP/Rd04K3/it3V7BUV+wTNdmtV
/Heh6ZGsZ+zQ+zZNR6ag27yhQzTm4stEk5bbNwnrmR//L66bAClaYNWoLOh4AXPJ
dWvTDXongun27SHfE5hY8+P99/EMA99u2gNOmxil070HWUqhsVDyf562gx3G4Uar
FZg0pugQjzHNud1kQjpO77JSsrp25XoUHx6/mp2jGQg+VdLa90LuclR5N2YyVuVK
Rv8wd4ie/eWgooALj74DFpNKQqEqdBFMahNRcxbNP1BcQMrZovrwL4d1RKxZsaKA
BxYKiWxCcJkbrfoC6zXP184Nx+2fHYX/62OtrT3CbpVc0PVlGnhWumQHuV+XGgUz
hwOOnjl7KVh4+f4SVBHCoQM6hdkmHsjkXyBUF1MZtVYt67b9mv978fK/HCg1yH0h
tvIFJknFucQyLj07f53ImMoJzluKlMBDusz5+NqOTzVrFOrpWQ/0lMZA+F3luYqU
re8JgKf8mELZvokzS6EVVXCzk09ciz+XAEIbjv46r0/3NXpXqvZPhh1Lv4VZOrYM
ZBLXhbKV6it0XQWEJQ/zlX2Jz+ML6CwLzpG9+ww5QGIxaV/jDBdKjv3xqeuHVYVa
0fvb4/Qmlw8mgKVNwoCOv5LcXxGmyj/eMp/V8+YENL9pFX+s2mngUy/Db7ruNyLG
zBt6JTCac8AEPs524tdZ
=4iJ5
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--

--===============0409541901101602445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0409541901101602445==--
