From: Martin Langer <martin-langer@gmx.de>
Subject: Re: my first usb-midi experiment ends with segmentation fault
Date: Mon, 29 Jul 2002 14:30:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020729123033.GA486@tuba.home>
References: <20020728213924.GA522@tuba.home> <s5h65yyakb0.wl@alsa2.suse.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h65yyakb0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 29, 2002 at 12:40:51PM +0200, Takashi Iwai wrote:
> At Sun, 28 Jul 2002 23:39:24 +0200,
> Martin Langer wrote:
> > ... and doing rmmod snd-usb-midi and rmmod snd-usb-audio ends here with 
> > Segmentation fault:
> > 
> > 
> > Jul 28 22:28:07 tuba kernel: usb.c: deregistering driver snd-usb-audio
> > Jul 28 22:28:10 tuba kernel: usb.c: deregistering driver snd-usb-midi
> > Jul 28 22:28:10 tuba kernel: Unable to handle kernel paging request at
> > virtual address 29323034
> > Jul 28 22:28:10 tuba kernel:  printing eip:
> > Jul 28 22:28:10 tuba kernel: e2858329
> > Jul 28 22:28:10 tuba kernel: *pde = 00000000
> > Jul 28 22:28:10 tuba kernel: Oops: 0002
> > Jul 28 22:28:10 tuba kernel: CPU:    0
> > Jul 28 22:28:10 tuba kernel: EIP:
> > 0010:[snd-dt019x:__insmod_snd-dt019x_O/lib/modules/2.4.19-rc1/kernel/sound/i+-195799/96]
> 
> hmm, why snd-dt019x module appears here..?
> was it loaded?  the trace seems corrupted...
> 

yes, snd-dt019x was loaded, but that make no difference.

> could you try to put snd-usb-audio to /etc/hotplug/blacklist, so that
> it's not automatically loaded.  then we'll know the problem is related
> only with snd-usb-midi.
> 

in both cases:
- without snd-usb-audio
- without snd-usb-audio and without snd-dt019x 
the same occurs. Yes, good arguments for a problem in snd-usb-midi. Here is
what I have done: just a modprobe and rmmod.

-------------------

tuba:~# lsmod 
Module                  Size  Used by    Not tainted
snd-mixer-oss           9056   0  (autoclean) (unused)
snd                    24136   0  (autoclean) [snd-mixer-oss]
soundcore               3364   0  (autoclean) [snd]
tuba:~# modprobe snd-usb-midi
tuba:~# rmmod snd-usb-midi
Segmentation fault
tuba:~# lsmod
Module                  Size  Used by    Not tainted
snd-usb-midi               0   0  (deleted)
snd-seq-virmidi         2728   0  [snd-usb-midi]
snd-seq-midi-event      2872   0  [snd-usb-midi snd-seq-virmidi]
snd-seq                37356   0  [snd-usb-midi snd-seq-virmidi
snd-seq-midi-event]
snd-timer              10400   0  [snd-seq]
snd-rawmidi            12224   0  [snd-seq-virmidi]
snd-seq-device          3856   0  [snd-usb-midi snd-seq snd-rawmidi]
snd-mixer-oss           9056   0  (autoclean) (unused)
snd                    24136   0  (autoclean) [snd-usb-midi snd-seq-virmidi
snd-seq-midi-event snd-seq snd-timer snd-rawmidi snd-seq-device snd-mixer-oss]
soundcore               3364   0  (autoclean) [snd]
tuba:~# 

--------------------

Jul 29 14:15:09 tuba kernel: usb.c: registered new driver snd-usb-midi
Jul 29 14:15:09 tuba kernel: snd-usb-midi: using interface 1
Jul 29 14:15:09 tuba kernel: snd-usb-midi: MIDIStreaming version 01.00
Jul 29 14:15:09 tuba kernel: snd-usb-midi: using 1 input jack(s) on endpoint 1
Jul 29 14:15:09 tuba kernel: snd-usb-midi: using 1 output jack(s) on
endpoint 2
Jul 29 14:15:09 tuba kernel: snd-usb-midi: detected Evolution Electronics L
MK-2
49C USB MIDI keyboa
Jul 29 14:15:14 tuba kernel: usb.c: deregistering driver snd-usb-midi
Jul 29 14:15:14 tuba kernel:  printing eip:
Jul 29 14:15:14 tuba kernel: e2b20329
Jul 29 14:15:14 tuba kernel: Oops: 0002
Jul 29 14:15:14 tuba kernel: CPU:    0
Jul 29 14:15:14 tuba kernel: EIP:    0010:[<e2b20329>]    Not tainted
Jul 29 14:15:14 tuba kernel: EFLAGS: 00210246
Jul 29 14:15:14 tuba kernel: eax: 29323030   ebx: db5021c0   ecx: db502204
edx
: db502100
Jul 29 14:15:14 tuba kernel: esi: db500c00   edi: 00001fff   ebp: e2b3b7dc
esp
: db041ee4
Jul 29 14:15:14 tuba kernel: ds: 0018   es: 0018   ss: 0018
Jul 29 14:15:14 tuba kernel: Process rmmod (pid: 485, stackpage=db041000)
Jul 29 14:15:14 tuba kernel: Stack: daf98380 dd446e00 e2b203ed db500c00
e2b18e5a
 daf98380 00001000 e2b18fc5 
 Jul 29 14:15:14 tuba kernel:        dd446e00 db500c00 dd446e00 00000001
e2b3b7c0
 e2b159ae dd446e00 00000001 
 Jul 29 14:15:14 tuba kernel:        00000000 e2b3aa01 dd446e00 dfe688d8
c021e47d
 dfe67800 dd446e00 dfe67300 
 Jul 29 14:15:14 tuba kernel: Call Trace: [<e2b203ed>] [<e2b18e5a>]
[<e2b18fc5>] 
[<e2b3b7c0>] [<e2b159ae>] 
Jul 29 14:15:14 tuba kernel:    [<e2b3aa01>] [usb_drivers_purge+141/224]
[<e2b3b
7c0>] [usb_drivers_purge+62/224] [<e2b3b7c0>] [<e2b3b7c0>] 
Jul 29 14:15:14 tuba kernel:    [usb_deregister+114/144] [<e2b3b7c0>]
[<e2b3aa8a
>] [<e2b3b7c0>] [free_module+23/160] [sys_delete_module+247/448] 
Jul 29 14:15:14 tuba kernel:    [system_call+51/56] 
Jul 29 14:15:14 tuba kernel: 
Jul 29 14:15:14 tuba kernel: Code: 89 50 04 89 02 ff 4b 3c ff 43 44 0f 8e 05
07 
00 00 53 56 e8 



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
