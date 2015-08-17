From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Add Kconfig option for
	topology
Date: Mon, 17 Aug 2015 13:18:35 -0700
Message-ID: <20150817201835.GB10748@sirena.org.uk>
References: <1439654427-26109-1-git-send-email-broonie@kernel.org>
 <s5hpp2oxu73.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3370832509533135595=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 1229826042F
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 22:18:38 +0200 (CEST)
In-Reply-To: <s5hpp2oxu73.wl-tiwai@suse.de>
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
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3370832509533135595==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NwQOVL9IuL7Lgg8R"
Content-Disposition: inline


--NwQOVL9IuL7Lgg8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 08:50:08PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > +ifneq ($(CONFIG_SND_SOC_TOPOLOGY),)
> >  snd-soc-core-objs += soc-topology.o
> > +endif

> This can be simplified like

> snd-soc-core-$(CONFIG_SND_SOC_TOPOLOGY) += soc-topology.o

Yeah, that thought did occur to me while I was doing this however all
the other optional files for the core that are in there already use the
same idiom for some reason so I'm going to go back and update them all
at once later rather than having some in one style and some in another.

--NwQOVL9IuL7Lgg8R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0kGaAAoJECTWi3JdVIfQEZsH/2Qh2tV2/bjwJO8yKSI7F3Tf
tqgCspeEl6SdfmqEIWvP23SuvAYQBrV4Dzz6cRfH2vuORQge7f0zmlrLzlPpQJRb
EGRR22Ah29AXPWoP0cvsyLjP84DkCJwaL7C1J2W+t4j8t1552wztc/+/rl883kfl
V+veuKkQyY0Tk5tdcsWECiHTHwdHUBSfBjQxPEqjM172uH9Zt97I7qTHRdRoIs0V
EEC8BxFLFd+NUIJlwYYkTJlvFIDUhnF+O97h+NwdBI6ZrivVpP1S0MoXyJo2UY/H
wIeL8XnYn55e3E2ooGjp1F14JNjyjUo0AvmWTR7GTscBOjXF+6D/js4lm1KYFuc=
=rQHh
-----END PGP SIGNATURE-----

--NwQOVL9IuL7Lgg8R--

--===============3370832509533135595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3370832509533135595==--
