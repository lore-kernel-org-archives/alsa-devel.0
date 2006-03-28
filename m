From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsa problems
Date: Tue, 28 Mar 2006 15:11:46 +0200
Message-ID: <1143551506.13615.48.camel@localhost>
References: <1143547835.13615.25.camel@localhost>
	 <s5hu09i7m3k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pT9wDDxjexp34uK/vUzJ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 826D311D
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 15:12:02 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 34BB499258
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 15:12:02 +0200 (MEST)
In-Reply-To: <s5hu09i7m3k.wl%tiwai@suse.de>
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


--=-pT9wDDxjexp34uK/vUzJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-28 at 15:08 +0200, Takashi Iwai wrote:

> > 1)
> > #include <sound/core.h>
> > doesn't compile because it requires sound/driver.h *before* it.
>=20
> Yes.  And what's the point?

Well, that's pretty dumb. If it requires sound/driver.h it could just as
well include it itself.

> I don't understand what's the problem.  You can create an empty PCM
> via snd_pcm_new(), then add each stream, playback or capture, can be
> assigned appropriately via snd_pcm_new_stream() later on.

Right.
snd_pcm_new()
snd_device_register(card, pcm)
snd_pcm_new_stream(...)   <--- this stream never shows up as a chardev!!

> It can.  Call snd_device_free().

Hah ok. I didn't realize pcms were really just device thingies since
they have so many extra functions.

johannes

--=-pT9wDDxjexp34uK/vUzJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCk2D6Vg1VMiehFYAQIRVw/+PATZxUJZJvKEOLvuXDOZd2wqdoqQ/ezv
n26Pfx220uOiSvdo7nq4flCCptCW2wclLaBw6GSzzXkPGT7u84UekG8uR/154qel
leP+oOJgir5Aetp0R8cHtwdG6YQN5o1JcGZwZcE2h6ilIOWoWcLCr9h9qYJ+jiFt
oMn5UIR+M1vjbamR9sX7L9gcUIYMkVN9AWLfgd3Wzn651Bj9pp1EoTRsoOlFL2sg
dik5n3CXzD8zk9tHHX30ECvPh2hJcw3UmzBZ6f7mXuCsoQg0Hn9m6gxw5x7RURIJ
grfUH36WvBwvHv2hjUWl4SvQTbpoKYA2rTKaem+QuxQRVKaxUZgXJxd6RY3vhLeT
Njb3g9Yb7k8kiwGppvSVP+NVTTVlhuCdZ+UcwL7bEwVhWwzupEMQqtIDls2ewhST
gVVZLVuOmE8hkjByQJ34OnRZkm089GQoi8DcJ8IbLM8fqH9813cQRgEerOovT97X
epjya2Ao7LjVEUqRksessBg2zlwb2oYhDv6zbxnQm8gFJjJxH0TyMjhqio4IjtIC
rER7WBHZPG2Fi+YbEt8eOUXvmElyFXgPUm0BQe33HUitXJrkE/1mc1Qxm6/UBikL
wvIEjPLe4lMDS907bEMdrlIYnKFDjB4j/LqE+6YowT2qkYD60g562wHNl5QKuVFc
gMCyTqe4nek=
=SjZg
-----END PGP SIGNATURE-----

--=-pT9wDDxjexp34uK/vUzJ--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
