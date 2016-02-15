From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add FE DAIs
 dynamically
Date: Mon, 15 Feb 2016 19:35:42 +0000
Message-ID: <20160215193542.GA18327@sirena.org.uk>
References: <cover.1452844210.git.mengdong.lin@linux.intel.com>
 <b7e208201542e5a27d052eb9e9f780056542db03.1452844210.git.mengdong.lin@linux.intel.com>
 <56A89457.4040307@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5039269261407528907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E5BE26070E
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:54:15 +0100 (CET)
In-Reply-To: <56A89457.4040307@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5039269261407528907==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 27, 2016 at 10:56:39AM +0100, Lars-Peter Clausen wrote:
> On 01/15/2016 09:13 AM, mengdong.lin@linux.intel.com wrote:
> [...]
> > +		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
> > +							caps->rate_max);

> How about just setting stream->rate_min and stream->rate_max?

I'll apply this but please send a followup patch fixing this.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwiiHAAoJECTWi3JdVIfQXC4H/0WuAypU5G43xqMnsE+9zCFA
1LioBAe/ZIvUSA+4X76km1LWo2ybgCm/DEp9DieXjqFETqA9KQ8GPw6a31aSrafw
La3/Devij8tMG5LLXjNXYZ7IcIiwIolEAuLf4/BxnwuFFy5mmmeCFGIDKQCYpq9/
CTA1h5AXt38LfoLxoYoTtTkTTdn8kf8uj5CE3zyCxc7elplNhaoVBMskJlLKkV0L
CJ30596hzuhJqTVRLP4fYqEvqxPSUU/dZjVMFALvqt83PxjmJNXxkymZ8NWCm2Q9
+mmXat5Yeb8rQhBTXakJqxApgJIaA/w8CRxnmxPUzQWPw+dX9k0C1lGJza0k3JU=
=CLz3
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--===============5039269261407528907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5039269261407528907==--
