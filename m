From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add Class G function options
Date: Wed, 14 Dec 2016 14:57:12 +0000
Message-ID: <20161214145712.uhsdfy6xr7ybja7f@sirena.org.uk>
References: <1481609526-21933-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4048688079605466047=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 592A0266F7E
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2016 15:57:20 +0100 (CET)
In-Reply-To: <1481609526-21933-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, Anatol Pomozov <anatol@google.com>, CTLIN0@nuvoton.com, Dylan Reid <dgreid@chromium.org>, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============4048688079605466047==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o4tkoaobtxjg2nzw"
Content-Disposition: inline


--o4tkoaobtxjg2nzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 12, 2016 at 10:12:06PM -0800, Ben Zhang wrote:
> Add a DAPM_MUX for userspace to control the Class G function:
> "Switching": Use +-1.8V or +-0.9V supply, based on signal amplitude.
> "1.8V": Always use +-1.8V.

This doesn't affect audio routing so why is it being done with a DAPM
mux?

--o4tkoaobtxjg2nzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRXcgACgkQJNaLcl1U
h9DeQQf/UrrTnzZhymLNCBSoZoBAgXiAI9x4V735PDbX4AazzD8TPleUOY34zoCo
qBqMis0qTR5lT/VACCyPb/tcyfgUirkPnDVt30zifptQqCzYfVO194+RsXHiTs9U
342tqrvcVuaPOf928E6A6KxbliriGGFJNS1vc77TrZI/5Zi/b9zGV0hSX/xCSHSv
Ih6U5RX31wndDHXS+XUL3osARn3BbY5+t5TP0LF+ZYXLxCTgiLgVxF/raFeoXFEg
WBlkVQaMzMCg0nFNH36CeAdhreouW2K7gNBK/zzXePhTsz0l0opE0oShUxJxtKIB
6LIR24SDfjupGQNzTxs/6K7SL+WRDw==
=ceI5
-----END PGP SIGNATURE-----

--o4tkoaobtxjg2nzw--

--===============4048688079605466047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4048688079605466047==--
