From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related crashes at 44100 Hz and 88200
 Hz for M-Audio Fast Track Ultra series.
Date: Tue, 31 Aug 2010 10:24:20 +0200
Message-ID: <1283243061.3971.20.camel@mattotaupa>
References: <4C32E3B2.5080707@web.de>  <4C7CA39C.60205@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0786449200782168481=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id A8D1B1037FB
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 10:24:25 +0200 (CEST)
Received: from f053040237.adsl.alicedsl.de ([78.53.40.237]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1OqM8l-0004VI-PY
	for alsa-devel@alsa-project.org; Tue, 31 Aug 2010 08:24:23 +0000
In-Reply-To: <4C7CA39C.60205@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0786449200782168481==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-/eEkRVK+WzpRxqhH0tG3"


--=-/eEkRVK+WzpRxqhH0tG3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Felix,


Am Dienstag, den 31.08.2010, 08:39 +0200 schrieb Felix Homann:

> almost 2 months ago I send a patch making the M-Audio Fast Track Ultra=
=20
> series audio interfaces work flawlessly in Linux except for missing=20
> mixer support:

for people having subscribe later or deleted the last messages, you can
find Felix=E2=80=99s message in the archive [1]. I could not download the
attachment though, so please try [2] instead.

> Am 06.07.2010 10:05, schrieb Felix Homann:
> > This fixes issues with M-Audio's Fast Track Ultra series:
> >
> > * devices now work at 44100 and 88200 Hz
> > * apparently, fixes some crashes, too
>=20
> Unfortunately, the patch didn't make it into Alsa so far. Clemens=20
> Ladisch seemed reluctant to apply a fixed endpoint quirk since the=20
> device should have worked without in his opinion. I gave him all the=20
> requested information to see what was happening without the fixed=20
> endpoint quirk. I never heard back from him again.
>=20
> So, could someone in charge kindly tell me why the patch didn't make it=
=20
> into Alsa? What's missing, what's wrong?
>=20
> If it's just the fact that Clemens doesn't like the fixed endpoint quirk=
=20
> please find attached a different patch yielding the same result.=20
> (Against Linux 2.6.35. It's again from dhubsith who posted it on the=20
> M-Audio forum.

Could you include the link to the forum post.

> He would sign it off if requested - on the other hand it=20
> is already derived work of the Alsa sources).

I guess his signed-off-by line additionally to yours (Tested-by: is also
good) would not hurt.

> And please, if it's not going anywhere, please tell us "laymen,=20
> volunteer Alsa helpers" about the reasons.
>=20
> The current situation is most frustrating: We know how to make the=20
> device work (much better than in Windows, btw) but we don't know why we=
=20
> have to patch alsa again and again.

Sorry, unfortunately I cannot tell you why your work has not been
committed yet and I do understand your frustration. The reasons might be
simple, that the developers were caught up by different things and your
patch just fall through the cracks. So it is a good thing, that you come
back and ask for the status.

So to ease work for the developers, could you please resend your patch.
Do you know if it can be split up, so that the controversial parts can
be left out at first?

Please use `git format-patch` with

1. a short commit summary line,
2. links to the respective Web pages where this patch was discussed.

You can just copy the lines from the resulting file into a normal
message (delete the header fields and copy the subject manually marking
it with [RESENT]). Just make sure the lines do not get wrapped.

Then make sure to CC the maintainers (I think Clemens, Takashi,
Jaroslav) too so that they do not miss it.

I hope your patch will be included soon afterward.


Thanks and good luck,

Paul


[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2010-July/thread.h=
tml#29193
[2] http://www.spinics.net/lists/alsa-devel/msg35372.html

--=-/eEkRVK+WzpRxqhH0tG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkx8vC4ACgkQPX1aK2wOHVhGfQCffJAnJ5B+XJ5Z1+YCfIx2ZnrF
VnoAn1Bbjc/mqNEcdNE1V45Ki8PcfTAE
=LEWP
-----END PGP SIGNATURE-----

--=-/eEkRVK+WzpRxqhH0tG3--


--===============0786449200782168481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0786449200782168481==--
