From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Problem with: Broken Pipe
Date: Thu, 24 Jul 2003 15:35:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19flmM-0004yw-00@sc8-sf-list1.sourceforge.net>
References: <3F1FE3B9.2030107@stn-atlas.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 24 Jul 2003 15:48:41 +0200."
             <3F1FE3B9.2030107@stn-atlas.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Holger Rostalski <rostalski.holger@stn-atlas.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>i have a problem with development of a soundapplication for Linux 8.2 
>with ALSA 0.9.0
>
>
>if i take the "Minimal Interrupt Driven -Program" from the tutorial (in 
>attachments) and changed a little bit the
>play_callback-methode, i got at start a
>"broken Pipe" error.

how many channels are you configuring? you are telling writei() that
you are supplying 4096 *frames* of data, yet from what i can tell, you
are actually trying to write data for, well, i don't know. could be 2
16 bit channels, or 1 32 bit channel, or 4 8 bit channels. i suspect
that is the source of the problem: you are not supplying enough data
to keep up with the card.

please remember that the arguments to almost every ALSA function that
measures "an amount of audio" are in units of *frames*, not bytes and
not samples.

--p


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
