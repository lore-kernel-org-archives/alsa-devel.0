From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 00/13] Adding SPDIF support to
	kirkwood-i2s
Date: Mon, 5 Aug 2013 12:59:47 +0100
Message-ID: <20130805115947.GA9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6648628926543397441=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 844B72615DD
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 13:59:53 +0200 (CEST)
In-Reply-To: <51FECB7A.6010208@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6648628926543397441==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MFXRZZgCgX5FsUyj"
Content-Disposition: inline


--MFXRZZgCgX5FsUyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2013 at 11:45:30PM +0200, Sebastian Hesselbarth wrote:
> On 08/04/2013 09:21 PM, Russell King - ARM Linux wrote:

> >                 .name = "S/PDIF1",
> >                 .stream_name = "IEC958 Playback",
> >                 .platform_name = "mvebu-audio.1",
> >                 .cpu_dai_name = "mvebu-audio.1",
> >                 .codec_dai_name = "dit-hifi",
> >                 .codec_name = "spdif-dit",

> Not a big deal for DT. I suggest to have a "audio-codecs" property that
> link CPU DAI to codec(s). One thing, I have noticed is that currently
> you need to supply both codec_name (or DT node) _and_ codec_dai_name.
> For that it would be helpful, if ASoC supplies helpers to get the DAI
> by index and use phandle with args here.

This should follow the same pattern as the other board bindings.

> i2s1: audio-controller@b0000 {
> 	compatible = "marvell,dove-i2s";
> 	reg = <0xb0000 0x2345>;
> 	audio-codecs = <&spdif 0>;
> };

No, things are glued together using the machine driver - again, look at
how all the other systems work.  The wiring on the board can get
interesting enough to need a binding of its own, for very simple
bindings that should just be pointing to a generic driver.

--MFXRZZgCgX5FsUyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/5OwAAoJELSic+t+oim9VNkP/RtXQrMesPjDSyTMr8iBcpl/
N145QYJXRxpBaxgEEWX3qgO9P8gp5P9jc3F8NnKTqPu56abfLkrn3OOubLeqqwWB
LnXWZuv3SRdqdF9aZ6vt32bPsd8ptCcM+AhtJ3ugN1/fcg32xWt3hs/0iTcpnlTu
U62gftQ8festNnRJkkvzolpbTxOh0EdK70gxdf36eYVRX6JMrbJWLG30N4QNZwPU
umGP3Snr27wMS/OtVbod9lEoWZuwUu+YJo9F5Gm2WZIflNhRm/cD6jltjSo9X56z
EZDXHzfu3Lnqq97hw9qykBVkGej9PDC1FQ0DlTsj1VJF4p9tPVNorUMK4AN7TcZ/
Vsj+lkC13lqCem1MtOKON0YElODY+bW/V9sXqQ5+CYQL3dsC+4mYOeAlfKwKap1j
Dus67X/loJ8hjXHZvZ+hKH6c1xzhgGHjk/y62Zm3kr+n/nRpl1eICq4gSwgSlc85
LFRMwwU1LP8sMTu5AVuh8U6/LvQi8e/QBFn9euZrkN6eSIm++g9KFwG3qLSHSriN
W8tJzHjdPPK9wBmVKodsFPrAngeo6JHpz6rrVfm9B1dlMEEhhXpTg8NnDnmgwmlH
DoIyPe6QKOgbHhIG5w/TVE81AkbBEVuMcnN93+qF7kvASJK/ZH79KjWm5+czmExI
ck1K9qZG00piKKZk23fc
=hDhc
-----END PGP SIGNATURE-----

--MFXRZZgCgX5FsUyj--

--===============6648628926543397441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6648628926543397441==--
