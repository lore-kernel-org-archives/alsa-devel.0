From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
 runtime route update
Date: Fri, 13 Dec 2013 11:42:15 +0000
Message-ID: <20131213114215.GW11044@sirena.org.uk>
References: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
 <20131212104347.GH11044@sirena.org.uk>
 <F766E4F80769BD478052FB6533FA745D4E76B8FA79@SC-VEXCH4.marvell.com>
 <20131212110718.GI11044@sirena.org.uk> <52AAF09A.40302@marvell.com>
 <s5hy53phthr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8341525631205817058=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7192D26163F
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 12:42:18 +0100 (CET)
In-Reply-To: <s5hy53phthr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Henry Zhao <xzhao10@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Nenghua Cao <nhcao@marvell.com>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org


--===============8341525631205817058==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KRJ4yArSHF8vY7I3"
Content-Disposition: inline


--KRJ4yArSHF8vY7I3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2013 at 12:37:20PM +0100, Takashi Iwai wrote:

> Usually backward compatibility is concerned when something new breaks
> the existing ones.  In your case, always updating DPCM would work,
> too, even without an extra flag; it's just suboptimal.

Right, and if we have separate versions then at some point we'll end up
having to define DPCM versions of everything which is going to get
tedious and error prone.

--KRJ4yArSHF8vY7I3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqvKUAAoJELSic+t+oim9MpUQAJgDHdxr3pmjQ4JszQtlMdsv
YqNBLAZZLrYwX7Y07CDDanaTc9vayUmQzf2IbngvGvmkN8JqwSHILEcWodfEKHn2
Rwc1+IprkoSSEetv7t6ACiJOpOgE3Pbd9xHkY8pCK7ylX+IMuQJvpVYr2vNHQEDT
b4fOm0bF2OG1VxaZX8GRuk7huhABxm7jnOwCwKwV1aefZug9z4P6KFTdRsP8UaoT
FTp4g4+QMdB3+xc2gfp2FcG9KTUoBiUvGXOHpyFEmrGIbg32xPuRfJYKWjqOUWr0
k+5J2FkTyB/mVXdk7UzRLbfizKn/1eyrNAjCoxYC9OUU5cbqFH0h9HO/FAC498Ih
rf1vYP4AKe6r9ShcEruoDHUdXQ6dG4zFW3T6QKKriCrNJiRKUig1ac0Y08FfEyGG
9Okz8LOzHYWhR04OuUdfCf7ldGQFZ/D3Bd5PCYkUpiHuGRBiScuenw0LE0C+zyyg
ak9gu9pX1xPkUvOVn0Vn7vHTYq0qAo5mBh09WCTzi7g9DLbSvKh3xaJgYbnKq2JG
kqnTCuAIaTeqryJlvA/xXcovgi18h3X1aISTkc9rdrYVwRf9dW9Xmpt00QN10VKX
Eqb4cYm9h+uZjo/YgNZubXrwxoEBpDsI9z9wW+xg7xo/HLc4e6IKyIm4A5x1e7Ev
A8tf5jNlBQHGrjqsfK5b
=6KvD
-----END PGP SIGNATURE-----

--KRJ4yArSHF8vY7I3--

--===============8341525631205817058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8341525631205817058==--
