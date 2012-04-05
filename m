From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: imx-audmux: Check for NULL
	pointer
Date: Thu, 5 Apr 2012 13:55:02 +0100
Message-ID: <20120405125501.GL3129@opensource.wolfsonmicro.com>
References: <1333629952-18243-1-git-send-email-festevam@gmail.com>
	<1333629952-18243-2-git-send-email-festevam@gmail.com>
	<4F7D94CC.80300@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0381703246942047692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C877B247C9
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 14:55:05 +0200 (CEST)
In-Reply-To: <4F7D94CC.80300@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: joancarles@fqingenieria.es, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============0381703246942047692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XRwESHC7KXlqFpSs"
Content-Disposition: inline


--XRwESHC7KXlqFpSs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05, 2012 at 02:49:16PM +0200, Marc Kleine-Budde wrote:
> On 04/05/2012 02:45 PM, Fabio Estevam wrote:

> >  	if (audmux_clk)
> >  		clk_prepare_enable(audmux_clk);

> > +	if (!audmux_base)
> > +		return -ENOSYS;

> What about "clk_prepare_enable"? Do you need to undo it in case of an error?

Or alternatively just reverse the order of the two tests so you don't
need to worry about that.

--XRwESHC7KXlqFpSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfZXhAAoJEBus8iNuMP3dIUAP/Ayt/W/5eQfGLPusTLtu4v+1
WsGbyqiIqEfGmdkCyxMUdhLj970xt3CWV0PRWk89Dtdy9/hJ+LJIYOfZIGcLkbuP
9G7NmdP+88J7kRTKzFxlomW9tay+4xGC4kahB4DVbvhKc7llbCjwU/SiQxn/pPZc
TTwx2ZKd6thEY/RtzoyIsfOReR/eLZCYkiIzA/yChtpg2AYkmLfnKEMk/B3aMvAq
ZTb1oIaC1JKPhz6h1+2LBo2Lm0sxDxVyMcP2TqP4HtfYEh2ymZkgTc+6vmpXru6p
xIVrwlCPk/B483qP+GwFoNvR391vd1Bm+Xdquup8toauvYIxVkBrIQnHOmJfVths
SUG4fz36IqnaO6TBcrPlqF4uMUMOXqJMOCinhbA6f/ufEDsQ7Qfhmh3/gBfnhP4j
sKtIXY6AiT3249mux86ashmy742iDVuyBBKYxlHbLaY7qpHsDdlxz4nq+Je/6H6a
441ZhjEKMLk7KK81xROP1LWCFyAHMutqEuZFBxvg87pCx0e7c8DbkygXptrR+uQD
6FZHB1/z+r8xteD9QKg6GYDxgUcDJtqBI60AOnmRrA8WkyPFAawF12KP4Q61xXwJ
lfZWNIOq0oLt7550nxKbHDvI5yWbYMlMmn4ujma29j5gih7y+3fl3Y9WWaJG62/l
EgyhQQlESm7efBbOB82A
=m98O
-----END PGP SIGNATURE-----

--XRwESHC7KXlqFpSs--

--===============0381703246942047692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0381703246942047692==--
