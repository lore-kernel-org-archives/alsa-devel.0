From: mark@undertone.org
Subject: Re: testers for SB Extigy wanted
Date: Fri, 11 Oct 2002 09:13:12 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021011141312.GA31835@undertone.org>
References: <s5hlm55ciee.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hlm55ciee.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I might be a complete idiot, but when I load up the usb-audio drivers
for my extigy out of the cvs tree, I'm not even getting the devices I
need to test the stuff. I'm using devfs, and and hwC0D0 doesnt pop
up. 

I the same guy that once claimed that he was going to work on drivers
for the extigy... although work has been pretty busy lately and im
still at the "comb through the usb spec" stage of things, heh. I still
lurk on this list, however, and I'm more than happy to assist in any
way I can. Who knows, once things slow down again I may start ramping
up to code up some goodness...

-Mark

On Fri, Oct 11, 2002 at 01:41:13PM +0200, Takashi Iwai wrote:
> Hi,
> 
> can anyone test the latest cvs snd-usb-audio driver with the SB
> Extigy?
> now the names of mixer controls on this device became more
> understandable.
> 
> the mixer topology of extigy is depicted in
> alsa-kernel/usb/usbmixer_maps.c.  unlike other usb devices, this is a
> really complicated one.
> 
> i have still no idea for what some switches work.  so, if you have an
> SB extigy, please test and report:
> 
> - there will be "PCM Playback" and "Digital In Playback"
>   switches/volumes.  which roles do they play?
> 
> - how does "Up Down Switch" affect?
> 
> - which output do "Digital Out1 Playback" and "Digital Out2 Playback"
>   correspond?
> 
> 
> TIA,
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


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
