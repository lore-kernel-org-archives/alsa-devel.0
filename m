From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer
	support
Date: Mon, 21 Jan 2019 12:40:53 +0000
Message-ID: <20190121124053.GA12679@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4462955845532462947=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9492E267333
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 13:41:02 +0100 (CET)
In-Reply-To: <s5hzhrxzrez.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, gustavo@embeddedor.com, srinivas.kandagatla@linaro.org, mchehab+samsung@kernel.org, sr@denx.de, daniel.thompson@linaro.org, corbet@lwn.net, philburk@google.com, willy@infradead.org, jmiller@neverware.com, keescook@chromium.org, arnd@arndb.de, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, anna-maria@linutronix.de, mathieu.poirier@linaro.org, Baolin Wang <baolin.wang@linaro.org>, sboyd@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, leo.yan@linaro.org, joe@perches.com
List-Id: alsa-devel@alsa-project.org


--===============4462955845532462947==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 08:39:32PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > > multiple tasks). I would probably go in this way and add more extended
> > > permission control for the PCM device, so permissions can be restricted
> > > for the passed descriptor to the producer or the consumer task. In this

> > One concern I have with doing some ALSA-specific custom permissions
> > thing is integration with frameworks like SELinux (they'd presumably
> > need to learn about the ALSA specific stuff to manage it).  It also

> Well, I wonder what makes it more difficult by the approach Jaroslav
> suggested.  With O_APPEND, you can just call mmap() normally, and
> that's all. What's the merit of dma-buf approach wrt the security?

It was the bit about adding more extended permission control that I was
worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
bit sounds like it might also work from the base buffer sharing point of
view, I have to confess I'd not heard of that feature before (it didn't
come up in the discussion when Eric raised this in Prague).

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxFvc0ACgkQJNaLcl1U
h9DIZgf/diES8I2aHgDHGiA47EDxQwSzkQCDjdVP1gzfiRds2qC+I8F2LGrRw7ds
5KeWEpM8zfxhM1qzxaErnzvJlq7iLHij6K/azhmDQlep2uCZZu0xT0+kVH+0Sl44
C/QbUosmDwzfDIIZo6YjubD1iKoRgTmZkmZVvGhqDQYFOTO75j7BBw445uphGTJ0
RPSYeAWob3mluUOy9Ob0zT259QRuGKr+Xa5S//M5dl1vwzTdnOb6hx+jc0hZWe8E
yLb6xoxfxq9UPWdt28dhBDmjrDvvYs2pPL9JiY3aIEYM2+OP2y/HKuwSG1bQpH+Y
azcEo7jf20gO+kf2Sa6AaYnOp+5yrA==
=SAV5
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

--===============4462955845532462947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4462955845532462947==--
