From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/2] ALSA: jack: Refactoring for jack
 kctls
Date: Mon, 23 Mar 2015 08:00:31 -0700
Message-ID: <20150323150031.GB14954@sirena.org.uk>
References: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
 <550FDA5B.8020604@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0137976131688266844=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F009A26066D
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 16:00:05 +0100 (CET)
In-Reply-To: <550FDA5B.8020604@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0137976131688266844==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2015 at 10:18:19AM +0100, David Henningsson wrote:

> Hmm, I must have missed this. It's great that you try to implement kctl
> jacks for ASoC, but your actual implementation seems to regress HDA, unle=
ss
> I'm missing something.

> In particular, the phantom jacks currently show up in the kctl jack layer
> only, not in the /dev/input layer, and I prefer to keep it that way in or=
der
> not to pollute the /dev/input layer with phantom jacks.
> But it looks like these will just disappear (?!) with your patch, but I'm
> not entirely sure. Could you elaborate?

We shouldn't be hacking individual drivers to support whatever random
subset of userspace interfaces some system decides it wants to use -
that isn't making anyone happy.  If we want to have the ability to
customize which userspace interfaces appear it seems better to put that
in the core code so individual drivers don't need to worry about it,
=66rom that point of view unifying the interfaces should be progress.

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVECqOAAoJECTWi3JdVIfQqaAH/01P1XwFyIXq2cNawdr/QA+B
zq7P93J8bVDSarQuFZGt5bbKt1c4ULS7XTD2OJJA9A2Gka0+RNIKUy7cV+nycqAF
inLB1mOHjURE73WXSRotKAnp5cPL2iQsfNEkDpG+/VkZlE0EhMMyGqi4t1Z+16Fk
fZ3pq7iPiK9J7V2fkw44UkGEcN5VHvAf/JOMiIRM8USuMSfjnXwdpxorIefe068w
ycU2w824DxbzszrArzfJRZ2tQdsOoioB2lLFz/10ZsjG85gxucpXFXMZBKIhZv7I
ggxv6Z3JDOdoO6q2vgDw6z6N/7jprYznUuAlPKyjuKAG/BURUgNUw+hjaC9rHt8=
=SIov
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

--===============0137976131688266844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0137976131688266844==--
