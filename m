From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsa problems
Date: Tue, 28 Mar 2006 16:10:36 +0200
Message-ID: <1143555036.13615.68.camel@localhost>
References: <1143547835.13615.25.camel@localhost>
	 <s5hu09i7m3k.wl%tiwai@suse.de> <1143551506.13615.48.camel@localhost>
	 <s5hr74m7lqi.wl%tiwai@suse.de> <1143552082.13615.51.camel@localhost>
	 <s5hodzq7ktj.wl%tiwai@suse.de> <1143553451.13615.57.camel@localhost>
	 <s5hhd5i7jfs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4QKaUPXA972XbnaRFMlj"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5EC92199
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 16:10:39 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 20A7F9923D
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 16:10:39 +0200 (MEST)
In-Reply-To: <s5hhd5i7jfs.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-4QKaUPXA972XbnaRFMlj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-28 at 16:06 +0200, Takashi Iwai wrote:

> A relatively easy workaround is to create two PCM instances, each of
> which is dedicated for only a single direction.  Then you can define
> appropriate configuration in alsa-lib to choose the right PCM number.
> The drawbacks are about the kernel OSS emulator, as usual.

Ok I guess that would work. But my current workaround with just defining
both directions and refusing access to those that don't work seems to do
fine too.

> Alternatively, we can create a new function,
> e.g. snd_pcm_register_stream(), for doing what snd_pcm_dev_register()
> does for a single stream.  It's an exception only for PCM which may
> have multiple device files.

Yes, that'd be good to have, indeed it would essentially be a code move
and the old code would call the new function.

> I have a rough design of new PCM middle layer in my head to reduce
> snd_pcm struct, and it would work fine in your case.  Nevertheless,
> it's still a vaporware :)

Heh :) Make sure to include some compressed content stuff, it could just
be a different format or something...

If you post a braindump I'll take a look and comment on it :)

johannes

--=-4QKaUPXA972XbnaRFMlj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARClD2KVg1VMiehFYAQJ5YRAAmp2VLkh9UKnsIX2mZATaZwXn8tBV/38M
YBodz7iesRoLzY3es58rnfzL5/lJuyXvdniK64US+EKRPcQbJA7YtRE6Om/ML9n2
hqvDWJjwHPmbEUTDbm/v3PAFYjYEDn3FS2zPt9Plbe0uAJl0CPatZXmXrSpamYcb
j9Si/djzT3dXYHnxMDHL4p2KQUE+0k/Yov0ayrVnpgFanFmbxhuHoLHpU1F00Kh3
RDJu2+C7e8mAv88de2w7HspXMrg3ravS6aUTQt0TX3QzcHWDnuSLKX/BpGTq7ku4
fy6y/vmK6F48Ge1KlwBV8gdjWu7qn4ARRN5BWhQVvOxh4k8oI04FXWCDe6Cl3Ie8
Kpmhy1VtrBY9LXJeeMGrM5aWJ04jbWdz32oVZacIH3ARb/mZ5+bvAbOI5u4U8Rg2
fedkBmsJoX9mDc5sQkf6XwjrktmEkkayKEkZ1Xwi+O8emisjqeji0HSY7EgQCr+j
bXWZd0nyv79KklOZfMigaSu+21Wm4JKDb3d4GGQz5brHUrAE/fw3FcLrb/3GOvOT
L29MK8Z3yhrTlTDaatDMYFA+QF3Kb+j+Tzzla59dRxFrS1/JgHl1kIvkHF0FD1yU
TW7PO8YFvE7APflrvvEWgJLHRHxw/tq/X/gBnjqxt5ndmNKzvq8XoFY3nnwIa36A
I6UAW6Ztpt0=
=JwxK
-----END PGP SIGNATURE-----

--=-4QKaUPXA972XbnaRFMlj--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
