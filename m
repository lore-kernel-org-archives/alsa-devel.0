From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: USB Audio problems
Date: Thu, 20 Nov 2003 11:04:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBC91C4.7020209@gmx.li>
References: <3FBBC461.1020006@opersys.com> <3FBC560B.7040104@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FBC560B.7040104@opersys.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: karim@opersys.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karim Yaghmour wrote:

>
> Well, it seems that I'm going to have to answer my own self ... :)

Yes, usb-audio seems to be a bit forgotten... (Takashi, those 
mplayer-plughw-segfaults still persist, even on x86 and even with kernel 
2.4 (current cvs of drivers/lib, of course)

>
> The following is what I've been able to find using additional tracing
> info. Also there's a fix for usbaudio.c.
>
hmmm, the submit_urb-error is gone, but random lockups and 
usb-device-disconnect until reboot have come... (bitkeeper-2.6 from just 
one hour ago...) with your function.

Have fun*

Niklas




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
