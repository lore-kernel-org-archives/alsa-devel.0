From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/3] ASoC: enable interrupt after dma
 buffer initialization
Date: Thu, 13 Sep 2018 12:31:26 +0100
Message-ID: <20180913113126.GB8411@sirena.org.uk>
References: <20180912194343.200443-1-yuzhao@google.com>
 <20180912194441.200564-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8618730674659626534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 50E7C267782
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 13:31:31 +0200 (CEST)
In-Reply-To: <20180912194441.200564-1-yuzhao@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yu Zhao <yuzhao@google.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8618730674659626534==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 01:44:41PM -0600, Yu Zhao wrote:
> In snd_hdac_bus_init_chip(), we enable interrupt before
> snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
> been acquired and irq handler uses the dma buffer, kernel may crash
> when interrupt comes in.

> ---
>  sound/hda/hdac_controller.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This is an ALSA commit, not an ASoC one.

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluaSo0ACgkQJNaLcl1U
h9DiHAf/TwY1CWZUMP1guYdB+OBLHuODaXob0bzkSWIjav3iHqj4lIkMkZvp46Wd
pTmjdhVOTrhlgFIy1u4tslv6tAwZsc1G0zviFhmT4mNF4J43rb9a6fWnI4lofqrp
fIL/eT5W1F7CBxVAQF9OQTbfutFLC7sQRhqmsKbVVRkmccrZdM91S94AtdKScMTp
4dVXuuLRqasOsRwrX6Io4zRAGeklul3itl4bOYMz3NtJ20eHvwIW35tFElHxaDI2
XgqO875C34FkRx2+fco1vteJzhnwiWaWLH4yOD93focPaXiL9GSZqoGpexq0QRop
2Q8TW8yyYXno+my+k9K2HaMXJg467Q==
=+Pxa
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--

--===============8618730674659626534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8618730674659626534==--
