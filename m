From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Mon, 30 Jul 2018 16:50:30 +0100
Message-ID: <20180730155030.GP5789@sirena.org.uk>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
 <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4600796339042743520=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 182D32673A0
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 17:50:36 +0200 (CEST)
In-Reply-To: <s5hy3dsviwq.wl-tiwai@suse.de>
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
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Alexander.Deucher@amd.com, Akshu Agrawal <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============4600796339042743520==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NDuspjMMC1Ui5ypn"
Content-Disposition: inline


--NDuspjMMC1Ui5ypn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 30, 2018 at 05:32:21PM +0200, Takashi Iwai wrote:

> That said, if delay callback of CPU dai provides the additional delay,
> the patch does correct thing.  OTOH, if CPU dai provides the base
> delay instead, we need to clarify that it's rather a must; the delay
> calculation in pointer callback becomes bogus in this scenario.

Part of the theory here is that every component might have a delay
independently of the rest and we need to add them all together to figure
out what the system as a whole will see.  Personally I'd rather just
have everything use a callack consistently to avoid confusion.

--NDuspjMMC1Ui5ypn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfM8UACgkQJNaLcl1U
h9DFvgf8CsHe8dwNrqBV/SvhEF+GoCuFHKSytnDQS+PduypJLUCWCUm06M5vZPmP
BzUOccYZ79pB/dp6jEJuDIk2Ptyz90r0DffH3gWZHJAIofaf7ct15PK7M3ilrLKm
Nc0vCWubhuBpl1adUR7gCMR+TMNi7tv12uFJX9b6j2UFC1MOHECeYBpKMlyWmELd
LE3ubFx6Yz/pkP6jhDq5OMxVDH7xQwr+wHNmv/1t6Uh4P+E3fFpk2KL3ak+Q3Rjr
vaMISlB/JuS15ChTrMnE0eZQxez3LVgCbs3PGC/MFAFnzcvTdnTdI63csSeMUJZB
q6X5w7EQQhNjESTGh/vnxSwtXLvNSQ==
=3qh7
-----END PGP SIGNATURE-----

--NDuspjMMC1Ui5ypn--

--===============4600796339042743520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4600796339042743520==--
