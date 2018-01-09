From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip: i2s: Support mono capture
Date: Tue, 9 Jan 2018 16:39:43 +0000
Message-ID: <20180109163943.GC11471@sirena.org.uk>
References: <20180105221242.22083-1-mka@chromium.org>
 <20180109000115.GA184703@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2004248649577271284=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FF9B26719C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 17:40:22 +0100 (CET)
In-Reply-To: <20180109000115.GA184703@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Dylan Reid <dgreid@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2004248649577271284==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 08, 2018 at 04:01:15PM -0800, Matthias Kaehlcke wrote:

> Due to different issues in our audio recording path I couldn't test
> this properly, and only looked at the .wav data in audacity, which
> appeared to look ok. After putting some of the missing pieces
> together and I noticed that mono capture doesn't work as intended,
> the recorded audio is slowed down. I think this is because the I2S
> controller keeps generating a two-channel stream, however the sound
> system interprets it as a monophonic stream because of the channel
> configuration.

That seems odd - I'd expect underruns somewhere?

> Not sure if there is a clean solution for this if we can't tell the
> hardware to generate a single-channel stream. Any suggestions or do
> we have to revert the patch?

It sounds like a very standard problem with I2S devices, it's a
fundamentally stereo format after all.  If you can't get it to discard
the second channel there's probably not much doing.

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpU8E4ACgkQJNaLcl1U
h9CNggf+M899bG3zeS/CrKb2ovGdRSbS0DqZCMjSO1u8VaLwabjfhEw20uDjkKXh
OnjOKE0AQVkCvSJS4hCdbw1xg+ObkCbkjcq2rGlR1ln4ANjfhvz9VO9xTFe5NvG4
zOyczymwwuLKWJX4p7Gsim+wsLwdUnMc4zcvP/QWkAHLcPNrMtYbed0AK7qDc0Ou
CuoBOCKc7idtJjXpIj6nQitUpFzaj6l4+WTSMWflNlLl/MS9XfuKwGHP1NmNCVJ3
k/JVto6+HheqiwNSrQVABEl8J+IUWmeqT79E+UOq8wC5JIB1zhIXerGRB40sYTUb
zxwNvegTcVjXRdCmtn+CaTx66tOXyA==
=l2Wj
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--

--===============2004248649577271284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2004248649577271284==--
