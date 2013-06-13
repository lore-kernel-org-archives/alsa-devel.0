From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5640: enable LDO1 before
	creating regmap
Date: Thu, 13 Jun 2013 18:43:43 +0100
Message-ID: <20130613174343.GA1403@sirena.org.uk>
References: <1371072864-13205-1-git-send-email-swarren@wwwdotorg.org>
 <1371072864-13205-2-git-send-email-swarren@wwwdotorg.org>
 <20130613093038.GW1403@sirena.org.uk>
 <51B9E0C1.4040601@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8213412929738133181=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B513B26524E
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2013 19:43:52 +0200 (CEST)
In-Reply-To: <51B9E0C1.4040601@wwwdotorg.org>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8213412929738133181==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t+hlxQ2APDzOSz17"
Content-Disposition: inline


--t+hlxQ2APDzOSz17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2013 at 09:09:53AM -0600, Stephen Warren wrote:

> This doesn't solve a current failure. It just seems to me that one
> shouldn't create the regmap object until it's actually possible to use it.

That's true but one of the goals with regmap is to be able to just use
the cache with the device powered off (lots of ASoC operation relies on
that for example) - regmap itself shouldn't ever be forcing the device
to be powered on.  One could equally say you shouldn't think about using
the hardware until you've got a regmap object with which to interact
with it, which is clearly the more urgent priority! :P

--t+hlxQ2APDzOSz17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRugTMAAoJELSic+t+oim9vQ4P/0T0PPnxpWRFCQ14d0e+kM3x
ayeZwpOnWfdR7bu6dIt9CgHTkDxCt1S5/LDkNibQVZdhjFk5vukHgZ5F3ulDOZFX
gaj7KrASdcg+Sqh61SJa00xjx04T4qQfL9RHMnmWuIWY1OOfGC+YWC2QAIDXFbBP
sdfbKes+tDqvggeVdHJ1xLjG0noUz88PyX1PwqOUCUIbUWuR9165CUW6PWZRI/qt
pz1VSyonvynD6LDsn3K49aN1u1epAND7wINCaoyBkL65/5CZcLIUC12h/jULYyl9
T8Ch/io3jz0krSXOoqwN3zeGRJy1TJFMvEVrDEpeKxOPvt26KzOxeF7X+AiXDYoD
kB94RwV4d3h6GKu3/qmigmt9kqlvjMGVsFt4Qa0KWYeO7W7tUDY8JIyGCsJT5Yp2
p+Fk45MnLidOMvkFJ86rnC1HywBT++6KF78vxYucjv5dv10gSrVkq6u7OoRB0ajG
JT0K/tmjh0cLYQ2FIx0hBZ8NFQrF6BFKkJnQAx7KCmXGq2me7FBCxymRbsifU9Ae
mlukV06O66KqMTzBlH5zatXjwNqiIu6t7v12S4kk3vXA//w3Btsd+smHhk9XCDM9
g0YST8GOrH5Ight2Nas9v57aAcNS58X+dM14QC6AtBNR20Vxpo4a+IHeNk4fbz/3
F69Ekufg+hT8q9HaMiQC
=dNkb
-----END PGP SIGNATURE-----

--t+hlxQ2APDzOSz17--

--===============8213412929738133181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8213412929738133181==--
