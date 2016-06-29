From: Baptiste Jonglez <baptiste@bitsofnetworks.org>
Subject: Re: Assertion failure in alsa-lib crashing
 applications (snd_pcm_area_copy: Assertion `dst < src || dst >= src +
 bytes' failed)
Date: Wed, 29 Jun 2016 15:59:59 +0200
Message-ID: <20160629135959.GA2159@lud.polynome.dn42>
References: <20160607172935.GC25444@lud.polynome.dn42>
 <20160614210221.GB5107@lud.polynome.dn42>
 <20160614223939.GB3039@lud.polynome.dn42>
 <20160626182832.GA29321@lud.polynome.dn42>
 <s5hfurwdsh2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2956482306171549995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mails.bitsofnetworks.org (rezine.polyno.me [193.33.56.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 66B57266EC8
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 16:00:03 +0200 (CEST)
In-Reply-To: <s5hfurwdsh2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2956482306171549995==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

On Wed, Jun 29, 2016 at 03:39:37PM +0200, Takashi Iwai wrote:
> > Do you think the problem is likely to come from an incorrect API usage
> > from the application?  Knowing this would significantly narrow down the
> > search, because the problem could also come from within alsa itself.
> >=20
> > The callling code from the application is quite complex, see here:
> >=20
> >   https://github.com/savoirfairelinux/ring-daemon/blob/master/src/media=
/audio/alsa/alsalayer.cpp
> >=20
> > In particular, the assertion is triggered by the call to
> > snd_pcm_avail_update() at line 694 (see the stack trace below).
>=20
> I have too little time to investigate on this issue, but judging from
> the fact that there has been no such a report until now, I guess it's
> specific to your code.  But I can't say sure, of course.

Well, I did find other projects having this issue:

https://aur.archlinux.org/packages/zoom/#comment-544696
http://ubuntuforums.org/showthread.php?t=3D2248373
https://github.com/js-platform/node-webrtc/issues/110
https://fedorahosted.org/fldigi/ticket/70

Although in most of these cases, the issue seems 100% reproducible
(e.g. crash at startup).  In our case, the assertion failure only happens
when there is significant CPU load.

> Is the relevant code path accessed concurrently?  The possible race is
> the first suspect I'd always think of in such a case.

Good idea, I will check.  Given it happens when the CPU is loaded, my
guess is that "something" is done too late, which means that it works on
"invalidated" data (this is all very vague, sorry).

Would you know a simple program using alsa-lib for sound capture, with
which I could try to reproduce?

Baptiste

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXc9RZAAoJEL4B7CKgTi5GXNwP/2Jy1nDoMZzX4Nyq5njSgqLe
aUjN386piUDAMSeiIb7i6D0zEUry5I614Cc7RhYl+nJO1Toa2CrflZrUpZkJga3Q
jYScrYm07xXgBIdzdd0unN7BzL7t9MX2jqvyId8RCnZSaqzOE0j5OXaaWTS5lHk6
3OhMhS4CIfMo76cKugG9m3/5ywBKUw94vbn4wkRo72mWT/Uk8YDIvQTZtflAtvjV
NZa6+g0bFDfX5pTOeOtJmlNGIW1n2f0cUgYMctn/jlR215lhEIA9q5Hh5HWucnES
hcFnR5yHxV+hDv7gYSMTsNfwKZmcGgByHdLSpKnm9s4KSoiGahcYzeH1m79oA2Wu
6u7MPoCJ8JtiEferASCPjzFDP6MhY9wY+cGFhsypC95Q2QA2z7DNosWArBQvoQwL
oceniGqslucNZfPW+hwf+2s16HCjAV5/uHav9ZyTq1FIKbVUIVTU3Ne1V0paZ154
WPLfpdZAVNcO/62cDy66GwhYAgczWWP9TpeYvVwUSLguAUOsUseHyS4NkDNnaooh
C1cTZRRRkV6Dbgpdic7exwE31iU6VlgHhf//RtlHS54FTi0zuPe74eqRdFEHXVmr
QgKP2uPUykNLCZhU9SGaFPm8HXctlwlF7A2g8i11H5YDcdZvNhNGL852YqYTDB0+
D/FC+ELB3oQNKKgu+qVS
=ThJc
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--===============2956482306171549995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2956482306171549995==--
