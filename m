From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
 codec driver
Date: Wed, 20 Dec 2017 10:26:25 +0000
Message-ID: <20171220102625.GB17890@sirena.org.uk>
References: <s5h4lorvxvj.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADB65F@BGSMSX104.gar.corp.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579ADCE9A@BGSMSX104.gar.corp.intel.com>
 <s5hmv2fc5ze.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD339@BGSMSX104.gar.corp.intel.com>
 <s5hmv2ebuay.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD712@BGSMSX104.gar.corp.intel.com>
 <s5ha7yebsa7.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD8AC@BGSMSX104.gar.corp.intel.com>
 <s5hk1xi4je6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5589387996718944779=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E3B12677C7
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 11:26:39 +0100 (CET)
In-Reply-To: <s5hk1xi4je6.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5589387996718944779==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 19, 2017 at 08:17:37PM +0100, Takashi Iwai wrote:

> Well, honestly speaking, that complete morphing scares me.  If it's a
> simple additional call, it's easier to track the code flow.  But your
> patch essentially fakes the legacy codec and bus structs and twists
> the control by that switch...  which looks too fragile to me.

Especially when it's layered on top of all the other x86 code which is
also complicated and fragile - feels like there's lots of places things
can go wrong and lots of potential unexpected interactions.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo6OtAACgkQJNaLcl1U
h9A9oAf1Hkgpn5aNiCjLocaBa8zjegofOMEBaAS8gPobWgi2UxnsoD6zIZ0UwqPR
l8WWl17KEdBFADpYaXHJtoq6/Fmd41f3CAWanGb0ieQg69mI7rihA/EalY/VtVaq
mpza1oudOpIYXebNYRzrqMuJNHacpZNR/0YxaF4c3f8hc71144onESLO8jBTkXCr
7pU00dSIbkPivGTLb2/hqyZGZi535Q8QRyrh+8tEDyLW8KVRm5zYpgIAKnR3wrOb
72N1FDE1TrQkDDaHMPIdU/21zjeRQ1OIjSPRGaufdVXCjYZ2sRw5akWtcdhm+lsq
RV7NeF0Dcb2y67bnbAh79513ZFjP
=/xp6
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

--===============5589387996718944779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5589387996718944779==--
