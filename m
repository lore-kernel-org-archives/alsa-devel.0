From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 01/16] ASoC: Intel: Skylake: Update DMIC
 DAIs and capabilities
Date: Wed, 2 Dec 2015 10:23:59 +0530
Message-ID: <20151202045359.GC1854@localhost>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
 <1448703121-5831-2-git-send-email-vinod.koul@intel.com>
 <20151201213251.GX1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2555749271940754185=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 40C942614CB
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 05:51:03 +0100 (CET)
In-Reply-To: <20151201213251.GX1929@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2555749271940754185==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2015 at 09:32:51PM +0000, Mark Brown wrote:
> On Sat, Nov 28, 2015 at 03:01:46PM +0530, Vinod Koul wrote:
>=20
> >  #define HDA_MONO 1
> >  #define HDA_STEREO 2
> > +#define HDA_QUAD 4
>=20
> Are these defines really helping clarify things?

hmm, that is a good point :) Since we already had 1, 2 4 seems a logical
choice. I dont mind either way

--=20
~Vinod

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXnlnAAoJEHwUBw8lI4NHuIQP/34K4Z5leDjjK63OP+Bg7avq
GhyeFpir5m7J9ovj8ec2hF/dnOfTdsDDA4Repm0xmH0CtFIg/IpXDPs3U/s5iCie
K91wLHIBIGqfwBf9ZhP+IJ0lYyXYNm7qIwxors9CzFQY4V0y3DO40Zu/yO/3uRWa
l/k86AWPr5akvd7MTizgK35/9jI1IlSVRbdANAMmv4QT8Mm7fTXKvOHU8iTT9XZx
0rXErwItgpZg6oXNIYQjkP7MqVhJ1FUH0kignlhIkEBPfwGKJV13vsa+caK6KjCo
g4+0Zk6qspflJ6s7Z6iwhkDoF9vEUFxFEW1QjRdIc77pWgRShThtp3EmPPOdu76J
IPvQr5dFRn8NZ2ECsprim0vwzgbo6FWecqopKZLXQeH8ZYn5uXp4dlVzNwV5mK6V
3V/cYuSPZBZJWrHWMQBeRosJ3lIDQgKfmtapfuR4C5hUR/PVMX4ZvbzCVc5Iq7Pm
IQzk7UbjFpSa0W8Iu+DNhrV9zIxMY9ZfEsRoe3DMTGxPC36UegmuC+7XBcmIU/8I
RBW02ia9d35ABveg63vkN5oM4pcNfD9DiUbb24wUiLGs5oVmw8h3+6ArB7Np5Izm
5hu+MaYQcQOdk6vdbM+z+zkbwwpXVLTGSv7K/l7j+tpEz2fEhPvNT3nUwM944O0j
5bwyYJGz8SSRDYNID135
=1wCj
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--===============2555749271940754185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2555749271940754185==--
