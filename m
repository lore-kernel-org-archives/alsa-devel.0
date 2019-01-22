From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 07/14] ASoC: SOF: Add DSP firmware
 logger support
Date: Tue, 22 Jan 2019 20:41:22 +0000
Message-ID: <20190122204122.GN7579@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
 <20190109204427.GR10405@sirena.org.uk>
 <85d2a9dc-4800-9db7-3e6a-3671f8eef226@linux.intel.com>
 <20190122185711.GI7579@sirena.org.uk>
 <17fc8892-90aa-a7b3-d9aa-23825b83fca0@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8184662997271191290=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <17fc8892-90aa-a7b3-d9aa-23825b83fca0@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8184662997271191290==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M2Pxvdb9QxnGd/3e"
Content-Disposition: inline


--M2Pxvdb9QxnGd/3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 02:33:55PM -0600, Pierre-Louis Bossart wrote:
>=20
> > > > > +	/* make sure count is <=3D avail */
> > > > > +	count =3D avail > count ? count : avail;
> > > > min()?

> > Why was sparse complaining - was it spotting something that is an actual
> > issue here and you've just masked the warning?

> It was about the use of typeof/sizeof() in min(), not an actual issue in =
the
> code

> sound/soc/sof/trace.c:90:17: warning: expression using sizeof(void)
> sound/soc/sof/trace.c:90:17: warning: expression using sizeof(void)

I don't understand that warning - avail and count are both size_t so
where's it deciding that there's a void involved?

--M2Pxvdb9QxnGd/3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHf/EACgkQJNaLcl1U
h9BDhgf9GbLCbSVVW4os1+HQgngwgvayQGEMrZRtk+UyHsrbCFJcrsp4owDNZzEl
ECo7KWIBdgcIkikZF+ueqTSdXVKrv4XixYqR1FQaIpUBxbRvhppaVnmo4trTA4b3
IohG0y5kzXf0S+m4MecHNj03HR6WAkClSnd0L541uVIUIJ8YHZ6GfgjkrUxxOwL0
VG6R2CHMZQ5OchAVlXnxgSYycE6oAAFQDmJbYpAjlx4oqLlAB54ZUEa/nodfmm4d
necuV1q27laTE9fKynpiUz+8fm+xwolDZHVpmTFYxH0ZR0SlnY+p4G0L8SFkwunE
I/wj2jfbQjD2XBjR9qqH3A+YOyVSmA==
=FEbf
-----END PGP SIGNATURE-----

--M2Pxvdb9QxnGd/3e--

--===============8184662997271191290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8184662997271191290==--
