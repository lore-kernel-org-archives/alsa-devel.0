From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rt298: clear IRQ at the
	beginning of rt298_irq
Date: Wed, 24 Feb 2016 12:42:34 +0900
Message-ID: <20160224034234.GO18327@sirena.org.uk>
References: <1455613956-14287-1-git-send-email-bardliao@realtek.com>
 <1455613956-14287-2-git-send-email-bardliao@realtek.com>
 <20160217132011.GQ7544@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D701119238@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0211266150600572264=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DB2A26145E
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 04:42:41 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701119238@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, John Lin <john.lin@realtek.com>, "senthilnathanx.veppur@intel.com" <senthilnathanx.veppur@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0211266150600572264==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8MWQa5Xlpje7WrDu"
Content-Disposition: inline


--8MWQa5Xlpje7WrDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 24, 2016 at 02:59:23AM +0000, Bard Liao wrote:

> > Why is this a benefit?  We're going to mask the interrupt as long as the
> > interrupt handler is running anyway.

> Thanks for your reminding. There is actually no benefit on the patch.
> Can you ignore this patch and apply other two patches?
> Or I should send the patches again?

I don't seem to have this series any more, please resend anything that
wasn't applied.

--8MWQa5Xlpje7WrDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWzSapAAoJECTWi3JdVIfQ+bwH/AiurakPFBEpZthw4M4tfTb6
4D5VBT1V1Wb/2xVGjWBLzahiYe2cmbDBZ2Tldc9ZVtqHnOgDXSx/2QdzaVMOUzmx
qWBVu0YNo8P9livZ/B3KsQO1DtRTA6Pl14JT4ERu+k3t1kaYnjIsXP6031CugHaN
iLceD1FLsHYfybcYkqycTNUdReBPqnTfY2Q8GShgFkmpvRIh21pTmgdQTI3d573H
QmgY6/hnB4GscUZkIHaTOCnmsQQEntSV5cCRaSHGDfgZoJmBo1dmX4aufFJZaKlb
aR2gGPPScXqiHTxl6hKl/ULEIlSBqlEnmRbmzPukmmrYk845wXBMt/C8270FJC8=
=ZDhi
-----END PGP SIGNATURE-----

--8MWQa5Xlpje7WrDu--

--===============0211266150600572264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0211266150600572264==--
