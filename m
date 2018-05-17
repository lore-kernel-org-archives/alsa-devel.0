From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 09/24] ASoC: qdsp6: q6afe: Add q6afe
	driver
Date: Thu, 17 May 2018 18:23:08 +0100
Message-ID: <20180517172308.GX20254@sirena.org.uk>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
 <20180517065544.GO20254@sirena.org.uk>
 <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7380640495448196345=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F296267364
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 19:23:14 +0200 (CEST)
In-Reply-To: <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7380640495448196345==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TOkWJigZa0YodlBE"
Content-Disposition: inline


--TOkWJigZa0YodlBE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 17, 2018 at 06:10:49PM +0100, Srinivas Kandagatla wrote:
> On 17/05/18 07:55, Mark Brown wrote:
> > On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:

> > This lock only protects the list, it does nothing to ensure that the
> > port we look up is still valid by the time we return to the caller.
> > That means we won't crash during list traversal but does nothing to
> > ensure we won't crash immediately afterwards if the port is deallocated
> > just after we look it up.  What stops that happening?

> Each port is allocated and de-allocated in dai probe and remove calls
> respectively.

> Lets say... So for this case to happen the dai has to be removed (unload
> module) at the same time when the interrupt callback happens due to delayed
> response from previous commands.

> This case would be almost impossible because all the calls to afe service
> are synchronous with timeouts, if any of the previous calls times out the
> respective caller would get an error, this should prevent him from unloading
> the module in the first place.

The user can also trigger manual unbinds without unloading the module,
and to be honet the scenario where the DSP has stopped responding well
and is delaying responses sounds like exactly the sort of time when
users might try to reload the driver...

--TOkWJigZa0YodlBE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9unsACgkQJNaLcl1U
h9AJvwf9GOcfk1SHbrXQgWUeZhYqtqeq7roCOu5AXTmB1UChVog1Pjf6l2Mf1yU+
PAWzywXIZHB2QCC8Gia0XFvOGsSFU4UNrnutGvw69HSkzVWNoxwwZ8Go/CNFlEYD
TJgABR2Ottsx5DblnHSwEVT2UjAKd1NKR/obMiVTNAbCiHHplvE09cBOQ+ysZwpO
wu/RakkwOPICIXqqwXVBGcEymLP2GmzE6BWZlIzgUdk7ZKN7OPUzjcbEYflixoBB
Yb/A+bjxkuN+8Nzsb6Y9ysVzb4x5/S2GSThQscb0MtGc8xDrjFzVA7nYDoxfAkQK
qA1P7H6maKckxnOQS+pvZHgtMDpkGA==
=6KkS
-----END PGP SIGNATURE-----

--TOkWJigZa0YodlBE--

--===============7380640495448196345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7380640495448196345==--
