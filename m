From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [linux-audio-user] novation remote 25 usb midi
 controller
Date: Mon, 04 Aug 2003 17:58:40 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308041745250.29364-100000@studcom.urz.uni-halle.de>
References: <3F2B0894.76B80218@zhevny.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3F2B0894.76B80218@zhevny.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Dantan Rzewnicki <eric@zhevny.com>
Cc: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Eric Dantan Rzewnicki wrote:
> Clemens Ladisch wrote:
> > Class ff is "vendor-specific", so it's not 100% compatible with the
> > USB Audio Specification.
> >
> > Please post the output of "lsusb -v".
>
> box1:~# lsusb -v
> ...

Unfortunately, this doesn't show any more information.

Well, we can try to find out what kind of protocol it speaks. If you
have Windows, please install a USB sniffer like "usbsnoop" or "usb
snoopy", press some keys on the keyboard, and send me the log file.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
