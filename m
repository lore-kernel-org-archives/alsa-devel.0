From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ASoC: Intel: sst: add runtime power
 management handling
Date: Fri, 31 Oct 2014 11:14:31 +0530
Message-ID: <20141031054430.GH28745@intel.com>
References: <1414645736-24426-1-git-send-email-vinod.koul@intel.com>
 <1414645736-24426-3-git-send-email-vinod.koul@intel.com>
 <20141030180609.GG18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8678712295306244442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 95E4C26068C
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 07:25:46 +0100 (CET)
In-Reply-To: <20141030180609.GG18557@sirena.org.uk>
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


--===============8678712295306244442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 06:06:09PM +0000, Mark Brown wrote:
> On Thu, Oct 30, 2014 at 10:38:55AM +0530, Vinod Koul wrote:
>=20
> > +	ret =3D sst_prepare_and_post_msg(sst, SST_TASK_ID_MEDIA, IPC_CMD,
> > +			IPC_PREP_D3, PIPE_RSVD, 0, NULL, NULL,
> > +			true, true, false, true);
> > +
> > +	if (ret < 0) {
> > +		dev_err(sst->dev, "not suspending FW!!!");
> > +		return -EIO;
>=20
> Better to print and pass back the actual error code we got.
OK

>=20
> > +	dev_info(dev, "runtime_suspend called\n");
> > +	if (ctx->sst_state =3D=3D SST_RESET) {
>=20
> Drop this down to a dev_dbg() or remove it please (and some others later
> on).
Oh yes, did remove some will celanup others
>=20
> > +		dev_dbg(dev, "LPE is already in RESET state, No action");
>=20
> Missing \n.
>=20
> > +		return 0;
> > +	}
> > +	/*save fw context*/
>=20
> /* Upstream comment style please */
Sure will check these

Thanks
--=20
~Vinod

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUUyG+AAoJEHwUBw8lI4NHeEIP+QGvJyBlYyacYtmQgWmHDEtz
MriFLOVfUQKs6IX0IHT645xFfUGNpm+xSAFognrcWD/i30m0JW4Ri2SSupAB0gCd
jV4JkreuJCGh37xqpv0Ka9NB1r/N6tY3ORNKY2/1K+HgvLvI8QHUINfdW11fsTGq
aqjEW/Qumecr7IhBen2Ner4qxnjLgO+4mjhwl0MHIPtYkXQQzZwunAbGeGbSK7KQ
4XP1baa6Oh2SzDHOr34NOAu8pXM9QwmBOpBSYaiAfxeuSKtq6bm5czhecNAX/k52
jANmWjm5/gGmeRWrF/R/qXvFyjFB3515kAvKqFpNLDTEQqokHZqOMofiXZBHMKmT
qh34FMmNakxTG7C0gzaLytb/x9R2v55J0n/QaPcMRkJSoBupqK4JEi9YDjQ7T84Z
qMhQSTsir3HrmfSEcKVPlDqQtACnpjVMY036nCEHLFfmf4tD/Fnp+haa+bJSCmSc
svgblIgcHecQUOt2bu80GjmPRv0/1EWEsAJ0/tMHykbZagY3nrjxG9fI51jjvEPz
mzKySQuHBCx4ss7rD2lmrYfsxS/cgOVoM4nk6hM0ISwttssOrUdQOhvJe7VDDnWL
Te7jqh6eugxIL1xEpOv/1zONUxOY8XzWUhrH3uBaTdasbpwCRk8ewDJrqArAiZ3l
twnz/gRDSzsMM6VG1exQ
=rlWq
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--

--===============8678712295306244442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8678712295306244442==--
