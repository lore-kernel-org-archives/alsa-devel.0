From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: RME HDSP 9632 driver
Date: Mon, 11 Aug 2003 11:31:59 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGEECPCPAB.mknecht@controlnet.com>
References: <200308111824.h7BIOc5G018578@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308111824.h7BIOc5G018578@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, Chris Smith <chris@realcomputerguy.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >More importantly is this a known issue that others are having as
> well? If so
> >is it only with the HDSP 9652? Have you brought the firmware up
> to the latest
> >level (is Windows absolutely needed for this?)?
>
> RME are happy to tell us how to write a firmware flash
> utility. someone just has to have the time. right now, i'm finding it
> hard to have the time to even check out how my hdsp9652 is behaving.
>
I think you have a customer or something keeping you busy right now?!?
Congrats on that!

Actually, testing for the problem I have is very easy and does not require
that you even listen to the card. With the newest driver code from Thomas,
and the newest hdspmixer, you can play a CD with alsaplayer, you'll see the
Playback meters operating, and see the Output meters either operating or
stuck at some level and not following playback.

I've recorded the output of the RME card in Pro Tools using the ADAT
interface there. All indications are that the card just sticks at some
level, constantly putting out the same numerical value until it starts
playing again. Pro Tools shows audio right up to the place it stops, and
then it just goes to the right recording a same, last audio value. 'Flat
liner' ;-)

This happens with or without Jack.

Anyway, if you can find the time I'd certainly appreciate it, but I do know
you are busy.

Cheers,
Mark





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
