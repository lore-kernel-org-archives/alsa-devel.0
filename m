From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer
	support
Date: Tue, 22 Jan 2019 20:25:35 +0000
Message-ID: <20190122202535.GK7579@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6125071218161369696=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A0352674A9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 21:25:44 +0100 (CET)
In-Reply-To: <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
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
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, gustavo@embeddedor.com, Takashi Iwai <tiwai@suse.de>, srinivas.kandagatla@linaro.org, mchehab+samsung@kernel.org, sr@denx.de, daniel.thompson@linaro.org, corbet@lwn.net, philburk@google.com, willy@infradead.org, jmiller@neverware.com, keescook@chromium.org, arnd@arndb.de, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, anna-maria@linutronix.de, mathieu.poirier@linaro.org, Baolin Wang <baolin.wang@linaro.org>, sboyd@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, leo.yan@linaro.org, joe@perches.com
List-Id: alsa-devel@alsa-project.org


--===============6125071218161369696==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="huG+SbfbdD6eblZQ"
Content-Disposition: inline


--huG+SbfbdD6eblZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 21, 2019 at 03:15:43PM +0100, Jaroslav Kysela wrote:
> Dne 21.1.2019 v 13:40 Mark Brown napsal(a):

> > It was the bit about adding more extended permission control that I was
> > worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
> > bit sounds like it might also work from the base buffer sharing point of
> > view, I have to confess I'd not heard of that feature before (it didn't
> > come up in the discussion when Eric raised this in Prague).

> With permissions, I meant to make possible to restrict the file
> descriptor operations (ioctls) for the depending task (like access to
> the DMA buffer, synchronize it for the non-coherent platforms and maybe
> read/write the actual position, delay etc.). It should be relatively
> easy to implement using the snd_pcm_file structure.

Right, that's what I understood you to mean.  If you want to have a
policy saying "it's OK to export a PCM file descriptor if it's only got
permissions X and Y" the security module is going to need to know about
the mechanism for setting those permissions.  With dma_buf that's all a
bit easier as there's less new stuff, though I've no real idea how much
of a big deal that actually is.

> Even with the full operation mode, it's difficult imagine what the
> depending task can break with the sound interface except probably annoy
> users with some cracks for the playback or start/stop the streaming rapidly.

In some embedded systems the ability to play back notifications clearly
can be very important to system functionality.  Obviously at times the
main purpose of the system is to play or record audio.

I don't have a *super* strong opinion here but I'm not really a security
person.

--huG+SbfbdD6eblZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHfD4ACgkQJNaLcl1U
h9Bi/gf/RX3fSAWWGh9peNObRd7J19zaw9F/D2+LAK882ygexXi+46clqp5voXp0
9ayUdE4ZGQEkJ7OMO9HFdBZLvWWwVdcovK9EPrWDKhEUzjZbmU71ZSrIqYm4eEyV
NHmJGrsWUMulWJsxsYmtAf+AF9uEke0/nWHSZlu7v26FIlihpZKx99IrBq3D5egh
6934PlTzIc7gzt2HFMRbeX7Wi8dQ+YyffoZ73kxjYENud7WbyC6tqWaWsihlApl7
T3mOL3UQx8DRCDwsR1zGbv2ECnjniTvuBPIFmuNB89jWWivjnQ7qdyasFR5i7Vw7
k7LxSzKlzpjvgPcFZSMwoFnXdPRN5Q==
=D6GE
-----END PGP SIGNATURE-----

--huG+SbfbdD6eblZQ--

--===============6125071218161369696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6125071218161369696==--
