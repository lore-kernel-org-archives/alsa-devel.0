From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5660: add rt5660 codec driver
Date: Mon, 19 Sep 2016 10:23:13 +0100
Message-ID: <20160919092313.GH10189@sirena.org.uk>
References: <1471930423-9619-1-git-send-email-oder_chiou@realtek.com>
 <20160914163114.GB27974@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694010056A8@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0410654616183130900=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE710261740
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 11:23:20 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694010056A8@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0410654616183130900==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 19, 2016 at 03:11:00AM +0000, Oder Chiou wrote:
> > On Tue, Aug 23, 2016 at 01:33:43PM +0800, Oder Chiou wrote:

> > > +- realtek,use-ldo2

> > This would more normally be done by making LDO2 a regulator via the
> > normal regulator framework - look at how the arizona drivers handle
> > DCVDD for an example, it provides a default supply mapping which makes
> > things really easy for users.  Right now it's not clear to me looking at
> > the code that the driver works for systems that don't use an internal
> > LDO as there's nothing that enables MICVDD.

> The LDO2 is not a regulator, and it is an internal LDO of codec that
> controlled by register setting. Normally, the MICVDD is connected to 3.3V

It's an internal regulator in the CODEC.

> VDD directly, and it isn't controlled by regulator. The option
> "realtek,use-ldo2" is depend on the customer that can decide that the MICVDD
> is provided by external 3.3V VDD or internal LDO2 for it. If they used the
> internal LDO2, the pin of MICVDD can be floated.

Sure, that's exactly what it looks like so my comments above apply.

> > We do a reset when we unregister at the CODEC level - that'll overwrite
> > these settings won't it?

> We have done it in the function "rt5660_remove".

Right, and if the user removes and reloads the driver then the reset
will happen.

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX366AAAoJECTWi3JdVIfQAeMH/iOXgEOSoOuOog/EpG4TKkqs
IznuB6EYHgerj6McRpJmniaqN1pFIMYp24bF1nf/RsfK4DFag13Qw2zCFhHRPSuc
ucsOpgYtgPsH0TTMZ6ZOiIiROm0mlM1TXz/2ZcwWVLQ5o41kp++Tte6s/LqwbSce
gdrG6qYeEuAhoXeeEK4fXyvGCTP8JFrRqCH+TCw3+eWQzpfitFOSxm19nr2B2fNR
rdTg80NbTEt5NzvgaumKH9io6Ar6fudO1f4woknRMpLQ8eGxaJshVEE3NlsP8QH7
dZLcivCUQcr91tM7uxUNcPXIhQdfF2bjRYzzQsZeFR9O+cduiDF9tAefT3n0Waw=
=T7kD
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--

--===============0410654616183130900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0410654616183130900==--
