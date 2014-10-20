From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 4/7] ASoC: Intel: sst: Add IPC handling
Date: Mon, 20 Oct 2014 10:48:08 +0530
Message-ID: <20141020051808.GB28745@intel.com>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-5-git-send-email-vinod.koul@intel.com>
 <20141017120918.GH1820@sirena.org.uk>
 <20141017115524.GS1638@intel.com>
 <20141017135314.GQ1820@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5443570538421575560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AF0D52606B1
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 07:55:10 +0200 (CEST)
In-Reply-To: <20141017135314.GQ1820@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5443570538421575560==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2014 at 03:53:14PM +0200, Mark Brown wrote:
> On Fri, Oct 17, 2014 at 05:25:24PM +0530, Vinod Koul wrote:
> > On Fri, Oct 17, 2014 at 02:09:18PM +0200, Mark Brown wrote:
>=20
> > > Shouldn't this be a dev_err() or something?
>=20
> > Not really.
>=20
> > We get response from FW which cna be short or long. In former there won=
t be
> > anyone waiting as all blocked ones are large.
> > We cant distiguish between the two thats why we log debug message here.=
 If
> > its real then finally the message will timeout and we would see that as
> > error. Yes this is limiation in IPC.
> > Putting this as err makes log very noisy :(
>=20
> OK, perhaps a comment explaining that the firmware generates lots of
> false positives might be in order?
Sure, that sound okay to me.
I will send that in fixes for these

--=20
~Vinod

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJURJsQAAoJEHwUBw8lI4NH9RwP/2VMj3SXzrOLw/Z4pDuJCTfF
HsizjcB61Xc2AiVDl0gcxoUIN9pxNZtFQ0MweCLkwFpF7kRbLeqkauQELISGzYzv
tFTqYestA98DB73QaDgfRnUHskpw7KDOB0kOeC2gxXRihYGID2QVwJU5U8kA/0Yz
ZeEXHnzruZV+29BQ0t2iLG1/JgdXwsDCvlsbFERey8F712LTNhq5F3OIKLm0k0CV
0pVnUY3j/5zRfQy+FbZVOks/u8iPQChEDRWw0jQ7dTDAD2Gmc3nV+VBnHdTHd9Zn
0fu0cWFg7BJ90ikTPwz4rNWuInRnXr0h34IPyk53x+B365lyuJCXcpqeR+HQ1O7a
BJWEpGxSf2xk53Fi1HLlLWdhcBsNtLzCzbTOlsfNLoCMLocTPAWpo+8RLsnmNQ8u
QdsJXJw9eydAvmeDaGyrYIxQpid8zHjTtetYt/ZAC/DyJL9keH4m8ZSST6SgCTfH
4PDmVJAeBeAaXtXaLhlhywXqx0GbQxSNvgl6RuxapO92h7H4crXJOgr8W6Pg3W8f
lGmqLYLc0J+BBJI2/p2OH8Xs4UTnBQBdmy/gHa81ZPVTzYJx2hlKWzitC7CwjzXf
gAdV4qzk2xfsp+THmRk5a+BWu85maI0nRnHdXmaQOUNzSKghmSXY4IlbbuGljFFs
/LoGB2CuAHBCbGz5t0bt
=pOic
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--===============5443570538421575560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5443570538421575560==--
