From: Johannes Berg <johannes@sipsolutions.net>
Subject: pcm parameters, digital output ...
Date: Wed, 29 Mar 2006 13:34:41 +0200
Message-ID: <1143632082.9481.6.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q2M5c4rxvpEeV1WLXm6P"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3903E1C2
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 14:37:00 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id DF7E49923E
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 14:36:59 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-Q2M5c4rxvpEeV1WLXm6P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-03-27 at 17:37 +0200, Takashi Iwai wrote:

> It's hard to restrict parameters on demands (although theoretically
> it's possible).  We usually provide two different devices, one for
> the normal i/o and another for the digital i/o, to avoid such
> conflicts.
>=20
> The apps that send to the digital data would choose "spdif" or
> whatever appropriate PCM name, and the system will reroute it.

I thought about this a bit more now...

Just FYI, the codec chip I'm working against is capable of generating
digital out and analog out at the same time, so I'd rather not create
two PCMs because then you'd have the problem that for one, only one of
the two can be active at the same time, and secondly, when the analog
output is active, the same data can also go out of the spdif port. Which
is a bit icky, and definitely hard to understand. Hence, I'd rather not
create extra streams for this.

I've been browsing the source for this and have a few questions:

What is the point in having "Con Mask", "Pro Mask" and just "Mask"?
Doesn't "Mask" subsume the other two, and in the "Pro Mask" the consumer
mode bit cannot be set (which ac97 seems to still allow...)? Just has me
puzzled.
Anyway, that isn't really the point.

Looking at the ac97 api, it specifies the SPDIF controls as part of the
mixer. Shouldn't those rather be tied to a specific PCM?

I think that there isn't much we can do without breaking everything. I
think it'd probably be best to add a new "pcm" format for the compressed
data. The current ac3play is using 16bit signed little endian pcm data
(SND_PCM_FORMAT_S16_LE), which is not really what it is sending, it
isn't sending PCM data at all.
Something like SND_PCM_FORMAT_SPDIF_NONPCM would be fine. Then
applications would use that to announce that they're sending non-pcm
data down the 'pcm' device...

Now note that there's a problem with old applications: using
SND_PCM_FORMAT_S16_LE they would, after adding
SND_PCM_FORMAT_SPDIF_NONPCM, assert that they are indeed sending PCM
data, which my driver would actually allow the user o play on the analog
output then, if it relies on he application telling the truth using
SND_PCM_FORMAT_SPDIF_NONPCM. But I don't think there's any better
choice.

If I were to rewrite this (as you hinted an another mail), I'd rename
the 'pcm' devices to 'datapump' devices and make the format parameter
actually two related parameters: data type (pcm/non-pcm), and data
format (word size etc.), where the data format is a sub-type of the data
type so to speak.
Note that currently, the only non-pcm data types would be U16_LE and
U16_BE (if the hardware does byteswaps), so it might be sufficient to
define SND_DATA_FORMAT_NONPCM_16_LE and SND_DATA_FORMAT_NONPCM_16_BE
(signedness isn't relevant in this case), and keep the current
SND_PCM_FORMAT_S16_LE as SND_DATA_FORMAT_PCM_S16_LE in the same format
parameter.

However, then the space in the 64 bits of 'format' would be nearing
being used up once some more non-pcm formats are defined, though that
should only be relevant for future hardware since the spdif bitstream is
defined via the spdif mask controls.

johannes

--=-Q2M5c4rxvpEeV1WLXm6P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIUAwUARCpw0KVg1VMiehFYAQKiRA/3W/MSXdyuMlNN5Qi+QSn07OQVuH2yXMLJ
6OaWmYz8qcQaedNzZf1twG5LDL2j5B8ujoCmCx4O3klhC6s+o/IWafKfPZ16dT8l
iBsui7oQ2X6FU6U4U3jQOYU274hZP4EAkFfoTnDXsGt4aTByTEnMCxaD6jfuDyhv
7YoiP746m/yJsEuvXl7EEBv1/iauQmNNUAuSztHPWhOaxrfjmdRJczEhHq1LOwZr
IMBd+X7d3pCYEhjRHi75BgLrEkP/CTuocWLfMvw63KHCxjzQvJXorLAwX4mKABKQ
PH7TfKpkMFQchI60fKlPiAN72ShkoT6dlMe543cTMG0K+sGwMPCm+yuCN4HEeDB0
xgzHgTblic3ig6V8GQVTUhXZX8cKlRKtXRrpQPrBihMFypWoRGm7LRXSEw49FHrZ
jgDy/95Un5CvOdQvo9IiKH1KEd1bfFU3Uca5udePGE4GZi/E26PZ7icaxvKGvWFk
2hMpFGZdOkulZ/a8nr6RGvaNXqoBeTNE2jOFpVKYD7NnWtebPaAtKj4hlAEPhJRr
sdJ94yNe84lHPubthkr5FqKJfo9uzqEB6lSxa9QlYmK7bqIj5d4dkJIiYVYSgQ2A
k9yEYafJFwbVkLAQTbuqF2MY7vmn+udd5+fN/3Z6yb1vhYxLWSg3WoiCNZJx9IRI
qcS2AMBKiQ==
=YFaf
-----END PGP SIGNATURE-----

--=-Q2M5c4rxvpEeV1WLXm6P--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
