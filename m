From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 8 Feb 2012 11:20:59 +0000
Message-ID: <20120208112059.GB3120@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com> <1328692723.3955.4.camel@odin>
	<1328693854.21099.5.camel@vkoul-udesk3>
	<1328694877.3955.9.camel@odin>
	<1328697415.21099.8.camel@vkoul-udesk3>
	<1328698650.3955.13.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7058877486843452150=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7FE16243D4
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 12:21:02 +0100 (CET)
In-Reply-To: <1328698650.3955.13.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7058877486843452150==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 10:57:30AM +0000, Liam Girdwood wrote:
> On Wed, 2012-02-08 at 16:06 +0530, Vinod Koul wrote:

> > We want to dynamical turn off this clock when not is use and turn on
> > only when codec is using. So I was thinking of turning this ON in
> > codecs .set_bias_level callback, but how to propagate this into machine
> > driver?

> It's usually done in the machine driver hw_params() since at this point
> we know the rate, format etc that can have a bearing on the clock
> configuration. You could switch it OFF in machine hw_free().

For modern devices set_bias_level() is often a better choice if you're
only going to do one of that or hw_params(), especially on the shutdown
paths - devices these days typically need the clocks for a lot more
stuff.  hw_params() by itself obviously has issues for analogue only
paths too.

I'd generally expect to see new machine drivers doing this stuff in
set_bias_level() and possibly also having additional startup code in
hw_params() depending on how flexible the clocking is.

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMlp2AAoJEBus8iNuMP3d3MgP/2DmLeNQPfdMa/AmMoN6e51S
bGSwfdakg0H3F6esk4lyGbUhAND2Q3gTzbcLQXnD4yeauAhFNRzsP8waGkyKDIoD
5YmyXT3/pUtvMrrAqp0oK31Qr+NoEr+eFXuyTlu5DBHhimeSJmUqgO0gJsEYnsGw
SaseMOFZUknvpgv5tzVk2Amces2MWgJuAKY6CP1C699/vZpz6TWvtaTtmsZo6if/
YwHH/2+3/+fZ8vIV9bzIG98nhMvX4w8GCccp6wN8jhVVux7brMQRTXVovAbXzVvf
ih86BnlvWp0EX7sQMW7THsmhvZ5Xf4JKQLOREpdCUX4ovtcMaFBCIbEYTnO7SyW0
LgPsyJl5wNFq5GH1t5QaNb7d5cUQyTukHZsYykrkGoxv1ncbLQfX5l2Lw7xeW/Pu
gThSR2tz5YsaByTJyhJS+nwKSCpoTKf6huNNC2yPLD+7ZSPGhEHTiF2vIJqw0nRB
2yZ6J7noTd6E3bg19MYcXgAeUjzepS4/K5SlYZWaTV8SJ0N+re4S/Rbpblnvt6CN
D+s3L1WqcL6udLMt6aYYO5j4b7rXURhHDh5tjY8PunrQNMnFCRKkpd88sqDMI05v
AnAbX4CNAS3Huc2p3lNL+XtHwK2cl7XmBDMb5x231wKy9mFyaLgtZFAJc76gTLZy
17rqMBax6cO+so/zGmXf
=3Z1H
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

--===============7058877486843452150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7058877486843452150==--
