From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Mon, 20 Mar 2017 17:26:47 +0000
Message-ID: <20170320172647.t7qacxqcgawe7xlf@sirena.org.uk>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <20170320150845.7rltrhycdkk2mza4@sirena.org.uk>
 <CAAd53p53MnZcSEgS47wWcCfm48=J6O3ynjqBdfN6_1nhBMdNwA@mail.gmail.com>
 <20170320160622.5s2oqdyluvanjp2u@sirena.org.uk>
 <CAAd53p4T33uKEPVHET1F-PFVbW9R-JeKoCTzYwCP7+iM+j0+qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2491646795590098225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E7BF266EF3
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 18:26:58 +0100 (CET)
In-Reply-To: <CAAd53p4T33uKEPVHET1F-PFVbW9R-JeKoCTzYwCP7+iM+j0+qg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2491646795590098225==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="va442svrmrnoixzj"
Content-Disposition: inline


--va442svrmrnoixzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 21, 2017 at 12:23:53AM +0800, Kai-Heng Feng wrote:
> On Tue, Mar 21, 2017 at 12:06 AM, Mark Brown <broonie@kernel.org> wrote:

> > As it says there "...and inserted automatically following the three dash
> > line".

> I saw iteration changelog in git log all over the place, maybe add a
> rule section for each subsystem?

Some people won't push back, the only people who insist on anything
different are the graphics people.

> I had the same thought originally, but printk under each case suggests
> otherwise - _POST_PMU is triggered not right after _PRE_PMU but right
> before _PRE_PMD.

Then you've broken something else on your system, that is obviously
completely nonsensical and would break anything that relies on having a
_POST_PMU event.  Why would we have two events that run at the same time
one of which is obviously misnamed?

> > > You didn't reply to my review comment and you sent the same code
> > > again.
> > That looks an awful lot like being ignored.

> Fair enough, I thought changelog is sufficient.

I'm not seeing anything in the changelog that addresses this.

--va442svrmrnoixzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljQENcACgkQJNaLcl1U
h9DTbwf/dBQUnftyISbcXK2n6NRRXtTm4tY7ksva5QB0g1UqkDF8XdscDCNZ41ax
ovOqCMqPJk92NZgjCnvqAYInhgbH9c3us1CDwLr0+Q55/l1kBr/zHUVoOyVFpLCX
L8NL/gmELjHiHUlJoeXG7qtDmFcOTlZ1ghMeDkvckMYaEEsZxdwY4fFMyyQzBLBj
n0Y4xBQEW55gz4l19eRNKkslz1Lfr4HeCvO3rTllfrfCiiF3/iPPfLIyIxpMXOk/
wpyfrIl0ng88q2EC/fp6ZZQuNLRGdrtQ/JROGpvd5bv//bSToDOhw4acx5DGjt1E
ArmR3TFHblg6tZpIcs7LsI+bBLcYHA==
=aais
-----END PGP SIGNATURE-----

--va442svrmrnoixzj--

--===============2491646795590098225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2491646795590098225==--
