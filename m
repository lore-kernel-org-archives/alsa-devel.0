From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share
	buffer	support
Date: Fri, 25 Jan 2019 18:25:15 +0000
Message-ID: <20190125182515.GD6939@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
 <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de>
 <20190123124658.GE15906@leoy-ThinkPad-X240s>
 <s5himyczxgl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2312676617832781919=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 279952666B3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 19:25:26 +0100 (CET)
In-Reply-To: <s5himyczxgl.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, gustavo@embeddedor.com, srinivas.kandagatla@linaro.org, mchehab+samsung@kernel.org, sr@denx.de, daniel.thompson@linaro.org, corbet@lwn.net, philburk@google.com, willy@infradead.org, jmiller@neverware.com, keescook@chromium.org, arnd@arndb.de, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, anna-maria@linutronix.de, mathieu.poirier@linaro.org, Baolin Wang <baolin.wang@linaro.org>, sboyd@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, Leo Yan <leo.yan@linaro.org>, joe@perches.com
List-Id: alsa-devel@alsa-project.org


--===============2312676617832781919==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2019 at 02:19:22PM +0100, Takashi Iwai wrote:
> Leo Yan wrote:

> > If we directly use the device node /dev/snd/ as file descriptor, even
> > though we specify flag O_EXCL when open it, but it still is not an
> > anon inode file descriptor.  Thus this is not safe enough and will be
> > blocked by SELinux.  On the other hand, this patch wants to use
> > dma-buf framework to provide file descriptor for the audio buffer, and
> > this audio buffer can be one of mutiple audio buffers in the system
> > and it can be shared to any audio client program.

> Hrm, it sounds like a workaround just to bypass SELinux check...

> The sound server can open another PCM stream with O_APPEND, and pass
> that fd to the client, too?

So long as we can teach SELinux that they're safe to export, yeah.

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxLVIoACgkQJNaLcl1U
h9BIlQf/c0GPSYvy1six7hAwKWMAQ1I97qAN/voUXyYjH2Ba9LCGY0NXVaMZBumu
e0hboaVbcfiE4TDKeCn2D6XyFw0RMmCUeS/xZp5lS0fPjOC/cjQhGEX9krOUxBV+
sWn6dJPzdTVF+pIsv7t3UsCJ09uwh3mQXx2lzvdG8mN9TY0dVYCg626qKaxnQwZR
DsPpDqxP8RSDZDlpozDZGz7OOgo6tw1J3MKVfTkx/nxCpe7cPMyTEjrBVFagRhQ0
0ATPOBtc/rH3wh4500vs1/p32NufvUwUhSBnQhk8AzqbSPGeGNW18SYUyg940KbP
ImR0G3QvM7VmN3WB7uyoiv0YSicgpw==
=Zsq2
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--

--===============2312676617832781919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2312676617832781919==--
