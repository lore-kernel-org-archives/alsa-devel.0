From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: add support to card
 re-bind/unbind using component framework
Date: Thu, 12 Jul 2018 16:58:17 +0100
Message-ID: <20180712155817.GG10369@sirena.org.uk>
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <68715fbc-9447-dfaf-3fe5-4200684c2cbc@linux.intel.com>
 <s5hsh4o8nq1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4638455854502683390=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3338F267715
 for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2018 17:58:21 +0200 (CEST)
In-Reply-To: <s5hsh4o8nq1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, lgirdwood@gmail.com, vkoul@kernel.org, rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4638455854502683390==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2018 at 05:42:30PM +0200, Takashi Iwai wrote:
> Pierre-Louis Bossart wrote:
> > On 7/11/18 3:43 AM, Srinivas Kandagatla wrote:

> > > This patch aims at add achieving dynamic behaviour of audio card when
> > > the dependent components disappear and reappear.

> > Humm, no real comment on this patch proper but rather on how userspace
> > would deal with this dynamic behavior?
> > We had similar opens when we worked on the BYT/CHT HDMI stuff and
> > ended-up with quite a few issues in userspace (PulseAudio mainly)
> > related to dynamic behavior at the kernel level as a result of
> > plug/unplug. Also not sure how an Android HAL would deal with a card
> > disappearing temporarily if DSP resources become unavailable or
> > unresponsive. Any thoughts or guidance you might think of?

> Was the card-level register / unregister really problematic with PA?
> It's basically similar as the hotplug like USB, so I thought it would
> work as is.

Yeah, I'd expect normal desktop stuff to be able to cope with this due
to physically hotpluggable hardware.  The main use case for doing things
like this with module unload is in a development context where hopefully
people can also arrange to use a userspace that can cope or to do
whatever to reset it, any limitations in some userspace shouldn't prevent
people from having the facility available.

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltHepkACgkQJNaLcl1U
h9AMIwf7BhRkGokjgqRqrNGjXZa6Kwykx4hHriSACyNkX7n9KrQJnmZjM7DYZ6sl
sNQIJL5AUetE0Swwtk5pQpYsqnBO0/yPSwCDthWu9gzTLC1o95LTVaJb+g5RtrJt
i65c6oKpL+UZ0ALa3FvUwSNOvnpQOvIg5X+ATPhXN8MajRFC/SxK456Pi52pR6Eo
lJ6TowhzK8lYfft2edbh2Z4XZA3X2YvOEBvgo0VWcd8eWQ6ive9Y2D8BhVoBFaWZ
98DOLCBvNhFmN/1mPSr56nQS/lEgF736wbNzOa2t3/lvLrS5ykkB3XzZv+Y/70o3
/DyeAr2GtVEJp2TLt23wkZgDhe0LFQ==
=nrKD
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--

--===============4638455854502683390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4638455854502683390==--
