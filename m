From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer
	support
Date: Fri, 18 Jan 2019 19:08:05 +0000
Message-ID: <20190118190805.GF6260@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6418817251262715067=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 25CFF266AA9
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 20:08:14 +0100 (CET)
In-Reply-To: <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
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
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, gustavo@embeddedor.com, linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org, mchehab+samsung@kernel.org, sr@denx.de, daniel.thompson@linaro.org, corbet@lwn.net, philburk@google.com, willy@infradead.org, jmiller@neverware.com, keescook@chromium.org, arnd@arndb.de, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, anna-maria@linutronix.de, mathieu.poirier@linaro.org, Baolin Wang <baolin.wang@linaro.org>, sboyd@kernel.org, tiwai@suse.com, vkoul@kernel.org, leo.yan@linaro.org, joe@perches.com
List-Id: alsa-devel@alsa-project.org


--===============6418817251262715067==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 10:35:44AM +0100, Jaroslav Kysela wrote:

>   the tinyalsa implementation does not show much - it's equal to the
> standard mmap access for the PCM devices. Even considering the Mark's
> text, there must be an arbiter (sound server) which communicates with
> the producer or consumer to control the data flow. I really would like
> to see a real usage for this.

Right, the driving force behind implementing this is Android which had
been using an out of tree version of this approach based on ION but
that's run into trouble due to other outside changes.

>   It seems to me that the only point to implement this is the
> permissions. We already have O_APPEND mode for the PCM file descriptor
> which can reuse the PCM device multiple times (mmap the buffer to
> multiple tasks). I would probably go in this way and add more extended
> permission control for the PCM device, so permissions can be restricted
> for the passed descriptor to the producer or the consumer task. In this
> way, the restricted task might reuse other control mechanism offered buy
> the PCM file descriptor without requesting the arbiter to do so (like
> read the actual position in the DMA buffer, get the audio delay or so -
> reduce context switches).

One concern I have with doing some ALSA-specific custom permissions
thing is integration with frameworks like SELinux (they'd presumably
need to learn about the ALSA specific stuff to manage it).  It also
seems like it's adding a lot more security sensitive interfaces and=20
code which which will require audit and review, one of the things I=20
really like about this approach is that it's incredibly simple from
the security point of view.

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCJBQACgkQJNaLcl1U
h9C1nwf6Ajg+8dtn4R9gXvvYxYKD3C8tBRZVKey3ANemRTEaLMVqPnepM0fFdfkq
aF3R/XWSTimr4VSDwiAjWILSgLFWyrDtrApIWCLic7hIAi3coe8ZwCQTgi+ADtxZ
1l/bwAX1j54kCEA3veyUf79yV7OHZ4pYzhJ5nDA/HDeyVbLsZ9IanqtsRo8nHpbS
GFBES7IFSPS9CbvzDIhfKS7F4OVrDecZR0F0SO62DSiExKjj+xfbt8Vnf1QyM41v
69E7CZKoU93F/HfDuqTg+zsFrCsNtE8j7rhrbir0Ub1goKXXdh/7g6voRGgu0mse
hdbw6qz6rJIU475liQwQG6zo041XPA==
=p664
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--

--===============6418817251262715067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6418817251262715067==--
