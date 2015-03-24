From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: check regmap_read result for
	ID check
Date: Tue, 24 Mar 2015 08:56:21 -0700
Message-ID: <20150324155621.GB17265@sirena.org.uk>
References: <1427161872-12356-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5441624634117251039=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34F1C26047A
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 16:56:15 +0100 (CET)
In-Reply-To: <1427161872-12356-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: alsa-devel@alsa-project.org, matt.fleming@intel.com, jocelyn.li@intel.com, lgirdwood@gmail.com, liam.r.girdwood@linux.intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5441624634117251039==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2015 at 09:51:12AM +0800, Bard Liao wrote:
> It is worth to check the regmap_read result for ID check since it
> is the first regmap_read. And we can check if there is any i2c
> issue.

Applied, thanks.

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEYkkAAoJECTWi3JdVIfQJTIH/1dKvdlIpesvr/dFfcMPpc8q
6226g9k4az3FTqy7BuUFcGb7SWQyHn7a9TlgWgjqG5H6gSF2PlzKOxxGsqqhA0LI
zA2liBlksuWvMbOACtK/BZz/FVqqkwFWBpZ/rAGMFv60UYHLI5D2xMgzbcpfaYGT
R+IZ9jvC3YIr7T//m5GUfPTFgxaFQ4KU/N0fNDZ7gfWvuykMcgp8A1n5Sc0F7vqf
db6/OsHxnpIjOzc5ACt5MgZB60cNJJJz5Kw19T6YlQXnxZzlzZ3MYU3yXwTDwoc7
Ylrp2S+O3VU6mzwL7jARvrJzcqNp1pFNeScBDrHYw96V5SDu4SY4KbMhnbLSnmA=
=USe8
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--

--===============5441624634117251039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5441624634117251039==--
