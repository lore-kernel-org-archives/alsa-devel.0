From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Implement mixer control sharing
Date: Fri, 29 Mar 2013 10:53:34 +0000
Message-ID: <20130329105333.GC18316@opensource.wolfsonmicro.com>
References: <1364514790-28398-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7787946553946141109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F38B5265CBE
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2013 11:53:37 +0100 (CET)
In-Reply-To: <1364514790-28398-1-git-send-email-swarren@wwwdotorg.org>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7787946553946141109==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kX7wsrERV8Y1FKEw"
Content-Disposition: inline


--kX7wsrERV8Y1FKEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2013 at 05:53:10PM -0600, Stephen Warren wrote:

> Mark, the goto here might be considered icky. It avoids heavy indent
> levels. Should I separate out the control creation part of dapm_new_mixer()
> into a separate function to avoid this?

I think the fact that you're asking this question means you know the
answer :)

> Also, this commit has the potential for user-space impact, since control
> names could change for existing drivers. However, in this case I suspect
> the affected controls wouldn't have worked very well anyway, since they'd
> be affected by one of the problems I mention in the commit description
> above anyway, so I doubt this will be a practical problem.

This isn't a big deal.

--kX7wsrERV8Y1FKEw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRVXKnAAoJELSic+t+oim9qI4P/jAcBeq6O71AERPKB4PPN+bq
/wPj7vYzBJKztEOis/RmbkW0eljOH8Eb6zcnaWGIVcjthhI1Gz1Ro5fOgulYisYW
KkNCG/aIPoq//KjLjg2cOUKW8wuRnj7UURUGpTSKl/XjfZxQhmPNqOcIlTNm0A3H
5Nohn3xtmkc0fNnd8KGKICYTntrOHBEUMHmUry+wIv49UfxtoYmOCkZqY7Gx4Cy2
1OgButKCL6aPGhu1yA0nW7KdFukSBRst1rvAGRFhXXn3oOJGjP61ZL3UOudnlGYS
7g7OiJZ1OilrWR7IIUJdM3h2VnNkxqOcUx7Da5Z+TbN9qVh9af/X5a4gLJlMHXTe
viauS+WIpqPsMhUGn/IGLh8fNS6Fzqf7Q25IAL5mzLPIC49nxrYS6s5Dr2IqGnnq
0p/h1VZ4/+4ulcX8puqmVPkuERWu2O3lmKP9I6VNmPbnLQqSq/ZDEpTpVaq4xvkA
yCtQ2BMFUrLQySgCPo+8OB+tCx0NMWbM1UnfmmTnJRq2U3Mh8aYTdvYsX8zcfp2+
b+TIB1iw2zNOuG1vHpHcBUV5eFC73oCQGds5g22SCcn8/fnmUUrlQZziv+miJu2C
4xBPhXWotkp98SKzU2bhCSLuW4RtrlUVxTLCzQw1uJDTAsQA+jGI+6i9lFiH0JhB
wlWkLBfKdL0xoYaoFJP5
=1qDe
-----END PGP SIGNATURE-----

--kX7wsrERV8Y1FKEw--

--===============7787946553946141109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7787946553946141109==--
