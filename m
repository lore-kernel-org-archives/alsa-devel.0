From: "Svetoslav Slavtchev" <svetljo@gmx.de>
Subject: Problems with Gamesurround Muse Pocket USB & 2.6.0-test11
Date: Sat, 6 Dec 2003 18:01:02 +0100 (MET)
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <13986.1070730062@www32.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-usb-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
just got a Hercules Gamesurround Muse Pocket USB
http://europe.hercules.com/showpage.php?p=84&b=1&show=2&f=1

and i got this (linux-2.6.0-test11 + alsa-1.0.0rc2)

hub 1-0:1.0: new USB device on port 2, assigned address 2
drivers/usb/input/hid-ff.c: hid_ff_init could not find initializer
input: USB HID v1.00 Device [USB Audio] on usb-0000:00:10.0-2
usbaudio: device 2 audiocontrol interface 0 has 1 input and 1 output
AudioStreaming interfaces
usbaudio: valid input sample rate 48000
usbaudio: device 2 interface 2 altsetting 1: format 0x80000010 sratelo 48000
sratehi 48000 attributes 0x00
usbaudio: valid output sample rate 48000
usbaudio: device 2 interface 1 altsetting 1: format 0x80000010 sratelo 48000
sratehi 48000 attributes 0x00
usbaudio: device 2 interface 1 altsetting 2 unsupported channels 6 framesize
2
usbaudio: registered dsp 14,19
usbaudio: constructing mixer for Terminal 6 type 0x0301
usbaudio: warning: found 2 of 6 logical channels.
usbaudio: no idea what's going on..., contact
linux-usb-devel@lists.sourceforge.net
usbaudio: registered mixer 14,16
usbaudio: constructing mixer for Terminal 7 type 0x0101
usbaudio: registered mixer 14,32
usb_audio_parsecontrol: usb_audio_state at d3575ea0
drivers/usb/core/usb.c: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
drivers/usb/core/usb.c: registered new driver snd-usb-audio

trough oss or alsa mixer i can access only the mic controls, but not the
pcm/volume controls :(

so
can i help somehow to get it fixed ?
or i should give it back

mainboard is Epox 8k9a3+ - VIA KT400/VT8235 (or was is VT8237)
according to the FAQ i should try changing the usb host controller drivers,
but i can not find the alternative uhci driver in 2.6 
loaded are uhci-hcd & ehci-hcd

best,

svetljo

PS.
please CC me as i'm not subscribed to the list

PS.2
[root@svetljo dev]# cat /proc/bus/usb/devices

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-ruby_t11_4_1 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:10.3
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-ruby_t11_4_1 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:10.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-ruby_t11_4_1 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:10.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 13/900 us ( 1%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-ruby_t11_4_1 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:10.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=06f8 ProdID=c000 Rev= 1.00
S:  Product=USB Audio
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 200 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 600 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=82(I) Atr=05(Isoc) MxPS= 200 Ivl=1ms
I:  If#= 3 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=83(I) Atr=03(Int.) MxPS=   3 Ivl=32ms

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
