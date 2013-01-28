From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-compress: Add support for not
 memory mapped DSPs
Date: Mon, 28 Jan 2013 12:56:13 +0800
Message-ID: <20130128045609.GA5683@opensource.wolfsonmicro.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130128040416.GJ26562@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4798415226791915901=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7931B2650C5
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 05:56:25 +0100 (CET)
In-Reply-To: <20130128040416.GJ26562@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4798415226791915901==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 27, 2013 at 08:04:16PM -0800, Vinod Koul wrote:

> How about:
> 	compr->ops = &soc_compr_ops;
> 	if (platform->driver->compr_ops && !platform->driver->compr_ops->copy)
> 		compr->ops->copy = NULL;

> That way you set it to null for those who doent implement this and would called
> for drivers who implement this.

We'd need to take a copy of it in case we have a system with a mix of
both styles.

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBgThAAoJELSic+t+oim9AOgP/i/MN+yq/AvYZKgGJe1bcMjs
r064uM46HfBu4PWQDCgusLoNdxrKxoliV+EMbdNfmogklZZIW7cE6TFSTrZftuG4
R0qZPnUhEwMC6/6AOusDWv6I9qec0wawQ+BF/55j2wn8fbDFtJE57xGpLtW16WUL
uZvqGhQ8uwiwUkreTWyN6okJpCAakheKb+1Gxgfn1cMZXe34RjwLUXW+KtRnDC/D
KYemCXJFiZ2cchwlQY/mwope5UdiDsVQSN4pIdVTzO59YI8msuGI3njrSaFHMzBS
wD0lr2mN9fkLqB8VfcG38rYjmHxpcP8blI5NoIBDU/IqYaL/oIsaYVzhfzsePku3
2MeVthhzcwP9f/n2IFNBr9LoOWDkY36a55rCynNu0w0/ijhdXLPORJtZs/OEQ7n0
s4R4fCMWVU+PHwLiRgPszEqjKGlCLC3Vxx/jGLS1uCNnQVrbxODMHit8udQNVlGD
3irWhAs6ECwqj+hjVj1YtScTLMEi3CtrBEyWYITFd/USg97yG27CEWbbOH+JwOm0
GplEgf9RmPcbeoN4Crg/fbSSZUkS3Xbw1v2mNQ4wTapmeMgyckG5Sf7F1BeHbM0h
M8GcQHgVoWLjAyJytrUSkCX6pkuCcpCzUh3KTXkk+tppUa/NU184KyLnIIW2Eg7Y
pco6KVU6yzuXJYThlUkP
=IKRu
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

--===============4798415226791915901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4798415226791915901==--
