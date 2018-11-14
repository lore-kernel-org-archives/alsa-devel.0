From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Wed, 14 Nov 2018 14:06:40 -0800
Message-ID: <20181114220640.GB2089@sirena.org.uk>
References: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
 <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
 <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5074893187178967034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F9AF2677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 23:06:47 +0100 (CET)
In-Reply-To: <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
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


--===============5074893187178967034==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iNKvvK4J48bNrWSb"
Content-Disposition: inline


--iNKvvK4J48bNrWSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 10, 2018 at 05:46:33PM +0200, Dimitris Papavasiliou wrote:

> Are you also getting loud pops when switching between clocks?  I
> use the following Python script to reproduce the problem (and
> also disable auto-mute via the mixer, as it can mask it):

Switching between clocks while the device isn't completely idle is
unlikely to work well with any device - I'd have questions about a use
case that's doing that.

--iNKvvK4J48bNrWSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvsnG8ACgkQJNaLcl1U
h9AMIAf9E4O/TB5FmYyBMc2ZuuVEqElJrPbQX0AZ/dKkuS4G05LRQSXKFifmhPF4
eM1NIgFSaITTFcjIUYMFiZPONrOF6Aq1GapypUWuvngS896YymF3OOnVZ/nX2g95
gM0GyjFf91Sv44gtrWeUTuJhYUfCk+nS+98hRxgbbptX/cHQX35lqX/u5/t0/2g3
kF0ZX/TIl36m3cco4vvkj53rssDGtmdAq4e5QqE5HaXGIRLdnON1qByG88eDDuJo
vY4UfZ1g6h1CAb9N1kTiSD6vhtGyEzBtTVxskDhQ1zybsRzoFupXcno8+WQisqKj
8rnIdnwmnFPvWc8bUVF+Go9Nf2TfIQ==
=d25X
-----END PGP SIGNATURE-----

--iNKvvK4J48bNrWSb--

--===============5074893187178967034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5074893187178967034==--
