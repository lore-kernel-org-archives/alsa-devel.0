From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: No snd_pcm_resume_all() ?
Date: Tue, 18 Apr 2006 19:55:22 +0200
Message-ID: <1145382922.4116.81.camel@localhost>
References: <1145321918.4705.4.camel@localhost.localdomain>
	 <s5hd5ffxc1r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aa8cIKGevkfS/Lg9zGWU"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (195.210.38.204.no-dns.no-wires.co.uk [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B67A183
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 19:55:42 +0200 (MEST)
In-Reply-To: <s5hd5ffxc1r.wl%tiwai@suse.de>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-aa8cIKGevkfS/Lg9zGWU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-18 at 15:12 +0200, Takashi Iwai wrote:

> Indeed, the pcm resume was designed to be called from application to
> restart.  The flow is like below:

Why does the app even need to know?!

johannes

--=-aa8cIKGevkfS/Lg9zGWU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAREUoCaVg1VMiehFYAQIO+w//XkqWTpsH9KVmTXUIh1J8RSPvKTPmCT9p
mg5jw2m9C0tH2IEJyahwDhMyUd111H+JIqn1YxCMtTDmJ6vOZ8yKjQwsMu37EbMh
XeOjNv5MTmnQ9hTKJXcSAyLFY70ppzObk05IRpE5Hvti5i+wtijA1fxLbWEKRw7Y
3WvPCtqujF98eRktnQEoHhjmOp5BrL4zZ5XKRtP2D4Yo9dCVN0NJSQofbZaRacVH
Z5LRgfRpBgVElaxxhlwa+IflBrxqNAnNTk6wb9n0lB7qJiHL5Kv2KgUIO2tYTTCW
7Ug9soQYAfybdPIASq2Rc4TUMt7UpearIJtE9ONN4jBAie1LAc445CXrARJdngBD
NM9UF635fiRKoq5qFU85fjCU8JGH4CK/9j5VI1x+IWucQ78YXF1EMvIcvavXO/VS
Ncd/ke9p2m9HBi+ek0NFMHj01MRKcpGznqt8STbK7HmC1virViy7N9kawYueR9dk
4M6R8Cl411FMW9aUrQeHgkLsXQe/ikjEpESjHSSVLSo6ECHQHjjQ4GC24cZPG9/f
cJk4UsqxQmomyU6hge1yInbHeoeOQL3gXo94488QBraLQZzciNrqvE9ErEnDQN6m
kyDIEOoEQZYLoFKvwvKdul4z+DJobZBTFiDRtsFcob7evRtywHsrYaHLNe9IwMvV
4BtO9fDOKeY=
=rZx+
-----END PGP SIGNATURE-----

--=-aa8cIKGevkfS/Lg9zGWU--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
