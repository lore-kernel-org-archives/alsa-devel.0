From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine: add runtime status
 checking in dmaengine_pcm_dma_complete
Date: Wed, 12 Jun 2013 15:39:44 +0100
Message-ID: <20130612143944.GF1403@sirena.org.uk>
References: <1370606249-19955-1-git-send-email-zhouqiao@marvell.com>
 <20130607143428.GR31367@sirena.org.uk>
 <51B4850C.5090508@metafoo.de> <51B4884D.3010904@metafoo.de>
 <20130610093155.GK31367@sirena.org.uk>
 <51B5AE9C.6020207@metafoo.de> <20130612074337.GH4107@intel.com>
 <51B8665C.7070109@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5953269829354706433=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 37107264FDF
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 16:39:55 +0200 (CEST)
In-Reply-To: <51B8665C.7070109@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, tiwai@suse.de, Qiao Zhou <zhouqiao@marvell.com>, alsa-devel@alsa-project.org, zhangfei.gao@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5953269829354706433==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YCGSkTKVt49j0xAo"
Content-Disposition: inline


--YCGSkTKVt49j0xAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2013 at 02:15:24PM +0200, Lars-Peter Clausen wrote:
> On 06/12/2013 09:43 AM, Vinod Koul wrote:

> > Yes you need to call dmaengine_terminate_all(). But even then we might have
> > trasaction in flight or some dma controllers cant abort immediately (need to
> > wait till FIFOs are flushed etc). In general it is a good practice to call
> > dma_sync_wait() before you tear down the client.
> > If you still see an issue, then it a buggy driver :)

> Even though if the driver can't abort the transfer immediately, I'd still
> expect to not see any calls to the descriptors callback after
> dmaengine_terminate_all() has been called.

It'd certainly be much less surprising - if something's terminated it
really oughtn't to be generating callbacks.

> We should probably still call dma_sync_wait() though before we free any of
> the DMA transfer buffers. But I guess this will open a whole new can of
> bugs, since none of the drivers actually seem to mark a descriptor as
> completed if the transfer is aborted using dmaengine_terminate_all()

Oh joy.

--YCGSkTKVt49j0xAo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuIgsAAoJELSic+t+oim9eJcP/ioyqLfyxqFDXUhh0svX4MjJ
D4tQokIgGNEc/OMcT4Ix+3ENcSlNdMaI63zfnU6D63ILYfXzLvPnFaE007z17igy
jyQPjTY7k0PUcivEOxF1Rt4K2EkLJcK6XH9IYFOl6stU6C0RxFemjQ+UCfFd6Apo
bp42sWQmYu2Vo0tgn7kWsfuyl/kFWOGVkL9EqCwzo8mUwZhc6gNjzgSqR+2MKzhf
TVAoUBd8FcXrv3dZjrr5YOoesFbBFX6gX8miYVPmChKZsgMQosaJjrIpcxYcdiFn
2N/+pqKY3MjHlb6BQe/mdHpNYSMsZBLy0akES/dFOjALRzr4Fy6lNN3U5J9kwnv0
TJdXBjJOFoP5Eq/gzsmvZxqDMVkoC2p+Nas+uSbMMAXL3cNLpCbFyN2WFG+Yw8/q
RBLutZFJF1jf/+s7wiv/J5Wbe1+dNoWQWPYygiQbtQRPfToAldkvYUm4l/ImYLIj
jZUciAGIOnv5B4C91nztJ/doPu7NGysmkGWRb8yKpnH8ozJRMLomncnIGiYtb228
Eue8w3JOE416/1JoUgS3m2jXwz0kNRyfIBqLuO6n4FxB5RPeB+IHNjbBUHaNParL
iUoyEGtBDaAGduJPIxlTJX0JEktp0yEt4BFvKhjblf4uomRXDyY3v78GW1OtTeNR
uYWyQUcT6lsmOY4tv8ub
=tbQl
-----END PGP SIGNATURE-----

--YCGSkTKVt49j0xAo--

--===============5953269829354706433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5953269829354706433==--
