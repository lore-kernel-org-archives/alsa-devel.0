From: Domen Puncer <domen@coderock.org>
Subject: Re: snd_mpu401_uart: hang when trying to play .mid
Date: Fri, 10 Sep 2004 15:22:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040910132243.GA3546@masina.coderock.org>
References: <20040905092234.GA3605@masina.coderock.org> <s5h656rwhmh.wl@alsa2.suse.de> <20040906154819.GA7901@nd47.coderock.org> <s5h1xhfwej2.wl@alsa2.suse.de> <20040906185838.GA8347@nd47.coderock.org> <1094501904.29921.56.camel@krustophenia.net> <s5hwtz7unxr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hwtz7unxr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Found an easier way to reproduce: `echo 1 > /dev/midi` :-)

On 06/09/04 22:45 +0200, Takashi Iwai wrote:
> At Mon, 06 Sep 2004 16:18:25 -0400,
> Lee Revell wrote:
> > 
> > On Mon, 2004-09-06 at 14:58, Domen Puncer wrote:
> > > On 06/09/04 18:25 +0200, Takashi Iwai wrote:
> > > > At Mon, 6 Sep 2004 17:48:19 +0200,
> > > > Domen Puncer wrote: 
> > > > > On 06/09/04 17:18 +0200, Takashi Iwai wrote:
> > > > > > Does your hardware really a MPU401 device?

It has MIDI/Joystick port.

> > > > > > If not, you can remove the call of snd_mpu401_uart_new() in
> > > > > > snd_trident_probe().

This helps.

> Yes, indeed, the trident code is shared among several different chips
> (trident 4D DX, 4D NX and SI7018), and MPU401 handling seems hitting
> on SI7018 only.  I guess SI7018 is equipped mostly on laptops, which
> unlikely have MPU401 connectors.  So, removing the mpu401 support for
> SI7018 may be the simplest and safest solution.
> 
> Of course, we can track down the hang-up point (perhaps in the
> interrupt handler, snd_mpu401_uart_interrupt()) and fix it, too.

That would be nice.

I tried nmi_watchdog=1, but it didn't trigger on hang!?

Enabled sound debugging messages, added some printk's and got:

XXX: snd_mpu401_uart_output_open: 269
XXX: snd_mpu401_uart_cmd: 204
ALSA sound/drivers/mpu401/mpu401_uart.c:217: cmd: tx timeout (status = 0x50)
XXX: snd_mpu401_uart_cmd: 236
ALSA sound/drivers/mpu401/mpu401_uart.c:238: cmd: 0xff failed at 0x20 (status = 0xff, data = 0x1)
XXX: snd_mpu401_uart_cmd: 204
ALSA sound/drivers/mpu401/mpu401_uart.c:217: cmd: tx timeout (status = 0xff)
XXX: snd_mpu401_uart_cmd: 236
ALSA sound/drivers/mpu401/mpu401_uart.c:238: cmd: 0x3f failed at 0x20 (status = 0x3f, data = 0x1)
XXX: snd_mpu401_uart_output_trigger: 416
XXX: snd_mpu401_uart_add_timer: 164
XXX: snd_mpu401_uart_add_timer: 175
XXX: snd_mpu401_uart_output_write: 389
XXX: snd_mpu401_uart_remove_timer: 184
XXX: snd_mpu401_uart_remove_timer: 193
double fault, gdt at c1206260 [255 bytes]
NMI Watchdog detected LOCKUP on CPU0, eip c010e3b2, registers:
Modules linked in: ipv6 uhci_hcd ehci_hcd stv680 videodev ohci_hcd snd_trident snd_util_mem snd_mpu401_uart 8139too mii crc32
parport_pc ppdev parport snd_ens1371 snd_rawmidi snd_ac97_codec rtc
CPU:    0
EIP:    0060:[<c010e3b2>]    Not tainted VLI
EFLAGS: 00004002   (2.6.9-rc1-bk7-kjt2)
EIP is at doublefault_fn+0x42/0x110
eax: 0120625f   ebx: c1206260   ecx: c041acd8   edx: 0000406e
esi: 00000000   edi: 00000000   ebp: c04fd85c   esp: c04fd838
ds: 007b   es: 007b   ss: 0068
Unable to handle kernel NULL pointer dereference at virtual address 00000068
 printing eip:
c0118ab1
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: ipv6 uhci_hcd ehci_hcd stv680 videodev ohci_hcd snd_trident snd_util_mem snd_mpu401_uart 8139too mii crc32
parport_pc ppdev parport snd_ens1371 snd_rawmidi snd_ac97_codec rtc
CPU:    0
EIP:    0060:[<c0118ab1>]    Not tainted VLI
EFLAGS: 00010017   (2.6.9-rc1-bk7-kjt2)
EIP is at do_page_fault+0x51/0x562
eax: c04ed000   ebx: c04fd000   ecx: 0000007b   edx: 00000000
esi: 00000000   edi: c0118a60   ebp: c04ed16c   esp: c04ed0cc
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 3382, threadinfo=c04ec000 task=ca5e0a40)
Stack: 00000000 00000000 00000000 00000068 00000000 00000000 00000000 00030001
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
Stack pointer is garbage, not printing trace
Code: ff 21 e0 81 bd 6c ff ff ff ff ff ff bf 8b 10 c7 85 7c ff ff ff 01 00 03 00 89 95 70 ff ff ff 0f 87 bc 04 00 00 8b 95 70
ff ff ff <8b> 5a 68 8b 50 14 8b 00 81 e2 ff ff ff fb 8b 40 14 f7 d0 c1 e8
 <0>Kernel panic - not syncing: Fatal exception in interrupt

-----

Then i removed/added some printk's and got:

XXX: snd_mpu401_uart_output_open: 266
XXX: snd_mpu401_uart_cmd: 202
ALSA sound/drivers/mpu401/mpu401_uart.c:215: cmd: tx timeout (status = 0x50)
ALSA sound/drivers/mpu401/mpu401_uart.c:235: cmd: 0xff failed at 0x20 (status = 0x50, data = 0x0)
XXX: snd_mpu401_uart_cmd: 202
ALSA sound/drivers/mpu401/mpu401_uart.c:215: cmd: tx timeout (status = 0x50)
ALSA sound/drivers/mpu401/mpu401_uart.c:235: cmd: 0x3f failed at 0x20 (status = 0x50, data = 0x0)
XXX: snd_mpu401_uart_output_trigger: 413
XXX: snd_mpu401_uart_add_timer: 164
XXX: snd_mpu401_uart_output_write: 386
XXX: snd_mpu401_uart_timer: 146
XXX: snd_mpu401_uart_timer: 152
XXX: _snd_mpu401_uart_interrupt: 95
ALSA sound/drivers/mpu401/mpu401_uart.c:89: cmd: clear rx timeout (status = 0x50)
XXX: _snd_mpu401_uart_interrupt: 105
XXX: snd_mpu401_uart_output_write: 386
XXX: _snd_mpu401_uart_interrupt: 115
XXX: snd_mpu401_uart_timer: 146
XXX: snd_mpu401_uart_timer: 152
XXX: _snd_mpu401_uart_interrupt: 95
ALSA sound/drivers/mpu401/mpu401_uart.c:89: cmd: clear rx timeout (status = 0x50)
(last 7 lines seem to be repeating forever)

-----

Something else i could try?


	Domen


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
