From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: success with the latest intel8x0 driver
Date: Mon, 26 Aug 2002 16:38:42 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208261634170.27110-100000@aino.wakkanet.fi>
References: <s5hznv9by6q.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznv9by6q.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Aug 2002, Takashi Iwai wrote:

>> Btw; I currently have access to quite a lot of sound hardware
>>      (desktops/laptops with cs4281, ess1978, ice1712, ens1371, 
> could you test the laptop with cs4281 whether suspend/resume works?

I tested with a few tp-x21 laptops (cs4281-rev01). Stand/resume works on
both, but suspend/resume does not. After resume the audio playback is not
audible. Reloading the module cures the problem. On one of the laptops I
got the following oops:

--cut--
Oops: 0000
CPU:    0
EIP:    0010:[<d08c0426>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: d086f180   ebx: ceb01618   ecx: 00000060   edx: d08c3000
esi: cffe1c34   edi: c143f800   ebp: 00000003   esp: cc299ee0
ds: 0018   es: 0018   ss: 0018
Process apm (pid: 3871, stackpage=cc299000)
Stack: c143fc08 d08c0526 ceb01618 c01b2380 c143fc00 00000003 c01b248a
c143fc00
       00000003 cffe1c20 00000003 00000000 00000000 c01b2577 cffe1c20
00000003
       cffed2a0 00000003 c01b2616 00000003 c0121a80 cffed2a0 00000000
00000003
Call Trace: [<d08c0526>] [<c01b2380>] [<c01b248a>] [<c01b2577>]
[<c01b2616>]
   [<c0121a80>] [<c0121b36>] [<c0110bee>] [<c0111357>] [<c013be17>]
[<c0106ceb>]
Code: 8b 04 10 89 84 0b 68 01 00 00 83 c1 04 eb eb 8d 88 80 01 00

>>EIP; d08c0426 <[snd-cs4281]cs4281_suspend+56/80>   <=====
Trace; d08c0526 <[snd-cs4281]snd_cs4281_suspend+46/50>
Trace; c01b2380 <pci_do_scan_bus+200/4a0>
Trace; c01b248a <pci_do_scan_bus+30a/4a0>
Trace; c01b2577 <pci_do_scan_bus+3f7/4a0>
Trace; c01b2616 <pci_do_scan_bus+496/4a0>
Trace; c0121a80 <pm_send+40/b0>
Trace; c0121b36 <pm_send_all+46/a0>
Trace; c0110bee <mtrr_del+145e/2d60>
Trace; c0111357 <mtrr_del+1bc7/2d60>
Trace; c013be17 <kill_fasync+307/320>
Trace; c0106ceb <__up_wakeup+112f/24b4>
Code;  d08c0426 <[snd-cs4281]cs4281_suspend+56/80>
00000000 <_EIP>:
Code;  d08c0426 <[snd-cs4281]cs4281_suspend+56/80>   <=====
   0:   8b 04 10                  mov    (%eax,%edx,1),%eax   <=====
Code;  d08c0429 <[snd-cs4281]cs4281_suspend+59/80>
   3:   89 84 0b 68 01 00 00      mov    %eax,0x168(%ebx,%ecx,1)
Code;  d08c0430 <[snd-cs4281]cs4281_suspend+60/80>
   a:   83 c1 04                  add    $0x4,%ecx
Code;  d08c0433 <[snd-cs4281]cs4281_suspend+63/80>
   d:   eb eb                     jmp    fffffffa <_EIP+0xfffffffa> 
d08c0420 <[snd-cs4281]cs4281_suspend+50/80>
Code;  d08c0435 <[snd-cs4281]cs4281_suspend+65/80>
   f:   8d 88 80 01 00 00         lea    0x180(%eax),%ecx
--cut--

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
