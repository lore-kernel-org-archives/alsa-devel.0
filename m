From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [linux-audio-user] Evolution UC16 problems,
 modules.conf for usb-midi and usb-audio together
Date: Wed, 23 Oct 2002 13:02:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210231302070.5772-100000@pnote.perex-int.cz>
References: <20021023110337.GB515@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021023110337.GB515@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Oct 2002, Martin Langer wrote:

> On Wed, Oct 23, 2002 at 11:50:37AM +0200, Clemens Ladisch wrote:
> > And you need to say which driver to use for snd-card-1. For the UC16 with
> > 0.9.0rc3, it would be
> > 	alias snd-card-1 snd-usb-midi
> > For 0.9.0rc4, it would be
> > 	alias snd-card-1 snd-usb-audio
> > 
> 
> 
> It would be better to add this module name change to the rc4 announce lines on
> www.alsa-project.org !

It's not possible to comment changes for all drivers in the news 
section...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
