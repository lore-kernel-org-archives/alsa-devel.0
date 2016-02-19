From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Fix setting of stream
 rates, rate_min and rate_max
Date: Sat, 20 Feb 2016 01:16:52 +0900
Message-ID: <20160219161651.GW18327@sirena.org.uk>
References: <1455603146-6138-1-git-send-email-mengdong.lin@linux.intel.com>
 <201602161403.uifzZpWI%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0219018164312192515=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69DB526529F
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:29:42 +0100 (CET)
In-Reply-To: <201602161403.uifzZpWI%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, vinod.koul@intel.com, hardik.t.shah@intel.com, liam.r.girdwood@linux.intel.com, lars@metafoo.de, kbuild-all@01.org, mengdong.lin@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0219018164312192515==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3wyj3Xt2kUWLNC5K"
Content-Disposition: inline


--3wyj3Xt2kUWLNC5K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 02:27:32PM +0800, kbuild test robot wrote:

>    sound/soc/soc-topology.c: In function 'set_stream_info':
> >> sound/soc/soc-topology.c:1588:1: warning: no return statement in function returning non-void [-Wreturn-type]
>     }
>     ^

This is a real bug that 0day has identified.

--3wyj3Xt2kUWLNC5K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxz/yAAoJECTWi3JdVIfQItMH/0xp9YFU44SOcjKmAlHh7oGf
AAi3FeKFjBtbfpN8mNFcNr/3W31KF3Lxepw46HAwvEhrEU+JUrmjoNKamQ9HUdme
UQwFPBV8Ax3E17RB9nS28dzmBl+eC/Up0QI1FH05YWBvK4/Q8IwPp7RO54YnoPXz
LcqyljgngSWPSCojRx3edusgi5Z4+bcnZOlQzd/NHKrRdDoQz4Js8OoOM5XuBBK5
GNidkIWJPwpD+A2cBoptmAXtcWixXljtZ7OKemUUdHbpNfQMq+ELumUYSvH2Du1o
6GltdmU6q4nkYNA8IKFk2sxFy19eh3kkxcI9m2v3iNkBDSO8tqcr1IXKhDLg0SU=
=DnBQ
-----END PGP SIGNATURE-----

--3wyj3Xt2kUWLNC5K--

--===============0219018164312192515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0219018164312192515==--
