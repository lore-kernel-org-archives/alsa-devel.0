From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4613: call dummy write for
 PW_MGMT1/3 when Playback
Date: Tue, 14 Nov 2017 11:08:45 +0000
Message-ID: <20171114110845.3fgnqlsywf6y6wcb@sirena.org.uk>
References: <87a7zpwfae.wl%kuninori.morimoto.gx@renesas.com>
 <bc955a77-fcdf-bfc7-1a87-5fec5f88ac63@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8698596865900007266=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 006E5266B0A
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 12:08:49 +0100 (CET)
In-Reply-To: <bc955a77-fcdf-bfc7-1a87-5fec5f88ac63@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============8698596865900007266==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7cdtclpoggzvzka2"
Content-Disposition: inline


--7cdtclpoggzvzka2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 14, 2017 at 05:27:42PM +0900, Takashi Sakamoto wrote:

> In my understanding, kernel's service of delayed work relies on kernel's
> timer service. Resolution of the service is quite coarse in this purpose, at
> least for several phases of word select clock. In the worst case when task
> scheduling is too delay, many audio samples are not presented by the DAC in
> the beginning of playback. I can easily imagine that users get confused.

Yes, the delayed work might be delayed a lot more than expected under
load (or possibly for other reasons).

> In your patch description, 5 word select phases after 'the first command'.
> According to "Digital Attenuator" section per page 44 of AK4613 English
> datasheet (AsahiKASEI 2015, MS1052-E-05)[1], your 'the first command' seems
> to be the previous command issueing of 'power-down release command'. In my
> understanding, in ak4613 codec driver, issueing of the previous command is
> done in 'ak4613_set_bias_level()'. If there's a guarantee for DAPM stuffs to
> call this function on any non-IRQ context, it's better to call the
> subsequent commands in the function with interval of sleep functionality
> with finer resolution (e.g. usleep_range()) but I don't know exactly that
> any components has guarantee to receive word select clock when the function
> is called.

The problem with set_bias_level() for this might be that the clocks
aren't all running until audio is triggered...  it's tricky to find a
good place to put this that's in line.  I'm thinking we might want to
add a post trigger callback for cases like this, digital_mute() kind of
has that job right now (since it exists mainly to cover up things like
controllers that output nonsense during startup) but it'd be a bit of an
abuse to just use it as-is.  Probably easiest though.

--7cdtclpoggzvzka2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloKzrwACgkQJNaLcl1U
h9CbDwgAgE9A6r3IKd7r2fw3lP6a6/NYMusGlpofamS3dPgEbPYCj5rbVcjCOaYF
yA7LXuoG8cs/qQivqae2BXLDco9vLSK13hnXWxEnC2rHpntkPyloZUF8W+bpip9/
K3GxSIegok3h6JG9kYxXEuLFZOEet80hi7A2QvtEKwAZq0mtp9jQuQggRdcC59ko
Xs/LbcEIsrhYVB1tFjMtT1tFhcBfTJwwmzYqnD6fDdjL5CJKHpV1nsi/XvfF5F/y
MWCYT+SAc43X1jCDKCweb0tyL0AKEDmmFTb5GfO9cV+J8kqzpNXs1bf71Fzl978y
Vh76ujEFWrw50KQub4IEyzfN0vCjtg==
=+CsN
-----END PGP SIGNATURE-----

--7cdtclpoggzvzka2--

--===============8698596865900007266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8698596865900007266==--
