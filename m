From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [RFC][PATCH] ASoC: soc-core: verify Sound Card
 normality
Date: Tue, 4 Apr 2017 13:37:53 +0100
Message-ID: <20170404123753.7tqnrrea4cce4tcp@sirena.org.uk>
References: <87vaqsajo0.wl%kuninori.morimoto.gx@renesas.com>
 <20170330215334.zwashvjerpfnkk3u@sirena.org.uk>
 <s5hefxdhop9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pp2snqjbdcmn2sam"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hefxdhop9.wl-tiwai@suse.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--pp2snqjbdcmn2sam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 31, 2017 at 09:48:02AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > flag directly when we see a problem call a function to do it.  That way
> > if we want to improve things in the future we can do that without having
> > to update the callers again.

> BTW, ALSA core has snd_card_disconnect() that does this kind of
> shut-up from user-space.  It was introduced for hot-unplug, but
> basically unbinding is the software hot-unplug.  So, if ASoC won't
> rebind a once-unbound component, you can simply call
> snd_card_disconnect() at the component unbinding time to assure that
> no further user actions can be done.

Ah, that's exactly the sort of improvement I was thinking of!

--pp2snqjbdcmn2sam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljjk6AACgkQJNaLcl1U
h9D9QQf/d/WsUkZ1N5jRzx4F+9ERtQ8Ca8Ko8b3xOH0DuR3FKeVWcDmeeK9ATyK3
cs/M03P70KTSQdSVICogbcnq2DUYczpmPJ6KIaQNhJPS0HjdcpB+A8iqTRsWTj8j
oLAjy4LSBJp5XtgC5IWoqqqVYdQ0WEhh7IwJtpnZ5j1B+mc5dSkMqncypdBgJW68
qQXkF6dVNvjBoRanTwRX8JYUeaqVPykTc0jATPLISyxdPFk7n/Qwk5TKFXrp7ci5
kWkJHcR7A+j9DpGkmsPv1Mt+xqid+bNxy9Rne0j7bdwcVQLiKPtNZqMjXUYfm6qU
XAYzAMV/ebV9FyiSpzLHIghZc2K9cA==
=xO01
-----END PGP SIGNATURE-----

--pp2snqjbdcmn2sam--
