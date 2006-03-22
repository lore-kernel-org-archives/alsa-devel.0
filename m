From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: ac3 in/out
Date: Wed, 22 Mar 2006 11:54:08 +0100
Message-ID: <1143024848.11724.64.camel@localhost>
References: <1142936836.4759.3.camel@localhost>
	 <1142965025.4532.132.camel@mindpipe> <s5hbqvzzlss.wl%tiwai@suse.de>
	 <1143020483.11724.46.camel@localhost>  <s5hveu6yd2u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TCgmuJq07NoFBWjyXrOv"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hveu6yd2u.wl%tiwai@suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-TCgmuJq07NoFBWjyXrOv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-22 at 11:43 +0100, Takashi Iwai wrote:

> > Yes, but apparently some hardware is capable of doing the conversion
> > (the chip apple uses for example: pcm3052, download data sheet for
> > pcm3052a if you're interested, it's the same chip)
>=20
> We don't support these chips yet :)

Well I know, I'm writing a driver for it, hence my posting here :)

> > On the other hand, some other chips seem to rely on software to
> > multiplex the channel status bits into the bitstream which is currently
> > done by userspace as far as I can tell.
>=20
> Yeah, that's the current situation.

Ok that's what I figured. Well, it has to change if I shall be able to
write a driver for the digital output of above chip.

> To clarify what I thought in the above:
> The conversion itself wouldn't be too difficult.  ALSA-lib has already
> many conversion plugins, e.g. iec958 plugin packs to 32bit spdif
> frames.

Ok. But this still means that we have to export the information on what
kind of input we expect. As I said, above chip can't take a stream
that's interleaved with the channel status, yet other chips need that
kind of stream. If we want to have a unified API we need to interleave
the stream with the channel status bits for the cards that need that,
and have userland present the channel bits and the stream in different
controls, where there's even a bitmask present of which channel bits can
be changed...

> The problem of compressed stream is that the rates of the input stream
> and the output audio signal are different especially if the input
> stream is VBR.  This style of input stream doesn't match with the
> current ALSA style because ALSA PCM assumes the constant rate.
> Changing this is more harder work.=20

That's another issue, I haven't even started thinking about that.

johannes

--=-TCgmuJq07NoFBWjyXrOv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCEszqVg1VMiehFYAQKqlg//XwfqnG+6xi22b3D7Xx2sYYyP9L6LlqVR
lgNpllKZWqIW/oq9kQfwUymDcITPFAR0B3inmsudhJSnfhnbCF/X+BuCr/cpB/08
0Fg7V36TqatAtAVU0OL2ZTI+rUpBD7zmoddlXmgILIC+HZsc6pqKCetPMD++drP+
a07z0OmPhELMKhqaHKTuXCgLpmqJYEdoM2XoIDom5v27KTstBoHdcifOMEpGFZ2U
ZNJWEyz9Wj8ZhTltQ+cAK36OErevLMXHydwAZHANE/W8PQ8psf7UOLx6GWivEgH3
6LRzCaBG3s/PqyQ8/wr+gESUE5wh9afYZoKMi4DS1kmiVvPCaJBFn33FbGihhWc+
Zik35/dhS3IohUzT0csekkuWyQUT5v1P1fNqXB0hVlJlNkn0RAtEub03t5DrUuHC
sQYOyELfBYcEVNaS3hOj2Ph8jhwNHOxnFCPGNS6DGYiLGTzSfOKjd9tf9SVLwjTb
OlXxCCudyEGroiMkkb+9HCJFBRHb8AgRv8G/AWIob58zKy1vd0+oKMF4qP3WtlOx
XrcbixXgV0D46fuTcy26klk28VnJbDndYMvcgSVKDJmPvHAgVZp3b+wHRNDzaqtd
xlE2F7FN35A46Pzq0YLqpNZ7yovljO7Kj4DxCjmcAPKw/4rANZpIej/vYsw9DX5x
clwBDMmsEdc=
=kVgn
-----END PGP SIGNATURE-----

--=-TCgmuJq07NoFBWjyXrOv--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
