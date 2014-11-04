From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Use specific r/w function
	for DSP mode
Date: Tue, 4 Nov 2014 20:40:54 +0000
Message-ID: <20141104204054.GA3815@sirena.org.uk>
References: <1414378351-2329-1-git-send-email-oder_chiou@realtek.com>
 <20141028222915.GG18557@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694F30527@RTITMBSV03.realtek.com.tw>
 <20141031175226.GN18557@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694F320FF@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1542643001716015077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E999D260627
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 21:42:08 +0100 (CET)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694F320FF@RTITMBSV03.realtek.com.tw>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@google.com" <benzh@google.com>, "anatol@google.com" <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1542643001716015077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQrIXZbGokyKU1X6"
Content-Disposition: inline


--yQrIXZbGokyKU1X6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 02:31:41AM +0000, Oder Chiou wrote:

> > Sorry, I'm not quite following what you're saying here - if you're saying that they're
> > slightly different to the main register map I/O for this device then it's OK to create
> > two regmaps and only access the DSP one through separate functions.

> Sorry for my weak explanations. In this codec, there are 2 access modes, and it
> only can be chosen one mode at the same time. In codec mode, we use the normal
> access method to access codec settings, and in DSP mode, we also can access the
> codec settings, but it should use the method of memory address map to access.
> Ex. If we want to access the MX-01 in the DSP mode, we need to convert to
> memory address 0x18020000 + (01 * 2). We want to use the same regmap table to
> handle the codec settings, so the customize r/w functions are needed in it.
> In the DSP mode, the registers MX-00 ~ MX-04 are used for DSP address access,
> so it also need the native function to avoid the regmap handle, thanks.

So, I think what's being said here is that the CODEC has two I/O modes
which you can switch between at runtime and you want to do that
switching.  One way to deal with this would be to just go into DSP mode
immediately on power up since it's hard to see a *big* cost in that.

Another way which is more in line with what you have would be to have a
regmap like you do with reg_read() and reg_write() operations but
instead of switching between open coded functions switch between two
regmaps which just have physical I/O defined (no register cache or
anything).  You then have three regmaps - the master regmap that ASoC
sees and which has the cache and the two physical regmaps which do the
actual I/O.

--yQrIXZbGokyKU1X6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWTnVAAoJECTWi3JdVIfQwoIH/0rzizHUQRRxtbiCu4bc5DuN
Ne1vP9tkjrzSkvlWF7s96unpXK8hpYjUO3knH/RBaVdIIDSSXwD7oZRd27jVbvSQ
L2HTFA4+pw//19lMwgvmlNCiGtUehddMfTTSNKWlA2H9NsrZHztSBAcEA4989XxT
Yshpm6Vui+tqOGOxDKhECTqgCChu9yxcK9QsEXY2HcK1LaQYb4B2dt0IIll2ABwD
KueRxf1uXp4cMMFB2CAs4UmJIXPla2DXIDL3y0/7Ze62cc6cgUwAYcvFSJj2BTS/
2iTrK6YaPInGdFeGn/y/UIVIBuvVvj6tWaiGUfQiFWiYsIxH0+yX7S3LpI6a+/Y=
=6k0O
-----END PGP SIGNATURE-----

--yQrIXZbGokyKU1X6--

--===============1542643001716015077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1542643001716015077==--
