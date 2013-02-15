From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Jack: add configurable option for
 irq_flag
Date: Fri, 15 Feb 2013 12:17:27 +0000
Message-ID: <20130215121727.GD22283@opensource.wolfsonmicro.com>
References: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
 <20130212114752.GA1678@opensource.wolfsonmicro.com>
 <63969.10.223.96.90.1360733997.squirrel@linux.intel.com>
 <20130213131917.GF5062@opensource.wolfsonmicro.com>
 <20130215071000.GA23031@oma-dev>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0894676558025640773=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1219D2615C3
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 13:17:29 +0100 (CET)
In-Reply-To: <20130215071000.GA23031@oma-dev>
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


--===============0894676558025640773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2013 at 12:40:00PM +0530, Omair M. Abdullah wrote:

> This patch is mainly to handle GPIOs where there is some toggling of the GPIO
> lines due to the switch bouncing, and the debounce time cannot be increased
> further due to other constraints. In such cases, providing the specific
> edge on which to trigger the interrupt helps increase the robustness.

>      ___   _                _   _________
> e.g.    |_| |______________| |_|

> insert followed by removal, where we want to trigger on the falling edge in both
> cases.

This doesn't make much sense to me, it's a *very* non-obvious change and
it doesn't reflect what's actually happening well.  If you happen to be
lucky and get no bounce it'll fail.  If it's working on your system
there is a fair element of luck in there.

It sounds like all you're looking for here is a better debounce
algorithm, for example one that delays for a bit then starts polling the
GPIO state at a higher rate and declares a result when the GPIO state
doesn't change for a few polls.

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHidAAAoJELSic+t+oim9MEEQAJQPcOS28igEasMrB6tjXeBb
qQ9qKfWJRu05KFBT76gBmhZZwr0QeV0356nJn1uTC2wpV2ZSvnAFQfvMYpRo/blC
kuwtKb0prOnuCDm1oEVrcxOBrDweP5X27JvlJXmt2DkMb9YY7kix+d+miS2xbQd/
5MVP5YAinahFItfZkAdp5mR2XTnn8ZWhzVr2H0LKZeTQWV6iqyda0aUtTDAXYPW5
momnZFbo2K7S9vLTYDsgOoIeKUkOpzmdPaicBgO+YL3tTl2uQMbCTQH51YW0CeUF
9E0m6NSCFGJEYFAfRosU2BDZEkPXfSW4Q061KjWPOnrB6NQ0JGtCPl7jR1+FS3zM
k3S6CgF/YSxbHeXHupoWRtUMd5zTcvDtc+/JWIMxHfBRqtCJRxEXZ3sfW3A2s+Ot
Lxb04mh83dXty4a4rNUuErCBReqNr4DrfbDBPgX90KPcZOI/mcTNWurgfzjTYUXJ
1QLs0YEKMEahlWVC/nmU6wfUmmBdap37z6gqe7ZWQwi/PwxxRpX8xYQeIiFW6seV
+cKKgrePqc6LpmtAfnmXr//1OBBPA5MU90h/doezZeLC4po9b8mNOmMsUm/a8cgE
pcCS5k58kaBWGbb3T/Nrbhhq8XBgLFo8zjLzAU6JUp+67WTQ5Jr2lgco/UVRlD4u
nhhlXeXAkZr9Tp6YEO6T
=6d40
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--

--===============0894676558025640773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0894676558025640773==--
