From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [linux-audio-user] novation remote 25 usb midi controller
Date: Fri, 01 Aug 2003 09:26:52 +0200 (METDST)
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308010917360.22186-100000@studcom.urz.uni-halle.de>
References: <3F29806E.24D0277E@zhevny.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-reply-to: <3F29806E.24D0277E@zhevny.com>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: linux-audio-user@music.columbia.edu
Cc: alsa user <alsa-user@lists.sourceforge.net>, alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Eric Dantan Rzewnicki wrote:
> Jul 31 16:35:27 box1 kernel: hub.c: USB new device connect on bus1/1,
> assigned device number 3
> Jul 31 16:35:27 box1 kernel: usb.c: USB device 3 (vend/prod
> 0x1235/0x4661) is not claimed by any active driver.
> Jul 31 16:35:30 box1 usb.agent: ... no modules for USB product
> 1235/4661/101
>
> box1:~# cat /proc/bus/usb/devices
> ...
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=1235 ProdID=4661 Rev= 1.01
> S:  Manufacturer=Novation EMS
> S:  Product=ReMOTE25 V1.0
> C:* #Ifs= 1 Cfg#= 1 Atr=20 MxPwr=250mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)

Class ff is "vendor-specific", so it's not 100% compatible with the
USB Audio Specification.

> Steve mentioned that i might need the snd-usb-midi driver instead, but
> if i remember correctly it was merged into the snd-usb-audio driver a
> while back. Is that true?

Yes, it's true (that the former is not true).

> I've read about special case quirks being added for specific usb
> devices, but haven't understood what they are... Could that be possible
> with the remote 25?

Those are for devices that are almost compatible with the spec. This
may or may not be the case with the Remote25.

Please post the output of "lsusb -v".


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
