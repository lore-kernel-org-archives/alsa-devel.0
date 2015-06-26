From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Fix deadlock on auto-disable
	mux controls
Date: Fri, 26 Jun 2015 12:47:15 +0100
Message-ID: <20150626114715.GX14071@sirena.org.uk>
References: <1435311583-18695-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5109360641800229391=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E641A265132
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 13:47:18 +0200 (CEST)
In-Reply-To: <1435311583-18695-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5109360641800229391==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p97lrzEvfCtl19z7"
Content-Disposition: inline


--p97lrzEvfCtl19z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 26, 2015 at 10:39:43AM +0100, Charles Keepax wrote:
> The commit 02aa78abec6e ("ASoC: DAPM: Add APIs to create individual DAPM
> controls.") added locking to the snd_soc_dapm_new_control function but
> did not update the call to snd_soc_dapm_new_control in the auto-disable
> mux code, this appears to be because the patches were sent at fairly
> similar times.

Applied, thanks.

--p97lrzEvfCtl19z7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjTvCAAoJECTWi3JdVIfQM4kH/1x5xk3qhb4NnN11nYvWQjOU
8vZIoTHRbzKmaTPhrpLvrh7qAIepKlEOoqKM0hqGsH9jRR/Pj0m9lEE+0wWm4q47
9hfGQEhEFxRaMFudV9bXa7GDnA8s3QxbH/efPmKdrKkULr0sbFvW1tsgEA+TngNp
LNj/A514FSy6eg0rrp2CxttbhTzIUjwh8YUVO0A+E59MM0AS4YCP9ybLtcyLS5M8
TcBVBrASZTA+2Ig7Efur1TxYqW3PiqdSehGYwBVXr/7J+3EaFALQtuKM7X6FuS9n
hzCJhxw5iMo+43eV+sasGDLwuJKN4o8u9o2fdiVa3BPKIwBez7Z1lYg883dyxCs=
=kZ4Y
-----END PGP SIGNATURE-----

--p97lrzEvfCtl19z7--

--===============5109360641800229391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5109360641800229391==--
