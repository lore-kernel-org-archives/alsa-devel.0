From: "Dan Nyborg" <nyborg@www.vertice.ca>
Subject: Re: Trivial hdsp.c patch to support rev 50 cards
Date: Wed, 30 Jul 2003 13:11:47 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030730191002.M68372@vertice.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

this message is originally from monday... i didn't realize when i replied to
the thread that i wasn't replying to alsa-devel, no wonder it didn't show up
on the list :P     sorry for the duplicate, paul.

********************************************
hello,

i modified hdsp.c to support my rev. 50 card last week (the trivial way), and 
have been experimenting with it for the past three days. everything seems to 
work - midi, spdif lock... - i even downloaded Charbonnel's mixer app, and it 
works great! i use a multiface.

however, when i try to play something with alsaplayer or aplay, my system 
freezes after 2 sec to 2 min of playback... sometimes i can get through a 
whole file, sometimes only partial, but an eventual lock-up is inevitable. i 
have not tried sending anything other than stereo, 44100kHz, 16bit files.

has anyone seen such behavior with this driver?

i am assuming it may have something to do with my setup: linux 2.4.20, alsa 
0.9.5 (with trivial patch to hdsp.c), devfs, recent multiface/pci card with 
rev. 50 firmware.

there's atleast one other person with the same hammerfall set who will be 
trying it out in linux later this week...

any comments appreciated,

dan.

On Mon, 28 Jul 2003 12:23:11 -0400, Paul Davis wrote
> >So then the only way to set volume levels on a DIGI9652 or DIGI9636 when
> >using Alsa is either in the application, or using some form of a script
> >like:
> >
> >#!/bin/bash
> >
> >for i in $(seq 1 26);do
> >amixer -c 0 sset 'Chn',$i 85%
> >done
> 
> only in the application. there is *no* mixer, nothing for ALSA to
> control. whatever is written to the PCM data buffer is what comes out
> of the hardware.
> 
> --p
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites 
> including Data Reports, E-commerce, Portals, and Forums are 
> available now. Download today and enter to win an XBOX or Visual 
> Studio .NET. http://aspnet.click-
url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>

--
Open WebMail Project (http://openwebmail.org)



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
