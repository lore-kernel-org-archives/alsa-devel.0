From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add suspend_pre and
 resume_post for Braswell snd_soc_card
Date: Thu, 12 Mar 2015 18:01:48 +0000
Message-ID: <20150312180148.GT28806@sirena.org.uk>
References: <1426045713-1738-1-git-send-email-yao.jin@linux.intel.com>
 <20150311125047.GD28806@sirena.org.uk>
 <5500E346.8020700@linux.intel.com>
 <ABFD875FF5FB574BA706497D987D48D701059B20@RTITMBSV03.realtek.com.tw>
 <550189CF.6020304@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0475558161885262954=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A7F02605E4
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 19:27:49 +0100 (CET)
In-Reply-To: <550189CF.6020304@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "subhransu.s.prusty@intel.com" <subhransu.s.prusty@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mengdong.lin@intel.com" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0475558161885262954==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+Ccw6gpuJ1V99M/T"
Content-Disposition: inline


--+Ccw6gpuJ1V99M/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2015 at 08:42:55PM +0800, Jin, Yao wrote:

> I pull the for-next branch right now and I can see the following rt5670
> patches have been integrated.

> 66454b3 ASoC: rt5670: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
> cc3c340 ASoC: rt5670: export jack suspend/resume APIs
> d3ef705 ASoC: rt5670: Add IRQ function

> Then I build the for-next branch with my patches (reverted before):

> ASoC: Intel: Add suspend_pre and resume_post for Braswell snd_soc_card
> ASoC: Intel: move the jack creation to Braswell machine driver

> The build is successful. So it looks we don't need to resend the patch
> series, just re-applying my patches should be OK.

These are two separate branches, if there's dependencies between the two
branches we need to merge them before applying new patches - I think
that's the missing piece of information here.

--+Ccw6gpuJ1V99M/T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAdSLAAoJECTWi3JdVIfQM1YH/0644qwYKY85eVsd9Jy2op89
bwD3PIE6KIbRDcbKlh0HSsViAdxXQQ141QSvN6Dz0A9V0q9KX4ST0BFoYVuqlXDe
4Mcx0aZstmxi4RWkXFtuoXikPkoBFliittx5Uew9XCKtnbhNuVGm0K0SaAFbJzgU
0YcBKIaJZe5EQAV+LrCrJS6Vq0DVTIKd5XVKTLF3oMogVjlyVhHEKx3QDZzM5uU8
fFlD6HAFoafJxD4XsYp/8RP92XnkL5eAs1+pcZ7BzZhcerhXzpQ/xdVXUVu241Xw
c91Jc7fuRg43/3gbXOmFQtueSXxNRXcSYWsyNMmRjdOt9+oL3XdCf5q5W8O4s8I=
=BNKW
-----END PGP SIGNATURE-----

--+Ccw6gpuJ1V99M/T--

--===============0475558161885262954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0475558161885262954==--
