From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: BUG: ALSA crashes if aplay is running to often at the same time
Date: Tue, 4 Oct 2005 18:46:07 +0200
Message-ID: <200510041846.09822.alien999999999@users.sourceforge.net>
References: <20051001100840.GA15351@pinky.haso>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2033410.ePS58NtXQ1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051001100840.GA15351@pinky.haso>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: florian kriener <florian@leflo.de>
List-Id: alsa-devel@alsa-project.org

--nextPart2033410.ePS58NtXQ1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op zaterdag 1 oktober 2005 12:08, schreef florian kriener:
> Hello,
>
> I experienced a problem with ALSA when someone send me a lot of IM's
> per GAIM with little time between them. GAIM launches aplay and plays
> this nice "new message" sound. And when called this many times ALSA
> crashes, i.e. all programs using sound output freeze, ps aux too and
> i have to reboot using the sysrq key.
>
> My sound-card is a Sound Blaster Live Platinum.
>
> Sincerely Yours,
> Florian.
>
> BTW: If I can help somehow, please ask.

WTF!!!

this describes EXACTLY my problem...

I always thought, it was the snd-au88x0 card, but i have an emu10k1 as well=
=2E..

I've had this with 1.0.8 at least...

didn't have this issue anymore, (using alsa-cvs now, for some time)

but it's exactly this:

alsa froze, all sound froze, all appl using sound froze...

I couldn't kill apps with killall or anything

doing ps aux, hung my console

issuing a reboot failed at the first kill command

sometimes ps aux would give me some lines, and then stop suddenly, (always =
the=20
same lines).

love to know if your problem is the same as mine...

try the very latest version (and alsa-cvs), if you don't have it anymore, i=
'll=20
be at ease...

--nextPart2033410.ePS58NtXQ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDQrHRuBWKXETrtdcRAqPeAJ0aYdRYwwzQ1uSuRzPpSPjJxWRBFgCfZSU8
HkdSgvszWGDgbktmMTVMGWg=
=aaIN
-----END PGP SIGNATURE-----

--nextPart2033410.ePS58NtXQ1--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
