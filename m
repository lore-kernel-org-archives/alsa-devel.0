From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Wed, 19 Dec 2018 16:19:49 +0000
Message-ID: <20181219161949.GD8130@sirena.org.uk>
References: <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
 <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
 <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
 <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6425669323864681241=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B8D9926770D
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 17:19:51 +0100 (CET)
In-Reply-To: <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
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


--===============6425669323864681241==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 18, 2018 at 12:39:09PM +0200, Dimitris Papavasiliou wrote:
> On 12/17/18 6:52 PM, Mark Brown wrote:

> > The device being open shouldn't have any impact on the power state?

> It's been a while since I tried it, but, as far as I recall, that was
> the observed behavior (determined via printk statements in the CODEC's
> set_bias_level callback).  To test potential fixes, I have a script
> that opens the device and switches sampling rate between 44.1kHz and
> 48kHz every one second.  It popped almost every time.

If you're saying you're keeping the device open while you're doing this
(rather than closing the stream and reconfiguring) then I'd expect
you're going to find other hardware which has similar issues, reclocking
the device isn't something I'd expect to be able to do glitch free.

> > I would expect the stream to be closed and reopened by most applications
> > in between reconfigurations like that, it certainly used to be the
> > common pattern.

> If by stream you mean the device, then perhaps they do.  As explained
> above, I test using a script, instead of using applications, such as a
> media player, as it's easier to reproduce the problem repeatedly at
> will and under controlled conditions.  At any rate, a potential fix of
> the problem, shouldn't depend on application behavior.

The application does have some responsibility for ensuring that things
work cleanly, there are limiations on what hardware can reasonably do
and often trying to do things behind the hardware to avoid problems in
unusual situations results in a lot of effort that's perhaps not worth
it.

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwab6UACgkQJNaLcl1U
h9ApKwf+N6bTGZ1nwWhlJ1T5NJ4XnCtdbIiFoasRHxEKOAFRJhbFMhKEt5qM8p5W
dHV2V7MgsMs3QhjNwSB3tCxzlRT+LCwp8BCGYeKfkSLp23xsO0hCnlaVtsApUSip
j/CmTq+p2kjeJLSt3znuxfYjjvk+B0KV/5nazFdr66mwOw+wjOO757DPCmvdcy2S
hE9El8iEcWnJ2CPBdcXeK6c4gWcbddyi1OrNefbf0wS6p8HdxJyDAY8cDRaJXwwf
U48V0u2T6frE57LG/+jtpb1N0igDGKuujk4e+KYwieIgZktUCYFmgF3GMnz0Pn4b
dL9QzeQ+jzb67Z0KGk9qK87A+YjcYw==
=S9sm
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--

--===============6425669323864681241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6425669323864681241==--
