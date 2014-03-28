From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3 v2] ASoC: ak4104: add regulator
	consumer support
Date: Fri, 28 Mar 2014 11:23:45 +0000
Message-ID: <20140328112345.GZ30768@sirena.org.uk>
References: <1395952936-10670-1-git-send-email-zonque@gmail.com>
 <1395952936-10670-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1638029022649726186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FB7B261987
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 12:24:01 +0100 (CET)
In-Reply-To: <1395952936-10670-2-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1638029022649726186==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qrotSzihSRAsrOtf"
Content-Disposition: inline


--qrotSzihSRAsrOtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 09:42:15PM +0100, Daniel Mack wrote:
> The AK4104 has only one power supply, called VDD. Enable it as long as
> the codec is in use.

This should update the DT binding too.  Also it seems we still have a
machine driver for Raumfeld using this which doesn't set full
constraints and isn't being updated here so would be broken as far as I
can tell.

--qrotSzihSRAsrOtf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNVu+AAoJELSic+t+oim9584P/33z1xhEKOT7QUbu3BigBtji
hlRNzyGxkNWRpip8UYTivbx8jZqX9alOgKaIXxIaW8PccthMJJ3+0TJlJz9DD/+0
1SAfm1xa/jvXz02/Eq0pYmDykngwi9hi9zOC7NuQ1RUznno2Cv1Qiu1z/V85RDMC
l08wIzVwBfkDnOxide6zUtFrLVaewJhutkAc9V0cR/IPR7qNdgDz2qg1mBAnooib
bSPL5H5j4avQ4r6w/ONdl6jgB6NwKujhiVqu+Z9yiNoj2xRIQQMuLo5dN8IueNdc
t44O7qniTdRbNe/DG2mOmgsZ24FQjLknJw6GC23FzUjtfdUcOLAtGCmecAOTGDla
VMx9RwW0ntuZlXNqcrOPK2IUvwdu0llufF7WZj9R0AdIg7ZXn0tXqI9Osytx2DF7
Wjpd2cF+kqUtosuVJet/Mlb7AJH9ARtl10e13Mq8dJ8UJOdfnzuSVaj5XmopSPAi
gqOHnGgHlaC6gDfYDNSPB8kk24DVlxdjgaDuoa/YKORmHOFhy/NT6v8iw9fKm2WN
mUZbCqpR95nKAyhcI+jbe+RDbCJtEC5hH7XnN1PAQAPzettipHgI8aqSKSygfQgi
26T2X1KyNFhi1sXpChZlMcIdHtcPt4VIFm6kkmlE8wxeQBsEZ0QmUBVPUSly0Elf
Z1HTOz05OuNDHH9/lGE1
=iUvK
-----END PGP SIGNATURE-----

--qrotSzihSRAsrOtf--

--===============1638029022649726186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1638029022649726186==--
