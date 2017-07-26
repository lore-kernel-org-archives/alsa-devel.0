From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: board: Fix missing sentinel
	for bxt_board_id
Date: Wed, 26 Jul 2017 13:02:41 +0100
Message-ID: <20170726120241.gqdnsqt5aaw4z6t2@sirena.org.uk>
References: <1500964186-25956-1-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6639269405912925097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8211E26740A
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 14:02:48 +0200 (CEST)
In-Reply-To: <1500964186-25956-1-git-send-email-pradeep.d.tewani@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pradeep Tewani <pradeep.d.tewani@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, fengguang.wu@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6639269405912925097==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2jbtpal55uv7f3c7"
Content-Disposition: inline


--2jbtpal55uv7f3c7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 11:59:46AM +0530, Pradeep Tewani wrote:
> Without a sentinel in the array of platform devices, we can get a panic
> so add a sentinel. Full stack dump below:
>=20
> [  231.564705] BUG: KASAN: global-out-of-bounds in platform_match+0xb0/0x=
146
> [  231.565500] Read of size 1 at addr ffffffff8380a1a0 by task swapper/0/1
> [  231.566280]
> [  231.566594] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-00289-g15=
2771f #1
> [  231.567526] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.9.3-20161025_171302-gandalf 04/01/2014

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--2jbtpal55uv7f3c7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4hOAACgkQJNaLcl1U
h9BjZAf/cbEcz3ZE8uVofivbxGZRPB8y60Pk9sxo2V420U4FIY0t4vKfUKkneRyJ
uQu3sMUV18hmoUtGFgzoXSw4730iyf28y8NDKyw5pGXKTDyHd1UPT9PvjAFwH9Dm
hlBokDPqg/AsEUtnQsRZsEnb5dVrbSmpPnbHt1mbPRJmx7veBBnrM67bcsEO7lhv
WlL7DXBww1dJnnLrqYXIR1QKIPKDxeySdQA6YcTZB9Dhd2a/sQpR2dW1qhcn9TSM
e9F8n0JmcLoScl1BzfchoQDnfXkOGmZIhB8eZwspjmF7ufn5tHUb2vQCz6hjuym6
UPyXQET9MTjfYnQiLwIYJ709haq7zA==
=aOhV
-----END PGP SIGNATURE-----

--2jbtpal55uv7f3c7--

--===============6639269405912925097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6639269405912925097==--
