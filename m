From: Mark Brown <broonie@kernel.org>
Subject: Re: Generic clock divider indices
Date: Thu, 6 Jun 2013 15:24:09 +0100
Message-ID: <20130606142409.GE31367@sirena.org.uk>
References: <51B09224.9050409@gmail.com> <20130606135605.GB9980@sirena.org.uk>
 <51B09830.7020208@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3197558045202943575=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E72CB26563A
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 16:24:11 +0200 (CEST)
In-Reply-To: <51B09830.7020208@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3197558045202943575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1PhPE3kzXS7rBT0C"
Content-Disposition: inline


--1PhPE3kzXS7rBT0C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 04:09:52PM +0200, Daniel Mack wrote:
> On 06.06.2013 15:56, Mark Brown wrote:

> > I don't think this is a terribly sensible idea; as soon as you start
> > relying on these dividers in machine code you're going to run into
> > drivers that just don't implement them either due to hardware or due to
> > them being able to figure things out by themselves and...

> I do see that we have a way to propagate the sysclk, but how would you
> determine the bit clock rate from a codec driver?

Usually you just set the bit clock to be whatever the minimim clock
needed for the data is - there's helpers in soc-utils.c to get the
number - or the next highest sensible rate if there's a division
problem.

> Also, the same problem with freely definable indices is true for
> .set_sysclk() as well. Not all drivers expect the actual MCLK rate here.

Yes, and thus you start to see the problems doing this sort of stuff
generically.  There's often also a whole bunch of different ways the
clocking can be set up which can make a material difference to the
quality of the output and may require some system specific taste to
choose.

The fact that the clock API isn't usefully generic is not a help here of
course.

--1PhPE3kzXS7rBT0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsJuGAAoJELSic+t+oim9So0P/iXHQCI3YBPXJ8ix8wcX93Py
6bXpU1nFafENa3eMLr+RcCgGl823jtCZy2aAUr4Wv+r4bEFK4FIsFi/YTXdZVR5I
vkFQgd+DjZ8kSHYJgglIpv/qYfh2DpFte/9Ku7Xl9Y5nts63DviuGI/x21rKRBvn
3Bo14Q8VA8sTcNTejk/8F9vBqON4C5gf2DjMIQyidiXS3WeBMI4B23gTd1/7J0yO
1zOiU/8cExLbssrAutd7QngJNXzQCWqUOz9fVCMLBLhWoxyksuc5YlxpZpj4j9x1
VAzTVRpvTTHtGKOo9YzRc2z4MeeEg0hIKbTeiqPJ7dU0gHVBL85XytVU9KSgHLmb
p90ag09zC/OkxBMQAnjKgxLOV3XxyWNH8IBuP/JPh4TbCeBWd6GHOKGrQKP+U2c3
pXdNH5hnzKxz9Ojrs5D0QD6P2o/l8MyilVD6YLMHdyWJisOuM5lNdN4nmLxcc5eg
lFE7+EN4XEaZYBH95E6+RFaOj4PmJpisrtew9GxoQ2tNssPQLiRStM6X4aiU8IWP
b9yk8DikuwGRMotTffCQxYYulTvbBCut1M+PxsI7JG0PU0MSId86dchfIbxRmURG
W14PreF6ChQg0lNHwVmyP58YEJB32uK3Ys80kdul1h/YMF79VkFNq4ClJNHvP9J2
wGMqy2uyFHdpaiXpDYkO
=3TL+
-----END PGP SIGNATURE-----

--1PhPE3kzXS7rBT0C--

--===============3197558045202943575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3197558045202943575==--
