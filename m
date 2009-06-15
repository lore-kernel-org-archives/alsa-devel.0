From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [RFC] I2S and LEFT_J (was: ASoC: pxa-ssp: enhance I2S and add
	Left_J support)
Date: Mon, 15 Jun 2009 11:57:04 -0300
Message-ID: <1245077824.24109.51.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
	<1244730992.21356.50.camel@brutus>
	<f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0632784638=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0632784638==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Is27/D1QetbobjSNUqu8"


--=-Is27/D1QetbobjSNUqu8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Seg, 2009-06-15 =C3=A0s 16:45 +0800, Eric Miao escreveu:
> Well, I'm completely lost in this thread. Can anyone give a summary
> on this issue? And it looks like set_tdm_slot() is used to generalize
> the issue of envelop (or the actual frame/sample width), and the DAI
> format setting code here will be generalized??

The patches fixes a number of issues on pxa-ssp, and extends
set_tdm_slot()

1. No abuse of SSCR0_MOD.

Currently pxa-ssp requires SSCR0_MOD to work, but this should only be
needed if you need a frame width larger than 32 bits or if you are
really using network mode.


2. Frame width is set wrong for 2*16 bits format.

Currently it sets 32bits DMA but 16bits frame width for stereo S16_LE
audio. It currently "works" because people set network mode with 2
active slots.


3. set_tdm_slot should be only for real network mode.

Currently set_tdm_slot is always required. After the patches the users
only need to call set_tdm_slot if they are really using network mode.=20

For frame widths > 32bits (SSCR0_MOD is needed to support these cases),
a "fake" network mode is automatically set.


4. Extends set_tdm_slot to include the desired frame width

It is needed to support real network mode. As the code is currently, the
frame width is set based on the the pcm format, so you cant have network
mode running if the devices uses 2 different pcm formats.


5. I2S and LEFT_J

I have 2 versions of this patch, first doesn't do the enveloping, and
just uses 32bits frames for 2*16bits I2S samples. The other does the
enveloping on 64bits frames for 2*16bits I2S samples (this can only work
on pxa3xx). I need somebody to test the first version on pxa3xx, as it
is much simpler and doesn't waste 32 bitclocks for each frame.

Having the start of the sample offset by 1 bitclk is not something
specific to I2S, its how DSP_A works too, and I believe that we
shouldn't make I2S a special case (vs DSP_A).

For what it matters, the only difference on I2S/LEFT_J vs DSP_A/DSP_B
should be the SSPSFRM duration as it is needed to emulate the LRCLK.
(and of course, the fact that I2S/LEFT_J are stereo only and that
network mode can't be supported)

> Could you please send out all the four patches? Sorry late on this,
> busy with the merging stuff.
Yes, i will send the patches again later today.

--=20
Daniel Ribeiro

--=-Is27/D1QetbobjSNUqu8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
	assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko2YTgACgkQw3OYl0G0liTZOACdE7CezkL4sfnhe9AjIQMlTR4N
yhgAn05a/g3C0xYaVel3Y834ZGtNHZb+
=67Bq
-----END PGP SIGNATURE-----

--=-Is27/D1QetbobjSNUqu8--



--===============0632784638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--===============0632784638==--
