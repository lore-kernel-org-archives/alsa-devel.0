From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Mon, 17 Nov 2003 20:16:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311172016.25155.pwk.linuxfan@gmx.de>
References: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com> <200311171918.54453.pwk.linuxfan@gmx.de> <s5hzneuj0ds.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzneuj0ds.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

WARNING: Unsanitized content follows.
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 17. November 2003 19:49 schrieb Takashi Iwai:
> At Mon, 17 Nov 2003 19:18:49 +0100,
> Peter Kirk wrote:
> > Am Montag, 17. November 2003 15:33 schrieb Takashi Iwai:
> > if I understand it right, then "high-end" cards should be able to play
> > multiple streams in hardware...meaning the smart dmix wouldnt even do
> > anything else than pass on the streams to the soundcard (no resampling,
> > no mixing, no nothing). Only if you play two streams on a soundcard that
> > can only handle playing one, then it would mix (and resample if necessa=
ry
> > for the mixing).
>
> well, my concern is that with the high-end cards, people tend to stick
> with the quality of sounds.  that means, any reason to reduce the
> quality wouldn't be acceptable for some people.  since dmix will do it
> silently (if needed), it might be unacceptable.

what ? are you suggesting there are people out there that would rather have=
=20
_NO_ sound instead of a (quality wise) slightly degraded sound ? I cant rea=
ly=20
believe it :P. If they wanted to have maximum quality, they shouldnt open=
=20
more soundstreams than their hardware can handle...

> anyway, it's just a concern.  the answer for this question would be
> just a questionary to users (and a good documentation or user-friendly
> GUI tool to configure).

well, at least I get your point now :). Maybe add a option that enables byp=
ass=20
of smart dmix for a device...but the default should be to use smart dmix, a=
s=20
most users I know wish to play the sounds that the applications they open=
=20
play...

Peter
- --=20
Oh, well, I guess this is just going to be one of those lifetimes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uR5/g2ieGvTmHiURAhK3AKCA+/zIAY0dOP9sPhLyAU13va1oEgCcDM1d
20wRl726T+iFG5WODfcKUrY=3D
=3D9gxW
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
