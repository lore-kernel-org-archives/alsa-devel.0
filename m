From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bcm: Remove obsoleted Kconfig
 dependency
Date: Thu, 9 Jan 2014 10:32:01 +0000
Message-ID: <20140109103201.GC31886@sirena.org.uk>
References: <1389173827-1554-1-git-send-email-tiwai@suse.de>
 <20140108195947.GZ31886@sirena.org.uk>
 <s5hbnzmp781.wl%tiwai@suse.de>
 <20140108201709.GA31886@sirena.org.uk>
 <s5h8uuppt1u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9142323020652487032=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57BC826515C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 11:32:10 +0100 (CET)
In-Reply-To: <s5h8uuppt1u.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Florian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org


--===============9142323020652487032==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KpzOdakGPe4Et1pG"
Content-Disposition: inline


--KpzOdakGPe4Et1pG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 07:29:01AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > get_maintainers *should* also tell you to use @kernel.org, that's what's
> > actually in MAINTAINERS (which should be preferred over git history, or
> > both used) which is where I actually read upstream mail.

> Then the problem is that you committed and signed off with linaro.org
> address in git.  If you don't want receive any patches at this

It's getting more common these days, companies want their address to end
up in git but it's not so good for upstream mail for whatever reason
(historically a lot of it has been Exchange related, though that's not
the case for me).  It's more noticable for people applying patches than
for people sending them.

> address, you should never use it for git.  As a Netiquette, one
> shouldn't post a mail to multiple addresses if it's known for the same
> person.

Sure, but if you're going to use one I'd expect the MAINTAINERS address
to win - I did have someone the other day using my Wolfson address still
since they were going off signoffs and the thing they were working on
wasn't that actively developed.

--KpzOdakGPe4Et1pG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSznqeAAoJELSic+t+oim9UakQAIpMRuiZk8JdXvdH3HN/m2ct
k/ulMjBnsCDY8aOZlMAs2/w2jF4FWckYKAmY8QWQt7E34ztkbXsjnrc3JiqQ4JID
L7t4PBXT6tLWwU6l157h+vBxGA5KZVn11IdRrXfwLcI4WHz0yTrtNFmNEtn4R1u0
qXBj5OtfZWFExE3S9MvbBnok1F5KurMx/1qYmSRcvKldOJA1VRueZ1eFIRveU9eF
PszeroDS7Jw/O9JqdGuUbzPvdOhi1TCdJ25eB2Lc2ynlZHmmzrUB9pT9A3DVEiBj
QZI7QmSeTLrjeOJperKgVM1mufHaOIMXCFWOTlyTgQ9ABBijdrXtDrL1avWnMxU7
WZ3AYip9vBulTm5wk5Ic7fQQQOdggnmiSOMm+N754eaYKptOWRb8BJaIgAGTS3kS
O84ETr8d9PjORO2ElXVOGrC4WkyinATtm6xyzkKLiTSrNcJwnYiLt2AADW/olwQ8
pRhouiVdCaq3nGxEV6lbV6IiJdsYCzRYKXRphmwmqwcIvuRsJHwbYMewg1Ev6Vbz
81dH8St0EoGc515RZGDnFx0cjkkvTtFkowpDR5lRj6M+gQCrKfp/ddaIfDJCC7Px
2SntYpEWxXkF2qlXDb73xCYZEInzcevfyS4cERpzFZslWAEnXddhEMdgJQ+4XfxO
a+aVngkRKwKuU+ZrvTuu
=ppOX
-----END PGP SIGNATURE-----

--KpzOdakGPe4Et1pG--

--===============9142323020652487032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9142323020652487032==--
