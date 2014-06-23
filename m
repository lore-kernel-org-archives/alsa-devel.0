From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l56: Fix stereo channel register
 assignment for Headphone and LineOut volume mixers
Date: Mon, 23 Jun 2014 17:35:50 +0100
Message-ID: <20140623163550.GD23300@sirena.org.uk>
References: <1403540273-15231-1-git-send-email-ryan.harvey@cirrus.com>
 <alpine.DEB.2.02.1406231124500.25941@heelrod>
 <20140623162642.GB23300@sirena.org.uk>
 <alpine.DEB.2.02.1406231136430.25941@heelrod>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6000669495941057504=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 14D48265654
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 18:35:56 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1406231136430.25941@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com, Ryan Harvey <ryan.harvey@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============6000669495941057504==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 23, 2014 at 11:37:06AM -0500, Brian Austin wrote:
> On Mon, 23 Jun 2014, Mark Brown wrote:
> >On Mon, Jun 23, 2014 at 11:25:18AM -0500, Brian Austin wrote:
> >>On Mon, 23 Jun 2014, Ryan Harvey wrote:

> >>>Stereo Headphone and LineOut volume mixers are now attached to HPA+HPB, LOA+LOB.

> >I don't seem to have been copied on the original patches here, or
> >they're snarled up somewhere in transmission anyway.

> You're there. Maybe stuck in Moderator with first post to mailing list?

The list shouldn't affect the direct CC to me though.

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqFdjAAoJELSic+t+oim9K5IP/0+jO4M78qCrYhqAe+oE2iHP
yA97uDqmswp5MsJkEz54LRbff/s7Dx8JFAt0CPV+dlGkBfBy+i+9WlnmghU+qanV
eO954Gmx+IjRFUyD2ArBx5zS0pegx5Mg34Yexf0DdGT+VmroB9kDztVz6RFaThzS
P466Ml1gEWJbmdGuM0ZqZRXvg4JbCNLjzqh4Rhkifz7g8E2JhvXb2BSY/l4o8Q9c
8CDtdqdf/QGU7eaWM8MsIXgvORffzf//pbl8Wv1T9Hf/R0/1uY6TNQmCxLuLtXS3
CQg988esjiQCvoC9OZ+x8TMFUQfp0RNIpTrK1iflUuPXOpskOGUtlcsSNzlyhz4+
1cKj/8/MRGrE+XdHEsDnRlN/4+iOeSnMzmGmKf9a3mlzu05xUAn2EKD90+pMN7Nt
EBblzopX+ecstOwk1+cHOWoHzrhGg0ZPZx6xGTAcFHJyO/JW6nCp25RJc9pHzIHa
y6yoz9s9q5RloZ4/l6miR+AamePW8GIMm0j2O1Zhi0deHZwXWrhxsftOdRlm8QQ+
udBOm3uZ9HCI45hoLZM3W+wfwFuZlcijwj7S/sqHdSthGBkUg+VjtVQ4wagvNbYS
Bhy/KAY9oI8xWU7pMyRNwXatpp7It3NLx6wl7WsAxKuY2eezVpuzHZ5Q5LRFNOH8
iZQwrqTYah/MWg3eedUh
=nCFj
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--

--===============6000669495941057504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6000669495941057504==--
