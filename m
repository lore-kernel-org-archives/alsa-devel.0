From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v13 05/14] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls.
Date: Wed, 28 Jun 2017 19:12:05 +0100
Message-ID: <20170628181205.sfagsnuqmfrqhoen@sirena.org.uk>
References: <20170624062419.23778-1-dannym@scratchpost.org>
 <20170624062419.23778-6-dannym@scratchpost.org>
 <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4386917092578355207=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 782D5266838
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 20:14:20 +0200 (CEST)
In-Reply-To: <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Danny Milosavljevic <dannym@scratchpost.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-sunxi <linux-sunxi@googlegroups.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============4386917092578355207==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aumdev75eqsgqzhc"
Content-Disposition: inline


--aumdev75eqsgqzhc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 26, 2017 at 09:48:59AM +0800, Chen-Yu Tsai wrote:
> On Sat, Jun 24, 2017 at 2:24 PM, Danny Milosavljevic

> > +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
> > +       SOC_DAPM_DOUBLE("DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
> >                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),

> This changes the mixer control names exposed to userspace. While I think
> consolidating mixer controls is nice, giving the user a less cluttered
> view, I'm not sure about the changing a possible userspace ABI.

> Maxime, ALSA and ASoC people, any comments about this?

It's better not to change things but on the other hand it really depends
if there's any users who will notice - if nobody notices it doesn't
matter.

Can we *please* get some review of the rest of this series?  It's
enormous, we're on version *13* and the first review on this version
here is on patch 5.  If the first four patches are fine then please says
so, if they're not then let's have some review comments so things can
move towards merging them.

--aumdev75eqsgqzhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT8XQACgkQJNaLcl1U
h9AqXQf/dA3v+EhX5jDdhpa++SfrJCcDP1YGj5aw+ndzcKrY+BJD/55JwohdMPxB
5TICseIByPsWeDc8juAsPVjPi5tW8ygOBqXf59qoB2nvzj01XuTUU9s3RhBcn2bw
yxVNpBIRKsSvW02Dk3fscHxSTT6r44UqA/vSQq/kEhsnmpKm9GpEVqqfyPnSyc3k
EghhiMK/diU9LRgKOeRwV+HUXpK7kDaSXetrVFo30LDlKH3Nion7PSpZJOHZYUa9
wrDjvAMMRxEhU3abyNK17p2JOhWZIzMm0cnD5QNVuaqMFtYPLmg1yV+oo9km/s6q
W7fgcK99Y8m9AvasmKFUrrLa1l5d9w==
=O/bb
-----END PGP SIGNATURE-----

--aumdev75eqsgqzhc--

--===============4386917092578355207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4386917092578355207==--
