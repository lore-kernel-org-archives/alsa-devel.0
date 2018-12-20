From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Thu, 20 Dec 2018 15:36:13 +0000
Message-ID: <20181220153613.GC9325@sirena.org.uk>
References: <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
 <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
 <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
 <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
 <20181219161949.GD8130@sirena.org.uk>
 <8c996338-19a3-996b-16dc-5535688ccea2@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8176753949106417010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D01CA2678D4
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 16:36:14 +0100 (CET)
In-Reply-To: <8c996338-19a3-996b-16dc-5535688ccea2@gmail.com>
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


--===============8176753949106417010==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 11:44:46PM +0200, Dimitris Papavasiliou wrote:
> On 12/19/18 6:19 PM, Mark Brown wrote:
> > If you're saying you're keeping the device open while you're doing this
> > (rather than closing the stream and reconfiguring) then I'd expect
> > you're going to find other hardware which has similar issues, reclocking
> > the device isn't something I'd expect to be able to do glitch free.

> I got pops even if I opened the stream, called hw_params and closed it
> on each iteration, but, as it turns out, that was in part because I
> was being lazy, using a Python script to do the above, which sneaked
> in a hw_params call immediately after opening the stream, to "reset"
> it to default values.

Wow, that's...  interesting.

> So I've retried your suggested approach.  It looks like setting
> .ignore_pmdown_time = 1 in the snd_soc_dai_link of the machine driver
> is enough to cause immediate power ups/downs, but I get the following
> behavior: The device gets powered up immediately after the first
> hw_params call (even if nothing gets played subsequently) and it gets

Are you sure it's the hw_params() call itself?

> powered down immediately after it's closed.  This does avoid the pop
> when the device gets configured right after opening it, which, as you
> say, seems to be what usually happens (I checked with the SoX play
> utility and the MPD), but a pop is generated if there are multiple
> hw_params calls and the sample rate is changed in any but the first one
> (where the device is still powered down).

> This can conceivably happen (for instance the Python library I was
> using, forces you to make multiple hw_params calls, in order to set
> more than one parameters).  Is there some way to configure the DAPM to
> power up the card right before playback starts, and power it down
> right after it stops?  This would prevent pops even in such
> pathological cases.

This is what's supposed to happen.  DAPM is triggered in the prepare()
callback, you can call hw_params() as often as you like and it should
have no interaction with DAPM at all.

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwbtu0ACgkQJNaLcl1U
h9DH8Qf+KLb5K3tqdN+ieifBLxaie+miOVsN8Yoxcp5t05IUA5ec489Cvo3hprnT
yggW8F04v+om6IcOQCB4MF9wkHf87PL+7pw7TT9bL4ixB1zhUQ40kcZgTbQsBp+o
o/4yWFMIfl8Xt2OGsNRVH7IiAYL67/DI0oaXjgPXMYnJxhOMb574nRya4OUv1uSW
bVOhNOpYL/438gtR2HYqXD35IdZ+R3n6incIvkE8iQyJj7KaN0Qh7sIpvICBHy12
w8Z1ER+9r1Pm/SOgypWU93U4n1EbAY6SWEedY3PJ9M7TtqbprVsvw3rb6VT3VvEd
aAS8kQ1TUbgZOoQZxqwbGfJJmwZoHg==
=dy9U
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

--===============8176753949106417010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8176753949106417010==--
