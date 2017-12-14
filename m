From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Thu, 14 Dec 2017 16:45:55 +0000
Message-ID: <20171214164555.GH9788@sirena.org.uk>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
 <20171214115648.qidtgzihdoikxvhe@localhost.localdomain>
 <20171214153139.GG9788@sirena.org.uk>
 <20171214155151.gfauoqjwomhadibh@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1432012053082806946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C5082267AE3
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 17:46:37 +0100 (CET)
In-Reply-To: <20171214155151.gfauoqjwomhadibh@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, "Chen.Liu" <chen.liu.opensource@gmail.com>, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org


--===============1432012053082806946==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2017 at 03:51:51PM +0000, Charles Keepax wrote:
> On Thu, Dec 14, 2017 at 03:31:39PM +0000, Mark Brown wrote:

> > Removing set_clkdiv() would be a better thing if there were conflicts
> > here, in general we're trying to avoid uses of it.

> Ok that can probably be done as a separate patch I will review
> again with that in mind.

Yeah.  It does depend a bit if something's using it but I don't *think*
so.

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloyqsMACgkQJNaLcl1U
h9BCswf+McioednL7m8/9CgGuGVNcoF2flKEeaqpG7+iMSZelR468Ofk8q8X6jiq
l5dll6bLbuWwhBuCvWkLFkq3TFx1F5CTz11lZZxiYws6Yo+xZLtfea5HKxOE8bDm
bMayy0GuMJUHTfI4QnG/nnRj7scKOsMqygKrYDcFKc5pD0AbWvrGUhcTGVv3phdG
xMM6CqmfJhOH2C4Mf5ESEs1wMg+w0GhKQsu8zhQQwy+l7qOK8F70mwpMeyvURWN1
cxXVKOD1yCy0T3hyy1DEPSImpyrmI6xcJsec1FUZW9oujM42SSCgKr2QIiG40blh
1qzJ3xg7S6jLNyR6N9Z3mc8fGVPGcg==
=xUNd
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--

--===============1432012053082806946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1432012053082806946==--
