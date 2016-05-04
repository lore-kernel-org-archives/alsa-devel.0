From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Wed, 4 May 2016 17:39:44 +0100
Message-ID: <20160504163943.GZ6292@sirena.org.uk>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
 <20160502162715.GK6292@sirena.org.uk>
 <57286D40.6030002@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6471882791156704687=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2063E26674A
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 18:39:52 +0200 (CEST)
In-Reply-To: <57286D40.6030002@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6471882791156704687==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ufMBWnG1WFkAvCRz"
Content-Disposition: inline


--ufMBWnG1WFkAvCRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2016 at 05:20:00PM +0800, John Hsu wrote:
> On 5/3/2016 12:27 AM, Mark Brown wrote:
> > On Fri, Apr 29, 2016 at 04:15:17PM +0800, John Hsu wrote:

> > > +	/* Mask all interruptions except jack insertion interruption */
> > > +	regmap_write(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0xfffe);

> > So if any other interrupts occur then things will break...

> The codec only has headset output and its function works when headset is
> connected. When headset is not connected, the driver only permit insertion
> interruption to happen. After insertion, the internal clock of codec turns
> on and all other interruptions just will be enabled. Without clock, the
> codec can detect jack insertion only.

People do surprising things with devices - they may not wire up the
headphone detection for some reason, or may connect some external
circuit.

> > This is ignoring the attempt to set up a clock but returning success
> > which is going to break things, printing the warning is dubious (a
> > system could be built without detection for example, or a speaker driver
> > connected) but probably OK in itself but the fact that we don't tell the
> > caller may make things worse.

> For clear expression, we should print error message and return error to
> caller. Is it right?

It'd be better to just accept the configuration but what you suggest is
less bad than just completely ignoring the problem.

> > > +		nau8825_eject_jack(nau8825);
> > > +		snd_soc_jack_report(nau8825->jack, 0, SND_JACK_HEADSET);
> > > +	}
> > > +	enable_irq(nau8825->irq);

> > The interrupt is optional (that bug appears to be already present in the
> > driver but should be fixed).

> If headset ejection happened when system suspend. After resume, the codec
> won't detect the change and no report to the kernel. The application does
> not aware the device change and still outputs stream to the headset device.
> For the issue, the driver has to notice the application of ejection ever
> happened in suspend. Let the application to change its device correctly.

This does not address the issue at all.  The interrupt is optional, it
may not have been wired up and the probe function handles that case
gracefully.

--ufMBWnG1WFkAvCRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKiXKAAoJECTWi3JdVIfQvvAH/28NLrlA22KR+h6ctrmAUX6m
l46Bol8mvvtTNcvnhC/LNmR3gvTE6vobnETY7lnuOxIcTvvKwkC2vH5x1Wd9gj8O
HAcH2X2FhWD9LQNLnfTw4IQY5lD1ZtQPW4OqLBSmQMXz/2p02EiBWMnTPGaedW6Z
nyj+nEBppcnwlYhdkzJDg0De9+eopgTQX7F6ki7yT7Rhb9foaCgKkA6zckrpfHpj
YVWZAwa1QDGjLZ9KLYuLWmi1MTiIlUsg2oKhAft2rrA6Krf/95m39v2OIRnORAXK
n5sYucR85CO82wNmstk/XQCWQY8n5L4bl6s9s3h12GgLihNWUecH2DSAyg9H6j8=
=gzYG
-----END PGP SIGNATURE-----

--ufMBWnG1WFkAvCRz--

--===============6471882791156704687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6471882791156704687==--
