From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Thu, 15 Nov 2018 11:04:03 -0800
Message-ID: <20181115190403.GI2089@sirena.org.uk>
References: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
 <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
 <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
 <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9129246515092885560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 631BB267AFC
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 20:04:12 +0100 (CET)
In-Reply-To: <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9129246515092885560==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eG1/bcghN0MjPhCR"
Content-Disposition: inline


--eG1/bcghN0MjPhCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 15, 2018 at 01:25:28PM +0200, Dimitris Papavasiliou wrote:

> Unless I misunderstand, I can't change the CODEC driver's settings
> (such as ignore_pmdown_time) from the machine driver.  Even if I

You can get to the CODEC driver from the machine driver, and for
idle_bias_off there's probably a good case for just setting it
unconditionally given the lack of delays.

> could, I'm not entirely sure it would consistently fix the problem.
> For instance, if the auto-mute is set to 21ms, the DAC output is muted
> automatically by the chip after 21ms of no input and the pop still
> manages to get through before that on occasion.

That's why I'm suggesting ignore_pmdown_time as a first thing to try -
it should cause the powerdown to happen synchronously so there's no
chance for anything else to go in and change the clocking to cause a
pop.

> It also seems like a roundabout solution, that depends on proper
> sequencing, i.e. it is assumed that the device is always biased
> off before the hw_params callback of the machine driver is
> called, something which might change in the future and cause a
> regression.

The whole goal with the combination of idle_bias_off and
ignore_pmdown_time is to ensure that this happens in an orderly
fashion in a way that the core knows about.

> afterwards.  Isn't there some way to lock the component/CODEC's
> regmap, so as to perform an operation involving more than one
> register change atomically? Something like
> snd_soc_component_lock/unlock_regmap sounds like it might be
> generally useful, to synchronize access to a chip's registers
> across CODE/machine/etc. drivers.

No, there's no facility for that and it's such a niche case that I'm not
convinced it's a good idea to do it.  Another thing you could do here
though is to do the bounce as part of set_sysclk() in the CODEC driver.

--eG1/bcghN0MjPhCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvtwyMACgkQJNaLcl1U
h9AQ9wf9E5jf5QhTpKWsp0diTOtC26gbwOvlBl0NXwYObGyUfhH1srlOizUIpKXE
PVdh1cyw3ta4KXOJdQIlsX9j0RHeFbOgy4JxHi1sfDl9VcDi0qhFEBXkrKj+X4uW
IIxDBSVcSRXuTk8QVKKOw4HBctFxbo40I5zpyg1YQE6GWoshWLJopAERFqY4kO3y
RRIvBLMl0dNev5bTafBHnYTJVccmemarUUPGcYzRKiRZFveZBFuIy7sndfWvyF1G
QAWwHEtqV0f1AJIUjltpsF6x7ZJd/lTfbgic4NMWqkx+CjyWOb8OlOFOyUIXQoGg
GPrd8h1p8nSyPlloyhJeOzZ+1CRDPQ==
=Z4pg
-----END PGP SIGNATURE-----

--eG1/bcghN0MjPhCR--

--===============9129246515092885560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9129246515092885560==--
