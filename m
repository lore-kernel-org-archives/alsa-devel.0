From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 8 Feb 2012 11:12:53 +0000
Message-ID: <20120208111252.GA3120@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com> <1328692723.3955.4.camel@odin>
	<1328693854.21099.5.camel@vkoul-udesk3>
	<1328694877.3955.9.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0665832803777580082=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 730ED24337
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 12:12:54 +0100 (CET)
In-Reply-To: <1328694877.3955.9.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0665832803777580082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 09:54:37AM +0000, Liam Girdwood wrote:

> However, I think one of the intentions of the clk framework rework is to
> allow non CPU clocks like CODEC PLLs to register as clocks and have
> their dependencies worked out. I've no idea of the status of this atm,
> but maybe Mark knows or you could ask on lkml.

It's going nowhere slowly.  Seems unlikely for 3.4 at this point,
there's been no activity for a month or two except for rmk getting
annoyed at the lack of activity.  The current block is that very few
people are converting the new clk_prepare() APIs, though there's other
problems we seem unable to get any traction on beyond that.

I rather suspect that the general lack of any end in sight is not
helpful for motivation of random maintainers and none of the folks
working on the core API are doing any of that legwork for them.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMlirAAoJEBus8iNuMP3dQpgP/3YRkgB+KPUBZp48G916rqaf
wrykcau//rptF6ZKYHUQbdkWKktSyua2A3wqEIzRy6/LpAdeGUH/RT/x6GBdV1fR
wTyOfCRqpOo22erDtXx0Ce+pNKQV+2E2Z8MYq5NXom9GY4b8W/+igx8Wy/WsMWEX
3mEvx+ZGR+GHALZViZstcF379kfnGptURhByGB5+e8LkCyslnD8O/ug70EeVEwu2
RUks4IyRngeubTV78Uy4e5xZcpNxOJu67ne8TS0w1xBQF0TWN60J4PbevSp29hcd
Id1zqmQGO1lQgZbB7e+ijsasU30NxCD9f9xX0TQ81UbydioWbWwrcHysXz1uvjTi
1cYJ2Fxd28CFVDT2Ws9qLto3DgeeNJa4QoRQqAEdKbNPY+lr897gdhZU5GQJUCRa
98YE0otzDDlIs+DJRPUT5dJChe4YuNrfaiYdioVQ57ycPG88cWADJEZGW4fEV+Xh
5aSN0wETzrfK3GqE2MoiKhwX7HbSJ+pS6hXDP6roSEDlXcc5BI/m1mOhFPRq6RyP
H220rYCqvzQuNGA/JfbTF4FesNk+vcFgooXt81WnRai/uUpSPxpdSS6ub2x8HOvs
YncX/Dk6iY7FPHZXETvAyehYzyJOZB+mDK8Iq3k7vyjM9xGOpc7q3/7Rg1raJvb1
BvZQeluvVTDtgMpZ/6gs
=pl0A
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

--===============0665832803777580082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0665832803777580082==--
