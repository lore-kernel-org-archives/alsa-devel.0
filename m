From: Andrew Burgess <aab@cichlid.com>
Subject: Re: alsa 9.4 + SBLive! + USB iMic = hard lockup
Date: Fri, 20 Jun 2003 12:19:07 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306201919.h5KJJ7V24815@athlon.cichlid.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I tried this with alsa 9.2 and same result. It did work one time
however, which I did not see with 9.4. Any suggestions would be welcome,
I've had no response to my initial email.

Andrew Burgess said:

> kernel 2.4.21-rc7-ac1
> alsa 9.4 (drivers, utils, libs)
> Tyan dual athlon MP S2460 motherboard
> (I tried it once with numcpus=1 just in case its an SMP
> problem, no change)
> 
> My SBLive! is the default soundcard.
> 
> imic is defined in .asoundrc as:
> 
>   pcm.imic {
>     type hw
>     card 1
>   }
>   ctl.imic {
>     type hw
>     card 1
>   }
> 
> I get a hard lockup (need to cycle power) when I try either:
> 
>   arecord -v -D imic --rate 44100 -f S16_LE - | aplay -v -
> 
> or
> 
>   arecord -v --rate 44100 -f S16_LE - | aplay -D imic  -v -
> 
> and then ^C to stop. Note, it runs fine until I ^C.
> 
> Running imic->imic or sblive->sblive works fine, ^C and rerun,
> no problem. I've been using the SBLive! for years. I just
> purchased the iMic.
> 
> It does print the "Aborted by signal Interrupt..." message
> from alsa-lib twice (for arecord and aplay)
> 
> No log messages, oopses or other screen messages -- just locks up.
> I have the driver configured --with-debug=full.
> 
> How may I help debug this further?


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
