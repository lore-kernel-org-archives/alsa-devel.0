From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Re: [linux-audio-user] Evolution UC16 problems, modules.conf for usb-midi and usb-audio together
Date: Wed, 23 Oct 2002 13:44:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023114410.GA11929@tuba.home>
References: <20021023110337.GB515@tuba.home> <Pine.LNX.4.33.0210231302070.5772-100000@pnote.perex-int.cz> <s5hwuo91jl0.wl@alsa2.suse.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hwuo91jl0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, perex@suse.cz, clemens@ladisch.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 23, 2002 at 01:27:23PM +0200, Takashi Iwai wrote:
> At Wed, 23 Oct 2002 13:02:28 +0200 (CEST),
> Jaroslav wrote:
> > 
> > On Wed, 23 Oct 2002, Martin Langer wrote:
> > 
> > > On Wed, Oct 23, 2002 at 11:50:37AM +0200, Clemens Ladisch wrote:
> > > > And you need to say which driver to use for snd-card-1. For the UC16 with
> > > > 0.9.0rc3, it would be
> > > > 	alias snd-card-1 snd-usb-midi
> > > > For 0.9.0rc4, it would be
> > > > 	alias snd-card-1 snd-usb-audio
> > > > 
> > > 
> > > 
> > > It would be better to add this module name change to the rc4 announce lines on
> > > www.alsa-project.org !
> > 
> > It's not possible to comment changes for all drivers in the news 
> > section...
> 
> but the change of driver names is actually very important for users,
> and there are only few:
> 
> 	snd-via686, snd-via8233 ==> snd-via82xx
> 	snd-usb-midi ==> snd-usb-audio

What about a linked changelog or announce file?

martin

> 
> 
> Takashi
> 
> 

-- 
"2b|!2b"


-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
