From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: add support to card rebind
Date: Thu, 6 Sep 2018 11:54:25 +0100
Message-ID: <20180906105425.GE5360@sirena.org.uk>
References: <20180810093708.13290-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6760366057426476812=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CCF126779A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:54:26 +0200 (CEST)
In-Reply-To: <20180810093708.13290-1-srinivas.kandagatla@linaro.org>
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
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, vkoul@kernel.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============6760366057426476812==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 10, 2018 at 10:37:08AM +0100, Srinivas Kandagatla wrote:
> Current behaviour of ASoC core w.r.t to component removal is that it
> unregisters dependent sound card totally. There is no support to
> rebind the card if the component comes back.
> Typical use case is DSP restart or kernel modules itself.

This looks OK but needs rebasing against current code.

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluRB2AACgkQJNaLcl1U
h9A8Cwf9G6hpkdHnQwsmGfH2s5rENsm0BYYZ/JhSMetKbDBXHNMXJ54GCY2cLyl5
7amwYyqqeeqRS+Db+o60kHDT88TZI2lmEt1wSh/zUvdmZWWWE+1QkYeQWVdIr7Et
FNURDaLlRODnSTMXnmIEYWUPLid+10DYOrAMTRtDJJoTusCAZLYZS4q6MJKVbCb1
LdBDumZigcTVuMPeIYu4NpOVlH0sd6sU6HX6ADNiZRrvcx2laxU5NQAKE25vkyhL
hScv6PByaYu7EZ4Nu6Zc+MsqBoOWNfD9hNL0DCgEp07ioAdPen48C+av7czAH0OC
OoG/pElugXqWZC+2omOlrTGumoFY7Q==
=JhVK
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--

--===============6760366057426476812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6760366057426476812==--
