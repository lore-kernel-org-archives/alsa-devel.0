From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 11/11] ASoC: topology: ABI - Add voice
 wake up flag for DAI links
Date: Fri, 4 Nov 2016 11:36:16 -0600
Message-ID: <20161104173616.iqeuhkm7wwfzc5e2@sirena.org.uk>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
 <4ec58db3621474cd8acf664483b18c30628f6cad.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7139029624398087195=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1637E2674D6
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:36:22 +0100 (CET)
In-Reply-To: <4ec58db3621474cd8acf664483b18c30628f6cad.1478071138.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7139029624398087195==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f277mnh3bie66jst"
Content-Disposition: inline


--f277mnh3bie66jst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 01:05:32AM +0800, mengdong.lin@linux.intel.com wrot=
e:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>=20
> Add a new flag bit SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP to link flags.
> If a link is used for voice wake up, users can set this flag bit and
> topology will set the link's 'ignore_suspend' to true.

So, as we discussed in person yesterday I'm not 100% convinced about the
name here - there are other applications that might want to use this
facility like other triggers or some sort of passthrough monitoring.
I'm drawing a bit of blank on better names right now...  I'm going to
apply this but we should continue to think about renaming.

--f277mnh3bie66jst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYHMcPAAoJECTWi3JdVIfQqIAH/2t4VxwdgvJzrVSnLnLTK4KJ
PPxvAGtFG1BWlipIetJ3XmD/ltWofe8DQcwumDypSC0ci68zO7DNgJyS62yF9LHm
jnt9OE4dWinAJPZIGQocTV3i/UvTtsxej19pBkmTOH98OAG7rlAP+AFiS/b8LtcK
242YHjQpRXSdeKk532P8kGFT5pvn4I46d3RyD926C1rRmQ7s0ppZO8ra220wKC1d
x2qbv/fR3ZDblDMFq5Ej2VMkVsDtTF345dMqe2nYyYiNkSy9gW63BjGX4gudJiww
iIGVk6Ht2nzP0dOMz2hMd4GPgb1FsK5zc5JXSkuJjIhRYU0wk1jJDx9CRfZu2Tg=
=nIAg
-----END PGP SIGNATURE-----

--f277mnh3bie66jst--

--===============7139029624398087195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7139029624398087195==--
