From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 06/16] ASoC: Intel: Skylake: Add support
 for Load/Unload IPCs
Date: Wed, 2 Dec 2015 10:37:02 +0530
Message-ID: <20151202050702.GD1854@localhost>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
 <1448703121-5831-7-git-send-email-vinod.koul@intel.com>
 <20151201225854.GZ1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3728761244575946681=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B0A49261737
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 06:04:06 +0100 (CET)
In-Reply-To: <20151201225854.GZ1929@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3728761244575946681==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2015 at 10:58:54PM +0000, Mark Brown wrote:
> On Sat, Nov 28, 2015 at 03:01:51PM +0530, Vinod Koul wrote:
>=20
> > Some firmware modules can be loaded and unloaded to/from DSP.
> > This can be done by invoking IPCs Load module and unload module
> > respectively. So this patch starts this by adding support for
> > these IPCs
>=20
> In what way does it do this?

By adding skl_ipc_load_modules and skl_ipc_unload_modules helpers to send
these IPCs to DSP

>=20
> > +int skl_ipc_load_modules(struct sst_generic_ipc *ipc,
> > +				u8 module_cnt, void *data)
> > +{
> > +	struct skl_ipc_header header =3D {0};
> > +	u64 *ipc_header =3D (u64 *)(&header);
> > +	int ret;
> > +
> > +	header.primary =3D IPC_MSG_TARGET(IPC_FW_GEN_MSG);
> > +	header.primary |=3D IPC_MSG_DIR(IPC_MSG_REQUEST);
> > +	header.primary |=3D IPC_GLB_TYPE(IPC_GLB_LOAD_MULTIPLE_MODS);
> > +	header.primary |=3D IPC_LOAD_MODULE_CNT(module_cnt);
> > +
> > +	ret =3D sst_ipc_tx_message_wait(ipc, *ipc_header, data,
> > +				(sizeof(u16) * module_cnt), NULL, 0);
>=20
> So the multiple modules are a block of at most 255 16 bit words?  That's
> a bit surprising - is it really a count of the number of modules or
> rather the size of the block of data that's being squirted at the DSP?

Nope, as you would think that does not make sense :)

So we do not point to module memory here, we are sending IPC saying module
X, Y and Z are being loaded, data contains the module IDs only. The IDs are
16 bits so sizeof(u16) and number of modules pass as arg

The modules are transfered with Code Loader DMA which invokes this as IPC
after preparing DMA from Host.

This way IPC allows us to load One or multiple modules at one shot

>=20
> > +int skl_ipc_unload_modules(struct sst_generic_ipc *ipc, u8 module_cnt,
> > +							void *data)
> > +{
> > +	struct skl_ipc_header header =3D {0};
> > +	u64 *ipc_header =3D (u64 *)(&header);
> > +	int ret;
> > +
> > +	header.primary =3D IPC_MSG_TARGET(IPC_FW_GEN_MSG);
> > +	header.primary |=3D IPC_MSG_DIR(IPC_MSG_REQUEST);
> > +	header.primary |=3D IPC_GLB_TYPE(IPC_GLB_UNLOAD_MULTIPLE_MODS);
> > +	header.primary |=3D IPC_LOAD_MODULE_CNT(module_cnt);
> > +
> > +	ret =3D sst_ipc_tx_message_wait(ipc, *ipc_header, data,
> > +				(sizeof(u16) * module_cnt), NULL, 0);
>=20
> This seems weird...  what's the data that's getting passed in?  This
> doesn't seem to be actually managing anything, it's just some very basic
> message formatting.

Here we are asking to remove module represented by IDs in data buffer.
Yes this is only messaging part of module load/unload

Thanks
--=20
~Vinod

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXnx2AAoJEHwUBw8lI4NHX5sQAJu5q/g0Um1NNbtMbhLpP9kl
7O8rSidUwOUzUbjuOHNClBcCY1eBNwWN7sv9f9cnSHEdgpU9+/544KB0J7VOx6rj
K7od9CQkYiBaEZZniG1UsSEvXQsoUDfygbei7l0Tfx/fTFm7jOc38IEByMZppArI
oYuDpYWYGmnKPoxuwY7ZFscboNNPPGqtQ1+pXd2HTvUXC1EIvqyLsRWLMbB05iNM
dSJMe0HTbCuPhBghncQYFQLNDNpvDkcU00o00zDO5FvgRR40O4lO2Xul+clLyIHq
YEVqc2tCU84nLaHB6rgDt5CgGE5OIbKmc0H9xwpW89dSDoilGF+fB2Fmw2moUqpL
JEctFqPImXbdA6QjFljP+lNz99dKcWCYDp4WNxCin90bmBCPS682TlEKa/pbF8dL
I7am3b0LR7veRiz7voH4pRk5zXyvKivb1DPqYoU/U1VwIOAan+K7ypS7P7zQU38w
UVFuGc8qnT0ydnUqKIwPL6j0GkvkZKFIFwQs7LIM4aQsEpkepnZ37VdqP9EE5Ce6
+UN7gEBj3WcGAGfncKTy2YQzp9dGpaW2V2v5ojUYfKNQa0eUEk/n8FFQxcdyQdC9
sEwFFr60AnRzCOdIyAbW20PDJ4Slu+q7YaMvb36VK6uFmhT+g1bEJEj3mA+v4P0B
6Ogh9bEpiqf6JxMg7dir
=dt0l
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

--===============3728761244575946681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3728761244575946681==--
