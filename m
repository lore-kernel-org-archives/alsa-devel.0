From: Patrick Shirkey <kotau@firstlinux.net>
Subject: Re: Fwd: Re: USB Quattro Linux support
Date: Wed, 17 Apr 2002 00:12:06 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020417071207.05D6636FA@sitemail.everyone.net>
Reply-To: pshirkey@boosthardware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



--- Paul Davis <pbd@op.net> wrote:
>
>
>Not at all. arecord(1) can capture audio, but it can't capture 26
>channels of audio at 64 frames/interrupt. Handling latency is partly
>an application issue, partly a kernel issue, and partly a requirement
>that libraries in the way don't get in the way. It has very little to
>do with whether you can do certain generic tasks or not.
>

Sure. But usb audio devices are limited to a pretty low channel count.

eg. this usb quattro can only capture 1 channel at 96000,24 bit even though it has up to 4 channels. It would seem to be a limitaion of usb as a transfer protocol. 

My point is that the latency requirements for USB devices are not quite as intense as PCI devices. So it shouldn't cause as many headaches to write the code compared to the RME dsp for example.

FWIW:

After Steve's tip (LAU) to turn on usb audio in the kernel (didn't know it existed) and modprobe audio,  I can get this info from 

cat /proc/bus/usb/devices

I haven't been able to send anything to the card yet because it doesn't create any devices in /dev/dspX.

At least we know that Maudio have followed the rules of the usb audio reference this far.

Does anyone have ideas on what I could do next?

--------
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=1020
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0763 ProdID=2001 Rev= 1.01
S:  Manufacturer=M Audio
S:  Product=USB AudioSport Quattro (tm)
C:* #Ifs=10 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=audio
I:  If#= 1 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=03(O) Atr=09(Isoc) MxPS= 192 Ivl=  1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=audio
I:  If#= 2 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=85(I) Atr=0d(Isoc) MxPS= 192 Ivl=  1ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
I:  If#= 4 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=audio
I:  If#= 4 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=03(O) Atr=09(Isoc) MxPS= 576 Ivl=  1ms
I:  If#= 4 Alt= 3 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=03(O) Atr=09(Isoc) MxPS= 288 Ivl=  1ms
I:  If#= 4 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=03(O) Atr=09(Isoc) MxPS= 192 Ivl=  1ms
I:  If#= 5 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=audio
I:  If#= 5 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=85(I) Atr=0d(Isoc) MxPS= 576 Ivl=  1ms
I:  If#= 5 Alt= 3 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=85(I) Atr=0d(Isoc) MxPS= 288 Ivl=  1ms
I:  If#= 5 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=85(I) Atr=0d(Isoc) MxPS= 192 Ivl=  1ms
I:  If#= 6 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
I:  If#= 7 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=audio
I:  If#= 7 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=04(O) Atr=09(Isoc) MxPS= 576 Ivl=  1ms
I:  If#= 7 Alt= 3 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=04(O) Atr=09(Isoc) MxPS= 288 Ivl=  1ms
I:  If#= 7 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=04(O) Atr=09(Isoc) MxPS= 192 Ivl=  1ms
I:  If#= 8 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=audio
I:  If#= 8 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=86(I) Atr=0d(Isoc) MxPS= 576 Ivl=  1ms
I:  If#= 8 Alt= 3 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=86(I) Atr=0d(Isoc) MxPS= 288 Ivl=  1ms
I:  If#= 8 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=86(I) Atr=0d(Isoc) MxPS= 192 Ivl=  1ms
I:  If#= 9 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  32 Ivl=  1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  32 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  32 Ivl=  0ms

--------


--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/Linux_Audio_Users_Guide/


_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_____________________________________________________________
Run a small business? Then you need professional email like you@yourbiz.com from Everyone.net  http://www.everyone.net?tag
