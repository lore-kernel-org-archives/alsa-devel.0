From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v6 1/7] slimbus: Device management on
	SLIMbus
Date: Wed, 11 Oct 2017 11:23:42 +0100
Message-ID: <20171011102342.llsau56cjytwmo2f@sirena.co.uk>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171010100534.zyv3b5m6fmgmceim@localhost.localdomain>
 <6dc24d42-7c40-9ffe-6be5-bf38d712222b@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5127229085217427906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B64D266B38
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 12:24:03 +0200 (CEST)
In-Reply-To: <6dc24d42-7c40-9ffe-6be5-bf38d712222b@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, Charles Keepax <ckeepax@opensource.cirrus.com>, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, gregkh@linuxfoundation.org, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org


--===============5127229085217427906==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z3erd7lyishk7y4k"
Content-Disposition: inline


--z3erd7lyishk7y4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 10, 2017 at 01:34:48PM +0100, Srinivas Kandagatla wrote:
> On 10/10/17 11:05, Charles Keepax wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > This does sort of make sense but kinda makes the code a bit ugly
> > parsing the MID and PID. Some parts will support SLIMBus and also
> > other control interfaces, which means they would need to add an
> > additional compatible string just for SLIMBus. It also breaks
> > the normal conventions of vendor,part and finally it makes the
> > compatible strings really unreadable which will be a bit annoying
> > when looking at DTs.

> This change was made inline to the comments provided in previous version of
> the patch https://lkml.org/lkml/2016/5/3/576

I'm not sure I really agree with Rob here - while Slimbus is notionally
discoverable I don't think I ever saw a practical system which relied on
that for enumeration.  In real systems the discoverability is more of a
complexity to be worked around than anything else.

--z3erd7lyishk7y4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnd8S0ACgkQJNaLcl1U
h9ADzgf+MfPdo5iS8HcAeOk5YJuBcP+SuJdWfQc5aTAF8PnXH9SxrWnErQamfJiX
HQ3nEbRvMpEjS5gAGWw/N+L8AGIvid1yitTwSSpeqRt1HnzzLHttp2Pk3pzJpbqB
l5LWpl0ye+uZ0POGOiakl+V3TsmB8c8MEJ/PT3BqzgfA4zEa4BTQAfTQG72ZClFe
vLHN8/l8YC5ETsAgNpARPwcXx3PcxFklpSA9/t88qNLBx7I2KoGuypkMDMuqyfKu
reRrOHMmPx9pEE+28K87S0gkeqXa/ViiIBOjfsC4ZG0PomWFugng7Xr9VhOYbD47
IlfJGXyYL9bJi1+W48xPn8XE0B6VDA==
=los5
-----END PGP SIGNATURE-----

--z3erd7lyishk7y4k--

--===============5127229085217427906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5127229085217427906==--
