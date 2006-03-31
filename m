From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: pcm parameters, digital output ...
Date: Fri, 31 Mar 2006 12:55:30 +0200
Message-ID: <1143802530.22691.29.camel@localhost>
References: <1143632082.9481.6.camel@localhost>
	 <Pine.LNX.4.61.0603301642170.11712@tm8103.perex-int.cz>
	 <1143731165.4617.0.camel@localhost>
	 <Pine.LNX.4.61.0603311204150.9303@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wg6ic2EFiUG1S0bjlXX6"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A78AC186
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 12:55:39 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5020B9928A
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 12:55:39 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0603311204150.9303@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-wg6ic2EFiUG1S0bjlXX6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-31 at 12:47 +0200, Jaroslav Kysela wrote:

> It's information for user space applications. The driver, of course,=20
> ignores the extra bits, but the application should be able to determine=20
> which bits are really send physically over IEC958 interface. Some Cirrus=20
> Logic chips supports only limited iec958 channel status bits and these=20
> bits are even different for pro and consumer modes.

Well there are 192 bits in either case so I don't see your point? If the
mask says that the consumer/pro mode bit cannot be set, then the meaning
is clear by asking the device once for the bits and seeing whether pro
is on or not, and if it is settable then the application knows which it
set or can also ask whether it is set or not.
I don't see what more information the app could get from having a pro
mask and a con mask. Or is there hardware that changes the allowed mask
with the setting of pro/con mode??

> Basically, I'm against to create these new formats, because the data=20
> organization is exactly same as for standard PCM samples. All what we=20
> require is to set a non-audio flag somewhere for the data stream.

Right. But it needs to be within the stream info, not out-of-band with
the iec control like you suggested.

> I would create SNDRV_PCM_SUBFORMAT_NONAUDIO and add subformat=20
> bitmask handling to struct snd_pcm_hardware. Also, note that applications
> passing AC3 or other compressed streams should set this subformat. To=20
> provide backward compatibility, we should create a hack for the iec958=20
> device in alsa-lib configuration which sets this subformat value when
> AES0 contains the non-audio bit. The mechanism for handling the extra=20
> iec958 parameters would remain same - using the control interface.

That makes sense. Essentially, I'm happy if I can use the same stream
and tell during prepare() if compressed audio is going to be sent or
not. That's pretty much all that matters to me.

johannes

--=-wg6ic2EFiUG1S0bjlXX6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARC0KmqVg1VMiehFYAQLFsxAAhBPDoTZ6+y3lkIBI+XHdy+Kvd6pQ4nBX
EX3ymrs3SwP7qAlw+1WZ2oR9ZQL36ZeC8zvrikw/CCKyEE8rie6WAfKVrF9FU8P1
1VICHYBm/L276jve9CQhl5ifWYrxgm9W89pP4Mn5dLZZeM0LkzdeVyXD8ONBLxrK
n5rRa61GJornbbx7r+sogaWTZuash+17ElAX/KJ7w6zlSKQiNzyg9v9RhUtaDv9G
N+19kwOlMFVBgQHmPLR2vgW0dNWC1ShzLEsSMbtwqHWkGDKCgfjOuLtDbNjPFZiQ
5ijAvh6l6g6p6oEmBwxSQSYSRE83iti3oFQHOcrMRAmL90RzcWClIhDT3B9yYd/0
45FwyCzLpWSLRPHgi46Hlcsu5Sxdd5xoR2Tgm9mxS8LceaF3U+Ph/D9b8w74DBn1
665WzZD9xXL43kbsjzPXY+RbEknKxYRdSUgZUB+b1VATKiPT1X/BBeAqvvwv27AO
BYwuEpKnNwFJsVk30gAhBZTH6jToW4JkN1bqnRezKst6yp0yW/Bn8LemPGlVJCY7
jMhXhzShXMYR7VfhVZFAZ+v7eHOI+Xe3GXTxPwuRnOoiXwyrcjeukgVLoHYzyCUW
yfNFP2qh57snwAzX3qJ7Q3A2rlSZw7rh03NPd5HctSZjIibkFyHfE4H3K4S2Z26U
hN+4FQJqi5s=
=Kubo
-----END PGP SIGNATURE-----

--=-wg6ic2EFiUG1S0bjlXX6--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
