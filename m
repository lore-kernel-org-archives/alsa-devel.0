From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Adds push button support
	for rt5650
Date: Tue, 21 Apr 2015 11:48:14 +0100
Message-ID: <20150421104814.GF22845@sirena.org.uk>
References: <1429497442-13021-1-git-send-email-bardliao@realtek.com>
 <20150420204114.GI14892@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D701062B62@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0422031612006058001=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 54F54260A59
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 12:48:27 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701062B62@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0422031612006058001==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 02:08:18AM +0000, Bard Liao wrote:

> > > -	{ 0xdd, 0x001b },

> > That's a bit weird, why is this in here?

> The default value of register 0xdd is different between rt5645 and rt5650.
> And it is for button detection configuration. That's why I put it in this
> patch instead of a separate patch.

OK, you probaly want to move to separate default tables per device.
This is something that should have been called out in the commit log.

> > > +			switch (btn_type) {
> > > +			case 0x8000:
> > > +			case 0x4000:
> > > +			case 0x2000:
> > > +				report |= SND_JACK_BTN_0;
> > > +				break;

> > Why do we mash all these values together?

> rt5650 can report the action of button (one click, double click or hold).
> That is basically for Windows OS. For linux, we only care about whether
> the button is pressed or released. So all of the three actions are treated
> as button pressed.

OK, can we have a comment for that please?  We might want to extend this
in the future as the userspace ABI grows richer (and depending on how
things get reported we may need to synthesize at least a double press
for userspace).

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNirtAAoJECTWi3JdVIfQWn8IAIApGoIO5AMv5eKENj40crAV
8JUCPYTib5pEK1f8XnPLATAeDJg2JQVtHvSrtERPZy/IBNdmWqaPVA4uMHqgxKgO
OBrbpvLQElOJXRDXHyWJmHtPY92ph0lWsixMyB8pnEvdTW7lyXMbsu1oZ3B2C/zf
NDnHZX7PuFuuv49xxQ8V0U84Hze5U3NmFf9xdbm1njQoZWEqsB+vsi32i/Igsn3v
qg4vnhZpuYYtmJ5snGBjQ6pwkXzv/TGP2ZefnvEmKlww5OWjbmdow906vHo66Rwc
qeGge9gLT0JaQfGBxnI6JMtk2cIEkUtPN2GAkaFPKMUASjGgohpPly3AiI0IxZo=
=6oLJ
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--

--===============0422031612006058001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0422031612006058001==--
