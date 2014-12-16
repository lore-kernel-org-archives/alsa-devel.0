From: Mark Brown <broonie@kernel.org>
Subject: Re: Streaming wake-up buffer from DSP to SoC over SPI
Date: Tue, 16 Dec 2014 11:40:11 +0000
Message-ID: <20141216114011.GO11764@sirena.org.uk>
References: <CAEUnVG6n15vNYgZoZXzRZvgAqej1Lb3bHDEy9cyQ+UCJbuv2kg@mail.gmail.com>
 <20141216044115.GU16827@intel.com>
 <CAEUnVG4OexC99Cxbd7TF7NQxxk8wQd0WRQS8Q6mzMMY1X5PWgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5500957970131835028=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 010F22605CB
 for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2014 12:40:25 +0100 (CET)
In-Reply-To: <CAEUnVG4OexC99Cxbd7TF7NQxxk8wQd0WRQS8Q6mzMMY1X5PWgA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@google.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============5500957970131835028==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2GakNc7NZZagqQ4g"
Content-Disposition: inline


--2GakNc7NZZagqQ4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 16, 2014 at 12:16:40AM -0800, Dylan Reid wrote:
> On Mon, Dec 15, 2014 at 8:41 PM, Vinod Koul <vinod.koul@intel.com> wrote:

> > The device here wont be any different than regular PCM/Compressed devices.
> > Assume the data path is SPI rather than I2S so things would be modelled that
> > way. You still need to setup SPI port, DMAs like you would do on I2S.

> Ah, I hadn't thought about using the compressed framework.  I can see
> how that would make this easier.  I'll take a closer look at it
> tomorrow.

You should be able to use a normal device as well, you need to either
arrange for the driver to buffer data until userspace starts the magic
stream or arrange for userspace to not mind if it blocks for extended
periods.  Either compressed or uncompressed should work.

--2GakNc7NZZagqQ4g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUkBoaAAoJECTWi3JdVIfQ0X0H/3JszFzyTRKYEtnXbp9l9ETe
8FJxuXDiDs4zb31XyXoX7EI8cgnEAw8ibVj2es0JD5aAQCwcMmFTXr8p1N4MjlpS
07wiog7FUXE/e7o8iENe3EMR6BmeKEqZC/l1u6rlRNbKRJfEDWT6fbx8IvJzHMly
KNl6zZUGHh3dWRcThvkh8bmrt0t1nVv/YrMgiGJw7PlZsMzjf+oijzoTWTMjPdP0
ZTq/nJB9+uUoSB01TGbXCkNdIOpEg+nBB33Dlqkb5fcCZIFZw/Ct+nu0GBGN5Jc5
4fTPG3+JO8vElgK83mUpeZ8F49zYqx0L/DlSrI/yUvEREPszFRsVr9TVi9w/GII=
=DQ5g
-----END PGP SIGNATURE-----

--2GakNc7NZZagqQ4g--

--===============5500957970131835028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5500957970131835028==--
