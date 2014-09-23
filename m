From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 05/10] ASoC: Intel: mrfld: add DSP core
	controls
Date: Mon, 22 Sep 2014 18:57:30 -0700
Message-ID: <20140923015730.GG27755@sirena.org.uk>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140916193053.GD7960@sirena.org.uk>
 <20140917105552.GA13006@vinod.koul@linux.intel.com>
 <20140917193706.GU7960@sirena.org.uk>
 <20140918061237.GA24663@intel.com>
 <20140918172852.GY7960@sirena.org.uk>
 <20140919081047.GB24663@intel.com>
 <20140919082152.GC24663@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5229913595960043043=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1221B261600
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 03:57:53 +0200 (CEST)
In-Reply-To: <20140919082152.GC24663@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5229913595960043043==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2014 at 01:51:53PM +0530, Vinod Koul wrote:

>         if (e->w && e->w->power)
>                 ret = sst_send_slot_map(drv);
> 		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> Here is the widget is powered up then we send the updated slot map to DSP.

> So it will be updated real time now :)

So in what situation might there not be a widget there?

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUINOJAAoJECTWi3JdVIfQjoMH/imbSYw/Xqnwj81+6JkdHqOv
pS1lD9WHiNiKFuTsAp31h819zsCquB5laKg5FcztVwTsaS4x5z4QMbvrPa2j7GQi
ToxH68YMpRKbj751kMwJvBFBgSqectthYntVuB+IGtvgcFxe3ls+zVYxnMQZzAoC
oYi5wtpoo9xXDcQb/iJUC+i8sgOM5hA6VPBPw/z5yiLrn9PzdKgA0MmtEDeN5WYi
wQFhSTHBUFXeOUh/igmrbFGN0kxdWQQfxPv1nOfhAZ0qgiDUyVvTDPYPsbdpbbL7
tIgW7c9O+VZ/LMzjUzuS6I7kPzYf5wDpfeSutyNOUKQOxGJtlm8oyiASZ7lFVlc=
=GBFz
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--

--===============5229913595960043043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5229913595960043043==--
