From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/4] ASoC: Intel: Skylake: Parse manifest
	data
Date: Tue, 23 Aug 2016 09:32:31 +0530
Message-ID: <20160823040231.GV2890@localhost>
References: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
 <1470985193-10680-5-git-send-email-vinod.koul@intel.com>
 <20160822174714.GV22076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4801115766948038219=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 08D4C266A6F
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 05:54:38 +0200 (CEST)
In-Reply-To: <20160822174714.GV22076@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4801115766948038219==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2016 at 06:47:14PM +0100, Mark Brown wrote:
> On Fri, Aug 12, 2016 at 12:29:53PM +0530, Vinod Koul wrote:
> > From: Shreyas NC <shreyas.nc@intel.com>
> >=20
> > Topology manifest has lib names and lib count info. So,
> > define tokens to represent module private data and parse
> > these tokens to fill up the manifest structure in the driver
> > accordingly.
>=20
> This doesn't apply against current code, please check and resend.

Surpised about that. I typically send againt your topic/intel.
Any other changes merged shouldn't have conflicted.

I have reapplied and sent again now.

Thanks
--=20
~Vinod

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXu8rXAAoJEHwUBw8lI4NH568P/1il9CQm4xNssGVDhr06Wsq1
nEf30qGEMfv+YhSghLUW44IdNHrx5iEkBh35Hu7aEOkSh81JJOc0U0X8Yv/ElMoV
wiQ1ppaLGpssGhkoWLeXd0T6dj+Ml543Drc7GiD/STSilffiblRqmflPmDwLM4HF
5vN1mwl3+U19s/M1y7nS+Whk+lOca4GPvgxBClit7/kj3SaMkpQCswFi5wFmtJfg
9HlGpJEsZtAVJYrpKGBX1C0I6QVgufBqD6shc+q0B6LB4fVzfiXV+c1M3nCtSMvd
BBUKxDTWiPcCAH4W2MgL8qPGTMD26mmN+P5KDO3R16/LKShhHDcLane2SLkJMvgn
j2PqCFUP+jdDVnbYl7g+w55PDQE+ksmOjhfD/rYQuCc7r7T862to2L1Hfl6QkofW
gk6CAMCk2cpnIR8IK1T/aLD5VMFwBn1Vue8crdyKNfeczDIk+D4qQdfzdlaQhgMI
VX8/kHzQBEhGVfJFkNpovPDPbwPwm5bLG9GqpEqVVX72XU30c1zkQ8UU3iesBzBf
5P4B4iL+YMax+LFHdV3cRDEnolfcmGtg2OkZnzbfeg7c76aVs+QMjo6i6RHc/0JA
V7rhT6gLV3+aM/lMgPKWjflehUnWxAi/LZ4+dSWfkDjIQmlYCq0mA/UV9ajThCO7
YQWo3E0LArvogAimHQqi
=EwPN
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

--===============4801115766948038219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4801115766948038219==--
