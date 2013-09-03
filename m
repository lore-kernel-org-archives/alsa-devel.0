From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: generic simple sound card DT
 bindings
Date: Wed, 4 Sep 2013 00:19:22 +0100
Message-ID: <20130903231922.GL3084@sirena.org.uk>
References: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
 <1377945878-13322-3-git-send-email-mpa@pengutronix.de>
 <52220766.1040504@metafoo.de> <52263795.8010600@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5505935594943612177=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EF70265479
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 01:19:30 +0200 (CEST)
In-Reply-To: <52263795.8010600@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5505935594943612177==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QeIEYJGnsH0eC7HY"
Content-Disposition: inline


--QeIEYJGnsH0eC7HY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2013 at 01:25:09PM -0600, Stephen Warren wrote:

> Mark has made the argument that (at least for CODEC analog pins) we can
> simply put those strings into the binding document, and make them as
> much a part of the binding as anything else. After all, (at least for
> CODEC analog pins) the values are simply the names of the pins on the
> package, as listed by the HW documentation itself.

> We could presumably do the same thing for DAIs; in DT, use a
> string-based DAI name derived directly from the HW documentation, rather
> than the current intra-ASoC DAI name strings.

> That said, I will admit that I personally don't really like the idea of
> using strings in bindings. That opinion certainly isn't universal though.

I think either works - with DAIs there is a tendency (though not
universal) for devices to just have numbered interfaces which makes the
numbers more natural.  I'm more concerned with the binding being legible
than with what ends up physically written in there, the original reason
for strings (apart from the fact that they're in the drivers already)
was that there was a lot of resistance in the DT community to symbolic
constants.  That would have lead to bindings which looked like line
noise.

> > The
> > binding also assumes that a CPU controller may have one DAI at most. In my
> > opinion this binding ought to use the upcoming of_xlate stuff for ASoC
> > components.

> That restriction seems reasonable for a *simple* DT sound binding. For
> more complex cards, one could presumably create more complex bindings,
> be they generic bindings that cover arbitrary more complex cases, or
> bindings for specific configurations that happen to include multiple DAIs.

The complexity there comes from the device that's being used rather than
the design of the sound card though - the fact that a SoC has an audio
block with many DAIs shouldn't prevent it using the simple bindings if
someone just hung a simple CODEC off one of the DAIs.

--QeIEYJGnsH0eC7HY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJm53AAoJELSic+t+oim9LKYP/2S8sZE3s5Pq+OFh4ZZNMvgp
61CehgYh4Ed4Q7vSHrC3ZC3WmOZiJnmady74y6X4roFd1CXhy91S9Q3t6bIi2Pq1
jFGOwiov+mqNsEr0C4DnVI6SXL9cuQ6yzHKAzQRSeM871YDfJoDZ+dS2MYv5uPYK
w8xPeEHFQIwkNKrGpiCfcrNLQoCk2zEKoKU2OGLTw+vTIrTnwqNbzQbi+9yh7slC
M8zhjH6la/AnbGKufJRR/ZomugRLaoWbQBcMDSCITuBhB8uB7tz89Xq2UBf0U8l1
jYS02r7StcRqqrtEBJ6p9hrE47LavrI9S2wA7fF04Z5BnWhpd9RWngOnJKdN9BB/
Jww0lVi2KtBX7g0WZMEOPgAD3nbN8p0+QHyCsLQamh/LgDUn9eXTrBUt+aBvH7zy
X9WcASbhEmKxVvJDQBDdgZ66AIlh0yZjoP3t9BwoeQLIQpUPNo10Ktdg2vHtEKSh
vhJdqDuRhtePHxbHs79As2w4op9EBHoUWLu6cLDAuAf4K7TM0i3wguBc3VcGyeT/
ior715vX5+2izh6qxET75Z+/ny5XgAPGB2hnCp/N4ViePS2PNjxyHSKbAIuMqiDJ
4jknOYg+LQsISYcw/0J9fvuYKpELAcNHDIN9forb2d7o0sYpnHS3L4frnfzb7aIr
ONTA19XWUkKyb4gMJm1D
=VMLW
-----END PGP SIGNATURE-----

--QeIEYJGnsH0eC7HY--

--===============5505935594943612177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5505935594943612177==--
