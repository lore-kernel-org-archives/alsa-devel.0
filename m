From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/2] ASoC: Add support for Conexant
 CX2092X DSP
Date: Fri, 7 Apr 2017 12:37:37 +0100
Message-ID: <20170407113737.wp676mcrpeqwno72@sirena.org.uk>
References: <cover.1491446448.git.simon.ho@conexant.com>
 <1e118d265847bf96722b8898ee11891c047558c6.1491446448.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3817169439011766151=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 64A992664EB
 for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2017 13:37:50 +0200 (CEST)
In-Reply-To: <1e118d265847bf96722b8898ee11891c047558c6.1491446448.git.simon.ho@conexant.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: simon.ho.cnxt@gmail.com
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============3817169439011766151==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zjsjps34g27zdpjq"
Content-Disposition: inline


--zjsjps34g27zdpjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 11:04:34AM +0800, simon.ho.cnxt@gmail.com wrote:
> From: Simon Ho <simon.ho@conexant.com>
>=20
> Initial commit of Conexant CX20921/CX20924 I2S Audio DSP driver
>=20
> The CX2092X devices are designed for virtual assisant application need to
> be always open, listening for users to summon it. There is no any power
> saving mode support on this device. The processed voice data will be sent
> to automatic speech recognition (ASR) application for further processing.

This is still fundamentally just passing undocumented commands straight
through to the device (presumably to a firmware flashed onto the device
since there's not even a firmware download happening) without any
substantial integration with the rest of the system.  That still doesn't
really feel like a Linux driver at all, it seems more like it's just
punching a hole through the Linux driver stack for proprietary software
to do its thing.  I'm also not clear how this can even implement always
on speech recognition, there seems to be no interrupt support which I'd
have thought would be a requirement.

There are other vendors with voice processing features, the drivers for
all these devices should be presenting interfaces that look similar to
each other.  What those drivers doing treaming the speech data to the
host via a normal PCM which blocks while there's no speech data, that is
much better integrated than this.

You really need to address this, a big part of how Linux has got to
where it is today is that it doesn't just have custom interfaces for
each device but instead generalizes things so that we share good
practice and features between devices and users can write Linux
applications rather than vendor specific applications.

--zjsjps34g27zdpjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljnegEACgkQJNaLcl1U
h9Asywf9H4FtpVhmuPPxKqajnmwQM/fNibQh3axBNcNca77gzQWJofUWEMg5EIOA
DjV7ATbU8iDKhIiiShDekykkwa2XbJv9JO9rLbBtjTuffdyQMTPolmlQk8S2AF0Y
huqzxfc4ehMPm/26QGt3rj8eba9+JLrwNO5eutcYVD1OARMg/7AfpkUcjPAs3cBA
LPfrpO7fV57FV4so5nu066ZCwBHUYgXjjyQj5ajg7pUeV2j/q7ILKhp0z3JaGNi0
3fL7jjy+uiD1CoiQkpGDJsfL1C19Xk+EiPSpe4dvnCx3bqJ1NFQoigghugyzs6+r
QK2PTiGBvuUHH9Nl3M7doh329FQddw==
=nEDw
-----END PGP SIGNATURE-----

--zjsjps34g27zdpjq--

--===============3817169439011766151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3817169439011766151==--
