From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/2] ASoC: Add support for Conexant
 CX2092X DSP
Date: Tue, 11 Apr 2017 22:03:08 +0100
Message-ID: <20170411210308.nx5225tix237mbeo@sirena.org.uk>
References: <cover.1491446448.git.simon.ho@conexant.com>
 <1e118d265847bf96722b8898ee11891c047558c6.1491446448.git.simon.ho@conexant.com>
 <20170407113737.wp676mcrpeqwno72@sirena.org.uk>
 <20170410194340.GA2245@GMAIL.COM>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4051845407487743489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 36A3426684C
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 23:03:21 +0200 (CEST)
In-Reply-To: <20170410194340.GA2245@GMAIL.COM>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Simon Ho <simon.ho.cnxt@gmail.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============4051845407487743489==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="em6pmwyeoxpfpojn"
Content-Disposition: inline


--em6pmwyeoxpfpojn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 03:43:40AM +0800, Simon Ho wrote:

> The purpose of the tunnel interface are for debugng and tunning purpose.
> The manufactor can use the them to customized the firmware to suit their
> needs. furtherore, the commands are platform specific and also firmware
> version specific. So that it is impossible to provide such commands in=20
> kernel unless we change our firmware design and policy.

Changing that policy does sound like a good idea...  in any case if this
genuinely is just for tuning then I'd suggest removing this from your
initial submission and adding it as a separate patch so as not to slow
down the review of the bit that's used in production systems.

> The device have GPIO pin can be configured as interrupt out pin, this=20
> feaures is option, not a must for SR application actually. In addition,
> I think the interrupt is platfrom-specpfic should be configured by=20
> Machine driver, am I right?=20

No, I'd not expect the machine driver to need to get involved for basic
interrupt functionality - look at how other drivers do interrupts.

> > You really need to address this, a big part of how Linux has got to
> > where it is today is that it doesn't just have custom interfaces for
> > each device but instead generalizes things so that we share good
> > practice and features between devices and users can write Linux
> > applications rather than vendor specific applications.

> Just like DMic, I imagine. The DMIC is not configurable, but it still
> requires a driver to communicate with the reset of the system. This
> won't prevent people from developing the application for DMIC to extend
> its functionality.=20

Some components are indeed very simple but they still require
integration with the rest of the system.

> The device send the normal PCM data to host as it claimed by codec
> driver, and we confirmed that the device can work with most SR=20
> software without problem. =20

Could you please explain how this device works and integrates in the
system, I'm completely at a loss as to how this is supposed to work.
You appear to be saying that the device simply passes through audio and
provides no information to the rest of the system.  That makes it
unclear what function the device is performing.

--em6pmwyeoxpfpojn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljtRIsACgkQJNaLcl1U
h9B2eAf9FQHEuLWDalQy1/5HcqebvjH8mzcqSHrMTdEjNmuNdSkq58HoKlvp2dlF
JVMGX35sGCELbIG6uw3EiPNArY3S8T1sFKnnwpsMZTIDGsfKY+nwA8Tc+8ShP/p8
eA2cXgD1AI/fesceQs163s8N8PhnzUwxmCKI/kUXc8F5d9iQs/UpDr6Y55w9l9YU
RTX3K1/zM5jpVA4wHMt+6H4tIdc8Q3RUckRfuscXl4VjphfnRVU9fgnXkZ20YVAu
nsTruttMsjFl+rhUd+0A+kHNY06t6P2oPk4C98erI/86duhIMbUEv9ZkpaTTHLdK
0IVPbD6vqp0ZcKuG2jeANAefNzmyWA==
=8q+V
-----END PGP SIGNATURE-----

--em6pmwyeoxpfpojn--

--===============4051845407487743489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4051845407487743489==--
