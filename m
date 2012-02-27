From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Support new HDA codec
Date: Mon, 27 Feb 2012 14:07:39 +0000
Message-ID: <20120227140739.GG3191@opensource.wolfsonmicro.com>
References: <AB277FB27524F74C87ACAFF84F2767490D5205C4E2@NTMBOX.central.cirsa.com>
	<s5hehtkxma6.wl%tiwai@suse.de>
	<20120225115048.GD3167@opensource.wolfsonmicro.com>
	<s5hpqd23i5s.wl%tiwai@suse.de>
	<20120227135131.GD3191@opensource.wolfsonmicro.com>
	<AB277FB27524F74C87ACAFF84F2767490D56E514A4@NTMBOX.central.cirsa.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7675303854410776625=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B39B24670
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 15:07:42 +0100 (CET)
In-Reply-To: <AB277FB27524F74C87ACAFF84F2767490D56E514A4@NTMBOX.central.cirsa.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7675303854410776625==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2012 at 03:01:11PM +0100, Jorge Fernandez Monteagudo wrote:
> > Mark Brown wrote

> > It should be very standards confirming and not require any magic Wolfson
> > specific verbs to use the functionality, a generic HDA driver should do
> > fine with an appropriate setup from the BIOS.

> With the generic HDA the only enabled path is DAC1 and PORT-A, the first
> it founds. In our carrier design we only use the stereo differential and
> SPIDF outputs. I've implemented a 'patch_wolfson.c' in order to enable th=
ese
> outputs and share the stream through both outputs, because I've no access
> to the BIOS code. The inputs are not used in our carrier, then I've not
> implemented anything.

Please share this code. =20

Whatever is being done to work around the BIOS probably ought to be
board specific, even if the BIOS is not configurable hopefully there's
enough information been added to distinguish the board.

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPS44jAAoJEBus8iNuMP3dywcP/11q0RJv92WQxRVl7qdRwD9n
R7sGN84LCiUc4eFP98BbDeRS+3qL8nUrBDHgYshjkc1jOuMw1szF1h4SXMOgwZFb
E9qEHhcYhSHbtZlZ0W/Qnr9Ec+JKTIguhYgByANTT8xkIpB3dH8D06hBP2MtEJ0d
6yJxucJuFdG94sCzVJP5WiZ+bBlgFtvx04hHE1KWo3Iwuf+O96tBHMTE/KJkkyxu
HRU89A4b0ot+zdr2SGwwHp929dYi0xEvPvORao9FMamsxlSyqgR/ekVrdYrUO0+O
xEHCI4ggPN+du7Ff8+l15r5T8tGndoqvLhIwjavl59KA3Hn+0Nbt1z3b9LgM0152
Gqr7+z2ua5HF19iGCa9qoebYag+hwCNdWYvqgGZASQIEp5OEImxSG4W1TO1ZV36e
4IPqHYFDmBLCY4ZCuerYJeGKbAwuwXTUVgyubPHVISF2VZ+K04H8L1So/rlfipy7
6mjXjYK1rtpwb6rLlOo0OZBr3/nsp7n840asUBD/4TG4B4sOGx4cHyKvchveSZbq
cyrMaJrO9pgIuCgD4Lh7NvShJdNiI22TZrCDlylyrWXCQ0cA+W7Mg8dZYvPNy8Qr
DbPvz/D4CHyz2UqOVN8F2zYvBrx9Py6dLZu0WUeW76ZYJnPgSRrjdAhOpo4UI2yw
gb9szX8VWRYtxAi/JsaH
=dqMX
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

--===============7675303854410776625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7675303854410776625==--
