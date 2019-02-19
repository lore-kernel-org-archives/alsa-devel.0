From: Mark Brown <broonie@kernel.org>
Subject: Re: [Sound-open-firmware] [PATCH v4 01/14] ASoC: SOF:
 Add Sound Open Firmware driver core
Date: Tue, 19 Feb 2019 15:38:36 +0000
Message-ID: <20190219153836.GD6319@sirena.org.uk>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-2-pierre-louis.bossart@linux.intel.com>
 <s5h1s4abu2n.wl-tiwai@suse.de>
 <ecb982bf-5f45-4551-592c-8375d06415e0@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0771467333351145636=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <ecb982bf-5f45-4551-592c-8375d06415e0@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0771467333351145636==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 14, 2019 at 08:53:11AM -0600, Pierre-Louis Bossart wrote:
> On 2/14/19 3:25 AM, Takashi Iwai wrote:
> > On Wed, 13 Feb 2019 23:07:21 +0100,
> > Pierre-Louis Bossart wrote:

> > > +	/* private data - core does not touch */
> > > +	void *private; /* FIXME: still SOF-specific, needs to less ambiguous */

> > Then better to name it sof_private?

> Ah, this is a mistake in the FIXME comment.
> initially we had a field called "sof" and Mark made the following comment:

...

> so we added a FIXME to track this, then later we moved the field and renamed
> it 'private' so that it can be used by others if needed but didn't remove
> the FIXME. Will fix this.

That doesn't really address the issue - there's multiple drivers using
any given runtime so none of them can safely use a generically named
private data field.  Conversely putting a field specific to a given
driver into the core data structures opens the door to everyone wanting
their custom stuff in the core which is also a problem for different
reasons.  This would be a lot easier with the DSP represented as a first
class device in the system...

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxsIvsACgkQJNaLcl1U
h9A1Ewf9GXajnZBi5fiw76T4aV9TFmcnZrDO3bqtvQvKFhpSK9k/BcF/2NCTRkYT
c/beXrGe0fqbBjeZ1YlDVeoCadzd4hKyakOYdO13dlCw3ddSKJQfTzqhC2n7YmPt
IqPuNsoKER8U0ogkUwuSb0bv+YgXtRrg7aKScG5KIFX+FjMd7IuKHL9Kk6foh8gj
I/xql8KzSr5Gs+e7HK+2f1MXowMUsbP38kUxtkYv0r9DiJ3a6Dul92ebUNTkexEU
8ZU4uF+ErvP6TXDqfvik5dUmJ5UonoNI34da+JNIAKPjZl5pNd8GHCe6iSmP9Kht
rGF+m63FaQ47wtTrF9WeWxR9DPcmtw==
=G1/f
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--

--===============0771467333351145636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0771467333351145636==--
