From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4 v2] regulator: arizona-ldo1: Do not
 control clocking from regulator
Date: Mon, 23 Jun 2014 17:35:10 +0100
Message-ID: <20140623163510.GC23300@sirena.org.uk>
References: <1403275273-22713-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140621205349.GD24291@sirena.org.uk>
 <20140623155337.GD23517@opensource.wolfsonmicro.com>
 <20140623162922.GE23517@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7028013756279742126=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CEF42655D7
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 18:35:19 +0200 (CEST)
In-Reply-To: <20140623162922.GE23517@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7028013756279742126==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 23, 2014 at 05:29:22PM +0100, Charles Keepax wrote:
> On Mon, Jun 23, 2014 at 04:53:37PM +0100, Charles Keepax wrote:

> > Whilst there are two things controlling it for a couple of
> > patches they both set the same value one after another, so it
> > should be safe. If it goes into the first patch nothing is
> > controlling the DVFS for a few patches so that actually creates a
> > bisection issue. It could be squashed into the second last patch
> > but this way feels cleaner?

> Although looking at that again it can happily merge into the
> second patch in the series so I will do that.

OK, or if you do want to leave them separate I'd suggest noting why it's
safe in the commit log.

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqFc6AAoJELSic+t+oim91akQAIgELTJCvucWoYqjhSxBu05q
CIUkO6oap50tUB/clVUhZWKIigRR7ag05hNiq6ld4D6F44gkbBLWFJSR7FPNX2yZ
lB1JjCBlNbSDqfvAiT/rKvtYg7ousawBf5ekKK7gZ9hGaP85G6Tq7Vr50NZD07YB
BPAD9yeODPN3m7xF0WWdM9RjCn9kdgN3CfcgLtnMeNF79Q95/vTO6jXGQkNxdOaM
MxO2agnJFzrYAMtkK23bvx8WejBLZH+63tZg0jGBOaCgMUELu76yCV1CeT9d0SUx
91evzuK1U3p2oFDLMCQgWVeutRYbQtlD99d9KVDyf8eF6LXh2AZ9YkW74QImZwAx
TVUVDgmYLHu5eBjXuIu+CxujxASaqMoNZk/jW/hC6MIpWM5wPOhcaqmCyo6fpEku
FUAVWT6S46vtR/YSjpSmyBvBcOvoTJTDh7zu9xkaKh4qfsfX1X8UckZEla7je5Cn
hrsVEjJLfDP3TqSJaEsvFMvHrK3sQk8IOTnVCfjc3vI9zEtsldqH1sBBQNhXjImp
vhofxbM1C6W2+Gj15Rx+5/bHX16uNaJQ5vntSzVyOLwyDgDWuEY11fz8kE4Cw4At
9LG8Yuv9sYn0LvTl6FM9UsoMhjHMK09QBSqnOtfZNik+6ExZDANiFLIPACZP4ann
x92tJAWxIYWZurDEQd1t
=R7Ky
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--

--===============7028013756279742126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7028013756279742126==--
