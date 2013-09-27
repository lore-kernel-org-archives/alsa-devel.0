From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoc: kirkwood: Extend the min and max
 number of bytes per period
Date: Fri, 27 Sep 2013 15:42:26 +0100
Message-ID: <20130927144226.GJ19304@sirena.org.uk>
References: <20130919112043.5ad16147@armhf>
 <20130926102408.GE19304@sirena.org.uk>
 <20130926102840.GP12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1283924569996965336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CAF11265098
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 16:42:37 +0200 (CEST)
In-Reply-To: <20130926102840.GP12758@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1283924569996965336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ZSpXV6RUUo6PuQK"
Content-Disposition: inline


--0ZSpXV6RUUo6PuQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2013 at 11:28:40AM +0100, Russell King - ARM Linux wrote:

> The values I have for these in my tree are:

> #define KIRKWOOD_SND_MIN_PERIODS                2
> #define KIRKWOOD_SND_MAX_PERIODS                16
> #define KIRKWOOD_SND_MIN_PERIOD_BYTES           256
> #define KIRKWOOD_SND_MAX_PERIOD_BYTES           0x100000
> #define KIRKWOOD_SND_MAX_BUFFER_BYTES           0x100000

> which are partly based on patches applied to Rabeeh's kernel, and then
> further adjusted.  Yes, the max period bytes won't be reachable since
> the minimum period will cause it to be half the max buffer bytes.

Those don't look implausible, obviously it'd be pretty CPU intensive
application that pushed down to the minima but perhaps someone is
willing to pay the cost.  As you say the maximum buffer might want
tweaking (or perhaps the maximum period bytes).

--0ZSpXV6RUUo6PuQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRZlPAAoJELSic+t+oim9zfMQAJ12+BS2KYZkMEcc6vgSkCaR
ON9CxOqa+YxJdLJ60Q7o7Eews8z7CTC1wAduQZkKvSzFl6f+fmjWJsF1UgXfa04g
emh3ILIsWDOsViycSEPWIJ3WjOo8aurESEyw7QrJyTmtfc41m+Z2Rr2eSOHGdHl+
LfZcu0UBFzZw+X78JFdko+tut/ZUV/olUMJS6qyGjlu0qQfEgixX7EAv0uFQqxC4
SkC/l9xbGC+gIwPlarbk9lLYnxlRtWvANbSwb3v6uB/oMxvoXLsCeVaQfioe3Zu3
c4A+HH3I+aWl8qeTMI5SgKAzdodLvIKVer0NpzzI9nkkwL9j9QC454IxtNbHSqpS
yl7XROdnXpx012EKZDxWjCbocaVOqrQWeyDaJ2h30Issr38V+CTccgr/pzrupuiv
+8Z7rmga+uyRtT9oo4TrqVdTNM7qj1OfRkCmTf/7fuU8pKJu6wVx3sgqJY/HJsqh
7zHyFKLlYHNx5DH2DrC6JkT7r4D2K1bkZcjFK4p8HXj5odC+n1ZEooxJwhp60n1i
ZNh4HbsJjw8UtpSSLyAGSPpDuOCcCNzcnQ9kIVkoHRl/kTt+rxP+Qo+d5alIVwPl
IxpfBfbP8vHjAIuDPVbZQB7r4Jfwzqy8mXuYb1oDGrEfF0CZ3KmGl3SH27PLu2B3
OqXe/KoJSe40Cs4y8XQn
=EBJC
-----END PGP SIGNATURE-----

--0ZSpXV6RUUo6PuQK--

--===============1283924569996965336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1283924569996965336==--
