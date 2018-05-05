From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: nau8810: change the target of
	MIC BIAS supply
Date: Sat, 5 May 2018 10:01:10 +0900
Message-ID: <20180505010110.GI13402@sirena.org.uk>
References: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
 <1525315602-3620-2-git-send-email-KCHSU0@nuvoton.com>
 <20180503231047.GB13402@sirena.org.uk>
 <5AEBB308.6020006@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8824840283613323256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F71A2675CD
 for <alsa-devel@alsa-project.org>; Sat,  5 May 2018 03:01:17 +0200 (CEST)
In-Reply-To: <5AEBB308.6020006@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, CFYU0@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, YCPENG7@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============8824840283613323256==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Content-Disposition: inline


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2018 at 09:10:32AM +0800, John Hsu wrote:
> On 5/4/2018 7:10 AM, Mark Brown wrote:
> > On Thu, May 03, 2018 at 10:46:42AM +0800, John Hsu wrote:
> > > The MICBAIS will not supply if there is only one path from MICP to
> > > input boost stage. The driver fixes the issue by changing the supply
> > > target to input boost stage mixer.

> > Does the input boost stage actually use the MICBIAS supply directly?
> > More usually a microphone bias would supply the microphone rather than
> > anything on the chip itself.

> The input boost stage has a mixer of two input sources. The normal case
> is that MIC goes to input PGA, then to input boot stage. The case is
> the original design of the driver. But there is another path that MIC
> goes input boot stage directly. The case is less happened but has chance.
> Ex. The single-end MIC goes to input boot stage. Therefore, we move
> the target of MICBIAS to input boost stage which can supply power for
> both cases.

That's not really answering the question - the issue is that the micbias
is normally connected to the microphone and supplies that, it's not
normally connected to anything in the CODEC itself.  You're talking
about the path for the signal from the microphone which isn't the same
thing as the power to the microphone.  The system could have external
micbiases or use the input for something that isn't actually a
microphone for example.

--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrtAlYACgkQJNaLcl1U
h9CMJgf/Tqm21m9F3Fof5wMfZ+aTR06yVZCqmjqZqNdQwB7UjyPIQ3cxR/Qv8SiR
2uMJP0w6tqx3p5egwElW4wTQNly0WpuaNGdV4SAiIxbORdMzVYPy6ulR5RahZKsP
t2A+kuYjAPWbW1jHIAgahJ2JgCAIuHvAZij+SPKBeVqgDm6+aOVHQRV0xNrwxwFh
2vWdVKWddOt+hhvwc0Wqbj5HA3mm71gKPMPuTA2rCB3xdTR09bQ9v7/qYQF3Bq1o
36WgdpZLSlmfAKMbjRNWUJZ0aUy+xzcwmJsBrgtiEwR6PsbQGKveoesCE5yXeggW
r6vO4ZyIVGPPr8H5ayRcKhn20d4cWQ==
=WrF7
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--

--===============8824840283613323256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8824840283613323256==--
