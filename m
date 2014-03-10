From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: Consolidate
 snd_soc_register_dai() and snd_soc_register_dais()
Date: Mon, 10 Mar 2014 12:19:15 +0000
Message-ID: <20140310121915.GH28112@sirena.org.uk>
References: <1394383307-7224-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8320791246755303452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9775D265113
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 13:19:23 +0100 (CET)
In-Reply-To: <1394383307-7224-1-git-send-email-lars@metafoo.de>
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


--===============8320791246755303452==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aq8B+PobjgurrfqM"
Content-Disposition: inline


--aq8B+PobjgurrfqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 09, 2014 at 05:41:45PM +0100, Lars-Peter Clausen wrote:
> snd_soc_register_dais() has basically the same code as snd_soc_register_dai(),
> but running in a loop. The only difference is that snd_soc_register_dai() calls

Applied all, thanks.

--aq8B+PobjgurrfqM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHa3AAAoJELSic+t+oim92I8P/iKSgQFAChxb4KZbQTI7PPr/
D1vIT16Mk1QFU3AVa7gKuDmm77AbfWk7gWfxTo7+TBkOeEeBPdI59hyQkd3XhzJ4
U9FPsHYyrXRRoU6UaXre0PDos6cQs8HrMgF1yXhcalNr3FY3urwCy9Aso54DMtZ5
QhNDBy9xH2TDVruh0lm21WubwLBurcOucpJnixeY+kecHNYAHBPOflSidPFNRMOx
rxMKMR0qIk864EOj3fq3KKis7IIaoTlnWtTDVRhPDUtzyJi77V+EmEgOQQsdt19J
zQRvJimrfwIMkU9y9UAKR54sLiLeYCf+JtigHHa3V7HgP5Py7lTpTa/M0lKf8gSP
YFw83WuNuvISHCakieKj9C1FakfhMTd5iINMw+VOMdexvJC4i0n2PTL3/tE5B7PR
V4DVmEI9WPlE0uccmjKuNnXWfyk2D0iSCoooQrSvJo77gXCvYqlL6UnOh4YBLVum
rfEr9QRy3w7DomhgXF0itamM+zOXselELhIkzRvjiDfXh0VBBfEF2DH+7D6lwUqt
IW/JK5tfb5jL39sl1oTFZUq5sV1FbVGeM5TKuHPDfh3HPgn6SUbKBWUs9ykGUfxg
WWIP3kCr1f4OfwT4IUi9r4uFbpHHrtEDrNdOoCSKTVwXveuGYuL1Z5sRR36rjunn
ihar1K1TMJNpPCSooYoz
=STAc
-----END PGP SIGNATURE-----

--aq8B+PobjgurrfqM--

--===============8320791246755303452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8320791246755303452==--
