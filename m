From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/13] ASoC: topology: ABI - Define DPCM
 trigger ordering for PCM
Date: Mon, 5 Sep 2016 14:01:08 +0100
Message-ID: <20160905130108.GY3950@sirena.org.uk>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
 <24428c2714d09062f3ace5803679c743d36afb04.1471599648.git.mengdong.lin@linux.intel.com>
 <20160823174135.GA22076@sirena.org.uk>
 <57C91FD8.1090205@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2384238076748208531=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28E8126657F
 for <alsa-devel@alsa-project.org>; Mon,  5 Sep 2016 15:01:26 +0200 (CEST)
In-Reply-To: <57C91FD8.1090205@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2384238076748208531==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0B3PZ1+h5f4cFxHi"
Content-Disposition: inline


--0B3PZ1+h5f4cFxHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 02, 2016 at 02:44:40PM +0800, Mengdong Lin wrote:
> On 08/24/2016 01:41 AM, Mark Brown wrote:

> > This seems *incredibly* implementation specific.  Why wouldn't the
> > driver for the thing implementing the topology be able to figure out the
> > ordering here?  What's the use case?  What happens when we change away
> > from DPCM?

> There is another patch (04/13) to add generic flags and flag mask to PCM
> objects. So we'll allow users to set DPCM trigger ordering as flags as
> below, to avoid using trigger[] in ABI. The topology kernel driver will
> check the flag bits and set the proper trigger ordering to FE DAI links. If
> we change away from DPCM in the future, user can stop using these flags. And
> the 32-bit flags seems enough for future extension.

This doesn't seem much better to be honest, it's just shuffling the
problem around.  Why do these things need to be triggered in this
particular order and why is that invisible to the system?

--0B3PZ1+h5f4cFxHi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzWyTAAoJECTWi3JdVIfQzpMH+gLl2MuiiY9zhlalfLJNO8sQ
FEG9PwSLGAyRX3nF0tVn6iYQcpTppK1NYNfG0ETJ3+QFDz9TxA4EVADmukghlr3e
mKpCoLpWfAs5arWWzXRtKZw9/4rACf8Sght8fwLEjo4Hj2SY4lXfWdLIQKMwut7u
ALdawWBJLQeIJa98edQAitQdSp2lpQWDqqiWp5WM1IoUO58jL+eRtmu8RyBLWqbi
R07Xq4PDs8i+gQJzSJsWGXNiIqdAjQuGKD3sNi6D16+ZWEciwinU3+U/jBAPo2pP
SK7hIbzg1jMp39MXUOQkMmpNFPns9W+ZiiIRya/r7J2jS7BwFCaOWC76rc6yB7o=
=uRC5
-----END PGP SIGNATURE-----

--0B3PZ1+h5f4cFxHi--

--===============2384238076748208531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2384238076748208531==--
