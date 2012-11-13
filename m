From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH v4 2/2] ASoC: sam9g20-wm8731: convert to dt support
Date: Tue, 13 Nov 2012 16:50:08 +0900
Message-ID: <20121113075007.GM18224@opensource.wolfsonmicro.com>
References: <1352361422-13265-1-git-send-email-voice.shen@atmel.com>
 <1352361422-13265-2-git-send-email-voice.shen@atmel.com>
 <20121108152431.GJ4576@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/GiYV45wF7IL3Iq"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121108152431.GJ4576@game.jcrosoft.org>
Sender: linux-sound-owner@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Bo Shen <voice.shen@atmel.com>, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, jm.lin@atmel.com
List-Id: alsa-devel@alsa-project.org


--9/GiYV45wF7IL3Iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2012 at 04:24:31PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:57 Thu 08 Nov     , Bo Shen wrote:
> > Signed-off-by: Bo Shen <voice.shen@atmel.com>
> > ---
> > Change since v3 RFC:
> >   Remove dai node, remap ssc in place
> >   without pinctrl added, so don't modify the dtsi file, will be added
> >   soon
> until I see the pinctrl to test this no
> This code is untested

I see a version adding the DT pinmux stuff has now been posted but this
does seem a bit unfair, the code should be fine on a current ASoC branch
- it's only going to break after merging with the pinctrl support.

--9/GiYV45wF7IL3Iq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQofunAAoJELSic+t+oim90K0P/jxH0SyFWX8pNHaL6hymBF9x
1xThfb4RdkvRe8pHqx5YmBcw6d3W5bBArFIQN3ds41zLKKneuUzhBnfLCq8Yt1/H
+SdHlC7gJxvyQnhVJpYX2Hz0uEHOR8gPDTm78YeUk0aGamZkxbcGGatv6Uy5F19i
abM9DLBlM0CcUq+skeBfZ/D7NB6Vd75dlJguwRoAmHzZxE7V5RFTya+ELZxbaNA2
mR84sU5k8dviZcMjVlUFPLYWFeppbmPR5ixaqhDDKINhp0JgmDekuClXBYrV7T6O
XBT5cnpPiOjrZsGg+DjEtFrY4jM+qu4vALzcfSyqN1fIhydd+b4yh/BTl71nLVq5
Sa+VWc4/hF7RgXnGljO9XGWbe1aOhPU9O40CLRul7y+0s/zg7FFFGo8KtJrU7aZp
ZFp0yaUdUsA5dSmKmZcsxDdlEy0aJa1Svu3dvIbCHFygmieH2eZ68Nv70hjYKb+8
aQrXL7E8yuo/USwCbVagi5xOxjsYx94He1LN+1YHKrx1s4yMbtPI2XVoWOw1S7eP
v2kRWMxUITz3CFvKglHCKVFdXZGKFs9WG4+b76Pu3b7StbND4tk/bjHF61Knly6o
ybU1Il5o8Se/CdkCPGQqR1DCXQBSKC0lI99oxXCXG5kFoxQc/wACGneH6/xNr83O
Mk8LJ1+IzUJPW/exgJSC
=9rBT
-----END PGP SIGNATURE-----

--9/GiYV45wF7IL3Iq--
