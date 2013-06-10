From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine: add runtime status
 checking in dmaengine_pcm_dma_complete
Date: Mon, 10 Jun 2013 10:31:55 +0100
Message-ID: <20130610093155.GK31367@sirena.org.uk>
References: <1370606249-19955-1-git-send-email-zhouqiao@marvell.com>
 <20130607143428.GR31367@sirena.org.uk>
 <51B4850C.5090508@metafoo.de> <51B4884D.3010904@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1515725928842958955=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 971AB26109D
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 11:31:58 +0200 (CEST)
In-Reply-To: <51B4884D.3010904@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: tiwai@suse.de, Qiao Zhou <zhouqiao@marvell.com>, alsa-devel@alsa-project.org, zhangfei.gao@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1515725928842958955==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R7M+3ROIzrLwNusK"
Content-Disposition: inline


--R7M+3ROIzrLwNusK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 09, 2013 at 03:51:09PM +0200, Lars-Peter Clausen wrote:
> On 06/09/2013 03:37 PM, Lars-Peter Clausen wrote:

> > I haven't see the original patch, but the proper solution to this problem
> > should be to add a check to snd_dmaengine_pcm_close() to see if the DMA is
> > still running.

> Ok, since this will never happen, I suppose the problem is rather that the DMA
> callback is called after dma_terminate_all() has been called. Which sounds like
> it is a bug in the dmaengine driver. And this will likely also be a problem for
> other users of that dmaengine driver and not only the ASoC driver, so it should
> be fixed in the dmaengine driver.

Just to clarify what is it makes you say that this will never happen?

--R7M+3ROIzrLwNusK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtZ0IAAoJELSic+t+oim9W+cP/2t8odqWyx16JPtek1ywaAe5
W+x1aFhzSeJ4+E8CBIiGp/SEbLV50yBXkoCaIFi01G2USIdWaOJDHztepTZxcb5E
iQRIwRKNHYEMJ6fWjrdMn4gc6pIXjdGVP63dLfNHcml+QOMhUBEVg44CFwiSorZL
Ouxrnr492nOHgsyJ56x8UpjU2u9m9v515lLewKOa1eM1w/AW6iGRWrQW9fK2+sCQ
DcQT7wiQ8uoP4JElrzPlgUHusBLsU4a68iOq6gCXb3BYtGuzJ+SYUHIWDkPTs9YB
GwnSgUxBi07ric4UAI3Mp2qqTjL14f5legg7A1fOHHyDTAZnKm3RzVvOSbHLP+bi
21QO2eaNjXkBKXsGx4GLPLhNsoi1JGb1u9hVCpPfIIyMXY5CWf2TQeugzXaMOk5V
BZjoLTFqMzROFcE/61qfRxGdbDIMXuVAVRbGBt/YABLXNb4fdzVBWsIEGoHhZ1m+
5unC1I488dzqO2kFRMz4mKWwQeWDNu2eYtnLlJeNa1OpO5NSdBHKnTAn2swQNNHB
HQTY+TVS1EnUF6ladFXLj3F6iLP0//7JqTowdtZg+HROc7ampclhbNPpMO0GoetK
LSZNy+oYv3p13nHiqPI6dMoR1lBYDywOv3hKtilKjq6WVXu2byoEkAyVKyXCEU94
8CvPZ7PMo0GMvcNALGyF
=2dEB
-----END PGP SIGNATURE-----

--R7M+3ROIzrLwNusK--

--===============1515725928842958955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1515725928842958955==--
