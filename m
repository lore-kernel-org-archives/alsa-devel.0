From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/14] soundwire: Add SoundWire bus type
Date: Thu, 16 Nov 2017 17:24:37 +0000
Message-ID: <20171116172437.k64r5c6ehujwvogd@sirena.org.uk>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-3-git-send-email-vinod.koul@intel.com>
 <cb4fbc87-7857-5ab3-a2cd-413ee57c463e@linaro.org>
 <20171116170221.GD3187@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6917654132416990514=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BED6C266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 18:25:00 +0100 (CET)
In-Reply-To: <20171116170221.GD3187@localhost>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============6917654132416990514==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="df5lijvbkbhlb2pz"
Content-Disposition: inline


--df5lijvbkbhlb2pz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2017 at 10:32:21PM +0530, Vinod Koul wrote:
> On Thu, Nov 16, 2017 at 04:05:17PM +0000, Srinivas Kandagatla wrote:

> > >+static const struct sdw_device_id *
> > >+sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
> > Indentation looks Odd here,

> not really, the return type in preceding line is a perfect way to define
> things...

Yeah, that's fairly normal - just ugly long.  You could also do it by
splitting the arguments over two lines.

> > >+	ret = dev_pm_domain_attach(dev, false);
> > >+	if (ret) {

> > I think we discussed this in v1, but erring out here means that all the
> > devices need to have pm domain  attached, which might not be true all the
> > time.

> oh yes, sorry i missed this one. will fix

Looking at this pattern here I'm wondering if this should be folded into
the domain code, everything attaching a domain is going to need to take
care of this at the minute.

--df5lijvbkbhlb2pz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloNydEACgkQJNaLcl1U
h9DlgQf/RM3wclY4vIX0lMJ41qavcaOQRMMe5WG2EdLoktgNQ+SugKjcAdYrGbW5
JoXIAN3acZVWYxNvFtRuvKU8AgwHtF+KeFU1IJR4ku3qTCSHNhb+JMGHgtsEZtIW
6m/nxb6Cnj+H46uxet33Ir5Przujd6C2Ki8Y2iJkiKZwpeA744FYslsx70HpKBX2
983L60+isaKBl/WacAM7QqerTLHHGSCXSuozHrNjN+Wb+TWj3+l5UBouKMKRvmnz
grjRGMzoCKogubr756vWGtukzXHzk5DPXFlREdCQEHrv3QJxmR3bQVptsL0UNjcn
GZarTowd13s3hh8lxboiDF7q+W6mjg==
=PgY5
-----END PGP SIGNATURE-----

--df5lijvbkbhlb2pz--

--===============6917654132416990514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6917654132416990514==--
