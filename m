From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: core: Add API to use DMI name
 in sound card long name
Date: Wed, 11 Jan 2017 15:01:19 +0000
Message-ID: <20170111150119.y43ik2xjf45xgyqr@sirena.org.uk>
References: <cover.1484030246.git.mengdong.lin@linux.intel.com>
 <2c6136c012b7f94dd2fb35fd5def8195abdc0113.1484030246.git.mengdong.lin@linux.intel.com>
 <s5h8tqjmlvc.wl-tiwai@suse.de> <5875D16B.8040002@linux.intel.com>
 <s5hh956koqu.wl-tiwai@suse.de> <58760877.8080104@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9153312047923649220=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D8962668B3
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 16:01:29 +0100 (CET)
In-Reply-To: <58760877.8080104@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9153312047923649220==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tdi62ezwzinewuyj"
Content-Disposition: inline


--tdi62ezwzinewuyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2017 at 06:27:03PM +0800, Mengdong Lin wrote:
> On 01/11/2017 04:03 PM, Takashi Iwai wrote:
> > Mengdong Lin wrote:
> > > On 01/10/2017 03:09 PM, Takashi Iwai wrote:
> > > > mengdong.lin@linux.intel.com wrote:

> > > > > + * Possible card long names may be:
> > > > > + * DellInc..XPS139343.01.0310JH
> > > > > + * ASUSTeKCOMPUTERINC..T100TA.1.0.T100TA
> > > > > + * Circuitco.MinnowboardMaxD0PLATFORM.D0.MinnowBoardMAX

> It looks nice. Thanks for the tips! I'll use "-" as the separator, and
> convert the the existing "-" in DMI strings to "_".

"nice" seems like a very strong term here :)  Not sure there's any
options that will look much better but still.

--tdi62ezwzinewuyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh2SL8ACgkQJNaLcl1U
h9CIiQf+KJl5bIlFmmAnhtFbUFtOt6CWNyfKXMWxyYqKlrxJtg7xCNze6qTA2TSp
roeA28cME0S/w7mJTxkvvxyZchyeiFBY5cfr38ECrPDpBEzZhrAbzdsbar57qfks
iXemwzdutFlo/nfdAdDe4Q67PsEnxN9D4oSmpLEULtqv02ETUk/gEj8ypNY2BpnY
OsEDtSsQKw9TCpnO6EEkL2n0IDsN+eKFN/KB7GsfkLlJAk8O19xfnuBne1vFdNpv
eThP2lPKmBmAe8iBpaN9RndOwF3lR2P0KghuPES0Xr8Dvrn8LVR1iFU/W0s/hCY4
L0dWVnl0LtzRT0wxwlKtEUhYpzPiWQ==
=bLZ2
-----END PGP SIGNATURE-----

--tdi62ezwzinewuyj--

--===============9153312047923649220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9153312047923649220==--
