From: Marc Giger <gigerstyle@gmx.ch>
Subject: Oops on resume alsa 0.9.8
Date: Mon, 15 Dec 2003 15:27:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031215152707.38d3cb61.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi All,

Since upgrading to 0.9.8 im not able to resume from apm. 

I'm willing to try out patches

greetings

Marc

Here are 2 oopses:

vaio ~ # ksymoops -m /boot/System.map-2423 oops2.txt
ksymoops 2.4.9 on i686 2.4.23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /boot/System.map-2423 (specified)

Dec 14 12:53:54 vaio kernel: c011a823
Dec 14 12:53:54 vaio kernel: Oops: 0000
Dec 14 12:53:54 vaio kernel: CPU:    0
Dec 14 12:53:54 vaio kernel: EIP:    0010:[<c011a823>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 14 12:53:54 vaio kernel: EFLAGS: 00210083
Dec 14 12:53:54 vaio kernel: eax: cd09ddb0   ebx: c901be6c   ecx:
0c109046 Dec 14 12:53:54 vaio kernel: esi: cd09ddb0   edi: 00000003  
ebp: cc8c1ee4 Dec 14 12:53:57 vaio kernel: ds: 0018   es: 0018   ss:
0018 Dec 14 12:53:57 vaio kernel: Process X (pid: 2361,
stackpage=cc8c1000) Dec 14 12:53:57 vaio kernel: Stack: cd09dc00
d0c74986 00000001 00200282 c1314c08 c1316854 c1316840 00000000
Dec 14 12:53:57 vaio kernel:        d0c719d2 ccec1000 c02542b6 c1314c00
c02543eb c1314c00 c1316840 00000003
Dec 14 12:53:57 vaio kernel:        00000000 c0254533 c1316840 c130b2e0
c0254595 c130b460 c012ba92 c130b2e0
Dec 14 12:53:57 vaio kernel: Call Trace:    [<d0c74986>] [<d0c719d2>]
[<c02542b6>] [<c02543eb>] [<c0254533>]
Dec 14 12:53:57 vaio kernel:   [<c0254595>] [<c012ba92>] [<c012bb94>]
[<c0116123>] [<c011683c>] [<c011a3c0>]
Dec 14 12:53:57 vaio kernel:   [<c014e839>] [<c010914f>]
Dec 14 12:53:57 vaio kernel: Code: 8b 01 85 c7 75 19 8b 02 89 d3 89 c2
0f 18


>>EIP; c011a823 <__wake_up+33/80>   <=====

>>eax; cd09ddb0 <_end+ccd2b9c/1080ce4c>
>>ebx; c901be6c <_end+8c50c58/1080ce4c>
>>esi; cd09ddb0 <_end+ccd2b9c/1080ce4c>
>>ebp; cc8c1ee4 <_end+c4f6cd0/1080ce4c>

Trace; d0c74986 <[snd-ymfpci]snd_ymfpci_resume+a6/100>
Trace; d0c719d2 <[snd-ymfpci]snd_card_ymfpci_resume+12/20>
Trace; c02542b6 <pci_pm_resume_device+26/30>
Trace; c02543eb <pci_pm_resume_bus+2b/70>
Trace; c0254533 <pci_pm_resume+33/50>
Trace; c0254595 <pci_pm_callback+45/50>
Trace; c012ba92 <pm_send+72/a0>
Trace; c012bb94 <pm_send_all+74/b0>
Trace; c0116123 <suspend+e3/120>
Trace; c011683c <do_ioctl+10c/180>
Trace; c011a3c0 <process_timeout+0/20>
Trace; c014e839 <sys_ioctl+c9/250>
Trace; c010914f <system_call+33/38>

Code;  c011a823 <__wake_up+33/80>
00000000 <_EIP>:
Code;  c011a823 <__wake_up+33/80>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c011a825 <__wake_up+35/80>
   2:   85 c7                     test   %eax,%edi
Code;  c011a827 <__wake_up+37/80>
   4:   75 19                     jne    1f <_EIP+0x1f>
Code;  c011a829 <__wake_up+39/80>
   6:   8b 02                     mov    (%edx),%eax
Code;  c011a82b <__wake_up+3b/80>
   8:   89 d3                     mov    %edx,%ebx
Code;  c011a82d <__wake_up+3d/80>
   a:   89 c2                     mov    %eax,%edx
Code;  c011a82f <__wake_up+3f/80>
   c:   0f 18 00                  prefetchnta (%eax)


vaio ~ # ksymoops -m /boot/System.map-2423 oops1.txt
ksymoops 2.4.9 on i686 2.4.23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /boot/System.map-2423 (specified)

Dec  1 09:54:55 vaio kernel: c011a823
Dec  1 09:54:55 vaio kernel: Oops: 0000
Dec  1 09:54:55 vaio kernel: CPU:    0
Dec  1 09:54:55 vaio kernel: EIP:    0010:[<c011a823>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  1 09:54:55 vaio kernel: EFLAGS: 00010083
Dec  1 09:54:55 vaio kernel: eax: c03269c0   ebx: c93c3e14   ecx:
00000000 Dec  1 09:54:55 vaio kernel: esi: cc8cedb0   edi: 00000003  
ebp: cca6bee4 Dec  1 09:54:55 vaio kernel: ds: 0018   es: 0018   ss:
0018 Dec  1 09:54:55 vaio kernel: Process X (pid: 2253,
stackpage=cca6b000) Dec  1 09:54:55 vaio kernel: Stack: c93c2000
00000000 00000001 00000282 c1314c08 c1316854 c1316840 00000000
Dec  1 09:54:55 vaio kernel:        d0c719d2 ccf63000 c02542b6 c1314c00
c02543eb c1314c00 c1316840 00000003
Dec  1 09:54:55 vaio kernel:        00000000 c0254533 c1316840 c130b2e0
c0254595 c130b460 c012ba92 c130b2e0
Dec  1 09:54:55 vaio kernel: Call Trace:    [<d0c719d2>] [<c02542b6>]
[<c02543eb>] [<c0254533>] [<c0254595>]
Dec  1 09:54:55 vaio kernel:   [<c012ba92>] [<c012bb94>] [<c0116123>]
[<c011683c>] [<c011a3c0>] [<c014e839>]
Dec  1 09:54:55 vaio kernel:   [<c010914f>]
Dec  1 09:54:55 vaio kernel: Code: 8b 01 85 c7 75 19 8b 02 89 d3 89 c2
0f 18


>>EIP; c011a823 <__wake_up+33/80>   <=====

>>eax; c03269c0 <default_ldt+0/28>
>>ebx; c93c3e14 <_end+8ff8c00/1080ce4c>
>>esi; cc8cedb0 <_end+c503b9c/1080ce4c>
>>ebp; cca6bee4 <_end+c6a0cd0/1080ce4c>

Trace; d0c719d2 <[snd-ymfpci]snd_card_ymfpci_resume+12/20>
Trace; c02542b6 <pci_pm_resume_device+26/30>
Trace; c02543eb <pci_pm_resume_bus+2b/70>
Trace; c0254533 <pci_pm_resume+33/50>
Trace; c0254595 <pci_pm_callback+45/50>
Trace; c012ba92 <pm_send+72/a0>
Trace; c012bb94 <pm_send_all+74/b0>
Trace; c0116123 <suspend+e3/120>
Trace; c011683c <do_ioctl+10c/180>
Trace; c011a3c0 <process_timeout+0/20>
Trace; c014e839 <sys_ioctl+c9/250>
Trace; c010914f <system_call+33/38>

Code;  c011a823 <__wake_up+33/80>
00000000 <_EIP>:
Code;  c011a823 <__wake_up+33/80>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c011a825 <__wake_up+35/80>
   2:   85 c7                     test   %eax,%edi
Code;  c011a827 <__wake_up+37/80>
   4:   75 19                     jne    1f <_EIP+0x1f>
Code;  c011a829 <__wake_up+39/80>
   6:   8b 02                     mov    (%edx),%eax
Code;  c011a82b <__wake_up+3b/80>
   8:   89 d3                     mov    %edx,%ebx
Code;  c011a82d <__wake_up+3d/80>
   a:   89 c2                     mov    %eax,%edx
Code;  c011a82f <__wake_up+3f/80>
   c:   0f 18 00                  prefetchnta (%eax)



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
