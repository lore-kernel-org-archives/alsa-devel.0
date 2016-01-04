From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Constify ACPI device ids
Date: Mon, 4 Jan 2016 01:32:10 +0000
Message-ID: <20160104013210.GI16023@sirena.org.uk>
References: <1451773436-25518-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2151205305555335379=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 923812604F4
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 02:32:17 +0100 (CET)
In-Reply-To: <1451773436-25518-1-git-send-email-minipli@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mathias Krause <minipli@googlemail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, John Lin <john.lin@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2151205305555335379==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dQAkT9kf8uI42z2+"
Content-Disposition: inline


--dQAkT9kf8uI42z2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 02, 2016 at 11:23:56PM +0100, Mathias Krause wrote:
> Constify the ACPI device ID array, no need to have it writable at
> runtime. Also drop the unused RT5645_INIT_REG_LEN define.

Please don't mix multiple unrelated changes in a single patch,
especially when there's no content overlap at all :(

--dQAkT9kf8uI42z2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWicuZAAoJECTWi3JdVIfQA70H/AzbqOJwXY5CocbfSsDmdZcM
bVgmgpCnr3Npn4ZnGURLXL8ApjPCcaXzrzdo3dqrssfjx+KZJhd7QX70xoB6k3YB
ullF+lC/2+h2JiKder6G0AvHiuD07bTJU6HiJo+2cfpMDYTpPmoHQtv4POGCuwvw
X2oLTJFZbcBjTCaK4011e0IPnkdSkoyDMJrKg500I01ytUsSaVY2BkuyOY+xb51L
bCh0Msci7sKtYTOHPjSa7eNcXctWnLHIfH0nDHWFrPR1J4KSkt3vsj4s4PYZpV76
hhhSQRx7BkvkJM4bgFzPLkTLdS2slXwmTaTA2yI3ugLw3By8FI/0mW2dH+laGZw=
=ELaK
-----END PGP SIGNATURE-----

--dQAkT9kf8uI42z2+--

--===============2151205305555335379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2151205305555335379==--
