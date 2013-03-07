From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
Date: Thu, 7 Mar 2013 17:31:23 +0800
Message-ID: <20130307093117.GB14315@opensource.wolfsonmicro.com>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <20130306171333.GR17833@n2100.arm.linux.org.uk>
 <20130307023316.GA22554@opensource.wolfsonmicro.com>
 <20130307091804.GA17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8098831019653206079=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55F6D265D58
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 10:31:57 +0100 (CET)
In-Reply-To: <20130307091804.GA17833@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Huang Shijie <b32955@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8098831019653206079==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2013 at 09:18:04AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 07, 2013 at 10:33:19AM +0800, Mark Brown wrote:

> > Could you go into more detail here please?  Looking at the code I'm not
> > seeing any allocations done by the library code at all, the allocations
> > are all done by the individual platform DMA drivers so I don't see
> > anything stopping them doing what they need.

> I don't know what else you require apart from the description above.  Isn't
> it rather obvious that you can't preallocate the ALSA buffer against the
> DMA engine device if you can only obtain the DMA engine device in the open
> function?

The bit I'm missing is why this is particularly hard to change, it
doesn't seem like a massive refactoring and there's not many users.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROF5dAAoJELSic+t+oim9TGwP/jNEBn/fMp7CxQ4ypFqfIX0X
ovUXqoBuCXm9g9LhPeVei1/1eZgWN1mVz3Jz76FpklXHhGgYujcVot1ct2K1Fo0p
+RDhfVjjsQAgnE5ut4h0dWhegddbZIIWhQE63FrHHrO1F3GjRAjcduNa9Bu/rTsG
MdkTIvK5g87U1qxPKWNHrq2g4apeDfJJmi8ZpnmlDcxO+4H/ByMJuc3oOg93woj5
C7vk3Rd1QoNkP6gMb4OBygN6uWGGf4XnjnKmBtpaMefnW9rZwBgHmTZKIHKMeqR+
d10oCtc34kqmj6+WRkn9BAJCyJvpyB2RNiEMFHjFtfJO/RcVlJkL3UYlfsXB9OPI
ZztEVxMQ/aHf0792KfjGtoZJmfZdJQLknWNahKTxPLUmTq9uDZPahGukGnkwJHB7
1fNp0ZwSDpz4DDkL7LXkHF1WHIrPA79v/7ysHjPrbKTni/PRvoflkDtryty3SmfA
b34QHSL4cupIUdFlPkUlC9WS8aSLELU7/3RRsm0GhUXYOaecQTakP8OmrTQdIxl7
2GuUTrY+mPXxPacdfd0Nn6Tleds1KUx5HIcjISOQes36i6GZorO+rJeDiStYJEg9
k5CjizmsBQHMr9/Z94rcuqcljytpDWoFd2Kx/Niyyxu4wEpzpVDoOokDqmScam8P
Ewp7mzBuDQZ/D4qIjgUH
=yQ3J
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

--===============8098831019653206079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8098831019653206079==--
