From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: export
 dapm_kcontrol_set/get_value functions
Date: Fri, 6 Jun 2014 11:24:08 +0530
Message-ID: <20140606055407.GA21128@intel.com>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
 <20140601192649.GQ5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7075875515341717458=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BFF4E26171D
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 08:12:14 +0200 (CEST)
In-Reply-To: <20140601192649.GQ5099@sirena.org.uk>
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
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7075875515341717458==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2014 at 08:26:49PM +0100, Mark Brown wrote:
> On Thu, May 29, 2014 at 03:33:36PM +0530, Vinod Koul wrote:
> > The DSPs like Intel ones use the DPCM to represent the DSP toplogy. So =
when DAPM
> > triggers the widget, the DSP needs to know the kcontrol values and pass=
 on to DSP
> > firmware, so export these for driver use
>=20
> I have to say that I share Lars' concerns with this one, especially for
> the set function (which doesn't quite gel with the description above) -
> it may be that this really is the best solution for the problem but it's
> not entirely clear what the problem is and like Lars says there's some
> other stuff in play here.  If there's something that the core just isn't
> doing that any driver trying to do similar things is going to want we
> should fix the core instead of requring drivers to do work.
Well the problem is that we can't use the current ASoC handlers for platfor=
m side
mixers etc. The current code assumes that mixer is only present in codecs s=
o in
snd_soc_put_volsw() it does snd_soc_update_bits_locked(codec,...) which wont
work for platform side.

Hence we went ahead and did our own handler for platform side but need the
dapm_kcontrol_set/get_value exported out. And yes I wouldn't have bothered =
you
if this was to be kept out of tree, the plan is to get this merged :)

If we go ahead with Lar's series we may not need this, but am yet to test
that bit.

Thanks
--=20
~Vinod

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTkVd/AAoJEHwUBw8lI4NHV1sQAIXbvZG7mR68TA5YSRkGKOEx
IeFaT63cjTZAimPvsWYrWYZJxTrpR9OYEjMVO1MEBKETMKqhw/luNMl1qDJoCNA3
owW94AwwSuCtFfdpzDF8CAT7IpvXYp2jT1ihEA1L8tPcsQ9qDI/uaEUk5M7a/KmV
/8HDyBuB3I3Q047HkhI96yLAP510N0gVQtPUTUvBUA4mH0nLsRBgm3OIUL7JZEwt
DEcChk1U34l9zuJm8CMTAI6LzkqgPwEqcymXlpql4FaQUGbI2kqC1NzaDmwHAxrX
qm9gQlvTByZkgtXpGAMrBEVUAjq24xFsBzUAK7qNkhXcoQUxa+PKGsyqUQIz/7ew
K+7ijV46HmlzaC2yPLxMyVKhRdRDqlOEJOFNQLe4ONGsCmWMMZbfRyCP6Eqy6rCR
bBHRKoAi3AtCjJK2E2yjjoT0QQQUk9EfqXtUGS0o3tmmsQhm4rSIIJqUpN4+CNbg
IL0njCBZ6EscGKdp1SBoZbsTrCsdnMIsEQKSgayETME3HTtBMgVvvKVPpnGeFEJA
Rrat12dZOUxMw54rmoHDgIL/Tj3d20oZzgSwqCr3/jX/mhxaz3igjpoeCP34xcjK
sRCl/MrsgR5nlFcpZmr4ECcJyo48V2goEJJJ18n96V7pJB2i/3Fhx7hcPD3TTAYq
7lravtVvNCobG7SCwdiE
=srmr
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--

--===============7075875515341717458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7075875515341717458==--
