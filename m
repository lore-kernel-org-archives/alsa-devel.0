From: Eric Dantan Rzewnicki <eric@zhevny.com>
Subject: Re: [linux-audio-user] novation remote 25 usb midi controller
Date: Thu, 31 Jul 2003 16:47:42 -0400
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <3F29806E.24D0277E@zhevny.com>
References: <Pine.HPX.4.33n.0307311256530.10293-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: linux-audio-user@music.columbia.edu
Cc: alsa user <alsa-user@lists.sourceforge.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I thought I had installed hotplug, but apparently I forgot. After
installing it the uhci driver loads. However, still no midi. After
stopping alsa and then hotplug and then starting hotplug and alsa via
init scripts I see this in /var/log/messages:

box1:~# grep "\(usb\|uhci\)" /var/log/messages
.....
Jul 31 16:30:57 box1 kernel: usb.c: registered new driver usbdevfs
Jul 31 16:30:57 box1 kernel: usb.c: registered new driver hub
Jul 31 16:30:57 box1 kernel: uhci.c: USB Universal Host Controller
Interface driver v1.1
Jul 31 16:30:57 bJul 31 16:35:14 box1 kernel: usb.c: USB disconnect on
device 2
Jul 31 16:30:57 box1 kernel: usb.c: new USB bus registered, assigned bus
number 1
Jul 31 16:30:58 box1 kernel: usb.c: USB device 2 (vend/prod
0x1235/0x4661) is not claimed by any active driver.
Jul 31 16:31:01 box1 usb.agent: ... no modules for USB product
1235/4661/101
Jul 31 16:31:06 box1 kernel: usb.c: registered new driver snd-usb-audio

turning the remote 25 off and back on yields this:

Jul 31 16:35:14 box1 kernel: usb.c: USB disconnect on device 2
Jul 31 16:35:27 box1 kernel: hub.c: USB new device connect on bus1/1,
assigned device number 3
Jul 31 16:35:27 box1 kernel: usb.c: USB device 3 (vend/prod
0x1235/0x4661) is not claimed by any active driver.
Jul 31 16:35:30 box1 usb.agent: ... no modules for USB product
1235/4661/101

aconnect doesn't show anything either:

box1:~# aconnect -i   
client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '
box1:~# aconnect -o 

But, at least it shows up on the USB bus now:

box1:~# lsusb
Bus 001 Device 001: ID 0000:0000  
Bus 001 Device 003: ID 1235:4661

box1:~# cat /proc/bus/usb/devices 
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=6400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=1235 ProdID=4661 Rev= 1.01
S:  Manufacturer=Novation EMS     
S:  Product=ReMOTE25 V1.0
C:* #Ifs= 1 Cfg#= 1 Atr=20 MxPwr=250mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=83(I) Atr=03(Int.) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=03(Int.) MxPS=  32 Ivl=1ms

box1:~# cat /proc/bus/usb/drivers 
         usbdevfs
         hub
         snd-usb-audio

Is there any other info I could provide that might help? 

Steve mentioned that i might need the snd-usb-midi driver instead, but
if i remember correctly it was merged into the snd-usb-audio driver a
while back. Is that true?

Are there some options I'm supposed to pass to snd-usb-audio via
modules.conf?

I've read about special case quirks being added for specific usb
devices, but haven't understood what they are... Could that be possible
with the remote 25?

Thanks for your help,
Eric Rz.

Clemens Ladisch wrote:
> 
> Eric Dantan Rzewnicki wrote:
> > lsusb returns nothing and there is nothing in /proc/bus/usb/devices (
> > which I guess says the same thing. )
> > ...
> > lsmod looks like this:
> >
> > Module                  Size  Used by    Not tainted
> > input                   3296   0  (autoclean)
> > usbcore                55968   0  [snd-usb-audio]
> > snd-...                ...
> 
> The USB host controller driver (uhci or usb-uhci) isn't loaded.
> (This should be done automatically by one of your startup scripts.)
> 
> HTH
> Clemens


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
