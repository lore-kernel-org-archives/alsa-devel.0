From: Mark Brown <broonie@kernel.org>
Subject: Re: [Sound-open-firmware] [PATCH v4 16/20] ASoC: SOF:
 Add PCI device support
Date: Tue, 2 Apr 2019 12:26:55 +0700
Message-ID: <20190402052655.GY2059@sirena.org.uk>
References: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
 <20190321161055.26582-17-pierre-louis.bossart@linux.intel.com>
 <20190328174819.GM9224@smile.fi.intel.com>
 <20190328174918.GN9224@smile.fi.intel.com>
 <9f48d5e7-8a95-db2f-0605-b15e45670ce0@linux.intel.com>
 <20190328220826.GQ9224@smile.fi.intel.com>
 <d6b6fc83-c362-4b86-ebb1-9c79dbb36858@linux.intel.com>
 <f4e5f957-b4f1-174c-3569-cf5c21b55ac4@linux.intel.com>
 <s5hh8bhlf64.wl-tiwai@suse.de>
 <5d4f7d94-4806-fd9a-687b-75c428348779@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0010521966324190430=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5d4f7d94-4806-fd9a-687b-75c428348779@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0010521966324190430==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c6YcJYqqMhegfX14"
Content-Disposition: inline


--c6YcJYqqMhegfX14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 05:59:16PM -0400, Pierre-Louis Bossart wrote:
> On 4/1/19 3:05 PM, Takashi Iwai wrote:

> > > Actually I need feedback from reviewers/maintainers: I could either
> > > provide an update addressing just comments from Andy and Takashi, or
> > > provide a larger update that would include known fixes and
> > > simplifications from SOF contributors on github, e.g. on the IPC. We
> > > have about 15-20 delta patches that were accepted on github, not sure
> > > what the preference is, just addressing comments so far or getting the
> > > latest and greatest patches squashed?

> > IMO, one or two more whole patchset refresh would be still worth.
> > Then we can merge the base, and go for refinement with each small
> > change, hopefully in this merge cycle.

Especially with the fixes just always add them, there's no sense in not
fixing bugs.

> > For the resubmission, please give me a bit more time.  I had no time
> > for further review in the last week due to completely other
> > businesses (the office room movement, etc)...

> Sure, I am understand how time consuming this can be and how 'reviewer
> fatigue' can occur. We can add a couple of additional changes, e.g. for the
> IPC and some resource management while you (and others) go over the current
> patchset and tentatively resubmit next week, would that work?

That seems fine to me.

--c6YcJYqqMhegfX14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi8p4ACgkQJNaLcl1U
h9DR8Af7B6qcpgvOgKLOdYdj6yKdy68E8OelQdPHuJxIpSuWf7RAkt3DcA5yQqlx
H57WCqurVpA5EFpFghXMsLn920e55FMK0MmPVI1f3IQEJ3++lx/GWkMYL4ZMVdJp
6nPPe6EQEK/b6eJjS5uoX9tTGZZbdA1RTcyxd/PYl8mt1DPRiAPKum6qVJz7b5pq
k+Om71J8Vpt6NCd4RzFvAgr9lltC+h/U+YxjJYc+HkNIuTucudndu1UZEuOziL7u
tEqDfw4pGq2rOEVTzpcu7+uLoPGHJIWFIZuKT5Qt1aqfNjhr4zvnrap9+aRTAFZG
51N7t4937HDay+arWlRd6jYNmd+Lfw==
=MZVZ
-----END PGP SIGNATURE-----

--c6YcJYqqMhegfX14--

--===============0010521966324190430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0010521966324190430==--
