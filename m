From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Only add platform DAI widgets
	once.
Date: Fri, 13 Sep 2013 18:28:16 +0100
Message-ID: <20130913172815.GP29403@sirena.org.uk>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4572463675353681969=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 21231261732
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:28:18 +0200 (CEST)
In-Reply-To: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4572463675353681969==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qWa1yZoiEHIhUpc5"
Content-Disposition: inline


--qWa1yZoiEHIhUpc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 06:09:45PM +0100, Liam Girdwood wrote:
> Currently platform CPU DAI widgets are created in soc_probe_platform and
> soc_probe_link_dais. Remove the extra call in soc_probe_link_dais().

Applied, thanks.

--qWa1yZoiEHIhUpc5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSM0ssAAoJELSic+t+oim9kJQP/1wbDw/kWzXqn8EWoHovGALn
xRn7TNOnnjZlZBtffaaTQNnBzRXlTL1FpbCotAMFebBKb09bKLWX2Z4H7QVV0+x0
7U/BWH4ZuwF+5gx3esj2oAnO5s2SX5OI3irUfWJ2dGOB7I46E34YAPA61c86t/4f
NtoOD6MZ319lE/O4mezwHoYlvHa5aAYjiJHoazzs75NjawzxbcSUSeYhwYBy9WAK
TMkch7od8UONqbbMTU2avBYXEIWIL+pPRbxYuWItOfIU0JVE2Fiufk8aQfIAhynM
Fb7W9lUibdvT4rXv8uYzvNcclqyojX7AbmWtwFMlKjL+8/IwKCloj51oZhoQ33hH
f3Hos1UBsVc15XU3EfbRHHmA6ePI0q6rI/uWgjVeY8YOkgfnNI3RmD+mhllYbs9h
PV8BnLW8U0Ij2Leqxx4u7kIGXWhVJd+VAf8U8mkz23/vKFm4/i3XFeFZStx4fPD+
BMXCSd/5IpVrt1xiMCHpRdQ8btdCoYmmxcjPCxzWq4Z5QZ1ZHmiGrIn7pmi6LLa9
68dvZZHN6V81yFIqEQvTHbdxTV2IYWejJApOAmxm5Gql1w4bfFkDFdBIlccmzTAY
2d+E+y6rlDFSrP6ULuHfY2Coee0/v1KU+Zlc/WJHQedYPBizMFOW82/e6+2F0wDB
303AEFtvCVBLXJADrh0V
=QDCZ
-----END PGP SIGNATURE-----

--qWa1yZoiEHIhUpc5--

--===============4572463675353681969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4572463675353681969==--
