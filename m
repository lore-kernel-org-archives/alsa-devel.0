From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: making aoss able to wrap fopen() calls
Date: Mon, 9 Feb 2004 19:19:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402091920.53309.pwk.linuxfan@gmx.de>
References: <200402051727.25712.pwk.linuxfan@gmx.de> <200402061228.12714.pwk.linuxfan@gmx.de> <Pine.LNX.4.58.0402091500250.2364@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0402091500250.2364@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 9. Februar 2004 15:07 schrieb Jaroslav Kysela:
> On Fri, 6 Feb 2004, Peter Kirk wrote:
> > Am Donnerstag, 5. Februar 2004 17:49 schrieb Jaroslav Kysela:
> > > > Could you point me to a good idea of implementing this ? On irc I w=
as
> > > > discussing doing a libc wrapper that replaces the fopen calls with
> > > > some substitute (that aoss can handle), but I'm not sure if its the
> > > > way to go.
> > > >
> > > > Please tell me how it can be achieved.
> > >
> > > The whole libaoss is based on glibc wrappers (open, close, ioctl,
> > > write, read, mmap) so follow this rule ;-)
> >
> > Right,
> >
> > I have done some looking at source code, and have found the places I
> > needed to find (in alsa-oss.c).
> > Two questions:
> > (1) Is my assumtion right, that I will have to write substitute functio=
ns
> > for fopen(), fclose(), fread() and fwrite() ?
> >
> > (2) My current approach is to "translate" the f* calls into calls that
> > can be handled already. Is this a good idea ?
>
> I'm more digging to this problem now and it seems that it's completely
> broken idea. Basically the FILE structure is not public outside the glibc,
> so mangling is very hard and very difficult to maintain.
>
> The sox has already support for ALSA, but because it use f* calls, it's
> limited to "hw:X,Y" devices only. So I suggest to use pipes (and stdin or
> stdout in sox) rather than doing something very ugly.
>
> I also don't like very much the situation with the OSS->ALSA wrapper.
> Right now, I'm working on a very small library which will reroute the
> native OSS calls to any dynamic library. So ALSA, arts, esd and other
> audio subsystems can use modified OSS programs directly. The modification
> of one application requires only a few minutes for a middle skilled
> programmer. Now, I need persuade audio developers to use this library
> rather than direct calls.


Ok,

that propably explains why my patch causes some weird results...will not sp=
end =20
anymore time with it. Hopefuly I will see the day where I can use teamspeak=
=20
with multiple input streams.

Thanks for the update, saves me from the headaches

Peter
=2D --=20
The husband who doesn't tell his wife everything probably reasons that
what she doesn't know won't hurt him.
		-- Leo J. Burke
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAJ88fg2ieGvTmHiURAntnAJ9mas87AX20ZGOzbOctGDRHFRAz9gCeK0Z7
6sy3rbbRgFb2JQrcTA0CyH4=3D
=3Dka4v
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
