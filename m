From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add Class G function options
Date: Mon, 9 Jan 2017 19:30:13 +0000
Message-ID: <20170109193013.vkyzzmy3luilbiyp@sirena.org.uk>
References: <1481609526-21933-1-git-send-email-benzh@chromium.org>
 <20161214145712.uhsdfy6xr7ybja7f@sirena.org.uk>
 <CAOV7By+iQSW7FRprXXmEAwY30K+vssweAcSJBgncNKphE1Djsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4309289696101864195=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B472668AD
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 20:30:25 +0100 (CET)
In-Reply-To: <CAOV7By+iQSW7FRprXXmEAwY30K+vssweAcSJBgncNKphE1Djsg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, Anatol Pomozov <anatol@google.com>, CTLIN0@nuvoton.com, Dylan Reid <dgreid@chromium.org>, "Zhi, Yong" <yong.zhi@intel.com>, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============4309289696101864195==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dvm7w6a3jwbf5lff"
Content-Disposition: inline


--dvm7w6a3jwbf5lff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2016 at 09:05:52PM -0800, Ben Zhang wrote:
> On Wed, Dec 14, 2016 at 6:57 AM, Mark Brown <broonie@kernel.org> wrote:

> > This doesn't affect audio routing so why is it being done with a DAPM
> > mux?

> When user wants the switching voltages, the Class G register bit needs
> to be toggled at a specific time in the widget power up/down sequences
> on the playback route. It helps reduce pop and is consistent with
> existing behavior. DAPM_MUX achieves this by taking DAPM_PGA_S in and

Sure, but a more normal way of doing that would be to use an event on
the widget for the amplifier that looks at the value a regular control
has set in a variable rather than having a mux...

> John has sent me a patch which uses a separate SOC_ENUM_EXT kcontrol
> in snd_soc_codec_driver.controls to set a flag, then has DAPM_PGA_S PM
> event callbacks selectively setting the register bit based on the
> flag. But it feels cleaner to implement this with a DAPM_MUX: The
> DAPM_PGA_S widget power status correctly reflects the actual register
> bit. User can experiment with the setting during playback.

...which is what it sounds like John's patch did.  It is more idiomatic,
it ensures that the DAPM routing represents the actual audio routing in
the chip which means we keep everything in the abstractions that the
system is using and avoid the potential for breakage resulting from
things getting confused later on (eg, if we start exporting the routing
to userspace).

--dvm7w6a3jwbf5lff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhz5MQACgkQJNaLcl1U
h9Db+wf/d5z/qyUvLxKPOObA2G/lckdcfHHQppb/6RjkBbJaDx+NW0+zpTOyCVH8
cCC0ZRjfjKdzOMIA5XGlD4d+2td/Z0+1lh70xr1McMcw2RnHc+MlQW2e494EJ+6s
XsIjp50j8MHTk+I1N9qmeQzwaDLI4GEwXWEWR85LsKFQgo+bOcrz+zd+WBgAW0eT
cpBJ9nn86JuepCmXBcokRsrGLv9hycFFQywxJVevWf91lG7pZJtHSZBgw68oB2wu
7x5T5B7wwabK0RJxhsA0azAp0LMcpmVfD4QTjEic+FFoLmMh2reYTZi+yppbqVzT
lN9u7Q27C3DVg0nvXt7T1zWiIifZww==
=Trq/
-----END PGP SIGNATURE-----

--dvm7w6a3jwbf5lff--

--===============4309289696101864195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4309289696101864195==--
