From: Dominique De Munck <domin@ulyssis.org>
Subject: Re: snd-via82xx full duplex problem
Date: Wed, 30 Apr 2003 11:02:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0304301057170.12291-100000@ace>
References: <s5hu1ciyc5n.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu1ciyc5n.wl@alsa2.suse.de>
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


no, with the last version, the problem seems solved !
:)))

using the 29-04-2003 cvs snapshot on 2.4.21rc1-kernel

The volume with this version, as remarked in other mails, is a bit high,
but no real problem.

greets,

Dominique

On Mon, 28 Apr 2003, Takashi Iwai wrote:

> At Mon, 21 Apr 2003 22:25:33 +0200 (CEST),
> Dominique De Munck wrote:
> >
> > Hi,
> >
> > when recording something (via sox, mencoder for example),
> > I can play sounds fine (for example mp3's, divx-files).
> > However, when I visit a flash enabled site at that moment,
> > my soundcard just hangs. It keeps recording, but every other
> > access to soundcard is not working / crashing the application.
> > Unloading the drivers doesn't work
> > (device or resource busy, fuser /dev/dsp & /dev/mixer gives nothing)
> > a reboot is necessary.
> > This is realy anoying me since I record a lot & a lot of sites are using
> > flash...
> >
> > The problem happens with artsd running and artsd disabled.
> > At the end of this mail dmesg output when Opera browser with Flash
> > 6.0.79 crashed.
>
> does it happen on cvs version, too?
>
>
> Takashi
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
