From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 07/14] ASoC: SOF: Add DSP firmware
 logger support
Date: Tue, 22 Jan 2019 21:08:32 +0000
Message-ID: <20190122210832.GO7579@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
 <20190109204427.GR10405@sirena.org.uk>
 <85d2a9dc-4800-9db7-3e6a-3671f8eef226@linux.intel.com>
 <20190122185711.GI7579@sirena.org.uk>
 <17fc8892-90aa-a7b3-d9aa-23825b83fca0@linux.intel.com>
 <20190122204122.GN7579@sirena.org.uk>
 <af89cb49-6550-d6b0-a274-0b803cfadffd@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1651971429099997506=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <af89cb49-6550-d6b0-a274-0b803cfadffd@linux.intel.com>
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


--===============1651971429099997506==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E0h0CbphJD8hN+Gf"
Content-Disposition: inline


--E0h0CbphJD8hN+Gf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 02:52:25PM -0600, Pierre-Louis Bossart wrote:

> > I don't understand that warning - avail and count are both size_t so
> > where's it deciding that there's a void involved?

> no idea really, I am only a user of sparse, I don't know how it generated
> that warning.

Yeah, I use it quite a bit as well.

> there are equally confusing ones such as

> include/linux/slab.h:332:43: warning: dubious: x & !y

> include/linux/slab.h:665:13: warning: call with no type!

> include/linux/slab.h:665:13: error: undefined identifier
> '__builtin_mul_overflow

> The main benefit of sparse is that it is the only tool that found endianess
> and iomem space issues, but it's often buried in heaps of false alarms in
> include files.

It's got less and less useful as time goes on I think :(  For this one
did you try reporting the bug to the authors?

--E0h0CbphJD8hN+Gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHhlAACgkQJNaLcl1U
h9DuVgf/WP4gNVDXunYPIir9Z6N7JGu7Im91KvlIFbuTlj4SX/OoS7AKVr0baHm+
DRD2RAXS4weKrFmpnDa5ZnWh+R49rZ/AkrNOYa8Bpz8QKrHFj9+wm9U8CPBn8hj2
mf3mrBw0OFBW0ioDxWy1bvmk17v8WhSBWNdpY8uZQIK8OsgHROrOViXUUzg4tJ88
k6oUEYpqasPX6y/5ZUKjKZIYZV65ztlKigA0jL3bxEjqfXW9iDh6PaR/IHK2HJI1
fuGea8T4bo+n7l3mOMQrXHQooZ4nYfoVjHIJUetjTUkKP8MNIy/ROjJztIMEOJCT
Mmn04Fj92ZaepoSjId58qJVrk85Bpg==
=KeWQ
-----END PGP SIGNATURE-----

--E0h0CbphJD8hN+Gf--

--===============1651971429099997506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1651971429099997506==--
