From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Mon, 17 Nov 2003 19:23:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311171924.40388.pwk.linuxfan@gmx.de>
References: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com> <s5hfzgnjc88.wl@alsa2.suse.de> <200311171716.35418.mark@egghead.free-online.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311171716.35418.mark@egghead.free-online.co.uk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Hubbard <mark@egghead.free-online.co.uk>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

WARNING: Unsanitized content follows.
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 17. November 2003 18:16 schrieb Mark Hubbard:
> Peter Kirk has an important point. Default dmix ("smart" could be a
> misnomer) will only work as the default pcm, therefore if one application
> is set-up to use surround51 and another set-up to use default, then nothi=
ng
> is going to be mixed. It would be better, for the sake of simplicity and
> ALSA's target user, to abandon the various pcm definitions and only use
> default which would work with all set-ups....I believe this is what Peter
> means by "smart".
Well,

no smart dmix is no "misnomer". What I mean with it is: a implementation of=
=20
dmix that only starts to mix if there is a need to do it - as long as the=
=20
soundcard can handle streams without mixing the smart dmix will not do=20
anything, except pass untouched streams to the hardware...when the first=20
stream that would exceed hardware limitation is sent to the sound device,=
=20
smart dmix would start mixing this stream into one of the existing ones.
You name a device I didnt know... "surround51". But, since this is what I c=
all=20
a "consumer app device", smart dmix would lure behind that too, and apply=
=20
mixing magic if necessary.

Peter
- --=20
Don't vote -- it only encourages them!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uRI6g2ieGvTmHiURAuJaAKCR3AR0xOCmTkC8sOig3kDkXgjB3gCeOtiD
Kp2fH2zKr+oLw3YAEECud9A=3D
=3DoGcT
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
