From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: making aoss able to wrap fopen() calls
Date: Mon, 9 Feb 2004 15:07:52 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402091500250.2364@pnote.perex-int.cz>
References: <200402051727.25712.pwk.linuxfan@gmx.de>
 <Pine.LNX.4.58.0402051748390.1864@pnote.perex-int.cz> <200402061228.12714.pwk.linuxfan@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200402061228.12714.pwk.linuxfan@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Kirk <pwk.linuxfan@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 6 Feb 2004, Peter Kirk wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Am Donnerstag, 5. Februar 2004 17:49 schrieb Jaroslav Kysela:
> > > Could you point me to a good idea of implementing this ? On irc I was
> > > discussing doing a libc wrapper that replaces the fopen calls with some
> > > substitute (that aoss can handle), but I'm not sure if its the way to go.
> > >
> > > Please tell me how it can be achieved.
> >
> > The whole libaoss is based on glibc wrappers (open, close, ioctl, write,
> > read, mmap) so follow this rule ;-)
> 
> Right, 
> 
> I have done some looking at source code, and have found the places I needed to 
> find (in alsa-oss.c). 
> Two questions:
> (1) Is my assumtion right, that I will have to write substitute functions for 
> fopen(), fclose(), fread() and fwrite() ?
> 
> (2) My current approach is to "translate" the f* calls into calls that can be 
> handled already. Is this a good idea ?

I'm more digging to this problem now and it seems that it's completely 
broken idea. Basically the FILE structure is not public outside the glibc, 
so mangling is very hard and very difficult to maintain.

The sox has already support for ALSA, but because it use f* calls, it's
limited to "hw:X,Y" devices only. So I suggest to use pipes (and stdin or
stdout in sox) rather than doing something very ugly.

I also don't like very much the situation with the OSS->ALSA wrapper.  
Right now, I'm working on a very small library which will reroute the
native OSS calls to any dynamic library. So ALSA, arts, esd and other
audio subsystems can use modified OSS programs directly. The modification
of one application requires only a few minutes for a middle skilled
programmer. Now, I need persuade audio developers to use this library 
rather than direct calls.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
