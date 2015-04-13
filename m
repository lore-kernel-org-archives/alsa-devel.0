From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix ifnullfree.cocci warnings
Date: Mon, 13 Apr 2015 11:38:31 +0100
Message-ID: <20150413103831.GE6023@sirena.org.uk>
References: <201504130318.BufQJB8v%fengguang.wu@intel.com>
 <20150412190626.GA28170@athens.lkp.intel.com>
 <552B15EB.7030806@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3773882846844385635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FE16261ADB
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 12:38:41 +0200 (CEST)
In-Reply-To: <552B15EB.7030806@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, kbuild-all@01.org, kbuild test robot <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3773882846844385635==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ag4KXF9gRq4fczJ"
Content-Disposition: inline


--4ag4KXF9gRq4fczJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2015 at 09:03:39AM +0800, Jin, Yao wrote:
> The NULL check here is to proivde the protection for current code and
> future potential code. It's possible that in future some code may
> change the pointer ipc->msg and the author may miss the kfree here.

That's not the point - the point is that if it's ever valid to call
kfree() then passing a null pointer in is fine.

--4ag4KXF9gRq4fczJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVK5ynAAoJECTWi3JdVIfQeoQH/2CoQt3JX86Q1SUpxHBhJ/D1
ATt3kSNFLKan8++/3mCzVcsqLaj6I0onwxSarv0FZTFYqCrOeSJh6djhrVfzeDpV
+I9yGh3/MVFqUMMr+d96/cvWuloAZB0EfeQ05aS7pF7Womh7BRuSIZekaYLUJkgl
1iHOwc7+wrAWNu5V43RY+LD1eGigY3sdZw20h1hsjGGRHqhfHeQsi5D/CIP8cNNc
gNvK3Uw7YeH8ieGhzeyvfRMn/BC9Y/CDntnx/7F007iVp9EgPgeZDVah2QbXlEU6
5TUGn9C5StQU0f3rBba5BqApB/TJQnncjpKsKLB48ATC+zc18cKckIT1PbLTeoY=
=bhxx
-----END PGP SIGNATURE-----

--4ag4KXF9gRq4fczJ--

--===============3773882846844385635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3773882846844385635==--
