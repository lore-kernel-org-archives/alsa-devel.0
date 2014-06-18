From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v3] ASoC: davinci-mcasp: set up channel
 status bits for S/PDIF mode
Date: Wed, 18 Jun 2014 17:14:50 +0200
Message-ID: <53A1ACEA.8000004@zonque.org>
References: <1395916060-16234-1-git-send-email-zonque@gmail.com>
 <20140327131823.GM30768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2618812076225114692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 41EDC26109F
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 17:14:52 +0200 (CEST)
In-Reply-To: <20140327131823.GM30768@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2618812076225114692==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EaeURLn4v5vGJlaXWTsphmRL6WKnxCbug"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EaeURLn4v5vGJlaXWTsphmRL6WKnxCbug
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2014 02:18 PM, Mark Brown wrote:
> On Thu, Mar 27, 2014 at 11:27:40AM +0100, Daniel Mack wrote:
>> In DIT (S/PDIF) mode, program the transmitted user bits to reflect the=

>> configured sample rate, along with some other details.
>=20
> Applied, thanks.
>=20

Strange - this one's also missing in mainline? No big deal, I can resend
if you want me to. I just want to understand what happened :)


Thanks,
Daniel


--EaeURLn4v5vGJlaXWTsphmRL6WKnxCbug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJToazqAAoJELphMRr8Y1QkjvYQAKHr/ZK8z5A9tc36USI2ZjuL
sHg6vfmh6FOP5OHYj0SJ63oKazLG+lbZGk/BpXRd8IXas75SnO/g1LVkprhyisBP
PNjeD1UAvKyEKE/Smgz2J7yiiJC90dlyhuF/PVq9s6XZ0WORJ60wHIt23ARAHIea
jTwT9yk5GaGCqkzoJfIzVKPxfUYNy1gMGkVxza51ZBCIeZjrd3twAR1uygLsOEey
xBsqgamiJ3MrkC2c7PRqCzeISInO6C/AOtCDXUipLka86lmjE5y6ih4/qdtYqGMR
S4omjl739AWiBDsJZnqBMiSLKYY2HIvev7E0RowA1cg18cM0EA6Tctmlu0hp1pzi
xTv7psyL9wjaULwWeUT+hcTxPxBRHpGkixFo9t5XgVveNUUdbPDDTW0xsPh3jufH
1YtPv2kzTws9ZJK3ueVfm3MemyvqQZn4silL3rS0cwIPdejnF38VE9sPOpXA7+BV
Z9SnRVlSZWBF4tjGyJKeeEGmj0fB9cCYzCNy2a05/MB2XOt7oQiRu+/gZoxJUIVK
GqAOl9VlmN5UgCne67+assBm+AuU9Q2GXPDXKAVCsc/zBidGb/PLEAA7lrql7iRK
cvXmPR4pulrAMsDvcMlpjfK1wOpNspfZgT+MMFuXhV2K2AIue/p36IjlXVTlmWeQ
JwczQmuXDdfXQ1BN+tZj
=Sxia
-----END PGP SIGNATURE-----

--EaeURLn4v5vGJlaXWTsphmRL6WKnxCbug--

--===============2618812076225114692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2618812076225114692==--
