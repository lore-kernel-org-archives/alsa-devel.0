From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]usx2y: prevent oops & dead keyboard on hot usb unplugging
Date: Wed, 20 Apr 2005 00:14:56 +0200 (CEST)
Message-ID: <20050419221456.53605.qmail@web26506.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--- Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 16 Apr 2005 02:31:06 +0200 (CEST),
> karsten wiese wrote:
> >=20
> > [1  <text/plain; iso-8859-1 (8bit)>]
> >=20
> > --- Clemens Ladisch <clemens@ladisch.de> wrote:
> > > Takashi Iwai wrote:
> > > > karsten wiese wrote:
> > > > > (-: You apply my patch now?
> > > >
> > > > No, not enough :)  This is exactly why
> > > snd_card_free_in_thread() was
> > > > introduced.
> > > >
> > > > As I asked, please make sure that the files are all
> > > released before
> > > > snd_card_free().  Otherwise the disconnect callback
> > > hangs at this
> > > > point because of this check.
> > >=20
> > > Most programs close the device file when an error
> occurs,
> > > so you have
> > > to test it with something like this to keep the file
> > > open:
> > >=20
> > > #include <stdio.h>
> > > int main()
> > > {
> > >   fopen("/dev/snd/hwC1D0", "rb");
> > >   getchar();
> > > }
> > >=20
> > Tested with it, see attached shell log (copied+pasted).
> > Any more tests needed?
> > I bet a kasten bier that it oopses reliably on first
> try,
> > if I revert to snd_card_free_in_thread() nothing else
> > changed.
> > And I'll inform you , if any oops should show when i
> shut
> > down (pc is still in the state like @ the end of the
> log).
> >=20
> > Regards,
> > Karsten
> >=20
> > P.S.: how about adding a kernelversion depending macro
> for
> > backward compatibility,... when was
> > snd_card_free_in_thread() introduced?
>=20
> Agreed.  The problem is that how to know which version
> has still this
> problem..?  At least, 2.4 kernel must have a problem
> without
> snd_card_free_in_thread().

>From memory I've been hitting the keyboard dead bug since
quite a long time ago. So as a first estimate I suggest=20
"kernelversion >=3D 2.6.0" as condition for use of
snd_card_free().

Karsten


=09

=09
	=09
___________________________________________________________=20
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anme=
lden: http://mail.yahoo.de


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime in=
fo,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
