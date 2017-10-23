From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/intel 38/38]
 sound/soc/intel/common/sst-firmware.c:1278:20: error: expected declaration
 specifiers or '...' before string constant
Date: Mon, 23 Oct 2017 08:49:25 +0100
Message-ID: <20171023074925.ywrvo73ugfrqt2hd@sirena.org.uk>
References: <201710211936.sIx11hK3%fengguang.wu@intel.com>
 <60faca99-948d-6087-f909-538c1e5fccee@linux.intel.com>
 <161a5a7b-a139-15d6-0ae9-fd73e6de8199@linux.intel.com>
 <s5hvaj7rwfs.wl-tiwai@suse.de>
 <661027b9-4837-ef0b-5820-0926b56ff90f@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3440970394096494227=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E1C6266DCD
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 09:49:40 +0200 (CEST)
In-Reply-To: <661027b9-4837-ef0b-5820-0926b56ff90f@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============3440970394096494227==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i5ank3pkk2xniw2p"
Content-Disposition: inline


--i5ank3pkk2xniw2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 23, 2017 at 09:52:44AM +0530, Pierre-Louis Bossart wrote:

> If you take 4.13 and use the config/command line provided below it's also
> broken... we'll fix this but I am not clear on why this is showing now.

xtensa always randomly reports build breaks, I generally don't pay much
attention since nobody else seems to either but it's good to fix them.

--i5ank3pkk2xniw2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlntnvoACgkQJNaLcl1U
h9D5lQf9EAKhq8kypOACLExMOcjukSkUz9CaRSNbDJOqSohWe7UtnGxTK6iPDvvI
YVaJBrNWQ7wmtqg2aNzcLIgeP7s6i/y7yDQ78obahz4t9EtAes9dubWZOqoWz8uV
hli2kXJoXFr/ATAY7xOMXqjk/f6sx+wt6otKvJP8SpMxrGeLWLZzDKTpZyR5ZsE1
prH/pQFrnzzllxraQFtgJv7nXzPIj7noNOBJaSRed6p+h3g4oqTI1OeukEyXjPwV
Z4ebxayUAgAo88a0EtknIBkUxG6xc9sY/3ppo1VnYRDAcDk9Q6b3Xu16Sb0maox0
cDKdPiR8sjq0aVMUde6IwSHG6Hr8jw==
=mByD
-----END PGP SIGNATURE-----

--i5ank3pkk2xniw2p--

--===============3440970394096494227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3440970394096494227==--
