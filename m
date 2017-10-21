From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/14] soundwire: cdns: Add cadence module
Date: Sat, 21 Oct 2017 10:52:01 +0100
Message-ID: <20171021095201.cxxmgvliyzzr4ydo@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-12-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4831913414541447378=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DBDF9266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 11:52:05 +0200 (CEST)
In-Reply-To: <1508382211-3154-12-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4831913414541447378==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cjnlkpq3uqy2g5rc"
Content-Disposition: inline


--cjnlkpq3uqy2g5rc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2017 at 08:33:27AM +0530, Vinod Koul wrote:

> Cadence IP implements SoundWire Master. Add base cadence module
> initialization and interrupt handling

It's probably worth saying something about how this isn't a device
driver but rather a library for device drivers.

> +	if (int_status & CDNS_MCP_INT_CTRL_CLASH) {
> +
> +		/* Slave is driving bit slot during control word */
> +		dev_err_ratelimited(cdns->dev, "Bus clash for control word\n");
> +		int_status |= CDNS_MCP_INT_CTRL_CLASH;
> +	}

So with this (and the other error flags) we check to see if the bit is
set, print an error and then set the bit we were looking for in the same
variable we just checked?

--cjnlkpq3uqy2g5rc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrGMEACgkQJNaLcl1U
h9CSiAf+LwDU8eAB15bRd0pNGqrk5usHPTncJGiPlOXenX/C2YMuFqvMEztrGPQX
le878O1B8/gSIMg8WpU4N0aSxYepX97kKcU0EGDprhZ1RbmjmnlzsErRWReeqmEn
K0NfTY5jAbKKkbFfxnfjzu6oeIQMlmVxTAKgRISqJ9EHE3L8VCGNQDn6Km+Q5mCa
EiqJic6kt9t4EbJ8mSPxhF8acSDKTqYwTkwjB2RN6fQgC8LJ007KxOhyOEmhmVGn
iXJaw9tOKIWC99jRNAw+nFrGOvfPwEEIuEQxnCplXXaR9k9whedi6pQRQ9xgk/yM
EagodMFGTp3wDDB76l6+bZUUGd0duQ==
=EGw/
-----END PGP SIGNATURE-----

--cjnlkpq3uqy2g5rc--

--===============4831913414541447378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4831913414541447378==--
