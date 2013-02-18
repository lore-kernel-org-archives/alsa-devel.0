From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Jack: add configurable option for
 irq_flag
Date: Mon, 18 Feb 2013 13:29:23 +0000
Message-ID: <20130218132922.GD30157@opensource.wolfsonmicro.com>
References: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
 <20130212114752.GA1678@opensource.wolfsonmicro.com>
 <63969.10.223.96.90.1360733997.squirrel@linux.intel.com>
 <20130213131917.GF5062@opensource.wolfsonmicro.com>
 <20130215071000.GA23031@oma-dev>
 <20130215121727.GD22283@opensource.wolfsonmicro.com>
 <20130217063725.GB23031@oma-dev>
 <20130217173015.GD1583@opensource.wolfsonmicro.com>
 <20130218125516.GC23031@oma-dev>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5527456749847401266=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1C1C264FEB
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 14:29:24 +0100 (CET)
In-Reply-To: <20130218125516.GC23031@oma-dev>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Omair M. Abdullah" <omair.m.abdullah@intel.com>
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, vaibhav.agarwal@intel.com, lgirdwood@gmail.com, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5527456749847401266==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2013 at 06:25:17PM +0530, Omair M. Abdullah wrote:
> On Sun, Feb 17, 2013 at 06:11:45PM +0000, Mark Brown wrote:

> > What you're describing does not sound at all sane, the GPIO jack code is
> > there for managing GPIO jacks not for providing a generic debounce
> > mechanism for interrupts.  I'm not sure how you'd actually go about
> > doing this...

> If you have the codec interrupt line which is connected to the SoC through a
> GPIO then this is possible.

No, that doesn't make much sense.  How is the CODEC IRQ ever going to
get delivered?  And in general this doesn't seem sensible anyway.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRIiyrAAoJELSic+t+oim93ooQAIE95WLC5EW2TMk3sk9zVLPr
bUy/y1GQKR+SjUQF2HCIoDik3JstEUX3RDad8w4EOfbsCu8EiwaI3igMlr8jRWEs
HX3zO0dTAy1pOE8x+Sm/58DAkht5FXi1vI3xyPebkT3gjEyFdKwNHs/5SG+y2dFm
hEebxTnC2joqQ9vd5/89IoMFf47/RCKA5Acprq9djp1gCwNf1PtAn4CbKbaA0T71
1+s1gBKRcc3pug+42Zbg0E+jZaWuAVWWjXeBpeL28YOdDKnNRKlvSm3mJiFZmPgc
ipRVoSEFuWRYaxd3qg6Htgr9mhNCUHVgBfvNeknwxBS48cOLJIBvF1As8IzOGxK3
XJ/TcYYip8RNAnk8hIV9Skmy8oj1Y5pSPfaZazCBuZpPReS53V3fB9TJtRgoCLYZ
xNdTOpeEvMIMHPT7H5Cpy6YpDqn1ZzMDqJLoCTBw62HfacUrya9AVdCSA0Fowru7
8LIU75shOTr/x0E60OR/5vvKK2/1BPsZveW7lMnX/aE7XAYk2gfYRHIf0ZAfZVxw
7IP+kDp8tQmwAN7DJO/ZSXBJv+Bdri+Wg1/vzXAe0xkXXOiejy7Zs3qYtdAB/bIg
CnhHQLj9KVXZyuz2Q2Tolte3GcwbWIv6fENT8aX7DVeOWukKwfRasNVw0P7aO3En
JO46nioZlDI5uE1azwxA
=ini8
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

--===============5527456749847401266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5527456749847401266==--
