From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Fri, 21 Dec 2018 10:57:41 +0000
Message-ID: <20181221105741.GB4996@sirena.org.uk>
References: <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
 <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
 <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
 <20181219161949.GD8130@sirena.org.uk>
 <8c996338-19a3-996b-16dc-5535688ccea2@gmail.com>
 <20181220153613.GC9325@sirena.org.uk>
 <c95346b8-335a-88c4-484b-9ad4e1aebc12@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0184799492899498789=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9465C267AB2
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 11:57:43 +0100 (CET)
In-Reply-To: <c95346b8-335a-88c4-484b-9ad4e1aebc12@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0184799492899498789==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 20, 2018 at 10:41:40PM +0200, Dimitris Papavasiliou wrote:
> On 12/20/18 5:36 PM, Mark Brown wrote:

> > Install one PCM hardware configuration chosen from a configuration
> > space and snd_pcm_prepare it.

> As far as I can see there's no other way to call hw_params from
> userspace, except for snd_pcm_set_params, which is just a wrapper that
> calls snd_pcm_hw_params internally, so I suppose calling hw_params to
> configure the stream, must inevitably lead to the device being powered
> up.

OK, that's fun...

> Unfortunately the documentation ("Writing an ALSA Driver") on the
> prepare callback even warns explicitly, to:

> > Be careful that this callback will be called many times at each
> > setup, too.

> I'm not sure if this implies that configuring the card in multiple
> steps when setting up the stream is expected behavior, but it could be
> interpreted that way.

It's certainly possible if there needs to be negotation about the
parameters (but then you wouldn't prepare as the stream as you'd fail to
set the parameters) but it's not normal.  The repeated configurations
used to be much more common as OSS had separate calls to set each
parameter rather than the atomic configuration that ALSA has so you got
a hw_params() call for each OSS ioctl(), with native ALSA applications
it is more usual to get it right first time.

> Should we then accept, that some pops will be generated and hope that
> they'll be suppressed by the digital_mute callback?

It's probably easiest.

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwcxyQACgkQJNaLcl1U
h9AwEwgAgkn6x95z315a2SQ6YH4dHQyPK8zE8iSixTYe8f/E/Cjgkbkm68CBjkiU
AVvPthxRcU5/b37NoQXYgz2xdCla0kL8HFeO6W0P1pfERgW2TeQsw1oLlUBjrKYv
wBYN1d51LCiQtlyjVpm4JQedW7UH3IP9eV6N6NXjlIdbVwPCShMjtKgFS6PZYD18
vAtFdLcXxY98Vh9JL1m6NQowVPjogflFsQDfzjJhqF6xfQvQ2rTBZTpBCRVIzAUx
vMJPDbB/Fdu5EyA6g3I1FzVpBm8dVMImKA1ynbuJXhxGGqy2Nfv1h48pNJShrzW2
E6U7eX7zU0sdZAQj/L0srnGLMzSsHA==
=1LCN
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

--===============0184799492899498789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0184799492899498789==--
