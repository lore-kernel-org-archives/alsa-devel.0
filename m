From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 2/2] ASoC: Intel: Use DMI name for sound
 card long name in Broadwell machine driver
Date: Wed, 18 Jan 2017 22:14:59 +0530
Message-ID: <20170118164459.GF3573@localhost>
References: <cover.1484381178.git.mengdong.lin@linux.intel.com>
 <7d5a432b03df6298e85b2af1f520e48821ada648.1484381178.git.mengdong.lin@linux.intel.com>
 <20170117175636.laoybapp7jqtpzno@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8082951157193783228=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 74D772669EA
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 17:44:53 +0100 (CET)
In-Reply-To: <20170117175636.laoybapp7jqtpzno@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8082951157193783228==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 05:56:36PM +0000, Mark Brown wrote:
> On Sat, Jan 14, 2017 at 04:13:09PM +0800, mengdong.lin@linux.intel.com wr=
ote:
> > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> >=20
> > Intel Broadwell machine driver will call API snd_soc_set_dmi_name() to
> > use DMI info to make the sound card long name.
>=20
> I guess we'll see further patches for other machine drivers?

Yes that's the idea. At least we will convert the Skylake and Broxton ones,
after the current submitted patches and DP-MST ones are merged.

Thanks
--=20
~Vinod

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYf5uLAAoJEHwUBw8lI4NHmTkQAIM2CV7j3Db0sejykx9jGvYH
3OzXH89lag33vhk1SbjUjSFL5woS/Lx92XIZqqx3JYZ5lRNUCxCDM3EKLB3fIPh5
wjmv/6Gfa4L0ZXKFAieVgHL+9fkzdIrRTG2eMKYHoxH5SHUODGSau9XekzKFNGB8
yhlw7CoASmR7dUVaLQX8X8NKteIL5ZYYuJNYas3OSkAUcA3jqDOBREAvEnvzvAco
B4J16ns8uHYKmj7dsIhDJjhue7OsCgKWGrIOPY5ka/ONu8GEdwXEEzClkkFDGvZs
MQBD7fwLHTvaz/Mvwyey6+e9Q3Buz8tBgfYkxr967JvbLZ1CE51DrMrlgqScBT4c
tmrMilQtrre1iT0vLfEJ7vedYLGhCw6c2wTebhwmVxk8y5jC0OYry/RluSnwbEQs
TgVf9QK4+ceUXeij7gKthOXDRwZDspBzloKCoR6LPa4BVyk9FpO82bhcT3IO/E8Y
aSOexBb5SXEmywwxO9itp0pIlSWOHYJnlrjt95+v/xRmXCWZB+uipQ8ekUb20aFW
xSWosAVuvXB9ApRymvsWPPDIfP99sQKs4w4MDUJKI+onWgBfbEuxBbc1SMv77zmX
cxxsMYpoOdI903Kgcy+Vnf/bG7Qqrw8yYoXB3WIxFTfsAg6DlXzVN+zR+ojORy/0
ROh8G3o1MAFBxl1RZBgO
=M3Mh
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--

--===============8082951157193783228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8082951157193783228==--
