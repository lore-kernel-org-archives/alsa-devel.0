From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Audigy2 Microphone capture: alsa-driver-1.0.9rc1 works, alsa-driver-1.0.9rc2 doesn't
Date: Thu, 31 Mar 2005 23:52:17 +0100 (BST)
Message-ID: <20050331225217.95947.qmail@web52902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: 6667
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Peter Zubaj <pzad@pobox.sk> wrote:
> Problem is, that your card was not detected correctly and ac97 mixer=20
> initialization is was not run.
> Looks like card identification broke lot of cards and things.
>=20
> Peter Zubaj
>=20
> Chris Rankin wrote:
>=20
> >--- James Courtier-Dutton <James@superbug.co.uk> wrote:
> > =20
> >
> >>Chris Rankin wrote:
> >>   =20
> >>
> >>>I've just compared the results with the alsa-driver-1.0.9rc1 and als=
a-driver-1.0.9rc2
> tarballs
> >>>with my Audigy2 sound card.
> >>>
> >>>The summary: I can record via the microphone with rc1, but can't wit=
h rc2.
> >>>
> >>>The command I'm using is:
> >>>
> >>>$ arecord -d10 -f cd -t wav > test.wav
> >>>
> >>>     =20
> >>>
> >>What does cat /proc/asound/cards  output?
> >>   =20
> >>
> >
> >0 [Audigy2        ]: Audigy2 - Sound Blaster Audigy2
> >                     Sound Blaster Audigy2 (rev.4, serial:0x10031102) =
at 0xccc0, irq 21
> >1 [ICH            ]: ICH4 - Intel 82801DB-ICH4
> >                     Intel 82801DB-ICH4 with AD1981B at 0xffa20400, ir=
q 17
> >2 [WebCam         ]: USB-Audio - USB Device 0x46d:0x8b4
> >                     USB Device 0x46d:0x8b4 at usb-0000:00:1d.1-1, ful=
l speed

Latest CVS doesn't help - do I need to wait 24 hours for your fix to show=
 up?

Cheers,
Chris



Send instant messages to your online friends http://uk.messenger.yahoo.co=
m=20


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
