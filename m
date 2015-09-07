From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: atmel-classd: DT binding for
 Class D audio amplifier driver
Date: Mon, 7 Sep 2015 17:25:48 +0100
Message-ID: <20150907162548.GW5313@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-3-git-send-email-songjun.wu@atmel.com>
 <20150903114316.GV12027@sirena.org.uk> <55EC0AFE.3080809@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0805880292835644154=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AB5112605C3
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2015 18:25:57 +0200 (CEST)
In-Reply-To: <55EC0AFE.3080809@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Wu, Songjun" <songjun.wu@atmel.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, lgirdwood@gmail.com, ijc+devicetree@hellion.org.uk, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============0805880292835644154==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dPKyTZoWbiJp7FfC"
Content-Disposition: inline


--dPKyTZoWbiJp7FfC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 06, 2015 at 05:44:30PM +0800, Wu, Songjun wrote:
> On 9/3/2015 19:43, Mark Brown wrote:

> >Why is this a separate DT node?  It seems that this IP is entirely self
> >contained so I'm not clear why we need a separate node for the card, the
> >card is usually a separate node because it ties together multiple
> >different devices in the system but that's not the case here.

> The classD can finish the audio function without other devices.
> But I want to reuse the code in ASoC, leave many things(like creating PCM,
> DMA operations) to ASoC, then the driver can only focus on how to configure
> classD.
> The classD IP is divided to tree parts logically, platform, CPU dai,
> and codec, and these parts are registered to ASoC.

> This separate DT node is needed in ASoC, ties these tree parts in ClassD.

Sure, there's no problem at all having that structure in software but it
should be possible to do this without having to represent this structure
in DT.  It should be possible to register the card at the same time as
the rest of the components rather than needing the separate device in
the DT.

--dPKyTZoWbiJp7FfC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV7bqLAAoJECTWi3JdVIfQVBoH/Rw8yw1K58ndD0wfnzLwsdKs
NGMcI/cAKZCtSEVC829ik7khw2Qf/r6arJffVRFIE0q8EF1kVvPrQa5QuRP5nyV5
4wGLj6T5EPUJ1zre03AHr24klKaaAPp0c3EswSaUEebXNP01KyKWHcHcTSdpT6z4
8CRWYdNvC9MeQKmYQxODNYGomkVkkULn240sltFxbBqkb2MCsAEwGMnyirXqlmBU
6edC6C7+4+mxm+jb4dHymbPA5wUGq+T58v5ShEO4fU3NlHOYKKLtFPYjFw1PJlyC
pxiRNC86DrSaRm7j/hX8Ewk6KUnn4FIqnoPdr6xTFQbG/Eoyy0Y+BfbgDD+hky4=
=fDa0
-----END PGP SIGNATURE-----

--dPKyTZoWbiJp7FfC--

--===============0805880292835644154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0805880292835644154==--
