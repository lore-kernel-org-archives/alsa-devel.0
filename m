From: =?iso-8859-15?Q?Jos=E9?= Fonseca <j_r_fonseca@yahoo.co.uk>
Subject: Oops in cs4281_suspend
Date: Mon, 11 Nov 2002 14:31:36 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021111143136.GB6862@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I'm using alsa-0.9.0_rc5 with 2.4.20-pre10-mjc2 and I get a kernel oops
in cs4281_suspend when suspeding the machine. Result of ksymoops is
attached.

Matching the disassembly with the assembly output of gcc with the same
options (also attached), it shows that the problem is in the line:

	chip->suspend_regs[i] = snd_cs4281_peekBA0(chip, saved_regs[i]);

more specifically, in the inlined snd_cs4281_peekBA0() function:

        return readl(chip->ba0 + offset);

I tried to add some more debugging output in cs4281_suspend to see why
this happens, but I can't get anything out of it. One thing is sure -
removing the snd-cs4281 module before suspending avoids the problem
completely.

I hope this enables you to fix the problem. Please tell me if there is
anything more I can do.

José Fonseca

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.4.5 on i686 2.4.20-pre10-mjc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre10-mjc2/ (default)
     -m /boot/System.map (specified)

cs: cb_alloc(bus 2): vendor 0x10ec, device 0x8139
8139too Fast Ethernet driver 0.9.26
Unable to handle kernel paging request at virtual address 991b6920
cc8cc437
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<cc8cc437>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: cc8e7920   ebx: cc8ccf40   ecx: cc8cf000   edx: 00000018
esi: cbabc800   edi: 00000003   ebp: c1487ed4   esp: c1487eac
ds: 0018   es: 0018   ss: 0018
Process apmd (pid: 4914, stackpage=c1487000)
Stack: cbabcc00 cba88008 cba850c0 cc8cc512 cbabc800 cbaae460 c1487ed4 c01b4002 
       cba88000 00000003 c1487ef0 c01b40e1 cba88000 00000003 cba850c0 00000003 
       00000003 c1487f08 c01b41ce cba850c0 00000003 cba7a2e0 00000000 c1487f14 
Call Trace:    [<cc8cc512>] [<c01b4002>] [<c01b40e1>] [<c01b41ce>] [<c01b425f>]
  [<c012404d>] [<c012410b>] [<c0110f6f>] [<c0111612>] [<c0144d76>] [<c0106fab>]
Code: 8b 04 08 89 84 96 64 01 00 00 42 eb ec ff 80 78 01 00 00 0f 


>>EIP; cc8cc437 <[snd-cs4281]cs4281_suspend+67/90>   <=====

>>eax; cc8e7920 <[8139too]rtl8139_pci_driver+0/27>
>>ebx; cc8ccf40 <[snd-cs4281]saved_regs+0/60>
>>ecx; cc8cf000 <[snd-cs4281].bss.end+1fe1/15041>
>>esi; cbabc800 <_end+b7fd648/c583ea8>
>>ebp; c1487ed4 <_end+11c8d1c/c583ea8>
>>esp; c1487eac <_end+11c8cf4/c583ea8>

Trace; cc8cc512 <[snd-cs4281]snd_cs4281_suspend+12/20>
Trace; c01b4002 <pci_pm_suspend_device+22/26>
Trace; c01b40e1 <pci_pm_suspend_bus+4b/66>
Trace; c01b41ce <pci_pm_suspend+22/46>
Trace; c01b425f <pci_pm_callback+2f/38>
Trace; c012404d <pm_send+61/80>
Trace; c012410b <pm_send_all+5f/8c>
Trace; c0110f6f <suspend+d/ec>
Trace; c0111612 <do_ioctl+f2/140>
Trace; c0144d76 <sys_ioctl+e4/264>
Trace; c0106fab <system_call+33/38>

Code;  cc8cc437 <[snd-cs4281]cs4281_suspend+67/90>
00000000 <_EIP>:
Code;  cc8cc437 <[snd-cs4281]cs4281_suspend+67/90>   <=====
   0:   8b 04 08                  mov    (%eax,%ecx,1),%eax   <=====
Code;  cc8cc43a <[snd-cs4281]cs4281_suspend+6a/90>
   3:   89 84 96 64 01 00 00      mov    %eax,0x164(%esi,%edx,4)
Code;  cc8cc441 <[snd-cs4281]cs4281_suspend+71/90>
   a:   42                        inc    %edx
Code;  cc8cc442 <[snd-cs4281]cs4281_suspend+72/90>
   b:   eb ec                     jmp    fffffff9 <_EIP+0xfffffff9>
Code;  cc8cc444 <[snd-cs4281]cs4281_suspend+74/90>
   d:   ff 80 78 01 00 00         incl   0x178(%eax)
Code;  cc8cc44a <[snd-cs4281]cs4281_suspend+7a/90>
  13:   0f 00 00                  sldtl  (%eax)


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cs4281.s"

[...]
	.file 159 "../alsa-kernel/pci/cs4281.c"
[...]
	.text
	.align 2
	.p2align 4,,15
	.type	cs4281_suspend,@function
cs4281_suspend:
.LFB47:
	.loc 159 2093 0
	pushl	%esi
.LCFI129:
	pushl	%ebx
.LCFI130:
	subl	$4, %esp
.LCFI131:
	movl	16(%esp), %esi
	.loc 159 2094 0
.LBB292:
	movl	44(%esi), %eax
	.loc 30 115 0
.LBB293:
.LBB294:
	leal	376(%eax), %ecx
	.loc 30 120 0
#APP
	# atomic down operation
	decl 376(%eax)
	js 2f
1:
.subsection 1
	.ifndef .text.lock.cs4281
	.text.lock.cs4281:
	.endif
	2:	call __down_failed
	jmp 1b
.previous
	
	.loc 159 2099 0
#NO_APP
.LBE294:
.LBE293:
	cmpl	$768, 372(%eax)
	je	.L985
	.loc 159 2102 0
	movl	48(%esi), %eax
	.loc 159 2112 0
	movl	$saved_regs, %ebx
	.loc 159 2102 0
	movl	%eax, (%esp)
	call	snd_pcm_suspend_all_R9cd5838a
	.loc 159 2112 0
	xorl	%edx, %edx
	.loc 159 578 0
.LBB295:
	movl	4(%esi), %ecx
	movl	1024(%ecx), %eax
	.loc 159 2105 0
.LBE295:
	orl	$65536, %eax
	.loc 159 573 0
.LBB296:
	movl	%eax, 1024(%ecx)
.LBE296:
.LBB297:
	movl	$2, 8(%ecx)
	.p2align 4,,15
.L995:
	.loc 159 2113 0
.LBE297:
	movl	(%ebx,%edx,4), %eax
	testl	%eax, %eax
	je	.L991
	.loc 159 578 0			; cs4281.c:578
.LBB298:
	movl	(%eax,%ecx), %eax	; <=====
	.loc 159 577 0
.LBE298:
	movl	%eax, 356(%esi,%edx,4)
	.loc 159 2112 0
.L991:
	incl	%edx
	jmp	.L995
.L985:
	.loc 30 201 0
.LBB299:
.LBB300:
#APP
	# atomic up operation
	incl 376(%eax)
	jle 2f
1:
.subsection 1
	.ifndef .text.lock.cs4281
	.text.lock.cs4281:
	.endif
	2:	call __up_wakeup
	jmp 1b
.previous
	.subsection 0

	.loc 159 2135 0
#NO_APP
	popl	%eax
	popl	%ebx
	popl	%esi
	ret
.LBE300:
.LBE299:
.LBE292:
.LFE47:
.Lfe47:
	.size	cs4281_suspend,.Lfe47-cs4281_suspend
[...]

--jI8keyz6grp/JLjh--
__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
