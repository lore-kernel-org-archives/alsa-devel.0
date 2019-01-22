From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 04/14] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Tue, 22 Jan 2019 21:13:19 +0000
Message-ID: <20190122211319.GP7579@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
 <20190109203720.GQ10405@sirena.org.uk>
 <876df209-c829-873e-047e-c73fb0579d68@linux.intel.com>
 <20190122190425.GJ7579@sirena.org.uk>
 <c4555b61-249c-7c7e-65ed-426e4be32309@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3853931687183745413=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <c4555b61-249c-7c7e-65ed-426e4be32309@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Jie Yang <yang.jie@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3853931687183745413==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sGwo475CiIwWEjLI"
Content-Disposition: inline


--sGwo475CiIwWEjLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 03:05:23PM -0600, Pierre-Louis Bossart wrote:
> On 1/22/19 1:04 PM, Mark Brown wrote:
> > On Thu, Jan 10, 2019 at 02:11:32PM -0600, Pierre-Louis Bossart wrote:

> > > Messages can be as big as the mailbox, which is hardware dependent. It could
> > > be from a few bytes to a larger e.g. 4k page or more, and indeed we need to
> > > keep the lock.

> > Is this copying into an actual mailbox or into some data structure in
> > memory?  It looked like it's copying into a buffer for sending rather
> > than the mailbox.

> I realize between your feedback and Daniel's that we have a terminology
> issue. On the Intel side we don't have a dedicated hardware mailbox unit,
> it's only doorbell registers and shared memory windows.

Ah, that's what I thought was going on.  What I was expecting was a
sequence of operations along the lines of:

  1. Allocate a buffer for the message.
  2. Fill in the message.
  3. Mark the message as readable by the DSP.

so you only need locking for steps 1 and 3 (and a similar path on
return).

--sGwo475CiIwWEjLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHh24ACgkQJNaLcl1U
h9Cj6gf+I+bgOQzZZY4cIVkQkmcSdrMgW3hU33zACcJlfnVOrQrvUU8FNXV7YAvq
Q1Z3uyIegBtYLb9oKWoQ05ln6kFXwh3sHsenpHqp+mjpUNleyeednRHsrlA3RV5W
SpMJ9/EhB28mK+BcpL3zXDTDaG64NhOurZgJpZJLasrMN4Bt6kXokPFxOrbIydLa
cqXzYTiFpT2RPHfLjApBbuWm0/mS4yG7WCQ0gVL1cRcZTIK0J2CynRYwcNcpsfci
oAU4eiU230/NG9g5dgeUwjK+JuRf1F2XUTiJNEsJ+kkxNGFOyPjvGOkUyfawcv5X
o4fFYoV9CCaYgCxbgcQx4F1+FDmhcA==
=AyGC
-----END PGP SIGNATURE-----

--sGwo475CiIwWEjLI--

--===============3853931687183745413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3853931687183745413==--
