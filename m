From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer
	support
Date: Thu, 24 Jan 2019 17:33:21 +0000
Message-ID: <20190124173321.GE5641@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
 <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de>
 <20190123124658.GE15906@leoy-ThinkPad-X240s>
 <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2903857328551767641=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E1D1D2676EB
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 18:33:29 +0100 (CET)
In-Reply-To: <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, gustavo@embeddedor.com, Takashi Iwai <tiwai@suse.de>, srinivas.kandagatla@linaro.org, mchehab+samsung@kernel.org, sr@denx.de, daniel.thompson@linaro.org, corbet@lwn.net, philburk@google.com, willy@infradead.org, jmiller@neverware.com, keescook@chromium.org, arnd@arndb.de, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, anna-maria@linutronix.de, mathieu.poirier@linaro.org, Baolin Wang <baolin.wang@linaro.org>, sboyd@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, Leo Yan <leo.yan@linaro.org>, joe@perches.com
List-Id: alsa-devel@alsa-project.org


--===============2903857328551767641==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2019 at 02:43:02PM +0100, Jaroslav Kysela wrote:

> If I look to the dma_buf_fd() implementation:

>   fd = get_unused_fd_flags(flags);
>   fd_install(fd, dmabuf->file);

> .. what if we just add one new ioctl to the ALSA's PCM API which will
> return a new anonymous inode descriptor with the restricted access to
> the main PCM device to satisfy the SELinux requirements / security
> policies? It might be more nice and simple solution than to implement
> the full dma-buf interface for the ALSA's PCM devices.

That certainly works for me so long as the security people are happy.

> Question: The dma-buf also implements the fencing, but I am not able to
> determine, if this mechanism is used in android [1]. It may allow
> concurrent mmap and synchronize apps - but the sound server should
> manage the access to the DMA buffer anyway. In my opinion, it makes much
> sense for the video-pipes when the hardware does some accelerations
> (encoding/decoding).

We had the same discuission off list and couldn't think of a need for
that feature in the audio context but left it in as it's already there
with dma-buf so there's no real cost to implementing it and we weren't
sure we weren't missing something.

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxJ9uEACgkQJNaLcl1U
h9BHRwf9GMsmMNurfImygbIVYIiOSvt5nUSqwx8eQXILTHWza2Pumojxs0EqTQgU
Tt3s81HcYK7RkDUqdV9BvarzZfQfA8pPK9+s7TzIIv1eJzIrRu8h5CJKaZwNhdzz
sHQki9F7tBbUKQXNlDvTvU078HyoaMe1I/yZgWrz1WJl2u3+FCugB137wke6fpSD
NyMTbC7JrwAVcNZWVCZcQHAs3cbPDc30FbZ2OmpQUcWhFOR9Y5lUpp4jzg811+cR
PwTuU8EyUNjZwzoj6gcVP1whifDugAIx7rLziEOKPLPE708MitHkVI+1+j32Xfcw
2aXLRNhXODvEP3Ll2N5mAx4GCwZqnQ==
=XB4S
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--

--===============2903857328551767641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2903857328551767641==--
