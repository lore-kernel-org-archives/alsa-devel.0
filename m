From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: alsa-0.9.3a : powermac locks machine hard
Date: Thu, 15 May 2003 19:05:40 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030515190540.567823bd.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I have an Apple iBook running Debian Linux with a kernel compiled
from the Debian kernel-source-2.4.20 package with the Debain PowerPC
patches applied. I have installed from source (obtained at 
alsa-project.org) :

	alsa-driver-0.9.3a
	alsa-lib-0.9.3

When I run the init script ("/etc/init.d/alsa start" on my Debian 
installation) it fails stating that alsactl seg faulted. If I 
then run "/etc/init.d/alsa stop", the machine locks hard (no 
response to keyboard or pings).

I then removed the battery and rebooted the machine. Here is the
kernel Ooops message. Is there anything I can do to help debug this?

Cheers,
Erik

May 15 11:09:04 miles kernel: i2c-core.o: driver PMac Keywest Audio registered.
May 15 11:09:04 miles kernel: i2c-core.o: client [TAS3001c] registered to adapter [mac-io 0](pos. 0).
May 15 11:09:05 miles kernel: Oops: kernel access of bad area, sig: 11
May 15 11:09:05 miles kernel: NIP: C001140C XER: 20000000 LR: C00113DC SP: CAB09E60 REGS: cab09db0 TRAP: 0300    Not tainted
May 15 11:09:05 miles kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
May 15 11:09:05 miles kernel: DAR: 00000000, DSISR: 40000000
May 15 11:09:05 miles kernel: TASK = cab08000[458] 'alsactl' Last syscall: 6 
May 15 11:09:05 miles kernel: last math cab08000 last altivec 00000000
May 15 11:09:05 miles kernel: GPR00: CC658D98 CAB09E60 CAB08000 00000001 00009032 00000001 D1823EF0 C02CE260 
May 15 11:09:05 miles kernel: GPR08: CA9D3000 C0200000 D184C000 C00113AC 24000822 1001F350 00000000 00000000 
May 15 11:09:05 miles kernel: GPR16: 00000000 00000000 00000000 00000000 00009032 0AB09F40 00000000 00000003 
May 15 11:09:05 miles kernel: GPR24: CC658D9C C0240000 C02039C0 00000001 CC658D98 CC658D9C 00000000 CAB09E60 
May 15 11:09:05 miles kernel: Call backtrace: 
May 15 11:09:05 miles kernel: C0032A40 D1823964 D182661C C00390B0 C0037C04 C0037C9C C00042FC 
May 15 11:09:05 miles kernel: 0FE180A0 0FF65D68 0FF65E04 100056EC 100061A8 0FCD0E04 00000000 
May 15 11:09:17 miles kernel: Oops: kernel access of bad area, sig: 11
May 15 11:09:17 miles kernel: NIP: C001140C XER: 20000000 LR: C00113DC SP: CAB13E60 REGS: cab13db0 TRAP: 0300    Not tainted
May 15 11:09:17 miles kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
May 15 11:09:17 miles kernel: DAR: 00000000, DSISR: 40000000
May 15 11:09:17 miles kernel: TASK = cab12000[468] 'alsactl' Last syscall: 6 
May 15 11:09:17 miles kernel: last math cab12000 last altivec 00000000
May 15 11:09:17 miles kernel: GPR00: CC658D98 CAB13E60 CAB12000 00000001 00009032 00000001 D1823EF0 C02CE260 
May 15 11:09:17 miles kernel: GPR08: CA9DE040 C0200000 D184C000 C00113AC 24000822 1001F350 00000000 00000000 
May 15 11:09:17 miles kernel: GPR16: 00000000 00000000 00000000 00000000 00009032 0AB13F40 00000000 00000003 
May 15 11:09:17 miles kernel: GPR24: CC658D9C C0240000 C02039C0 00000001 CC658D98 CC658D9C 00000000 CAB13E60 
May 15 11:09:17 miles kernel: Call backtrace: 
May 15 11:09:17 miles kernel: C0032A40 D1823964 D182661C C00390B0 C0037C04 C0037C9C C00042FC 
May 15 11:09:17 miles kernel: 0FE180A0 0FF65D68 0FF65E04 10005484 10006154 0FCD0E04 00000000 


-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
Linux, the UNIX defragmentation tool.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
