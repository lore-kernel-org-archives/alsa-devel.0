From: Martin Langer <martin-langer@gmx.de>
Subject: my first usb-midi experiment ends with segmentation fault
Date: Sun, 28 Jul 2002 23:39:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020728213924.GA522@tuba.home>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA02556
	for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2002 23:34:54 +0200
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

my new USB-MIDI-Keyboard has two USB subclasses usb-midi and usb-audio.
Evolution, the manufacturer, told me "it's an Audio Class compliant device", 
but I don't find a new entry in /proc/asound/seq/clients after loading the
modules.

cat /proc/bus/usb/devices 

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=01(audio) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0a4d ProdID=008e Rev= 2.00
S:  Manufacturer=Evolution Electronics Ltd.
S:  Product=MK-249C USB MIDI keyboard
C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-midi
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms


dmesg:

usb.c: registered new driver snd-usb-audio
usb.c: snd-usb-audio driver claimed interface dfe688c0
usb.c: registered new driver snd-usb-midi
snd-usb-midi: using interface 1
snd-usb-midi: MIDIStreaming version 01.00
snd-usb-midi: using 1 input jack(s) on endpoint 1
snd-usb-midi: using 1 output jack(s) on endpoint 2
snd-usb-midi: detected Evolution Electronics L MK-249C USB MIDI keyboa
usb.c: snd-usb-midi driver claimed interface dfe688d8



It's not typical to have a midi-keyboard with two subclasses, or?
... and doing rmmod snd-usb-midi and rmmod snd-usb-audio ends here with 
Segmentation fault:


Jul 28 22:28:07 tuba kernel: usb.c: deregistering driver snd-usb-audio
Jul 28 22:28:10 tuba kernel: usb.c: deregistering driver snd-usb-midi
Jul 28 22:28:10 tuba kernel: Unable to handle kernel paging request at
virtual address 29323034
Jul 28 22:28:10 tuba kernel:  printing eip:
Jul 28 22:28:10 tuba kernel: e2858329
Jul 28 22:28:10 tuba kernel: *pde = 00000000
Jul 28 22:28:10 tuba kernel: Oops: 0002
Jul 28 22:28:10 tuba kernel: CPU:    0
Jul 28 22:28:10 tuba kernel: EIP:
0010:[snd-dt019x:__insmod_snd-dt019x_O/lib/modules/2.4.19-rc1/kernel/sound/i+-195799/96]
   Not tainted
   Jul 28 22:28:10 tuba kernel: EFLAGS: 00210246
   Jul 28 22:28:10 tuba kernel: eax: 29323030   ebx: dcb21940   ecx:
dcb21984   edx: dcb21900
Jul 28 22:28:10 tuba kernel: esi: d900d000   edi: 00001fff   ebp: e2b637dc
esp: d84cdee4
Jul 28 22:28:10 tuba kernel: ds: 0018   es: 0018   ss: 0018
Jul 28 22:28:10 tuba kernel: Process rmmod (pid: 529, stackpage=d84cd000)
Jul 28 22:28:10 tuba kernel: Stack: d9662dc0 db38cc00 e28583ed d900d000
e2854e5a d9662dc0 00001000 e2854fc5 
Jul 28 22:28:10 tuba kernel:        db38cc00 d900d000 db38cc00 00000001
e2b637c0 e28519ae db38cc00 00000001 
Jul 28 22:28:10 tuba kernel:        00000000 e2b62a01 db38cc00 dfe68898
c021e47d dfe67800 db38cc00 dfe67300 
Jul 28 22:28:10 tuba kernel: Call Trace:
[snd-dt019x:__insmod_snd-dt019x_O/lib/modules/2.4.19-rc1/kernel/sound/i+-195603/96]
[snd-dt019x:__insmod_snd-dt019x_O/lib/modules/2.4.19-rc1/kernel/sound/i+-209318/96]
[snd-dt019x:__insmod_snd-dt019x_O/lib/modules/2.4.19-rc1/kernel/sound/i+-208955/96]
[<e2b637c0>]
[snd-dt019x:__insmod_snd-dt019x_O/lib/modules/2.4.19-rc1/kernel/sound/i+-222802/96]

Jul 28 22:28:10 tuba kernel:    [<e2b62a01>] [usb_drivers_purge+141/224]
[<e2b637c0>] [usb_drivers_purge+62/224] [<e2b637c0>] [<e2b637c0>] 
Jul 28 22:28:10 tuba kernel:    [usb_deregister+114/144] [<e2b637c0>]
[<e2b62a8a>] [<e2b637c0>] [free_module+23/160] [sys_delete_module+247/448] 
Jul 28 22:28:10 tuba kernel:    [system_call+51/56] 
Jul 28 22:28:10 tuba kernel: 
Jul 28 22:28:10 tuba kernel: Code: 89 50 04 89 02 ff 4b 3c ff 43 44 0f 8e 05
07 00 00 53 56 e8 


a small bug or a big hole?

martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
