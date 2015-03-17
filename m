From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt286: Drop unnecessary dapm
 bias_level initialization
Date: Tue, 17 Mar 2015 12:09:20 +0000
Message-ID: <20150317120920.GF28806@sirena.org.uk>
References: <1426520397-24263-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3201959501838121794=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F3C42606B4
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 13:09:31 +0100 (CET)
In-Reply-To: <1426520397-24263-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============3201959501838121794==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ra+QPBLzfvE2u76S"
Content-Disposition: inline


--Ra+QPBLzfvE2u76S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2015 at 04:39:56PM +0100, Lars-Peter Clausen wrote:
> The default value for the bias_level is SND_SOC_BIAS_OFF when probe is being
> called, there is no need to initialize it explicitly.

Applied, thanks.

--Ra+QPBLzfvE2u76S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCBlvAAoJECTWi3JdVIfQ1EsH/0w/05TJgoOdhIQUkiltEwA5
XEquG12fUmzIE3aVeykcV/3PRRwz1XI9rDFLOYLKmq4Qy9WgM3TBndclhFI2qQ29
l75eslWooDqWW/m8uVm7g30p6rAT/4gQkz66zFPvZISXNjW1EfXiwIc5xOOFuACJ
Ltn5m6hFaRF7hE9fd1anj4TUsTWygirMRqXsiUrbkI79yIPzAajTeJj4oQT8bi1e
SWj/q1L/eLKQ5FzLwKEK9aNQUsF+kTNveVd5uLrhEolObpxCcuw8ide0VVTc8O2E
FTbXVV4Wx9N29zYMqXoFTW+G68EsUC2w8V/ahz76+VvDps598gepoGH3ct2VL0w=
=oNXN
-----END PGP SIGNATURE-----

--Ra+QPBLzfvE2u76S--

--===============3201959501838121794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3201959501838121794==--
