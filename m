From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5514: Set the pin GPIO6(IRQ)
 to output low as default
Date: Tue, 1 Aug 2017 14:10:31 +0100
Message-ID: <20170801131031.xp5ub4vqvc4as5cn@sirena.org.uk>
References: <1501480063-32225-1-git-send-email-oder_chiou@realtek.com>
 <1501480063-32225-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0789932662253903633=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0944B26691A
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 15:10:39 +0200 (CEST)
In-Reply-To: <1501480063-32225-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, shumingf@realtek.com, bardliao@realtek.com, chinyue@google.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0789932662253903633==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hzwyo23ru2npdqga"
Content-Disposition: inline


--hzwyo23ru2npdqga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2017 at 01:47:43PM +0800, Oder Chiou wrote:
> The patch set the pin GPIO6(IRQ) to output low as default to prevent the
> IRQ pin to trigger the IRQ function continuously in the float status.

Isn't this going to be a board specific thing?  If it's a GPIO
presumably it could have other configurations and it might cause
problems (perhaps even damage) if it has been used for some other
purpose.

--hzwyo23ru2npdqga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmAfcYACgkQJNaLcl1U
h9BBTwf9Eu/uGAn9bpad2g5i077xrMZ4qi4XBHpBEGRUpLWJmHp0SlunEm279226
oBh1Z9amtwLNp4mcRTHB/baJrceYQKPXDlW2GlZ1eG7iMcMDXrgPP+1Vfa/0sg5J
t8hkB1zU9CphYNO43R+AmWL8XBA6PB20cFRyTrjhwDuD3F3vNcd+27jyCKvGJZWz
WZNVhztVNWk0xYp87yeOYWCyZgGOWrIisDPMuBWOfafnQlrJYJxjjySy9OdaIgrG
scUQls7jZzGw4gi0eeHUmirTAg8xI6iMSH6I3yOrLqtblE462UBnZORC4PAzffAF
uYcl5badqyTM4QtzdPlX5HiDHmNTug==
=+FNz
-----END PGP SIGNATURE-----

--hzwyo23ru2npdqga--

--===============0789932662253903633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0789932662253903633==--
