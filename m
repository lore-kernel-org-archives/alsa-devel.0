From: Mark Brown <broonie@kernel.org>
Subject: Re: [v2 1/5] ASoC: Intel: mrfld - add the dsp sst
	driver
Date: Tue, 19 Aug 2014 11:11:17 -0500
Message-ID: <20140819161117.GJ24407@sirena.org.uk>
References: <1408444627-28906-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408444627-28906-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1508064909981007742=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80AE6261600
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 18:12:34 +0200 (CEST)
In-Reply-To: <1408444627-28906-2-git-send-email-subhransu.s.prusty@intel.com>
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


--===============1508064909981007742==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2014 at 04:07:03PM +0530, Subhransu S. Prusty wrote:

>  sound/soc/intel/sst/sst.c                 | 443 ++++++++++++++
>  sound/soc/intel/sst/sst.h                 | 654 ++++++++++++++++++++
>  sound/soc/intel/sst/sst_drv_interface.c   | 475 +++++++++++++++
>  sound/soc/intel/sst/sst_ipc.c             | 373 ++++++++++++
>  sound/soc/intel/sst/sst_loader.c          | 975 ++++++++++++++++++++++++++++++
>  sound/soc/intel/sst/sst_pvt.c             | 207 +++++++
>  sound/soc/intel/sst/sst_stream.c          | 526 ++++++++++++++++
>  11 files changed, 3696 insertions(+)

As I indicated last time please split this up into smaller patches, for
example one per file.  This is an enormous amount of code to look at in
a single commit which is really going to slow down review.

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT83ciAAoJELSic+t+oim9j2wP/2S9ZFXeigvqRbsRr7eSRKYA
FNhV6vT/IYgTTClgs3b3ALDajBw5L/738D2EM4dMZL0KNQC2w7K3xI0ggyrhl6bu
ZHjeu6x1Rkkiu/bwvSB7/9payq9erGquKJLjpuPLTTORMmyAYeirl4v53fpzVTMK
O9cGuDJT/QhXafZKiS+Vp5aoubg43T32K6aaPMLZijRNn/6sUBQ5qfPCZzQ75+nK
6HDgkR6bKXHLOO85NAhgneHwYJNktswPyBWiUOcwDDSNel4Nd392SwiUteFtqULz
5kQ4y6se057FXTWXXF+Yni63ksiGz6Drh/ihIX4dY9Xws6YkHDqH0p1tt9I0yZlr
+i1B7/in9VzibJZyOiKOGjUQl5+xfJTuH8KSMP/doDqymxp8dcm7uPYShxA00giX
laQaNpwH4jEYvMK50kTRJ9oj4CjAbMxxDhZ4PnOVO4LeluYagiZ6a3j4xox8LVil
7RJIRzad9OInjxKvuuyx6hpmUdsd/rPCZzS0duhZLE07OVbXsq4blQOBkvEnKPqo
xIxHIXPecDlU9eBDxXPuB7+tCnHD3ZcMQcgAmR08FKVIEvmHABpfwpzCaHPQYlEW
L+KgIynyh7a/B81a3Tm9KB4bmAph5q7SHKoBFTn5BV11fObZ2upb9HYC3HA5azba
PLX2aPZSsqHtS9rhCJUS
=MZKH
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--

--===============1508064909981007742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1508064909981007742==--
