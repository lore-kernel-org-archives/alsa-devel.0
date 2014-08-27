From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 10/11] ASoC: mfld-compress: Use dedicated
 function instead of ioctl
Date: Wed, 27 Aug 2014 21:51:31 +0100
Message-ID: <20140827205131.GB17528@sirena.org.uk>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-11-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2640523844271867686=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F00D2681D2
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 22:53:28 +0200 (CEST)
In-Reply-To: <1408625450-32315-11-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2640523844271867686==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M0hVCpAGwZMf/OPT"
Content-Disposition: inline


--M0hVCpAGwZMf/OPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 06:20:49PM +0530, Subhransu S. Prusty wrote:
> Also pass sst device as an argument to function pointer prototypes of
> compr_ops. This will be used to derive sst driver context.

Applied, thanks.

--M0hVCpAGwZMf/OPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/kTPAAoJELSic+t+oim9HswP/14zIx10OkN6CURnkxdFL2Y4
vUpz8hpgcsQ4BZR5WpIdlRbgFZTYUni7u+5/l9bMgtuTL3YR2JmNlywC8PsdSXs2
RMj+LvQa95K+gBte9HyccZXwqWWjAHDh+GSwIwAWzexK3VK0YrcKXzfCRL4yZ5nI
7PA/th9JR/3VljmBBDy3lMSj8MrQMHZ2omjWDbDxROFBzpG+XwnX+9gaAFW8etII
jSwQPMSSKSc5gO7I4Wmdo9PjbV24cW9RKnnEkbuE3vX+eJlsR007CMq011HYKpS+
6b9CjFQ+riNbiC3OmX5oGnk6JDj8665gMO6DZnYibNQbFavldonXgerELM3W4NyF
Q7MfDpLOOPlLim9DoJTno/SB2dtElWT4rDwZE7oK5gvjAupI3k+6fXyVSI+Ries0
x3MMGjgzrBv39h5SbIRwyjLw93yi48cFAbdXKymcss9OpUNlZr5iwTxMNKpX71fD
rWX96o8U4X1saPyZdF9nE480poSgLlbJdzKLaE81dz5T+x99Gacce6J+Ku/IjFtq
R7zPFeJ0wN66DQnedVrxzleTzcokjA4eAMqHmvvD7iYgeat5kxDuKNbS2PYC8Vqy
V5n7l1K4/JClPSBV2DD6o0f2STPhXLbEEMW5SxePB5m33BYH/rMgZ2hoxJPur8Z+
+rfG55UTYHCkil0jxa22
=634S
-----END PGP SIGNATURE-----

--M0hVCpAGwZMf/OPT--

--===============2640523844271867686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2640523844271867686==--
