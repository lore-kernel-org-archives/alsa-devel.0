From: Mark Brown <broonie@kernel.org>
Subject: Re: [Sound-open-firmware] [PATCH v4 01/14] ASoC: SOF:
 Add Sound Open Firmware driver core
Date: Thu, 21 Feb 2019 18:47:48 +0000
Message-ID: <20190221184748.GF5970@sirena.org.uk>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-2-pierre-louis.bossart@linux.intel.com>
 <s5h1s4abu2n.wl-tiwai@suse.de>
 <ecb982bf-5f45-4551-592c-8375d06415e0@linux.intel.com>
 <20190219153836.GD6319@sirena.org.uk>
 <19843650-4f58-4aa9-7bf3-c1ce4c72d1c9@linux.intel.com>
 <20190220162645.GB9878@sirena.org.uk>
 <d92700ef-4975-fd8b-c93b-b699f65781b1@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5086900848651136048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d92700ef-4975-fd8b-c93b-b699f65781b1@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5086900848651136048==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 20, 2019 at 03:32:54PM -0600, Pierre-Louis Bossart wrote:

> The only reason for extending the struct snd_soc_pcm_runtime was to enable
> the use of a 'context' in PCM operations, see e.g in patch 5/14 the repeated
> pattern to get an 'SOF PCM' context:

> struct snd_sof_pcm *spcm = rtd->private;

The reason you're having trouble with this is that the DSP isn't really
properly visible in the system, it's pushed in on the side with DPCM
coexisting with multiple other drivers so as far as I can see it's hard
for it to fit in anywhere in Intel systems.

> So ironically in ASoC we don't have a means to use a private_data field for
> the substreams since it's used for a 'standard' mechanism.

This is why there's things like snd_soc_dai_get_dma_data() and
snd_soc_component_get_drvdata() - if you're a fully visible component in
the system there's ways to get to your ASoC specific driver data.  For
something like SoF that'd mean cooperating with the drivers for the
devices with the SoF using DSPs in some way.

> The extension suggested in this patch 1/14 was really trying to come back to
> a practical means to store a context in a substream, and make the PCM
> operations manageable. I totally agree that extending the PCM runtime might
> not recommended or safe, but at this point I don't have any slack in the
> existing data structures to add a context in a substream.

> Does this help clarify the problem statement?

It is fairly clear what driver data is useful for.  The issue is that
instead of getting to it through the relevant hardware component you're
adding something directly in the core data structure, whatever way we
look at it that's going to be awkward.  Consider for example what
happens if someone integrates a system with a SoF DSP in the SoC and
another SoF DSP in the CODEC - there will be two separate copies of SoF
on a single DAI so a SoF specific value directly in the runtime isn't
going to work.

If there were a component for the DSP (or the DSP was fully part of some
other existing component) then it should be possible to arrange to get
to the DSP data using that but with it just floating there unattached to
anything it's harder.

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxu8lMACgkQJNaLcl1U
h9Bcugf9EF24EFoRQLi0kWm+lfQ249omf2Dr8HwGCKqyX1Mg8KEd05p3fJr4jdAk
0q3lGcZeuPiXA6KBelngXpgaP3iFOHcryLmlxszTjlUR0a+6meAW8W4od/Y9yAh0
srN3tIOxOaVw4v41Z11ZJWSKRnH4rESvcZ5Tp/D8X0AIZIvQxmELnZi3fziCZD3U
IjWeCTmY2tQ1vdYc/TBGgQEKfAWnWpuTtkmwe+geRt4ooouX44APQPDnHDEzpxgV
JY//Gq5Aje47UC0otetzblMWxNhmeTceF6u75uh6WiCM5ISfB0KM/3tMgdpYrcmH
pKHINzLB0H3tYXlXNxWfgoFS2RANTg==
=q1ej
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--

--===============5086900848651136048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5086900848651136048==--
