From: Svante Signell <srs@kth.se>
Subject: Bug#613979: [alsa-devel] Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Thu, 31 Mar 2011 00:42:46 +0200
Message-ID: <1301524966.21366.118.camel@hp.my.own.domain>
References: <1301394280.3906.29.camel@s1499.it.kth.se>
	 <s5haage43qz.wl%tiwai@suse.de>	<1301396296.32453.1.camel@s1499.it.kth.se>
	 <s5h7hbi41xs.wl%tiwai@suse.de>
	 <1301480744.21366.110.camel@hp.my.own.domain>
	 <s5hpqp827sv.wl%tiwai@suse.de> <1301486370.32453.9.camel@s1499.it.kth.se>
	 <4D932C71.10402@ladisch.de>
Reply-To: Svante Signell <srs@kth.se>, 613979@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-aZdDwlmqxkIajkvWZLLv"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.613979.B613979.130152501217681@bugs.debian.org>
In-Reply-To: <4D932C71.10402@ladisch.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, 619034@bugs.debian.org, alsa-devel@alsa-project.org, 613979@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--=-aZdDwlmqxkIajkvWZLLv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-03-30 at 15:13 +0200, Clemens Ladisch wrote:
> Svante Signell wrote:
> > Code: f4 01 00 00 ef 31 f6 48 89 df e8 15 dd ff ff 85 c0
> > 0f 88 2b 03 00 00 48 89 ef e8 ee 11 b9 e0 8b 7b 40 e8 9f 25 a7 e0 48 8b
> > 43 38 <66> 8b 10 66 89 14 24 8b 43 14 83 e8 03 83 f8 01 77 32 31 d2 be
> 
>    5:   31 f6                   xor    %esi,%esi
>    7:   48 89 df                mov    %rbx,%rdi
>    a:   e8 15 dd ff ff          callq  0xffffffffffffdd24
>    f:   85 c0                   test   %eax,%eax
>   11:   0f 88 2b 03 00 00       js     0x342
>   17:   48 89 ef                mov    %rbp,%rdi
>   1a:   e8 ee 11 b9 e0          callq  0xffffffffe0b9120d
>   1f:   8b 7b 40                mov    0x40(%rbx),%edi
>   22:   e8 9f 25 a7 e0          callq  0xffffffffe0a725c6
>   27:   48 8b 43 38             mov    0x38(%rbx),%rax
>   2b:   66 8b 10                mov    (%rax),%dx         <-- crash here
>   2e:   66 89 14 24             mov    %dx,(%rsp)
>   32:   8b 43 14                mov    0x14(%rbx),%eax
>   35:   83 e8 03                sub    $0x3,%eax
>   38:   83 f8 01                cmp    $0x1,%eax
>   3b:   77 32                   ja     0x6f
>   3d:   31 d2                   xor    %edx,%edx
> 
> This is the azx_readw(chip, GCAP) in azx_create(); chip->remap_addr is
> 0xffffc90011c08000 which does look like a valid pointer, but isn't.

Thank you Clemens! Maybe your input is sufficient to solve this problem.
I have now installed the debug version of the kernel, the objdump output
is attached (please let me know if you are missing something).sorry, I
don't know where to find the relevant information in this file, but that
is all I have (still very large). (Does not include the error messages
on stderr, maybe something is still missing.)

Thanks!




--=-aZdDwlmqxkIajkvWZLLv
Content-Disposition: attachment; filename="objdump_dbg.out"
Content-Type: text/plain; name="objdump_dbg.out"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


/lib/modules/2.6.38-2-amd64/kernel/sound/pci/hda/snd-hda-intel.ko:     file format elf64-x86-64


Disassembly of section .note.gnu.build-id:

0000000000000000 <.note.gnu.build-id>:
alsa_card_azx_exit():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1870
   0:	04 00                	add    $0x0,%al
pci_get_drvdata():
   2:	00 00                	add    %al,(%rax)
   4:	14 00                	adc    $0x0,%al
   6:	00 00                	add    %al,(%rax)
   8:	03 00                	add    (%rax),%eax
   a:	00 00                	add    %al,(%rax)
   c:	47                   	rex.RXB
   d:	4e 55                	rex.WRX push %rbp
   f:	00 99 56 d8 67 3f    	add    %bl,0x3f67d856(%rcx)
alsa_card_azx_init():
  15:	a9 de f7 14 c3       	test   $0xc314f7de,%eax
pci_set_drvdata():
  1a:	5e                   	pop    %rsi
  1b:	2e 7e 1c             	jle,pn 3a <__mod_power_save_controller116+0x11>
  1e:	6b 76 a0 4f          	imul   $0x4f,-0x60(%rsi),%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
  22:	2d                   	.byte 0x2d
readl():
  23:	4e                   	rex.WRX

Disassembly of section .text:

0000000000000000 <azx_get_position>:
       0:	48 8b 46 68          	mov    0x68(%rsi),%rax
azx_get_position():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1874
       4:	48 63 40 3c          	movslq 0x3c(%rax),%rax
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
       8:	8b 84 87 e8 01 00 00 	mov    0x1e8(%rdi,%rax,4),%eax
azx_via_get_position():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1817
       f:	83 f8 01             	cmp    $0x1,%eax
      12:	74 0b                	je     1f <azx_get_position+0x1f>
      14:	83 f8 03             	cmp    $0x3,%eax
      17:	0f 85 a6 00 00 00    	jne    c3 <azx_get_position+0xc3>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1827
      1d:	eb 0c                	jmp    2b <azx_get_position+0x2b>
      1f:	48 8b 46 58          	mov    0x58(%rsi),%rax
readw():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:57
      23:	8b 48 04             	mov    0x4(%rax),%ecx
      26:	e9 9e 00 00 00       	jmpq   c9 <azx_get_position+0xc9>
      2b:	48 8b 46 58          	mov    0x58(%rsi),%rax
azx_via_get_position():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1834
      2f:	8b 48 04             	mov    0x4(%rax),%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1832
      32:	80 7e 75 03          	cmpb   $0x3,0x75(%rsi)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1834
      36:	0f 87 8d 00 00 00    	ja     c9 <azx_get_position+0xc9>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1836
      3c:	48 8b 46 30          	mov    0x30(%rsi),%rax
      40:	44 8b 46 3c          	mov    0x3c(%rsi),%r8d
      44:	48 8b 7f 38          	mov    0x38(%rdi),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1839
      48:	8b 00                	mov    (%rax),%eax
      4a:	66 44 8b 8f 90 00 00 	mov    0x90(%rdi),%r9w
      51:	00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1842
      52:	40 8a 7e 7c          	mov    0x7c(%rsi),%dil
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1843
      56:	45 0f b7 c9          	movzwl %r9w,%r9d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1845
      5a:	40 f6 c7 08          	test   $0x8,%dil
      5e:	74 12                	je     72 <azx_get_position+0x72>
      60:	44 39 c9             	cmp    %r9d,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1827
      63:	77 04                	ja     69 <azx_get_position+0x69>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1848
      65:	31 c9                	xor    %ecx,%ecx
      67:	eb 60                	jmp    c9 <azx_get_position+0xc9>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1849
      69:	83 e7 f7             	and    $0xfffffffffffffff7,%edi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1827
      6c:	40 88 7e 7c          	mov    %dil,0x7c(%rsi)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1849
      70:	eb 0c                	jmp    7e <azx_get_position+0x7e>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1850
      72:	44 39 c9             	cmp    %r9d,%ecx
      75:	77 07                	ja     7e <azx_get_position+0x7e>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1848
      77:	8b 7e 38             	mov    0x38(%rsi),%edi
      7a:	01 cf                	add    %ecx,%edi
      7c:	eb 02                	jmp    80 <azx_get_position+0x80>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1852
      7e:	89 cf                	mov    %ecx,%edi
      80:	31 d2                	xor    %edx,%edx
      82:	44 29 cf             	sub    %r9d,%edi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1853
      85:	41 f7 f0             	div    %r8d
      88:	44 8b 46 3c          	mov    0x3c(%rsi),%r8d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1855
      8c:	89 c8                	mov    %ecx,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1856
      8e:	41 89 d2             	mov    %edx,%r10d
      91:	31 d2                	xor    %edx,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1855
      93:	41 f7 f0             	div    %r8d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1856
      96:	44 39 ca             	cmp    %r9d,%edx
      99:	73 0e                	jae    a9 <azx_get_position+0xa9>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1861
      9b:	31 d2                	xor    %edx,%edx
      9d:	89 f8                	mov    %edi,%eax
azx_get_position():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1880
      9f:	41 f7 f0             	div    %r8d
      a2:	41 39 d2             	cmp    %edx,%r10d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1883
      a5:	72 06                	jb     ad <azx_get_position+0xad>
      a7:	89 f9                	mov    %edi,%ecx
      a9:	29 d1                	sub    %edx,%ecx
      ab:	eb 11                	jmp    be <azx_get_position+0xbe>
      ad:	42 8d 0c 07          	lea    (%rdi,%r8,1),%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1886
      b1:	b8 00 00 00 00       	mov    $0x0,%eax
azx_pcm_pointer():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1894
      b6:	29 d1                	sub    %edx,%ecx
      b8:	3b 4e 38             	cmp    0x38(%rsi),%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1889
      bb:	0f 43 c8             	cmovae %eax,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1894
      be:	44 01 d1             	add    %r10d,%ecx
      c1:	eb 06                	jmp    c9 <azx_get_position+0xc9>
      c3:	48 8b 46 30          	mov    0x30(%rsi),%rax
      c7:	8b 08                	mov    (%rax),%ecx
      c9:	3b 4e 38             	cmp    0x38(%rsi),%ecx
      cc:	b8 00 00 00 00       	mov    $0x0,%eax
      d1:	0f 43 c8             	cmovae %eax,%ecx
      d4:	89 c8                	mov    %ecx,%eax
      d6:	c3                   	retq   

00000000000000d7 <azx_pcm_pointer>:
      d7:	53                   	push   %rbx
      d8:	48 8b 87 c0 00 00 00 	mov    0xc0(%rdi),%rax
      df:	48 89 fb             	mov    %rdi,%rbx
      e2:	48 8b b0 48 01 00 00 	mov    0x148(%rax),%rsi
      e9:	48 8b 47 10          	mov    0x10(%rdi),%rax
request_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/interrupt.h:139
      ed:	48 8b 38             	mov    (%rax),%rdi
      f0:	e8 0b ff ff ff       	callq  0 <azx_get_position>
      f5:	48 8b 93 c0 00 00 00 	mov    0xc0(%rbx),%rdx
probe_codec():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2100
      fc:	89 c0                	mov    %eax,%eax
      fe:	48 c1 e0 03          	shl    $0x3,%rax
request_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/interrupt.h:139
     102:	5b                   	pop    %rbx
probe_codec():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2100
     103:	8b 8a 90 00 00 00    	mov    0x90(%rdx),%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2102
     109:	48 99                	cqto   
     10b:	48 f7 f9             	idiv   %rcx
     10e:	c3                   	retq   

000000000000010f <azx_acquire_irq>:
     10f:	55                   	push   %rbp
     110:	49 c7 c0 00 00 00 00 	mov    $0x0,%r8
azx_acquire_irq():
     117:	89 f5                	mov    %esi,%ebp
request_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/interrupt.h:139
     119:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
azx_acquire_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2102
     120:	53                   	push   %rbx
request_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/interrupt.h:139
     121:	48 89 fb             	mov    %rdi,%rbx
     124:	49 89 d9             	mov    %rbx,%r9
     127:	48 83 ec 08          	sub    $0x8,%rsp
     12b:	8a 87 f4 01 00 00    	mov    0x1f4(%rdi),%al
azx_acquire_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2101
     131:	83 e0 10             	and    $0x10,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2104
     134:	3c 01                	cmp    $0x1,%al
     136:	48 8b 47 08          	mov    0x8(%rdi),%rax
     13a:	48 19 c9             	sbb    %rcx,%rcx
     13d:	31 d2                	xor    %edx,%edx
     13f:	81 e1 80 00 00 00    	and    $0x80,%ecx
     145:	8b b8 e4 02 00 00    	mov    0x2e4(%rax),%edi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2106
     14b:	e8 00 00 00 00       	callq  150 <azx_acquire_irq+0x41>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2107
     150:	85 c0                	test   %eax,%eax
     152:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
     156:	74 28                	je     180 <azx_acquire_irq+0x71>
     158:	8b b7 e4 02 00 00    	mov    0x2e4(%rdi),%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2111
     15e:	31 c0                	xor    %eax,%eax
     160:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2110
     167:	e8 00 00 00 00       	callq  16c <azx_acquire_irq+0x5d>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2111
     16c:	83 c8 ff             	or     $0xffffffffffffffff,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2110
     16f:	85 ed                	test   %ebp,%ebp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2111
     171:	74 2e                	je     1a1 <azx_acquire_irq+0x92>
     173:	48 8b 3b             	mov    (%rbx),%rdi
     176:	e8 00 00 00 00       	callq  17b <azx_acquire_irq+0x6c>
     17b:	83 c8 ff             	or     $0xffffffffffffffff,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2113
     17e:	eb 21                	jmp    1a1 <azx_acquire_irq+0x92>
     180:	40 8a b3 f4 01 00 00 	mov    0x1f4(%rbx),%sil
azx_position_ok():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1907
     187:	8b 87 e4 02 00 00    	mov    0x2e4(%rdi),%eax
     18d:	40 c0 ee 04          	shr    $0x4,%sil
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     191:	89 43 40             	mov    %eax,0x40(%rbx)
     194:	83 f6 01             	xor    $0x1,%esi
     197:	83 e6 01             	and    $0x1,%esi
azx_position_ok():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1913
     19a:	e8 00 00 00 00       	callq  19f <azx_acquire_irq+0x90>
     19f:	31 c0                	xor    %eax,%eax
     1a1:	5a                   	pop    %rdx
     1a2:	5b                   	pop    %rbx
     1a3:	5d                   	pop    %rbp
     1a4:	c3                   	retq   

00000000000001a5 <azx_position_ok>:
     1a5:	41 55                	push   %r13
     1a7:	41 54                	push   %r12
     1a9:	55                   	push   %rbp
     1aa:	48 89 fd             	mov    %rdi,%rbp
     1ad:	53                   	push   %rbx
     1ae:	48 89 f3             	mov    %rsi,%rbx
     1b1:	48 83 ec 08          	sub    $0x8,%rsp
     1b5:	48 8b 47 38          	mov    0x38(%rdi),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1916
     1b9:	44 8b 60 30          	mov    0x30(%rax),%r12d
     1bd:	48 8b 46 50          	mov    0x50(%rsi),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1917
     1c1:	31 d2                	xor    %edx,%edx
     1c3:	b9 03 00 00 00       	mov    $0x3,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1918
     1c8:	44 2b 66 48          	sub    0x48(%rsi),%r12d
     1cc:	48 01 c0             	add    %rax,%rax
     1cf:	48 f7 f1             	div    %rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1919
     1d2:	49 39 c4             	cmp    %rax,%r12
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1920
     1d5:	0f 82 b0 00 00 00    	jb     28b <azx_position_ok+0xe6>
     1db:	48 8b 46 68          	mov    0x68(%rsi),%rax
     1df:	4c 63 68 3c          	movslq 0x3c(%rax),%r13
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1923
     1e3:	e8 18 fe ff ff       	callq  0 <azx_get_position>
     1e8:	49 83 c5 78          	add    $0x78,%r13
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1924
     1ec:	42 83 7c ad 08 00    	cmpl   $0x0,0x8(%rbp,%r13,4)
     1f2:	75 2f                	jne    223 <azx_position_ok+0x7e>
     1f4:	85 c0                	test   %eax,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1926
     1f6:	75 22                	jne    21a <azx_position_ok+0x75>
     1f8:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1929
     1ff:	e8 00 00 00 00       	callq  204 <azx_position_ok+0x5f>
     204:	42 c7 44 ad 08 01 00 	movl   $0x1,0x8(%rbp,%r13,4)
     20b:	00 00 
     20d:	48 89 de             	mov    %rbx,%rsi
     210:	48 89 ef             	mov    %rbp,%rdi
     213:	e8 e8 fd ff ff       	callq  0 <azx_get_position>
     218:	eb 09                	jmp    223 <azx_position_ok+0x7e>
     21a:	42 c7 44 ad 08 02 00 	movl   $0x2,0x8(%rbp,%r13,4)
     221:	00 00 
     223:	8b 4b 3c             	mov    0x3c(%rbx),%ecx
     226:	85 c9                	test   %ecx,%ecx
     228:	75 2c                	jne    256 <azx_position_ok+0xb1>
     22a:	80 3d 00 00 00 00 01 	cmpb   $0x1,0x0(%rip)        # 231 <azx_position_ok+0x8c>
     231:	74 58                	je     28b <azx_position_ok+0xe6>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1932
     233:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
     23a:	be 8a 07 00 00       	mov    $0x78a,%esi
     23f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     246:	31 c0                	xor    %eax,%eax
     248:	e8 00 00 00 00       	callq  24d <azx_position_ok+0xa8>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1935
     24d:	c6 05 00 00 00 00 01 	movb   $0x1,0x0(%rip)        # 254 <azx_position_ok+0xaf>
     254:	eb 35                	jmp    28b <azx_position_ok+0xe6>
     256:	48 6b 53 50 05       	imul   $0x5,0x50(%rbx),%rdx
     25b:	48 c1 ea 02          	shr    $0x2,%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1936
     25f:	49 39 d4             	cmp    %rdx,%r12
     262:	73 1c                	jae    280 <azx_position_ok+0xdb>
     264:	31 d2                	xor    %edx,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1937
     266:	f7 f1                	div    %ecx
     268:	d1 e9                	shr    %ecx
azx_create():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1938
     26a:	39 ca                	cmp    %ecx,%edx
     26c:	76 12                	jbe    280 <azx_position_ok+0xdb>
azx_position_ok():
     26e:	48 63 55 10          	movslq 0x10(%rbp),%rdx
azx_update_rirb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:637
     272:	31 c0                	xor    %eax,%eax
     274:	83 3c 95 00 00 00 00 	cmpl   $0x0,0x0(,%rdx,4)
     27b:	00 
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     27c:	74 0d                	je     28b <azx_position_ok+0xe6>
     27e:	eb 0e                	jmp    28e <azx_position_ok+0xe9>
     280:	4c 01 63 48          	add    %r12,0x48(%rbx)
azx_update_rirb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:643
     284:	b8 01 00 00 00       	mov    $0x1,%eax
azx_create():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:642
     289:	eb 03                	jmp    28e <azx_position_ok+0xe9>
     28b:	83 c8 ff             	or     $0xffffffffffffffff,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:643
     28e:	59                   	pop    %rcx
     28f:	5b                   	pop    %rbx
     290:	5d                   	pop    %rbp
     291:	41 5c                	pop    %r12
     293:	41 5d                	pop    %r13
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:645
     295:	c3                   	retq   

0000000000000296 <azx_update_rirb>:
     296:	41 54                	push   %r12
     298:	55                   	push   %rbp
     299:	53                   	push   %rbx
     29a:	48 89 fb             	mov    %rdi,%rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:602
     29d:	48 8b 47 38          	mov    0x38(%rdi),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:649
     2a1:	40 8a 68 58          	mov    0x58(%rax),%bpl
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:652
     2a5:	0f b7 87 42 01 00 00 	movzwl 0x142(%rdi),%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:649
     2ac:	40 0f b6 ed          	movzbl %bpl,%ebp
     2b0:	39 c5                	cmp    %eax,%ebp
     2b2:	0f 84 91 00 00 00    	je     349 <azx_update_rirb+0xb3>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:651
     2b8:	66 89 ab 42 01 00 00 	mov    %bp,0x142(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:653
     2bf:	45 31 e4             	xor    %r12d,%r12d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:652
     2c2:	eb 74                	jmp    338 <azx_update_rirb+0xa2>
     2c4:	ff c0                	inc    %eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:600
     2c6:	48 8b 8b 30 01 00 00 	mov    0x130(%rbx),%rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:602
     2cd:	66 25 ff 00          	and    $0xff,%ax
     2d1:	66 89 83 40 01 00 00 	mov    %ax,0x140(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:656
     2d8:	0f b7 c0             	movzwl %ax,%eax
     2db:	01 c0                	add    %eax,%eax
     2dd:	8d 50 01             	lea    0x1(%rax),%edx
     2e0:	89 c0                	mov    %eax,%eax
     2e2:	8b 34 81             	mov    (%rcx,%rax,4),%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:657
     2e5:	89 d2                	mov    %edx,%edx
     2e7:	8b 14 91             	mov    (%rcx,%rdx,4),%edx
     2ea:	89 d0                	mov    %edx,%eax
     2ec:	83 e0 0f             	and    $0xf,%eax
     2ef:	83 f8 08             	cmp    $0x8,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:658
     2f2:	41 0f 43 c4          	cmovae %r12d,%eax
     2f6:	f6 c2 10             	test   $0x10,%dl
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:660
     2f9:	74 0e                	je     309 <azx_update_rirb+0x73>
     2fb:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
check_msi():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:662
     302:	e8 00 00 00 00       	callq  307 <azx_update_rirb+0x71>
     307:	eb 2f                	jmp    338 <azx_update_rirb+0xa2>
     309:	89 c0                	mov    %eax,%eax
     30b:	48 8d 48 50          	lea    0x50(%rax),%rcx
     30f:	83 7c 8b 04 00       	cmpl   $0x0,0x4(%rbx,%rcx,4)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:647
     314:	74 0d                	je     323 <azx_update_rirb+0x8d>
     316:	89 b4 83 64 01 00 00 	mov    %esi,0x164(%rbx,%rax,4)
     31d:	ff 4c 8b 04          	decl   0x4(%rbx,%rcx,4)
     321:	eb 15                	jmp    338 <azx_update_rirb+0xa2>
     323:	8b 8c 83 f8 01 00 00 	mov    0x1f8(%rbx,%rax,4),%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1102
     32a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     331:	31 c0                	xor    %eax,%eax
spin_lock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:285
     333:	e8 00 00 00 00       	callq  338 <azx_update_rirb+0xa2>
     338:	8b 83 40 01 00 00    	mov    0x140(%rbx),%eax
check_msi():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1102
     33e:	0f b7 d0             	movzwl %ax,%edx
     341:	39 ea                	cmp    %ebp,%edx
spin_lock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:285
     343:	0f 85 7b ff ff ff    	jne    2c4 <azx_update_rirb+0x2e>
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     349:	5b                   	pop    %rbx
     34a:	5d                   	pop    %rbp
     34b:	41 5c                	pop    %r12
     34d:	c3                   	retq   

000000000000034e <azx_interrupt>:
     34e:	41 57                	push   %r15
check_msi():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1112
     350:	41 56                	push   %r14
     352:	41 55                	push   %r13
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1135
     354:	41 54                	push   %r12
     356:	4c 8d 66 44          	lea    0x44(%rsi),%r12
     35a:	55                   	push   %rbp
     35b:	4c 89 e7             	mov    %r12,%rdi
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     35e:	48 89 f5             	mov    %rsi,%rbp
check_msi():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1135
     361:	53                   	push   %rbx
     362:	48 83 ec 18          	sub    $0x18,%rsp
     366:	e8 00 00 00 00       	callq  36b <azx_interrupt+0x1d>
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
     36b:	48 8b 45 38          	mov    0x38(%rbp),%rax
     36f:	44 8b 70 24          	mov    0x24(%rax),%r14d
check_msi():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1114
     373:	45 85 f6             	test   %r14d,%r14d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1118
     376:	74 17                	je     38f <azx_interrupt+0x41>
     378:	48 8d 85 18 02 00 00 	lea    0x218(%rbp),%rax
     37f:	45 31 ed             	xor    %r13d,%r13d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1119
     382:	41 b7 1c             	mov    $0x1c,%r15b
azx_create():
     385:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
     38a:	e9 a5 00 00 00       	jmpq   434 <azx_interrupt+0xe6>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     38f:	66 ff 45 44          	incw   0x44(%rbp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     393:	31 c0                	xor    %eax,%eax
     395:	e9 e1 00 00 00       	jmpq   47b <azx_interrupt+0x12d>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1122
     39a:	49 63 dd             	movslq %r13d,%rbx
     39d:	48 c1 e3 07          	shl    $0x7,%rbx
     3a1:	48 03 5d 68          	add    0x68(%rbp),%rbx
INIT_LIST_HEAD():
     3a5:	44 85 73 60          	test   %r14d,0x60(%rbx)
     3a9:	0f 84 82 00 00 00    	je     431 <azx_interrupt+0xe3>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1126
     3af:	48 8b 43 58          	mov    0x58(%rbx),%rax
azx_create():
     3b3:	8a 40 03             	mov    0x3(%rax),%al
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1127
     3b6:	48 8b 53 58          	mov    0x58(%rbx),%rdx
     3ba:	44 88 7a 03          	mov    %r15b,0x3(%rdx)
check_position_fix():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1128
     3be:	48 83 7b 68 00       	cmpq   $0x0,0x68(%rbx)
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
     3c3:	74 6c                	je     431 <azx_interrupt+0xe3>
check_position_fix():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1130
     3c5:	f6 43 7c 02          	testb  $0x2,0x7c(%rbx)
     3c9:	74 66                	je     431 <azx_interrupt+0xe3>
     3cb:	a8 04                	test   $0x4,%al
spin_lock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:285
     3cd:	74 62                	je     431 <azx_interrupt+0xe3>
     3cf:	48 89 de             	mov    %rbx,%rsi
     3d2:	48 89 ef             	mov    %rbp,%rdi
     3d5:	e8 cb fd ff ff       	callq  1a5 <azx_position_ok>
check_position_fix():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1132
     3da:	83 f8 01             	cmp    $0x1,%eax
     3dd:	75 1c                	jne    3fb <azx_interrupt+0xad>
     3df:	80 63 7c fb          	andb   $0xfb,0x7c(%rbx)
     3e3:	66 41 ff 04 24       	incw   (%r12)
     3e8:	48 8b 7b 68          	mov    0x68(%rbx),%rdi
     3ec:	e8 00 00 00 00       	callq  3f1 <azx_interrupt+0xa3>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1134
     3f1:	4c 89 e7             	mov    %r12,%rdi
     3f4:	e8 00 00 00 00       	callq  3f9 <azx_interrupt+0xab>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1135
     3f9:	eb 36                	jmp    431 <azx_interrupt+0xe3>
     3fb:	85 c0                	test   %eax,%eax
     3fd:	75 32                	jne    431 <azx_interrupt+0xe3>
     3ff:	48 8b 85 c8 00 00 00 	mov    0xc8(%rbp),%rax
     406:	48 85 c0             	test   %rax,%rax
     409:	74 26                	je     431 <azx_interrupt+0xe3>
     40b:	48 83 b8 40 01 00 00 	cmpq   $0x0,0x140(%rax)
     412:	00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1117
     413:	74 1c                	je     431 <azx_interrupt+0xe3>
     415:	80 4b 7c 04          	orb    $0x4,0x7c(%rbx)
azx_create():
     419:	48 8b 85 c8 00 00 00 	mov    0xc8(%rbp),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     420:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
check_probe_mask():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1143
     425:	48 8b b8 40 01 00 00 	mov    0x140(%rax),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1145
     42c:	e8 00 00 00 00       	callq  431 <azx_interrupt+0xe3>
     431:	41 ff c5             	inc    %r13d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1146
     434:	44 3b 6d 28          	cmp    0x28(%rbp),%r13d
     438:	0f 8c 5c ff ff ff    	jl     39a <azx_interrupt+0x4c>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1147
     43e:	48 8b 45 38          	mov    0x38(%rbp),%rax
     442:	8a 40 5d             	mov    0x5d(%rax),%al
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     445:	0f b6 c0             	movzbl %al,%eax
     448:	a8 05                	test   $0x5,%al
     44a:	74 25                	je     471 <azx_interrupt+0x123>
     44c:	a8 01                	test   $0x1,%al
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
     44e:	74 18                	je     468 <azx_interrupt+0x11a>
     450:	83 7d 14 0a          	cmpl   $0xa,0x14(%rbp)
     454:	75 0a                	jne    460 <azx_interrupt+0x112>
     456:	bf 30 3e 05 00       	mov    $0x53e30,%edi
check_probe_mask():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1160
     45b:	e8 00 00 00 00       	callq  460 <azx_interrupt+0x112>
     460:	48 89 ef             	mov    %rbp,%rdi
     463:	e8 2e fe ff ff       	callq  296 <azx_update_rirb>
update_pci_byte():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1039
     468:	48 8b 55 38          	mov    0x38(%rbp),%rdx
     46c:	b0 05                	mov    $0x5,%al
     46e:	88 42 5d             	mov    %al,0x5d(%rdx)
     471:	66 41 ff 04 24       	incw   (%r12)
     476:	b8 01 00 00 00       	mov    $0x1,%eax
     47b:	48 83 c4 18          	add    $0x18,%rsp
pci_read_config_byte():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:734
     47f:	5b                   	pop    %rbx
     480:	5d                   	pop    %rbp
     481:	41 5c                	pop    %r12
     483:	41 5d                	pop    %r13
     485:	41 5e                	pop    %r14
     487:	41 5f                	pop    %r15
     489:	c3                   	retq   

000000000000048a <update_pci_byte>:
     48a:	41 55                	push   %r13
     48c:	41 88 cd             	mov    %cl,%r13b
update_pci_byte():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1044
     48f:	41 54                	push   %r12
pci_write_config_byte():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:747
     491:	41 88 d4             	mov    %dl,%r12b
update_pci_byte():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1044
     494:	55                   	push   %rbp
     495:	89 f5                	mov    %esi,%ebp
     497:	89 ea                	mov    %ebp,%edx
     499:	53                   	push   %rbx
     49a:	48 89 fb             	mov    %rdi,%rbx
pci_write_config_byte():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:747
     49d:	48 83 ec 18          	sub    $0x18,%rsp
azx_create():
     4a1:	8b 77 38             	mov    0x38(%rdi),%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1044
     4a4:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
     4a8:	48 8d 4c 24 0f       	lea    0xf(%rsp),%rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:747
     4ad:	e8 00 00 00 00       	callq  4b2 <update_pci_byte+0x28>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1046
     4b2:	44 88 e1             	mov    %r12b,%cl
     4b5:	8b 73 38             	mov    0x38(%rbx),%esi
     4b8:	45 21 ec             	and    %r13d,%r12d
     4bb:	f7 d1                	not    %ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1049
     4bd:	22 4c 24 0f          	and    0xf(%rsp),%cl
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1057
     4c1:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
     4c5:	89 ea                	mov    %ebp,%edx
     4c7:	44 09 e1             	or     %r12d,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1049
     4ca:	88 4c 24 0f          	mov    %cl,0xf(%rsp)
     4ce:	0f b6 c9             	movzbl %cl,%ecx
     4d1:	e8 00 00 00 00       	callq  4d6 <update_pci_byte+0x4c>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1057
     4d6:	48 83 c4 18          	add    $0x18,%rsp
     4da:	5b                   	pop    %rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1059
     4db:	5d                   	pop    %rbp
     4dc:	41 5c                	pop    %r12
     4de:	41 5d                	pop    %r13
     4e0:	c3                   	retq   

00000000000004e1 <azx_init_pci>:
     4e1:	55                   	push   %rbp
     4e2:	31 c9                	xor    %ecx,%ecx
     4e4:	ba 07 00 00 00       	mov    $0x7,%edx
     4e9:	be 44 00 00 00       	mov    $0x44,%esi
     4ee:	53                   	push   %rbx
     4ef:	48 89 fb             	mov    %rdi,%rbx
     4f2:	48 83 ec 18          	sub    $0x18,%rsp
     4f6:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1062
     4fa:	e8 8b ff ff ff       	callq  48a <update_pci_byte>
     4ff:	8b 43 14             	mov    0x14(%rbx),%eax
     502:	83 f8 03             	cmp    $0x3,%eax
     505:	74 16                	je     51d <azx_init_pci+0x3c>
     507:	7f 09                	jg     512 <azx_init_pci+0x31>
     509:	ff c8                	dec    %eax
     50b:	7d 6f                	jge    57c <azx_init_pci+0x9b>
     50d:	e9 c4 00 00 00       	jmpq   5d6 <azx_init_pci+0xf5>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1068
     512:	83 f8 08             	cmp    $0x8,%eax
     515:	0f 85 bb 00 00 00    	jne    5d6 <azx_init_pci+0xf5>
     51b:	eb 15                	jmp    532 <azx_init_pci+0x51>
     51d:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
     521:	b9 02 00 00 00       	mov    $0x2,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1071
     526:	ba 07 00 00 00       	mov    $0x7,%edx
     52b:	be 42 00 00 00       	mov    $0x42,%esi
     530:	eb 43                	jmp    575 <azx_init_pci+0x94>
     532:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
     536:	b9 0f 00 00 00       	mov    $0xf,%ecx
     53b:	ba 0f 00 00 00       	mov    $0xf,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1074
     540:	be 4e 00 00 00       	mov    $0x4e,%esi
     545:	e8 40 ff ff ff       	callq  48a <update_pci_byte>
     54a:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
     54e:	b9 01 00 00 00       	mov    $0x1,%ecx
     553:	ba 01 00 00 00       	mov    $0x1,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1080
     558:	be 4d 00 00 00       	mov    $0x4d,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:738
     55d:	e8 28 ff ff ff       	callq  48a <update_pci_byte>
     562:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
     566:	b9 01 00 00 00       	mov    $0x1,%ecx
     56b:	ba 01 00 00 00       	mov    $0x1,%edx
     570:	be 4c 00 00 00       	mov    $0x4c,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1081
     575:	e8 10 ff ff ff       	callq  48a <update_pci_byte>
     57a:	eb 5a                	jmp    5d6 <azx_init_pci+0xf5>
     57c:	48 8b 43 08          	mov    0x8(%rbx),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1082
     580:	48 8d 6c 24 0e       	lea    0xe(%rsp),%rbp
readw():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:751
     585:	ba 78 00 00 00       	mov    $0x78,%edx
     58a:	48 89 e9             	mov    %rbp,%rcx
azx_create():
     58d:	8b 70 38             	mov    0x38(%rax),%esi
     590:	48 8b 78 10          	mov    0x10(%rax),%rdi
     594:	e8 00 00 00 00       	callq  599 <azx_init_pci+0xb8>
     599:	0f b7 4c 24 0e       	movzwl 0xe(%rsp),%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:738
     59e:	f6 c5 08             	test   $0x8,%ch
     5a1:	74 33                	je     5d6 <azx_init_pci+0xf5>
     5a3:	48 8b 43 08          	mov    0x8(%rbx),%rax
     5a7:	81 e1 ff f7 00 00    	and    $0xf7ff,%ecx
     5ad:	ba 78 00 00 00       	mov    $0x78,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1093
     5b2:	8b 70 38             	mov    0x38(%rax),%esi
     5b5:	48 8b 78 10          	mov    0x10(%rax),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1710
     5b9:	e8 00 00 00 00       	callq  5be <azx_init_pci+0xdd>
     5be:	48 8b 43 08          	mov    0x8(%rbx),%rax
     5c2:	48 89 e9             	mov    %rbp,%rcx
     5c5:	ba 78 00 00 00       	mov    $0x78,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1712
     5ca:	8b 70 38             	mov    0x38(%rax),%esi
     5cd:	48 8b 78 10          	mov    0x10(%rax),%rdi
     5d1:	e8 00 00 00 00       	callq  5d6 <azx_init_pci+0xf5>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1718
     5d6:	48 83 c4 18          	add    $0x18,%rsp
     5da:	5b                   	pop    %rbx
     5db:	5d                   	pop    %rbp
     5dc:	c3                   	retq   

00000000000005dd <azx_pcm_trigger>:
     5dd:	41 57                	push   %r15
     5df:	41 56                	push   %r14
     5e1:	41 55                	push   %r13
pci_set_dma_mask():
     5e3:	41 54                	push   %r12
     5e5:	55                   	push   %rbp
     5e6:	53                   	push   %rbx
     5e7:	48 89 fb             	mov    %rdi,%rbx
     5ea:	48 83 ec 38          	sub    $0x38,%rsp
     5ee:	48 8b 47 10          	mov    0x10(%rdi),%rax
azx_create():
     5f2:	83 fe 06             	cmp    $0x6,%esi
dma_set_coherent_mask():
     5f5:	48 8b 28             	mov    (%rax),%rbp
     5f8:	77 1d                	ja     617 <azx_pcm_trigger+0x3a>
     5fa:	b8 01 00 00 00       	mov    $0x1,%eax
     5ff:	40 88 f1             	mov    %sil,%cl
     602:	48 d3 e0             	shl    %cl,%rax
     605:	a8 29                	test   $0x29,%al
     607:	75 18                	jne    621 <azx_pcm_trigger+0x44>
     609:	a8 50                	test   $0x50,%al
     60b:	41 bd 01 00 00 00    	mov    $0x1,%r13d
pci_set_dma_mask():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1734
     611:	75 11                	jne    624 <azx_pcm_trigger+0x47>
     613:	a8 02                	test   $0x2,%al
     615:	75 12                	jne    629 <azx_pcm_trigger+0x4c>
     617:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
     61c:	e9 00 03 00 00       	jmpq   921 <azx_pcm_trigger+0x344>
dma_set_coherent_mask():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1738
     621:	45 31 ed             	xor    %r13d,%r13d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1734
     624:	45 31 ff             	xor    %r15d,%r15d
     627:	eb 0c                	jmp    635 <azx_pcm_trigger+0x58>
     629:	41 bd 01 00 00 00    	mov    $0x1,%r13d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1735
     62f:	41 bf 01 00 00 00    	mov    $0x1,%r15d
     635:	48 8b 83 10 01 00 00 	mov    0x110(%rbx),%rax
azx_create():
     63c:	45 31 f6             	xor    %r14d,%r14d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1737
     63f:	45 31 e4             	xor    %r12d,%r12d
     642:	be 01 00 00 00       	mov    $0x1,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1739
     647:	48 8b 40 08          	mov    0x8(%rax),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1738
     64b:	48 2d e0 00 00 00    	sub    $0xe0,%rax
     651:	eb 3c                	jmp    68f <azx_pcm_trigger+0xb2>
     653:	48 8b 08             	mov    (%rax),%rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/pcm.h:712
     656:	48 8b 13             	mov    (%rbx),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1738
     659:	48 8b 3a             	mov    (%rdx),%rdi
     65c:	48 39 39             	cmp    %rdi,(%rcx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1734
     65f:	75 21                	jne    682 <azx_pcm_trigger+0xa5>
     661:	48 8b 90 c0 00 00 00 	mov    0xc0(%rax),%rdx
     668:	41 89 f1             	mov    %esi,%r9d
     66b:	41 ff c4             	inc    %r12d
     66e:	48 8b 8a 48 01 00 00 	mov    0x148(%rdx),%rcx
     675:	0f b6 49 75          	movzbl 0x75(%rcx),%ecx
     679:	48 89 1a             	mov    %rbx,(%rdx)
     67c:	41 d3 e1             	shl    %cl,%r9d
     67f:	45 09 ce             	or     %r9d,%r14d
     682:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
     689:	48 2d e0 00 00 00    	sub    $0xe0,%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:285
     68f:	48 8b 90 e0 00 00 00 	mov    0xe0(%rax),%rdx
     696:	48 8d 88 e0 00 00 00 	lea    0xe0(%rax),%rcx
kcalloc():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1744
     69d:	0f 18 0a             	prefetcht0 (%rdx)
     6a0:	48 8b 93 10 01 00 00 	mov    0x110(%rbx),%rdx
azx_create():
     6a7:	48 83 c2 08          	add    $0x8,%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     6ab:	48 39 d1             	cmp    %rdx,%rcx
     6ae:	75 a3                	jne    653 <azx_pcm_trigger+0x76>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1746
     6b0:	48 8d 45 44          	lea    0x44(%rbp),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     6b4:	48 89 c7             	mov    %rax,%rdi
kcalloc():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1748
     6b7:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1761
     6bc:	e8 00 00 00 00       	callq  6c1 <azx_pcm_trigger+0xe4>
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     6c1:	41 83 fc 01          	cmp    $0x1,%r12d
azx_stream_stop():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1002
     6c5:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
azx_create():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1748
     6ca:	7e 0d                	jle    6d9 <azx_pcm_trigger+0xfc>
     6cc:	48 8b 4d 38          	mov    0x38(%rbp),%rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1761
     6d0:	8b 51 34             	mov    0x34(%rcx),%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1748
     6d3:	44 09 f2             	or     %r14d,%edx
     6d6:	89 51 34             	mov    %edx,0x34(%rcx)
     6d9:	48 8b 93 10 01 00 00 	mov    0x110(%rbx),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1749
     6e0:	47 8d 5c 2d 00       	lea    0x0(%r13,%r13,1),%r11d
     6e5:	41 b1 1c             	mov    $0x1c,%r9b
     6e8:	41 b8 01 00 00 00    	mov    $0x1,%r8d
     6ee:	48 8b 72 08          	mov    0x8(%rdx),%rsi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1751
     6f2:	44 88 5c 24 0f       	mov    %r11b,0xf(%rsp)
     6f7:	48 81 ee e0 00 00 00 	sub    $0xe0,%rsi
     6fe:	e9 bd 00 00 00       	jmpq   7c0 <azx_pcm_trigger+0x1e3>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1752
     703:	48 8b 0e             	mov    (%rsi),%rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     706:	48 8b 13             	mov    (%rbx),%rdx
     709:	48 8b 3a             	mov    (%rdx),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1753
     70c:	48 39 39             	cmp    %rdi,(%rcx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1754
     70f:	0f 85 9d 00 00 00    	jne    7b2 <azx_pcm_trigger+0x1d5>
     715:	48 8b 96 c0 00 00 00 	mov    0xc0(%rsi),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1755
     71c:	45 85 ed             	test   %r13d,%r13d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:979
     71f:	48 8b 92 48 01 00 00 	mov    0x148(%rdx),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     726:	74 4e                	je     776 <azx_pcm_trigger+0x199>
     728:	48 8b 4d 38          	mov    0x38(%rbp),%rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:982
     72c:	8b 49 30             	mov    0x30(%rcx),%ecx
     72f:	89 c9                	mov    %ecx,%ecx
     731:	45 85 ff             	test   %r15d,%r15d
     734:	48 89 4a 48          	mov    %rcx,0x48(%rdx)
     738:	75 08                	jne    742 <azx_pcm_trigger+0x165>
     73a:	48 2b 4a 50          	sub    0x50(%rdx),%rcx
     73e:	48 89 4a 48          	mov    %rcx,0x48(%rdx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     742:	80 4a 7c 08          	orb    $0x8,0x7c(%rdx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     746:	4c 8b 55 38          	mov    0x38(%rbp),%r10
     74a:	41 8b 7a 20          	mov    0x20(%r10),%edi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     74e:	44 0f b6 5a 75       	movzbl 0x75(%rdx),%r11d
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     753:	44 89 5c 24 1c       	mov    %r11d,0x1c(%rsp)
     758:	8a 4c 24 1c          	mov    0x1c(%rsp),%cl
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     75c:	45 89 c3             	mov    %r8d,%r11d
     75f:	41 d3 e3             	shl    %cl,%r11d
     762:	44 09 df             	or     %r11d,%edi
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     765:	41 89 7a 20          	mov    %edi,0x20(%r10)
     769:	48 8b 7a 58          	mov    0x58(%rdx),%rdi
azx_alloc_cmd_io():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1002
     76d:	8a 0f                	mov    (%rdi),%cl
     76f:	83 c9 1e             	or     $0x1e,%ecx
     772:	88 0f                	mov    %cl,(%rdi)
     774:	eb 2f                	jmp    7a5 <azx_pcm_trigger+0x1c8>
     776:	48 8b 7a 58          	mov    0x58(%rdx),%rdi
     77a:	8a 0f                	mov    (%rdi),%cl
     77c:	83 e1 e1             	and    $0xffffffffffffffe1,%ecx
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     77f:	88 0f                	mov    %cl,(%rdi)
azx_init_stream():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1761
     781:	48 8b 4a 58          	mov    0x58(%rdx),%rcx
     785:	44 88 49 03          	mov    %r9b,0x3(%rcx)
azx_alloc_cmd_io():
     789:	4c 8b 55 38          	mov    0x38(%rbp),%r10
     78d:	41 8b 7a 20          	mov    0x20(%r10),%edi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1748
     791:	0f b6 4a 75          	movzbl 0x75(%rdx),%ecx
azx_init_stream():
     795:	45 89 c3             	mov    %r8d,%r11d
     798:	41 d3 e3             	shl    %cl,%r11d
     79b:	41 f7 d3             	not    %r11d
     79e:	44 21 df             	and    %r11d,%edi
     7a1:	41 89 7a 20          	mov    %edi,0x20(%r10)
     7a5:	8a 4a 7c             	mov    0x7c(%rdx),%cl
     7a8:	83 e1 fd             	and    $0xfffffffffffffffd,%ecx
     7ab:	0a 4c 24 0f          	or     0xf(%rsp),%cl
     7af:	88 4a 7c             	mov    %cl,0x7c(%rdx)
     7b2:	48 8b b6 e0 00 00 00 	mov    0xe0(%rsi),%rsi
     7b9:	48 81 ee e0 00 00 00 	sub    $0xe0,%rsi
     7c0:	48 8b 96 e0 00 00 00 	mov    0xe0(%rsi),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1764
     7c7:	48 8d 8e e0 00 00 00 	lea    0xe0(%rsi),%rcx
     7ce:	0f 18 0a             	prefetcht0 (%rdx)
     7d1:	48 8b 93 10 01 00 00 	mov    0x110(%rbx),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1765
     7d8:	48 83 c2 08          	add    $0x8,%rdx
azx_create():
     7dc:	48 39 d1             	cmp    %rdx,%rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1770
     7df:	0f 85 1e ff ff ff    	jne    703 <azx_pcm_trigger+0x126>
     7e5:	66 ff 45 44          	incw   0x44(%rbp)
     7e9:	45 85 ed             	test   %r13d,%r13d
     7ec:	b9 88 13 00 00       	mov    $0x1388,%ecx
     7f1:	0f 84 8c 00 00 00    	je     883 <azx_pcm_trigger+0x2a6>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1771
     7f7:	41 83 fc 01          	cmp    $0x1,%r12d
     7fb:	0f 84 1e 01 00 00    	je     91f <azx_pcm_trigger+0x342>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     801:	48 8b 93 10 01 00 00 	mov    0x110(%rbx),%rdx
     808:	31 f6                	xor    %esi,%esi
     80a:	48 8b 52 08          	mov    0x8(%rdx),%rdx
     80e:	48 81 ea e0 00 00 00 	sub    $0xe0,%rdx
     815:	eb 3b                	jmp    852 <azx_pcm_trigger+0x275>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1774
     817:	4c 8b 02             	mov    (%rdx),%r8
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1776
     81a:	48 8b 3b             	mov    (%rbx),%rdi
     81d:	4c 8b 0f             	mov    (%rdi),%r9
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1770
     820:	4d 39 08             	cmp    %r9,(%r8)
     823:	75 1f                	jne    844 <azx_pcm_trigger+0x267>
     825:	48 8b ba c0 00 00 00 	mov    0xc0(%rdx),%rdi
     82c:	48 8b bf 48 01 00 00 	mov    0x148(%rdi),%rdi
     833:	48 8b 7f 58          	mov    0x58(%rdi),%rdi
     837:	40 8a 7f 03          	mov    0x3(%rdi),%dil
     83b:	83 e7 20             	and    $0x20,%edi
     83e:	83 ff 01             	cmp    $0x1,%edi
     841:	83 d6 00             	adc    $0x0,%esi
     844:	48 8b 92 e0 00 00 00 	mov    0xe0(%rdx),%rdx
     84b:	48 81 ea e0 00 00 00 	sub    $0xe0,%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1778
     852:	48 8b ba e0 00 00 00 	mov    0xe0(%rdx),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1768
     859:	4c 8d 82 e0 00 00 00 	lea    0xe0(%rdx),%r8
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1786
     860:	0f 18 0f             	prefetcht0 (%rdi)
     863:	48 8b bb 10 01 00 00 	mov    0x110(%rbx),%rdi
     86a:	48 83 c7 08          	add    $0x8,%rdi
     86e:	49 39 f8             	cmp    %rdi,%r8
     871:	75 a4                	jne    817 <azx_pcm_trigger+0x23a>
     873:	85 f6                	test   %esi,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1787
     875:	0f 84 83 00 00 00    	je     8fe <azx_pcm_trigger+0x321>
     87b:	f3 90                	pause  
     87d:	ff c9                	dec    %ecx
     87f:	75 80                	jne    801 <azx_pcm_trigger+0x224>
     881:	eb 7b                	jmp    8fe <azx_pcm_trigger+0x321>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     883:	48 8b 93 10 01 00 00 	mov    0x110(%rbx),%rdx
     88a:	31 f6                	xor    %esi,%esi
     88c:	48 8b 52 08          	mov    0x8(%rdx),%rdx
     890:	48 81 ea e0 00 00 00 	sub    $0xe0,%rdx
     897:	eb 3a                	jmp    8d3 <azx_pcm_trigger+0x2f6>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1790
     899:	4c 8b 02             	mov    (%rdx),%r8
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1792
     89c:	48 8b 3b             	mov    (%rbx),%rdi
     89f:	4c 8b 1f             	mov    (%rdi),%r11
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1786
     8a2:	4d 39 18             	cmp    %r11,(%r8)
     8a5:	75 1e                	jne    8c5 <azx_pcm_trigger+0x2e8>
     8a7:	48 8b ba c0 00 00 00 	mov    0xc0(%rdx),%rdi
azx_pcm_trigger():
     8ae:	48 8b bf 48 01 00 00 	mov    0x148(%rdi),%rdi
     8b5:	48 8b 7f 58          	mov    0x58(%rdi),%rdi
     8b9:	40 8a 3f             	mov    (%rdi),%dil
     8bc:	83 e7 02             	and    $0x2,%edi
     8bf:	83 ff 01             	cmp    $0x1,%edi
     8c2:	83 de ff             	sbb    $0xffffffffffffffff,%esi
     8c5:	48 8b 92 e0 00 00 00 	mov    0xe0(%rdx),%rdx
     8cc:	48 81 ea e0 00 00 00 	sub    $0xe0,%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1794
     8d3:	48 8b ba e0 00 00 00 	mov    0xe0(%rdx),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1799
     8da:	4c 8d 82 e0 00 00 00 	lea    0xe0(%rdx),%r8
spin_lock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:285
     8e1:	0f 18 0f             	prefetcht0 (%rdi)
     8e4:	48 8b bb 10 01 00 00 	mov    0x110(%rbx),%rdi
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     8eb:	48 83 c7 08          	add    $0x8,%rdi
azx_pcm_trigger():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1802
     8ef:	49 39 f8             	cmp    %rdi,%r8
     8f2:	75 a5                	jne    899 <azx_pcm_trigger+0x2bc>
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     8f4:	85 f6                	test   %esi,%esi
     8f6:	74 06                	je     8fe <azx_pcm_trigger+0x321>
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
     8f8:	f3 90                	pause  
     8fa:	ff c9                	dec    %ecx
     8fc:	75 85                	jne    883 <azx_pcm_trigger+0x2a6>
azx_pcm_trigger():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1806
     8fe:	41 ff cc             	dec    %r12d
     901:	7e 1c                	jle    91f <azx_pcm_trigger+0x342>
     903:	48 89 c7             	mov    %rax,%rdi
     906:	e8 00 00 00 00       	callq  90b <azx_pcm_trigger+0x32e>
     90b:	48 8b 55 38          	mov    0x38(%rbp),%rdx
azx_init_chip():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1011
     90f:	8b 42 34             	mov    0x34(%rdx),%eax
     912:	41 f7 d6             	not    %r14d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1012
     915:	44 21 f0             	and    %r14d,%eax
     918:	89 42 34             	mov    %eax,0x34(%rdx)
     91b:	66 ff 45 44          	incw   0x44(%rbp)
     91f:	31 c0                	xor    %eax,%eax
     921:	48 83 c4 38          	add    $0x38,%rsp
azx_reset():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:870
     925:	5b                   	pop    %rbx
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     926:	5d                   	pop    %rbp
     927:	41 5c                	pop    %r12
     929:	41 5d                	pop    %r13
     92b:	41 5e                	pop    %r14
     92d:	41 5f                	pop    %r15
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     92f:	c3                   	retq   

0000000000000930 <azx_init_chip>:
     930:	55                   	push   %rbp
     931:	53                   	push   %rbx
     932:	48 89 fb             	mov    %rdi,%rbx
     935:	48 83 ec 08          	sub    $0x8,%rsp
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     939:	f6 87 f4 01 00 00 02 	testb  $0x2,0x1f4(%rdi)
     940:	0f 85 30 02 00 00    	jne    b76 <azx_init_chip+0x246>
azx_reset():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:881
     946:	85 f6                	test   %esi,%esi
     948:	74 77                	je     9c1 <azx_init_chip+0x91>
     94a:	48 8b 57 38          	mov    0x38(%rdi),%rdx
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     94e:	b0 ff                	mov    $0xff,%al
     950:	88 42 0e             	mov    %al,0xe(%rdx)
     953:	48 8b 57 38          	mov    0x38(%rdi),%rdx
azx_codec_configure():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:880
     957:	8b 42 08             	mov    0x8(%rdx),%eax
     95a:	83 e0 fe             	and    $0xfffffffffffffffe,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:886
     95d:	89 42 08             	mov    %eax,0x8(%rdx)
     960:	bd 32 00 00 00       	mov    $0x32,%ebp
     965:	eb 0a                	jmp    971 <azx_init_chip+0x41>
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     967:	bf 01 00 00 00       	mov    $0x1,%edi
     96c:	e8 00 00 00 00       	callq  971 <azx_init_chip+0x41>
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     971:	48 8b 43 38          	mov    0x38(%rbx),%rax
     975:	8a 40 08             	mov    0x8(%rax),%al
     978:	84 c0                	test   %al,%al
azx_codec_configure():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:893
     97a:	74 04                	je     980 <azx_init_chip+0x50>
     97c:	ff cd                	dec    %ebp
     97e:	75 e7                	jne    967 <azx_init_chip+0x37>
     980:	bf 01 00 00 00       	mov    $0x1,%edi
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     985:	e8 00 00 00 00       	callq  98a <azx_init_chip+0x5a>
     98a:	48 8b 53 38          	mov    0x38(%rbx),%rdx
azx_reset():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:892
     98e:	8a 42 08             	mov    0x8(%rdx),%al
     991:	83 c8 01             	or     $0x1,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:896
     994:	88 42 08             	mov    %al,0x8(%rdx)
     997:	bd 32 00 00 00       	mov    $0x32,%ebp
     99c:	eb 0a                	jmp    9a8 <azx_init_chip+0x78>
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     99e:	bf 01 00 00 00       	mov    $0x1,%edi
     9a3:	e8 00 00 00 00       	callq  9a8 <azx_init_chip+0x78>
azx_mixer_create():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:906
     9a8:	48 8b 43 38          	mov    0x38(%rbx),%rax
     9ac:	8a 40 08             	mov    0x8(%rax),%al
azx_reset():
     9af:	84 c0                	test   %al,%al
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     9b1:	75 04                	jne    9b7 <azx_init_chip+0x87>
     9b3:	ff cd                	dec    %ebp
     9b5:	75 e7                	jne    99e <azx_init_chip+0x6e>
     9b7:	bf 01 00 00 00       	mov    $0x1,%edi
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     9bc:	e8 00 00 00 00       	callq  9c1 <azx_init_chip+0x91>
azx_reset():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:911
     9c1:	48 8b 43 38          	mov    0x38(%rbx),%rax
pci_set_drvdata():
     9c5:	8a 40 08             	mov    0x8(%rax),%al
readw():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:57
     9c8:	84 c0                	test   %al,%al
     9ca:	74 2f                	je     9fb <azx_init_chip+0xcb>
     9cc:	f6 83 f4 01 00 00 04 	testb  $0x4,0x1f4(%rbx)
power_down_all_codecs():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:912
     9d3:	75 0d                	jne    9e2 <azx_init_chip+0xb2>
     9d5:	48 8b 53 38          	mov    0x38(%rbx),%rdx
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     9d9:	8b 42 08             	mov    0x8(%rdx),%eax
     9dc:	80 cc 01             	or     $0x1,%ah
power_down_all_codecs():
     9df:	89 42 08             	mov    %eax,0x8(%rdx)
     9e2:	66 83 bb c0 00 00 00 	cmpw   $0x0,0xc0(%rbx)
     9e9:	00 
     9ea:	75 0f                	jne    9fb <azx_init_chip+0xcb>
     9ec:	48 8b 43 38          	mov    0x38(%rbx),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:958
     9f0:	66 8b 40 0e          	mov    0xe(%rax),%ax
     9f4:	66 89 83 c0 00 00 00 	mov    %ax,0xc0(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     9fb:	31 c0                	xor    %eax,%eax
     9fd:	b1 1c                	mov    $0x1c,%cl
     9ff:	eb 15                	jmp    a16 <azx_init_chip+0xe6>
     a01:	48 8b 73 68          	mov    0x68(%rbx),%rsi
     a05:	48 63 d0             	movslq %eax,%rdx
     a08:	48 c1 e2 07          	shl    $0x7,%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     a0c:	48 8b 54 32 58       	mov    0x58(%rdx,%rsi,1),%rdx
writel():
     a11:	88 4a 03             	mov    %cl,0x3(%rdx)
     a14:	ff c0                	inc    %eax
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     a16:	3b 43 28             	cmp    0x28(%rbx),%eax
     a19:	7c e6                	jl     a01 <azx_init_chip+0xd1>
     a1b:	48 8b 53 38          	mov    0x38(%rbx),%rdx
azx_int_enable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:928
     a1f:	b0 ff                	mov    $0xff,%al
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     a21:	88 42 0e             	mov    %al,0xe(%rdx)
azx_notifier_register():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1023
     a24:	b0 05                	mov    $0x5,%al
azx_init_chip():
     a26:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     a2a:	88 42 5d             	mov    %al,0x5d(%rdx)
     a2d:	b8 ff 00 00 40       	mov    $0x400000ff,%eax
spin_lock_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:310
     a32:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     a36:	89 42 24             	mov    %eax,0x24(%rdx)
     a39:	48 8b 53 38          	mov    0x38(%rbx),%rdx
azx_init_cmd_io():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:542
     a3d:	8b 42 20             	mov    0x20(%rdx),%eax
     a40:	0d 00 00 00 c0       	or     $0xc0000000,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:541
     a45:	89 42 20             	mov    %eax,0x20(%rdx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:542
     a48:	f6 83 f4 01 00 00 04 	testb  $0x4,0x1f4(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:541
     a4f:	0f 85 00 01 00 00    	jne    b55 <azx_init_chip+0x225>
     a55:	48 8d 7b 44          	lea    0x44(%rbx),%rdi
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     a59:	e8 00 00 00 00       	callq  a5e <azx_init_chip+0x12e>
azx_init_cmd_io():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:544
     a5e:	48 8b 93 98 01 00 00 	mov    0x198(%rbx),%rdx
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     a65:	48 8b 83 a0 01 00 00 	mov    0x1a0(%rbx),%rax
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     a6c:	48 89 93 d8 00 00 00 	mov    %rdx,0xd8(%rbx)
writew():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:65
     a73:	48 89 83 e0 00 00 00 	mov    %rax,0xe0(%rbx)
     a7a:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     a7e:	89 42 40             	mov    %eax,0x40(%rdx)
     a81:	8b 83 e4 00 00 00    	mov    0xe4(%rbx),%eax
     a87:	48 8b 53 38          	mov    0x38(%rbx),%rdx
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     a8b:	89 42 44             	mov    %eax,0x44(%rdx)
     a8e:	b2 02                	mov    $0x2,%dl
     a90:	48 8b 43 38          	mov    0x38(%rbx),%rax
azx_init_cmd_io():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:557
     a94:	88 50 4e             	mov    %dl,0x4e(%rax)
     a97:	31 c0                	xor    %eax,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:556
     a99:	48 8b 4b 38          	mov    0x38(%rbx),%rcx
     a9d:	66 89 41 48          	mov    %ax,0x48(%rcx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:559
     aa1:	be 00 80 ff ff       	mov    $0xffff8000,%esi
     aa6:	48 8b 43 38          	mov    0x38(%rbx),%rax
     aaa:	66 89 70 4a          	mov    %si,0x4a(%rax)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:558
     aae:	48 8b 43 38          	mov    0x38(%rbx),%rax
     ab2:	88 50 4c             	mov    %dl,0x4c(%rax)
     ab5:	48 8b 83 98 01 00 00 	mov    0x198(%rbx),%rax
     abc:	4c 8b 83 a0 01 00 00 	mov    0x1a0(%rbx),%r8
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:557
     ac3:	4c 8d 8b 44 01 00 00 	lea    0x144(%rbx),%r9
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:556
     aca:	b9 08 00 00 00       	mov    $0x8,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:557
     acf:	66 c7 83 40 01 00 00 	movw   $0x0,0x140(%rbx)
     ad6:	00 00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:556
     ad8:	66 c7 83 42 01 00 00 	movw   $0x0,0x142(%rbx)
     adf:	00 00 
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     ae1:	4c 89 cf             	mov    %r9,%rdi
     ae4:	48 05 00 08 00 00    	add    $0x800,%rax
azx_init_cmd_io():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:561
     aea:	49 81 c0 00 08 00 00 	add    $0x800,%r8
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     af1:	48 89 83 30 01 00 00 	mov    %rax,0x130(%rbx)
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     af8:	31 c0                	xor    %eax,%eax
     afa:	4c 89 83 38 01 00 00 	mov    %r8,0x138(%rbx)
writew():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:65
     b01:	f3 ab                	rep stos %eax,%es:(%rdi)
azx_init_cmd_io():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:568
     b03:	48 8b 43 38          	mov    0x38(%rbx),%rax
     b07:	44 89 40 50          	mov    %r8d,0x50(%rax)
     b0b:	8b 83 3c 01 00 00    	mov    0x13c(%rbx),%eax
writew():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:65
     b11:	48 8b 4b 38          	mov    0x38(%rbx),%rcx
     b15:	89 41 54             	mov    %eax,0x54(%rcx)
     b18:	48 8b 43 38          	mov    0x38(%rbx),%rax
     b1c:	88 50 5e             	mov    %dl,0x5e(%rax)
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     b1f:	48 8b 43 38          	mov    0x38(%rbx),%rax
     b23:	66 89 70 58          	mov    %si,0x58(%rax)
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
     b27:	83 7b 14 0a          	cmpl   $0xa,0x14(%rbx)
arch_local_irq_enable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/paravirt.h:868
     b2b:	48 8b 43 38          	mov    0x38(%rbx),%rax
     b2f:	75 07                	jne    b38 <azx_init_chip+0x208>
azx_init_chip():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1027
     b31:	ba c0 00 00 00       	mov    $0xc0,%edx
     b36:	eb 05                	jmp    b3d <azx_init_chip+0x20d>
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     b38:	ba 01 00 00 00       	mov    $0x1,%edx
     b3d:	66 89 50 5a          	mov    %dx,0x5a(%rax)
azx_init_chip():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1028
     b41:	b0 03                	mov    $0x3,%al
     b43:	48 8b 53 38          	mov    0x38(%rbx),%rdx
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     b47:	88 42 5c             	mov    %al,0x5c(%rdx)
     b4a:	66 ff 43 44          	incw   0x44(%rbx)
azx_init_chip():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1030
     b4e:	ff 14 25 00 00 00 00 	callq  *0x0
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1031
     b55:	8b 83 d0 01 00 00    	mov    0x1d0(%rbx),%eax
azx_stop_chip():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2118
     b5b:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     b5f:	89 42 70             	mov    %eax,0x70(%rdx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2117
     b62:	8b 83 d4 01 00 00    	mov    0x1d4(%rbx),%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2118
     b68:	48 8b 53 38          	mov    0x38(%rbx),%rdx
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
     b6c:	89 42 74             	mov    %eax,0x74(%rdx)
     b6f:	80 8b f4 01 00 00 02 	orb    $0x2,0x1f4(%rbx)
     b76:	5b                   	pop    %rbx
     b77:	5b                   	pop    %rbx
     b78:	5d                   	pop    %rbp
     b79:	c3                   	retq   

0000000000000b7a <azx_stop_chip>:
     b7a:	53                   	push   %rbx
     b7b:	31 c0                	xor    %eax,%eax
     b7d:	f6 87 f4 01 00 00 02 	testb  $0x2,0x1f4(%rdi)
azx_int_disable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:938
     b84:	48 89 fb             	mov    %rdi,%rbx
     b87:	75 1e                	jne    ba7 <azx_stop_chip+0x2d>
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     b89:	e9 af 00 00 00       	jmpq   c3d <azx_stop_chip+0xc3>
     b8e:	48 8b 4b 68          	mov    0x68(%rbx),%rcx
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
     b92:	48 63 d0             	movslq %eax,%rdx
     b95:	48 c1 e2 07          	shl    $0x7,%rdx
azx_int_disable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:948
     b99:	48 8b 4c 0a 58       	mov    0x58(%rdx,%rcx,1),%rcx
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     b9e:	8a 11                	mov    (%rcx),%dl
     ba0:	83 e2 e3             	and    $0xffffffffffffffe3,%edx
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     ba3:	88 11                	mov    %dl,(%rcx)
     ba5:	ff c0                	inc    %eax
     ba7:	3b 43 28             	cmp    0x28(%rbx),%eax
     baa:	7c e2                	jl     b8e <azx_stop_chip+0x14>
     bac:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     bb0:	31 c0                	xor    %eax,%eax
     bb2:	88 42 20             	mov    %al,0x20(%rdx)
     bb5:	48 8b 53 38          	mov    0x38(%rbx),%rdx
azx_int_clear():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:958
     bb9:	8b 42 20             	mov    0x20(%rdx),%eax
     bbc:	25 ff ff ff 3f       	and    $0x3fffffff,%eax
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     bc1:	89 42 20             	mov    %eax,0x20(%rdx)
     bc4:	31 c0                	xor    %eax,%eax
     bc6:	b1 1c                	mov    $0x1c,%cl
     bc8:	eb 15                	jmp    bdf <azx_stop_chip+0x65>
     bca:	48 8b 73 68          	mov    0x68(%rbx),%rsi
     bce:	48 63 d0             	movslq %eax,%rdx
     bd1:	48 c1 e2 07          	shl    $0x7,%rdx
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     bd5:	48 8b 54 32 58       	mov    0x58(%rdx,%rsi,1),%rdx
     bda:	88 4a 03             	mov    %cl,0x3(%rdx)
     bdd:	ff c0                	inc    %eax
spin_lock_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:310
     bdf:	3b 43 28             	cmp    0x28(%rbx),%eax
     be2:	7c e6                	jl     bca <azx_stop_chip+0x50>
     be4:	48 8b 53 38          	mov    0x38(%rbx),%rdx
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
     be8:	b0 ff                	mov    $0xff,%al
     bea:	88 42 0e             	mov    %al,0xe(%rdx)
     bed:	b0 05                	mov    $0x5,%al
     bef:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     bf3:	88 42 5d             	mov    %al,0x5d(%rdx)
     bf6:	b8 ff 00 00 40       	mov    $0x400000ff,%eax
arch_local_irq_enable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/paravirt.h:868
     bfb:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     bff:	89 42 24             	mov    %eax,0x24(%rdx)
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
     c02:	48 8d 7b 44          	lea    0x44(%rbx),%rdi
     c06:	e8 00 00 00 00       	callq  c0b <azx_stop_chip+0x91>
     c0b:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     c0f:	31 c0                	xor    %eax,%eax
     c11:	88 42 5c             	mov    %al,0x5c(%rdx)
azx_stop_chip():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2132
     c14:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     c18:	88 42 4c             	mov    %al,0x4c(%rdx)
azx_power_notify():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2138
     c1b:	66 ff 43 44          	incw   0x44(%rbx)
     c1f:	ff 14 25 00 00 00 00 	callq  *0x0
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2143
     c26:	31 c0                	xor    %eax,%eax
     c28:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     c2c:	89 42 70             	mov    %eax,0x70(%rdx)
     c2f:	48 8b 53 38          	mov    0x38(%rbx),%rdx
     c33:	89 42 74             	mov    %eax,0x74(%rdx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2144
     c36:	80 a3 f4 01 00 00 fd 	andb   $0xfd,0x1f4(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2143
     c3d:	5b                   	pop    %rbx
     c3e:	c3                   	retq   

0000000000000c3f <azx_power_notify>:
     c3f:	48 89 f8             	mov    %rdi,%rax
     c42:	48 83 ec 08          	sub    $0x8,%rsp
     c46:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
     c4a:	48 8b 50 58          	mov    0x58(%rax),%rdx
     c4e:	48 8d 70 58          	lea    0x58(%rax),%rsi
     c52:	48 83 ea 10          	sub    $0x10,%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2150
     c56:	eb 0d                	jmp    c65 <azx_power_notify+0x26>
     c58:	f6 82 30 03 00 00 20 	testb  $0x20,0x330(%rdx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2151
     c5f:	75 16                	jne    c77 <azx_power_notify+0x38>
     c61:	48 8d 51 f0          	lea    -0x10(%rcx),%rdx
     c65:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2152
     c69:	4c 8d 42 10          	lea    0x10(%rdx),%r8
     c6d:	4c 39 c6             	cmp    %r8,%rsi
     c70:	0f 18 09             	prefetcht0 (%rcx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2153
     c73:	75 e3                	jne    c58 <azx_power_notify+0x19>
     c75:	eb 25                	jmp    c9c <azx_power_notify+0x5d>
     c77:	41 59                	pop    %r9
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2151
     c79:	be 01 00 00 00       	mov    $0x1,%esi
     c7e:	e9 ad fc ff ff       	jmpq   930 <azx_init_chip>
azx_irq_pending_work():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1944
     c83:	83 3d 00 00 00 00 00 	cmpl   $0x0,0x0(%rip)        # c8a <azx_power_notify+0x4b>
     c8a:	74 19                	je     ca5 <azx_power_notify+0x66>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1945
     c8c:	80 b8 68 01 00 00 00 	cmpb   $0x0,0x168(%rax)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1944
     c93:	78 10                	js     ca5 <azx_power_notify+0x66>
     c95:	41 58                	pop    %r8
     c97:	e9 de fe ff ff       	jmpq   b7a <azx_stop_chip>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1948
     c9c:	f6 87 f4 01 00 00 01 	testb  $0x1,0x1f4(%rdi)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1949
     ca3:	75 de                	jne    c83 <azx_power_notify+0x44>
     ca5:	5e                   	pop    %rsi
     ca6:	c3                   	retq   

0000000000000ca7 <azx_irq_pending_work>:
     ca7:	41 57                	push   %r15
     ca9:	41 56                	push   %r14
     cab:	41 55                	push   %r13
     cad:	41 54                	push   %r12
     caf:	4c 8d a7 e8 fd ff ff 	lea    -0x218(%rdi),%r12
     cb6:	55                   	push   %rbp
     cb7:	53                   	push   %rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1953
     cb8:	48 89 fb             	mov    %rdi,%rbx
     cbb:	48 83 ec 08          	sub    $0x8,%rsp
spin_lock_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:310
     cbf:	f6 47 dc 20          	testb  $0x20,-0x24(%rdi)
     cc3:	75 1b                	jne    ce0 <azx_irq_pending_work+0x39>
     cc5:	48 8b 87 e8 fd ff ff 	mov    -0x218(%rdi),%rax
     ccc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
azx_irq_pending_work():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1959
     cd3:	8b 30                	mov    (%rax),%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1960
     cd5:	31 c0                	xor    %eax,%eax
     cd7:	e8 00 00 00 00       	callq  cdc <azx_irq_pending_work+0x35>
     cdc:	80 4b dc 20          	orb    $0x20,-0x24(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1961
     ce0:	49 8d 6c 24 44       	lea    0x44(%r12),%rbp
     ce5:	45 31 ff             	xor    %r15d,%r15d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1962
     ce8:	48 89 ef             	mov    %rbp,%rdi
     ceb:	45 31 f6             	xor    %r14d,%r14d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1961
     cee:	45 31 ed             	xor    %r13d,%r13d
     cf1:	e8 00 00 00 00       	callq  cf6 <azx_irq_pending_work+0x4f>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1965
     cf6:	eb 54                	jmp    d4c <azx_irq_pending_work+0xa5>
     cf8:	49 63 dd             	movslq %r13d,%rbx
     cfb:	48 c1 e3 07          	shl    $0x7,%rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1966
     cff:	49 03 5c 24 68       	add    0x68(%r12),%rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1967
     d04:	8a 43 7c             	mov    0x7c(%rbx),%al
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
     d07:	a8 04                	test   $0x4,%al
azx_irq_pending_work():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1969
     d09:	74 3e                	je     d49 <azx_irq_pending_work+0xa2>
     d0b:	48 83 7b 68 00       	cmpq   $0x0,0x68(%rbx)
     d10:	74 37                	je     d49 <azx_irq_pending_work+0xa2>
spin_lock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:285
     d12:	a8 02                	test   $0x2,%al
     d14:	74 33                	je     d49 <azx_irq_pending_work+0xa2>
     d16:	48 89 de             	mov    %rbx,%rsi
     d19:	4c 89 e7             	mov    %r12,%rdi
azx_irq_pending_work():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1971
     d1c:	e8 84 f4 ff ff       	callq  1a5 <azx_position_ok>
     d21:	85 c0                	test   %eax,%eax
     d23:	7e 1b                	jle    d40 <azx_irq_pending_work+0x99>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1959
     d25:	80 63 7c fb          	andb   $0xfb,0x7c(%rbx)
     d29:	66 ff 45 00          	incw   0x0(%rbp)
     d2d:	48 8b 7b 68          	mov    0x68(%rbx),%rdi
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
     d31:	e8 00 00 00 00       	callq  d36 <azx_irq_pending_work+0x8f>
arch_local_irq_enable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/paravirt.h:868
     d36:	48 89 ef             	mov    %rbp,%rdi
     d39:	e8 00 00 00 00       	callq  d3e <azx_irq_pending_work+0x97>
azx_irq_pending_work():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1977
     d3e:	eb 09                	jmp    d49 <azx_irq_pending_work+0xa2>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1979
     d40:	41 ff c6             	inc    %r14d
     d43:	85 c0                	test   %eax,%eax
     d45:	45 0f 45 f7          	cmovne %r15d,%r14d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1980
     d49:	41 ff c5             	inc    %r13d
     d4c:	45 3b 6c 24 28       	cmp    0x28(%r12),%r13d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1981
     d51:	7c a5                	jl     cf8 <azx_irq_pending_work+0x51>
     d53:	66 ff 45 00          	incw   0x0(%rbp)
     d57:	ff 14 25 00 00 00 00 	callq  *0x0
azx_resume():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2199
     d5e:	45 85 f6             	test   %r14d,%r14d
pci_get_drvdata():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:1268
     d61:	74 0f                	je     d72 <azx_irq_pending_work+0xcb>
     d63:	bf 01 00 00 00       	mov    $0x1,%edi
azx_resume():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2199
     d68:	e8 00 00 00 00       	callq  d6d <azx_irq_pending_work+0xc6>
pci_get_drvdata():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:1268
     d6d:	e9 76 ff ff ff       	jmpq   ce8 <azx_irq_pending_work+0x41>
azx_resume():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2203
     d72:	41 5a                	pop    %r10
pci_get_drvdata():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:1268
     d74:	5b                   	pop    %rbx
     d75:	5d                   	pop    %rbp
azx_resume():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2201
     d76:	41 5c                	pop    %r12
     d78:	41 5d                	pop    %r13
     d7a:	41 5e                	pop    %r14
     d7c:	41 5f                	pop    %r15
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2203
     d7e:	c3                   	retq   

0000000000000d7f <azx_resume>:
     d7f:	41 54                	push   %r12
     d81:	55                   	push   %rbp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2204
     d82:	48 89 fd             	mov    %rdi,%rbp
     d85:	48 8d bf 90 00 00 00 	lea    0x90(%rdi),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2205
     d8c:	53                   	push   %rbx
     d8d:	e8 00 00 00 00       	callq  d92 <azx_resume+0x13>
     d92:	31 f6                	xor    %esi,%esi
     d94:	48 89 ef             	mov    %rbp,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2206
     d97:	49 89 c4             	mov    %rax,%r12
     d9a:	48 8b 98 70 01 00 00 	mov    0x170(%rax),%rbx
     da1:	e8 00 00 00 00       	callq  da6 <azx_resume+0x27>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2208
     da6:	48 89 ef             	mov    %rbp,%rdi
     da9:	e8 00 00 00 00       	callq  dae <azx_resume+0x2f>
     dae:	48 89 ef             	mov    %rbp,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2209
     db1:	e8 00 00 00 00       	callq  db6 <azx_resume+0x37>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2211
     db6:	85 c0                	test   %eax,%eax
     db8:	79 20                	jns    dda <azx_resume+0x5b>
     dba:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2212
     dc1:	31 c0                	xor    %eax,%eax
     dc3:	e8 00 00 00 00       	callq  dc8 <azx_resume+0x49>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2213
     dc8:	4c 89 e7             	mov    %r12,%rdi
     dcb:	e8 00 00 00 00       	callq  dd0 <azx_resume+0x51>
     dd0:	b8 fb ff ff ff       	mov    $0xfffffffb,%eax
     dd5:	e9 bd 00 00 00       	jmpq   e97 <azx_resume+0x118>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2214
     dda:	48 89 ef             	mov    %rbp,%rdi
     ddd:	e8 00 00 00 00       	callq  de2 <azx_resume+0x63>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2215
     de2:	f6 83 f4 01 00 00 10 	testb  $0x10,0x1f4(%rbx)
     de9:	74 18                	je     e03 <azx_resume+0x84>
     deb:	be 01 00 00 00       	mov    $0x1,%esi
     df0:	48 89 ef             	mov    %rbp,%rdi
     df3:	e8 00 00 00 00       	callq  df8 <azx_resume+0x79>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2217
     df8:	85 c0                	test   %eax,%eax
     dfa:	79 07                	jns    e03 <azx_resume+0x84>
     dfc:	80 a3 f4 01 00 00 ef 	andb   $0xef,0x1f4(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2219
     e03:	be 01 00 00 00       	mov    $0x1,%esi
snd_hda_codecs_inuse():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2166
     e08:	48 89 df             	mov    %rbx,%rdi
     e0b:	e8 ff f2 ff ff       	callq  10f <azx_acquire_irq>
     e10:	89 c2                	mov    %eax,%edx
     e12:	b8 fb ff ff ff       	mov    $0xfffffffb,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2167
     e17:	85 d2                	test   %edx,%edx
     e19:	78 7c                	js     e97 <azx_resume+0x118>
     e1b:	48 89 df             	mov    %rbx,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2166
     e1e:	e8 be f6 ff ff       	callq  4e1 <azx_init_pci>
     e23:	48 8b 93 c8 00 00 00 	mov    0xc8(%rbx),%rdx
     e2a:	48 8b 42 58          	mov    0x58(%rdx),%rax
     e2e:	48 83 c2 58          	add    $0x58,%rdx
     e32:	48 83 e8 10          	sub    $0x10,%rax
azx_resume():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2220
     e36:	eb 0d                	jmp    e45 <azx_resume+0xc6>
     e38:	83 b8 34 03 00 00 00 	cmpl   $0x0,0x334(%rax)
     e3f:	75 16                	jne    e57 <azx_resume+0xd8>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2222
     e41:	48 8d 41 f0          	lea    -0x10(%rcx),%rax
     e45:	48 8b 48 10          	mov    0x10(%rax),%rcx
     e49:	48 8d 70 10          	lea    0x10(%rax),%rsi
snd_power_change_state():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/core.h:169
     e4d:	48 39 f2             	cmp    %rsi,%rdx
     e50:	0f 18 09             	prefetcht0 (%rcx)
     e53:	75 e3                	jne    e38 <azx_resume+0xb9>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/core.h:168
     e55:	eb 0d                	jmp    e64 <azx_resume+0xe5>
     e57:	be 01 00 00 00       	mov    $0x1,%esi
     e5c:	48 89 df             	mov    %rbx,%rdi
     e5f:	e8 cc fa ff ff       	callq  930 <azx_init_chip>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/core.h:169
     e64:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
     e6b:	e8 00 00 00 00       	callq  e70 <azx_resume+0xf1>
     e70:	49 8d bc 24 78 02 00 	lea    0x278(%r12),%rdi
     e77:	00 
azx_bus_reset():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1362
     e78:	41 c7 84 24 50 02 00 	movl   $0x0,0x250(%r12)
     e7f:	00 00 00 00 00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1365
     e84:	31 c9                	xor    %ecx,%ecx
     e86:	ba 01 00 00 00       	mov    $0x1,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1366
     e8b:	be 03 00 00 00       	mov    $0x3,%esi
     e90:	e8 00 00 00 00       	callq  e95 <azx_resume+0x116>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1367
     e95:	31 c0                	xor    %eax,%eax
     e97:	5b                   	pop    %rbx
     e98:	5d                   	pop    %rbp
     e99:	41 5c                	pop    %r12
     e9b:	c3                   	retq   

0000000000000e9c <azx_bus_reset>:
     e9c:	41 54                	push   %r12
     e9e:	55                   	push   %rbp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1369
     e9f:	48 89 fd             	mov    %rdi,%rbp
     ea2:	53                   	push   %rbx
     ea3:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
     ea7:	80 8f 68 01 00 00 40 	orb    $0x40,0x168(%rdi)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1373
     eae:	48 89 df             	mov    %rbx,%rdi
     eb1:	e8 c4 fc ff ff       	callq  b7a <azx_stop_chip>
     eb6:	be 01 00 00 00       	mov    $0x1,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1372
     ebb:	48 89 df             	mov    %rbx,%rdi
     ebe:	e8 6d fa ff ff       	callq  930 <azx_init_chip>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1374
     ec3:	f6 83 f4 01 00 00 02 	testb  $0x2,0x1f4(%rbx)
     eca:	74 2f                	je     efb <azx_bus_reset+0x5f>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1375
     ecc:	45 31 e4             	xor    %r12d,%r12d
     ecf:	4a 8b 7c 23 70       	mov    0x70(%rbx,%r12,1),%rdi
     ed4:	49 83 c4 08          	add    $0x8,%r12
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1378
     ed8:	e8 00 00 00 00       	callq  edd <azx_bus_reset+0x41>
     edd:	49 83 fc 50          	cmp    $0x50,%r12
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1379
     ee1:	75 ec                	jne    ecf <azx_bus_reset+0x33>
azx_suspend():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2174
     ee3:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
     eea:	e8 00 00 00 00       	callq  eef <azx_bus_reset+0x53>
pci_get_drvdata():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:1268
     eef:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
azx_suspend():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2174
     ef6:	e8 00 00 00 00       	callq  efb <azx_bus_reset+0x5f>
pci_get_drvdata():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/pci.h:1268
     efb:	80 a5 68 01 00 00 bf 	andb   $0xbf,0x168(%rbp)
azx_suspend():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2176
     f02:	5b                   	pop    %rbx
     f03:	5d                   	pop    %rbp
     f04:	41 5c                	pop    %r12
snd_power_change_state():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/core.h:169
     f06:	c3                   	retq   

0000000000000f07 <azx_suspend>:
     f07:	41 55                	push   %r13
     f09:	41 54                	push   %r12
     f0b:	41 89 f4             	mov    %esi,%r12d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/core.h:168
     f0e:	55                   	push   %rbp
     f0f:	48 89 fd             	mov    %rdi,%rbp
     f12:	48 8d bf 90 00 00 00 	lea    0x90(%rdi),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/core.h:169
     f19:	53                   	push   %rbx
     f1a:	48 83 ec 08          	sub    $0x8,%rsp
     f1e:	e8 00 00 00 00       	callq  f23 <azx_suspend+0x1c>
     f23:	48 8b 98 70 01 00 00 	mov    0x170(%rax),%rbx
spin_lock_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:310
     f2a:	48 8d b8 78 02 00 00 	lea    0x278(%rax),%rdi
     f31:	c7 80 50 02 00 00 00 	movl   $0x300,0x250(%rax)
     f38:	03 00 00 
azx_clear_irq_pending():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1990
     f3b:	31 c9                	xor    %ecx,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1989
     f3d:	ba 01 00 00 00       	mov    $0x1,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1990
     f42:	be 03 00 00 00       	mov    $0x3,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1989
     f47:	e8 00 00 00 00       	callq  f4c <azx_suspend+0x45>
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
     f4c:	48 8d 7b 44          	lea    0x44(%rbx),%rdi
arch_local_irq_enable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/paravirt.h:868
     f50:	e8 00 00 00 00       	callq  f55 <azx_suspend+0x4e>
     f55:	31 c0                	xor    %eax,%eax
     f57:	eb 12                	jmp    f6b <azx_suspend+0x64>
     f59:	48 8b 4b 68          	mov    0x68(%rbx),%rcx
azx_suspend():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2182
     f5d:	48 63 d0             	movslq %eax,%rdx
     f60:	ff c0                	inc    %eax
     f62:	48 c1 e2 07          	shl    $0x7,%rdx
     f66:	80 64 11 7c fb       	andb   $0xfb,0x7c(%rcx,%rdx,1)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2181
     f6b:	3b 43 28             	cmp    0x28(%rbx),%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2183
     f6e:	7c e9                	jl     f59 <azx_suspend+0x52>
     f70:	66 ff 43 44          	incw   0x44(%rbx)
     f74:	ff 14 25 00 00 00 00 	callq  *0x0
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2184
     f7b:	45 31 ed             	xor    %r13d,%r13d
     f7e:	4a 8b 7c 2b 70       	mov    0x70(%rbx,%r13,1),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2185
     f83:	49 83 c5 08          	add    $0x8,%r13
     f87:	e8 00 00 00 00       	callq  f8c <azx_suspend+0x85>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2186
     f8c:	49 83 fd 50          	cmp    $0x50,%r13
     f90:	75 ec                	jne    f7e <azx_suspend+0x77>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2187
     f92:	f6 83 f4 01 00 00 02 	testb  $0x2,0x1f4(%rbx)
     f99:	74 0c                	je     fa7 <azx_suspend+0xa0>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2188
     f9b:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2190
     fa2:	e8 00 00 00 00       	callq  fa7 <azx_suspend+0xa0>
     fa7:	48 89 df             	mov    %rbx,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2191
     faa:	e8 cb fb ff ff       	callq  b7a <azx_stop_chip>
     faf:	8b 7b 40             	mov    0x40(%rbx),%edi
     fb2:	85 ff                	test   %edi,%edi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2192
     fb4:	78 0f                	js     fc5 <azx_suspend+0xbe>
     fb6:	48 89 de             	mov    %rbx,%rsi
     fb9:	e8 00 00 00 00       	callq  fbe <azx_suspend+0xb7>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2193
     fbe:	c7 43 40 ff ff ff ff 	movl   $0xffffffff,0x40(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2194
     fc5:	f6 83 f4 01 00 00 10 	testb  $0x10,0x1f4(%rbx)
     fcc:	74 09                	je     fd7 <azx_suspend+0xd0>
     fce:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
     fd2:	e8 00 00 00 00       	callq  fd7 <azx_suspend+0xd0>
     fd7:	48 89 ef             	mov    %rbp,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2196
     fda:	e8 00 00 00 00       	callq  fdf <azx_suspend+0xd8>
     fdf:	48 89 ef             	mov    %rbp,%rdi
     fe2:	e8 00 00 00 00       	callq  fe7 <azx_suspend+0xe0>
azx_pcm_free():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2007
     fe7:	44 89 e6             	mov    %r12d,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2008
     fea:	48 89 ef             	mov    %rbp,%rdi
     fed:	e8 00 00 00 00       	callq  ff2 <azx_suspend+0xeb>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2009
     ff2:	48 89 ef             	mov    %rbp,%rdi
     ff5:	89 c6                	mov    %eax,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2010
     ff7:	e8 00 00 00 00       	callq  ffc <azx_suspend+0xf5>
     ffc:	41 5b                	pop    %r11
     ffe:	5b                   	pop    %rbx
     fff:	5d                   	pop    %rbp
    1000:	41 5c                	pop    %r12
    1002:	31 c0                	xor    %eax,%eax
    1004:	41 5d                	pop    %r13
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2013
    1006:	c3                   	retq   

0000000000001007 <azx_pcm_free>:
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2011
    1007:	48 83 ec 08          	sub    $0x8,%rsp
    100b:	48 89 f8             	mov    %rdi,%rax
azx_free():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2256
    100e:	48 8b bf b0 01 00 00 	mov    0x1b0(%rdi),%rdi
    1015:	48 85 ff             	test   %rdi,%rdi
azx_notifier_unregister():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2248
    1018:	74 16                	je     1030 <azx_pcm_free+0x29>
    101a:	48 63 40 18          	movslq 0x18(%rax),%rax
    101e:	48 8b 17             	mov    (%rdi),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2249
    1021:	48 c7 44 c2 70 00 00 	movq   $0x0,0x70(%rdx,%rax,8)
    1028:	00 00 
    102a:	5a                   	pop    %rdx
    102b:	e9 00 00 00 00       	jmpq   1030 <azx_pcm_free+0x29>
azx_free():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2261
    1030:	58                   	pop    %rax
    1031:	c3                   	retq   

0000000000001032 <azx_free>:
    1032:	55                   	push   %rbp
    1033:	53                   	push   %rbx
    1034:	48 89 fb             	mov    %rdi,%rbx
    1037:	48 83 ec 08          	sub    $0x8,%rsp
spin_lock_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:310
    103b:	48 83 bf 38 02 00 00 	cmpq   $0x0,0x238(%rdi)
    1042:	00 
    1043:	74 0c                	je     1051 <azx_free+0x1f>
    1045:	48 8d bf 38 02 00 00 	lea    0x238(%rdi),%rdi
azx_clear_irq_pending():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1990
    104c:	e8 00 00 00 00       	callq  1051 <azx_free+0x1f>
    1051:	f6 83 f4 01 00 00 02 	testb  $0x2,0x1f4(%rbx)
    1058:	0f 84 83 00 00 00    	je     10e1 <azx_free+0xaf>
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
    105e:	48 8d 7b 44          	lea    0x44(%rbx),%rdi
arch_local_irq_enable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/paravirt.h:868
    1062:	e8 00 00 00 00       	callq  1067 <azx_free+0x35>
    1067:	31 c0                	xor    %eax,%eax
    1069:	eb 12                	jmp    107d <azx_free+0x4b>
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
    106b:	48 8b 4b 68          	mov    0x68(%rbx),%rcx
azx_stream_stop():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1002
    106f:	48 63 d0             	movslq %eax,%rdx
    1072:	ff c0                	inc    %eax
azx_free():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2263
    1074:	48 c1 e2 07          	shl    $0x7,%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2264
    1078:	80 64 11 7c fb       	andb   $0xfb,0x7c(%rcx,%rdx,1)
    107d:	3b 43 28             	cmp    0x28(%rbx),%eax
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
    1080:	7c e9                	jl     106b <azx_free+0x39>
    1082:	66 ff 43 44          	incw   0x44(%rbx)
    1086:	ff 14 25 00 00 00 00 	callq  *0x0
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
    108d:	31 c0                	xor    %eax,%eax
    108f:	40 b5 1c             	mov    $0x1c,%bpl
    1092:	bf 01 00 00 00       	mov    $0x1,%edi
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
    1097:	eb 3b                	jmp    10d4 <azx_free+0xa2>
    1099:	48 63 c8             	movslq %eax,%rcx
azx_stream_stop():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1002
    109c:	48 c1 e1 07          	shl    $0x7,%rcx
    10a0:	48 03 4b 68          	add    0x68(%rbx),%rcx
    10a4:	48 8b 71 58          	mov    0x58(%rcx),%rsi
    10a8:	8a 16                	mov    (%rsi),%dl
    10aa:	83 e2 e1             	and    $0xffffffffffffffe1,%edx
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    10ad:	88 16                	mov    %dl,(%rsi)
azx_free():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2263
    10af:	48 8b 51 58          	mov    0x58(%rcx),%rdx
    10b3:	40 88 6a 03          	mov    %bpl,0x3(%rdx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2265
    10b7:	48 8b 73 38          	mov    0x38(%rbx),%rsi
    10bb:	8b 56 20             	mov    0x20(%rsi),%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2268
    10be:	0f b6 49 75          	movzbl 0x75(%rcx),%ecx
    10c2:	41 89 f8             	mov    %edi,%r8d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2269
    10c5:	41 d3 e0             	shl    %cl,%r8d
    10c8:	44 89 c1             	mov    %r8d,%ecx
    10cb:	f7 d1                	not    %ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2270
    10cd:	21 ca                	and    %ecx,%edx
    10cf:	89 56 20             	mov    %edx,0x20(%rsi)
    10d2:	ff c0                	inc    %eax
    10d4:	3b 43 28             	cmp    0x28(%rbx),%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2271
    10d7:	7c c0                	jl     1099 <azx_free+0x67>
    10d9:	48 89 df             	mov    %rbx,%rdi
    10dc:	e8 99 fa ff ff       	callq  b7a <azx_stop_chip>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2272
    10e1:	8b 7b 40             	mov    0x40(%rbx),%edi
    10e4:	85 ff                	test   %edi,%edi
    10e6:	78 08                	js     10f0 <azx_free+0xbe>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2273
    10e8:	48 89 de             	mov    %rbx,%rsi
    10eb:	e8 00 00 00 00       	callq  10f0 <azx_free+0xbe>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2275
    10f0:	f6 83 f4 01 00 00 10 	testb  $0x10,0x1f4(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2277
    10f7:	74 09                	je     1102 <azx_free+0xd0>
    10f9:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    10fd:	e8 00 00 00 00       	callq  1102 <azx_free+0xd0>
    1102:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
    1106:	48 85 ff             	test   %rdi,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2278
    1109:	74 05                	je     1110 <azx_free+0xde>
    110b:	e8 00 00 00 00       	callq  1110 <azx_free+0xde>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2276
    1110:	31 ed                	xor    %ebp,%ebp
    1112:	48 83 7b 68 00       	cmpq   $0x0,0x68(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2280
    1117:	75 1b                	jne    1134 <azx_free+0x102>
    1119:	eb 1e                	jmp    1139 <azx_free+0x107>
    111b:	48 63 fd             	movslq %ebp,%rdi
    111e:	48 c1 e7 07          	shl    $0x7,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2281
    1122:	48 03 7b 68          	add    0x68(%rbx),%rdi
    1126:	48 83 7f 10 00       	cmpq   $0x0,0x10(%rdi)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2282
    112b:	74 05                	je     1132 <azx_free+0x100>
    112d:	e8 00 00 00 00       	callq  1132 <azx_free+0x100>
    1132:	ff c5                	inc    %ebp
    1134:	3b 6b 28             	cmp    0x28(%rbx),%ebp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2283
    1137:	7c e2                	jl     111b <azx_free+0xe9>
    1139:	48 83 bb 98 01 00 00 	cmpq   $0x0,0x198(%rbx)
    1140:	00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2284
    1141:	74 0c                	je     114f <azx_free+0x11d>
    1143:	48 8d bb 88 01 00 00 	lea    0x188(%rbx),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2285
    114a:	e8 00 00 00 00       	callq  114f <azx_free+0x11d>
    114f:	48 83 bb c8 01 00 00 	cmpq   $0x0,0x1c8(%rbx)
    1156:	00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2286
    1157:	74 0c                	je     1165 <azx_free+0x133>
    1159:	48 8d bb b8 01 00 00 	lea    0x1b8(%rbx),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2287
    1160:	e8 00 00 00 00       	callq  1165 <azx_free+0x133>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2290
    1165:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    1169:	e8 00 00 00 00       	callq  116e <azx_free+0x13c>
azx_dev_free():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2294
    116e:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2295
    1172:	e8 00 00 00 00       	callq  1177 <azx_free+0x145>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2294
    1177:	48 8b 7b 68          	mov    0x68(%rbx),%rdi
setup_bdle():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1169
    117b:	e8 00 00 00 00       	callq  1180 <azx_free+0x14e>
    1180:	48 89 df             	mov    %rbx,%rdi
    1183:	e8 00 00 00 00       	callq  1188 <azx_free+0x156>
    1188:	59                   	pop    %rcx
    1189:	5b                   	pop    %rbx
    118a:	31 c0                	xor    %eax,%eax
    118c:	5d                   	pop    %rbp
    118d:	c3                   	retq   

000000000000118e <azx_dev_free>:
    118e:	48 83 ec 08          	sub    $0x8,%rsp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1170
    1192:	48 8b 7f 20          	mov    0x20(%rdi),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1172
    1196:	5e                   	pop    %rsi
    1197:	e9 96 fe ff ff       	jmpq   1032 <azx_free>

000000000000119c <setup_bdle>:
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1176
    119c:	41 56                	push   %r14
    119e:	41 55                	push   %r13
    11a0:	49 89 d5             	mov    %rdx,%r13
    11a3:	41 54                	push   %r12
    11a5:	41 89 cc             	mov    %ecx,%r12d
    11a8:	55                   	push   %rbp
    11a9:	48 89 f5             	mov    %rsi,%rbp
snd_sgbuf_get_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/memalloc.h:103
    11ac:	53                   	push   %rbx
    11ad:	48 89 fb             	mov    %rdi,%rbx
    11b0:	48 83 ec 10          	sub    $0x10,%rsp
snd_pcm_sgbuf_get_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/pcm.h:974
    11b4:	4c 8b 32             	mov    (%rdx),%r14
setup_bdle():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1184
    11b7:	e9 9a 00 00 00       	jmpq   1256 <setup_bdle+0xba>
snd_sgbuf_get_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/memalloc.h:105
    11bc:	81 7d 40 ff 00 00 00 	cmpl   $0xff,0x40(%rbp)
setup_bdle():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1184
    11c3:	76 0b                	jbe    11d0 <setup_bdle+0x34>
snd_sgbuf_get_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/memalloc.h:103
    11c5:	41 bc ea ff ff ff    	mov    $0xffffffea,%r12d
    11cb:	e9 93 00 00 00       	jmpq   1263 <setup_bdle+0xc7>
    11d0:	48 8b 83 c0 00 00 00 	mov    0xc0(%rbx),%rax
    11d7:	44 89 e1             	mov    %r12d,%ecx
    11da:	44 89 e6             	mov    %r12d,%esi
    11dd:	48 89 ca             	mov    %rcx,%rdx
    11e0:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/memalloc.h:105
    11e6:	48 89 df             	mov    %rbx,%rdi
    11e9:	48 c1 ea 0c          	shr    $0xc,%rdx
    11ed:	48 8b 80 d8 02 00 00 	mov    0x2d8(%rax),%rax
setup_bdle():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1182
    11f4:	48 c1 e2 04          	shl    $0x4,%rdx
    11f8:	48 8b 40 28          	mov    0x28(%rax),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1184
    11fc:	48 8b 40 10          	mov    0x10(%rax),%rax
    1200:	48 8b 44 02 08       	mov    0x8(%rdx,%rax,1),%rax
    1205:	44 89 c2             	mov    %r8d,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1185
    1208:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1190
    120e:	48 8d 04 01          	lea    (%rcx,%rax,1),%rax
    1212:	41 89 06             	mov    %eax,(%r14)
    1215:	48 c1 e8 20          	shr    $0x20,%rax
    1219:	41 89 46 04          	mov    %eax,0x4(%r14)
    121d:	44 89 44 24 08       	mov    %r8d,0x8(%rsp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1193
    1222:	44 89 0c 24          	mov    %r9d,(%rsp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1190
    1226:	e8 00 00 00 00       	callq  122b <setup_bdle+0x8f>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1192
    122b:	41 89 46 08          	mov    %eax,0x8(%r14)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1191
    122f:	44 8b 44 24 08       	mov    0x8(%rsp),%r8d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1172
    1234:	44 8b 0c 24          	mov    (%rsp),%r9d
    1238:	41 29 c0             	sub    %eax,%r8d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1195
    123b:	0f 94 c1             	sete   %cl
    123e:	31 d2                	xor    %edx,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1197
    1240:	45 85 c9             	test   %r9d,%r9d
    1243:	0f 95 c2             	setne  %dl
    1246:	41 01 c4             	add    %eax,%r12d
    1249:	21 ca                	and    %ecx,%edx
    124b:	41 89 56 0c          	mov    %edx,0xc(%r14)
azx_pcm_prepare():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1652
    124f:	ff 45 40             	incl   0x40(%rbp)
    1252:	49 83 c6 10          	add    $0x10,%r14
    1256:	45 85 c0             	test   %r8d,%r8d
    1259:	0f 8f 5d ff ff ff    	jg     11bc <setup_bdle+0x20>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1656
    125f:	4d 89 75 00          	mov    %r14,0x0(%r13)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1653
    1263:	5f                   	pop    %rdi
    1264:	5d                   	pop    %rbp
    1265:	5b                   	pop    %rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1655
    1266:	5d                   	pop    %rbp
    1267:	44 89 e0             	mov    %r12d,%eax
    126a:	41 5c                	pop    %r12
    126c:	41 5d                	pop    %r13
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1654
    126e:	41 5e                	pop    %r14
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1655
    1270:	c3                   	retq   

0000000000001271 <azx_pcm_prepare>:
    1271:	41 57                	push   %r15
    1273:	41 56                	push   %r14
    1275:	41 55                	push   %r13
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1656
    1277:	41 54                	push   %r12
    1279:	49 89 fc             	mov    %rdi,%r12
    127c:	55                   	push   %rbp
    127d:	53                   	push   %rbx
    127e:	48 83 ec 38          	sub    $0x38,%rsp
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
    1282:	48 63 47 3c          	movslq 0x3c(%rdi),%rax
    1286:	4c 8b 77 10          	mov    0x10(%rdi),%r14
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
    128a:	48 8b af c0 00 00 00 	mov    0xc0(%rdi),%rbp
    1291:	4d 8b 2e             	mov    (%r14),%r13
    1294:	48 8b 9d 48 01 00 00 	mov    0x148(%rbp),%rbx
azx_stream_reset():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1272
    129b:	49 8b 44 c6 10       	mov    0x10(%r14,%rax,8),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1274
    12a0:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    12a5:	48 8b 53 58          	mov    0x58(%rbx),%rdx
    12a9:	8a 02                	mov    (%rdx),%al
    12ab:	83 e0 e1             	and    $0xffffffffffffffe1,%eax
    12ae:	88 02                	mov    %al,(%rdx)
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
    12b0:	b0 1c                	mov    $0x1c,%al
    12b2:	48 8b 53 58          	mov    0x58(%rbx),%rdx
azx_stream_reset():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1276
    12b6:	88 42 03             	mov    %al,0x3(%rdx)
    12b9:	48 8b 53 58          	mov    0x58(%rbx),%rdx
    12bd:	8a 02                	mov    (%rdx),%al
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
    12bf:	83 c8 01             	or     $0x1,%eax
azx_stream_reset():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1279
    12c2:	88 02                	mov    %al,(%rdx)
    12c4:	bf 55 32 00 00       	mov    $0x3255,%edi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1281
    12c9:	e8 00 00 00 00       	callq  12ce <azx_pcm_prepare+0x5d>
    12ce:	b8 2c 01 00 00       	mov    $0x12c,%eax
    12d3:	48 8b 53 58          	mov    0x58(%rbx),%rdx
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
    12d7:	8a 12                	mov    (%rdx),%dl
    12d9:	f6 c2 01             	test   $0x1,%dl
azx_stream_reset():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1285
    12dc:	75 04                	jne    12e2 <azx_pcm_prepare+0x71>
    12de:	ff c8                	dec    %eax
    12e0:	75 f1                	jne    12d3 <azx_pcm_prepare+0x62>
    12e2:	48 8b 43 58          	mov    0x58(%rbx),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1290
    12e6:	83 e2 fe             	and    $0xfffffffffffffffe,%edx
    12e9:	88 10                	mov    %dl,(%rax)
    12eb:	bf 55 32 00 00       	mov    $0x3255,%edi
azx_pcm_prepare():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1662
    12f0:	e8 00 00 00 00       	callq  12f5 <azx_pcm_prepare+0x84>
    12f5:	b8 2c 01 00 00       	mov    $0x12c,%eax
    12fa:	48 8b 53 58          	mov    0x58(%rbx),%rdx
    12fe:	8a 12                	mov    (%rdx),%dl
    1300:	80 e2 01             	and    $0x1,%dl
    1303:	74 04                	je     1309 <azx_pcm_prepare+0x98>
    1305:	ff c8                	dec    %eax
    1307:	75 f1                	jne    12fa <azx_pcm_prepare+0x89>
    1309:	48 8b 43 30          	mov    0x30(%rbx),%rax
    130d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    1313:	49 8b 46 08          	mov    0x8(%r14),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1668
    1317:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    131c:	8b 75 60             	mov    0x60(%rbp),%esi
    131f:	8b 7d 5c             	mov    0x5c(%rbp),%edi
    1322:	44 0f b7 80 84 02 00 	movzwl 0x284(%rax),%r8d
    1329:	00 
    132a:	8b 4a 20             	mov    0x20(%rdx),%ecx
    132d:	8b 55 54             	mov    0x54(%rbp),%edx
    1330:	e8 00 00 00 00       	callq  1335 <azx_pcm_prepare+0xc4>
snd_pcm_lib_buffer_bytes():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/pcm.h:591
    1335:	85 c0                	test   %eax,%eax
    1337:	89 c6                	mov    %eax,%esi
    1339:	75 1c                	jne    1357 <azx_pcm_prepare+0xe6>
azx_pcm_prepare():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1674
    133b:	8b 4d 54             	mov    0x54(%rbp),%ecx
    133e:	8b 55 60             	mov    0x60(%rbp),%edx
frames_to_bytes():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/pcm.h:581
    1341:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
azx_pcm_prepare():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1674
    1348:	8b 75 5c             	mov    0x5c(%rbp),%esi
    134b:	31 c0                	xor    %eax,%eax
    134d:	e8 00 00 00 00       	callq  1352 <azx_pcm_prepare+0xe1>
    1352:	e9 ab 01 00 00       	jmpq   1502 <azx_pcm_prepare+0x291>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1675
    1357:	49 8b bc 24 c0 00 00 	mov    0xc0(%r12),%rdi
    135e:	00 
    135f:	b9 08 00 00 00       	mov    $0x8,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1680
    1364:	44 8b 8f 90 00 00 00 	mov    0x90(%rdi),%r9d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1681
    136b:	4c 89 c8             	mov    %r9,%rax
    136e:	48 0f af 47 78       	imul   0x78(%rdi),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1682
    1373:	48 99                	cqto   
    1375:	48 f7 f9             	idiv   %rcx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1684
    1378:	41 89 c0             	mov    %eax,%r8d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1683
    137b:	4c 89 c8             	mov    %r9,%rax
    137e:	48 0f af 47 68       	imul   0x68(%rdi),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1685
    1383:	48 99                	cqto   
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    1385:	48 f7 f9             	idiv   %rcx
    1388:	44 3b 43 38          	cmp    0x38(%rbx),%r8d
    138c:	75 0e                	jne    139c <azx_pcm_prepare+0x12b>
    138e:	3b 43 3c             	cmp    0x3c(%rbx),%eax
    1391:	75 09                	jne    139c <azx_pcm_prepare+0x12b>
azx_setup_periods():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1214
    1393:	3b 73 70             	cmp    0x70(%rbx),%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1215
    1396:	0f 84 70 01 00 00    	je     150c <azx_pcm_prepare+0x29b>
    139c:	89 43 3c             	mov    %eax,0x3c(%rbx)
    139f:	44 89 43 38          	mov    %r8d,0x38(%rbx)
    13a3:	31 c0                	xor    %eax,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1218
    13a5:	89 73 70             	mov    %esi,0x70(%rbx)
    13a8:	48 8b 53 58          	mov    0x58(%rbx),%rdx
    13ac:	89 42 18             	mov    %eax,0x18(%rdx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1220
    13af:	48 8b 53 58          	mov    0x58(%rbx),%rdx
    13b3:	89 42 1c             	mov    %eax,0x1c(%rdx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1221
    13b6:	8b 43 3c             	mov    0x3c(%rbx),%eax
    13b9:	31 d2                	xor    %edx,%edx
    13bb:	89 04 24             	mov    %eax,(%rsp)
    13be:	8b 43 38             	mov    0x38(%rbx),%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1222
    13c1:	f7 34 24             	divl   (%rsp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1223
    13c4:	89 44 24 14          	mov    %eax,0x14(%rsp)
    13c8:	48 8b 43 10          	mov    0x10(%rbx),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1225
    13cc:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    13d1:	c7 43 40 00 00 00 00 	movl   $0x0,0x40(%rbx)
    13d8:	49 63 45 10          	movslq 0x10(%r13),%rax
    13dc:	8b 34 85 00 00 00 00 	mov    0x0(,%rax,4),%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1226
    13e3:	85 f6                	test   %esi,%esi
    13e5:	7e 60                	jle    1447 <azx_pcm_prepare+0x1d6>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1229
    13e7:	49 8b 8c 24 c0 00 00 	mov    0xc0(%r12),%rcx
    13ee:	00 
    13ef:	31 d2                	xor    %edx,%edx
    13f1:	41 b8 80 bb 00 00    	mov    $0xbb80,%r8d
frames_to_bytes():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/sound/pcm.h:581
    13f7:	89 f7                	mov    %esi,%edi
    13f9:	8b 41 5c             	mov    0x5c(%rcx),%eax
    13fc:	0f af c6             	imul   %esi,%eax
    13ff:	05 7f bb 00 00       	add    $0xbb7f,%eax
    1404:	41 f7 f0             	div    %r8d
    1407:	85 c0                	test   %eax,%eax
    1409:	74 0e                	je     1419 <azx_pcm_prepare+0x1a8>
    140b:	8d 54 06 ff          	lea    -0x1(%rsi,%rax,1),%edx
azx_setup_periods():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1232
    140f:	89 d0                	mov    %edx,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1231
    1411:	99                   	cltd   
    1412:	f7 fe                	idiv   %esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1232
    1414:	89 c7                	mov    %eax,%edi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1233
    1416:	0f af fe             	imul   %esi,%edi
    1419:	8b 91 90 00 00 00    	mov    0x90(%rcx),%edx
    141f:	48 63 c7             	movslq %edi,%rax
    1422:	41 b8 08 00 00 00    	mov    $0x8,%r8d
    1428:	48 0f af c2          	imul   %rdx,%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1237
    142c:	48 99                	cqto   
    142e:	49 f7 f8             	idiv   %r8
    1431:	3b 04 24             	cmp    (%rsp),%eax
    1434:	41 89 c7             	mov    %eax,%r15d
    1437:	7c 15                	jl     144e <azx_pcm_prepare+0x1dd>
    1439:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1440:	31 c0                	xor    %eax,%eax
    1442:	e8 00 00 00 00       	callq  1447 <azx_pcm_prepare+0x1d6>
    1447:	45 31 ff             	xor    %r15d,%r15d
    144a:	31 c0                	xor    %eax,%eax
    144c:	eb 28                	jmp    1476 <azx_pcm_prepare+0x205>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1240
    144e:	44 8a 89 a4 00 00 00 	mov    0xa4(%rcx),%r9b
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1246
    1455:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1240
    145a:	31 c9                	xor    %ecx,%ecx
    145c:	41 89 c0             	mov    %eax,%r8d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1246
    145f:	48 89 de             	mov    %rbx,%rsi
    1462:	4c 89 e7             	mov    %r12,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1247
    1465:	41 83 f1 01          	xor    $0x1,%r9d
    1469:	41 83 e1 01          	and    $0x1,%r9d
    146d:	e8 2a fd ff ff       	callq  119c <setup_bdle>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1246
    1472:	85 c0                	test   %eax,%eax
    1474:	78 78                	js     14ee <azx_pcm_prepare+0x27d>
    1476:	8b 54 24 14          	mov    0x14(%rsp),%edx
    147a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    1481:	00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1247
    1482:	ff ca                	dec    %edx
    1484:	89 54 24 18          	mov    %edx,0x18(%rsp)
    1488:	8b 14 24             	mov    (%rsp),%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1250
    148b:	44 29 fa             	sub    %r15d,%edx
    148e:	89 54 24 1c          	mov    %edx,0x1c(%rsp)
    1492:	eb 4e                	jmp    14e2 <azx_pcm_prepare+0x271>
    1494:	8b 54 24 18          	mov    0x18(%rsp),%edx
    1498:	39 54 24 04          	cmp    %edx,0x4(%rsp)
    149c:	75 0f                	jne    14ad <azx_pcm_prepare+0x23c>
    149e:	45 85 ff             	test   %r15d,%r15d
    14a1:	74 0a                	je     14ad <azx_pcm_prepare+0x23c>
    14a3:	45 31 c9             	xor    %r9d,%r9d
    14a6:	44 8b 44 24 1c       	mov    0x1c(%rsp),%r8d
    14ab:	eb 1b                	jmp    14c8 <azx_pcm_prepare+0x257>
    14ad:	49 8b 94 24 c0 00 00 	mov    0xc0(%r12),%rdx
    14b4:	00 
    14b5:	44 8b 04 24          	mov    (%rsp),%r8d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1253
    14b9:	44 8a 8a a4 00 00 00 	mov    0xa4(%rdx),%r9b
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1245
    14c0:	41 83 f1 01          	xor    $0x1,%r9d
    14c4:	41 83 e1 01          	and    $0x1,%r9d
    14c8:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1259
    14cd:	89 c1                	mov    %eax,%ecx
    14cf:	48 89 de             	mov    %rbx,%rsi
    14d2:	4c 89 e7             	mov    %r12,%rdi
    14d5:	e8 c2 fc ff ff       	callq  119c <setup_bdle>
    14da:	85 c0                	test   %eax,%eax
    14dc:	78 10                	js     14ee <azx_pcm_prepare+0x27d>
    14de:	ff 44 24 04          	incl   0x4(%rsp)
    14e2:	8b 54 24 14          	mov    0x14(%rsp),%edx
    14e6:	39 54 24 04          	cmp    %edx,0x4(%rsp)
azx_pcm_prepare():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1692
    14ea:	7c a8                	jl     1494 <azx_pcm_prepare+0x223>
    14ec:	eb 1e                	jmp    150c <azx_pcm_prepare+0x29b>
    14ee:	8b 73 38             	mov    0x38(%rbx),%esi
    14f1:	8b 14 24             	mov    (%rsp),%edx
    14f4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
    14fb:	31 c0                	xor    %eax,%eax
azx_pcm_prepare():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1692
    14fd:	e8 00 00 00 00       	callq  1502 <azx_pcm_prepare+0x291>
    1502:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
    1507:	e9 02 01 00 00       	jmpq   160e <azx_pcm_prepare+0x39d>
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
    150c:	48 69 45 68 c0 5d 00 	imul   $0x5dc0,0x68(%rbp),%rax
    1513:	00 
    1514:	8b 4d 5c             	mov    0x5c(%rbp),%ecx
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
    1517:	31 d2                	xor    %edx,%edx
    1519:	48 f7 f1             	div    %rcx
    151c:	48 8b 53 58          	mov    0x58(%rbx),%rdx
azx_setup_controller():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1301
    1520:	48 69 c0 e8 03 00 00 	imul   $0x3e8,%rax,%rax
    1527:	48 89 43 50          	mov    %rax,0x50(%rbx)
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    152b:	8a 02                	mov    (%rdx),%al
azx_setup_controller():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1306
    152d:	83 e0 e1             	and    $0xffffffffffffffe1,%eax
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    1530:	88 02                	mov    %al,(%rdx)
    1532:	b0 1c                	mov    $0x1c,%al
    1534:	48 8b 53 58          	mov    0x58(%rbx),%rdx
azx_setup_controller():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1310
    1538:	88 42 03             	mov    %al,0x3(%rdx)
writew():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:65
    153b:	48 8b 4b 58          	mov    0x58(%rbx),%rcx
    153f:	8b 01                	mov    (%rcx),%eax
    1541:	0f b6 53 74          	movzbl 0x74(%rbx),%edx
    1545:	25 ff ff 0f ff       	and    $0xff0fffff,%eax
azx_setup_controller():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1313
    154a:	c1 e2 14             	shl    $0x14,%edx
writew():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:65
    154d:	09 d0                	or     %edx,%eax
azx_setup_controller():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1317
    154f:	89 01                	mov    %eax,(%rcx)
    1551:	8b 43 38             	mov    0x38(%rbx),%eax
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    1554:	48 8b 53 58          	mov    0x58(%rbx),%rdx
    1558:	89 42 08             	mov    %eax,0x8(%rdx)
azx_setup_controller():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1319
    155b:	8b 43 70             	mov    0x70(%rbx),%eax
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    155e:	48 8b 53 58          	mov    0x58(%rbx),%rdx
    1562:	66 89 42 12          	mov    %ax,0x12(%rdx)
azx_setup_controller():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1322
    1566:	8b 43 40             	mov    0x40(%rbx),%eax
    1569:	48 8b 53 58          	mov    0x58(%rbx),%rdx
    156d:	ff c8                	dec    %eax
    156f:	66 89 42 0c          	mov    %ax,0xc(%rdx)
    1573:	8b 43 18             	mov    0x18(%rbx),%eax
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
    1576:	48 8b 53 58          	mov    0x58(%rbx),%rdx
    157a:	89 42 18             	mov    %eax,0x18(%rdx)
azx_setup_controller():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1324
    157d:	8b 43 1c             	mov    0x1c(%rbx),%eax
    1580:	48 8b 53 58          	mov    0x58(%rbx),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1325
    1584:	89 42 1c             	mov    %eax,0x1c(%rdx)
    1587:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    158e:	00 00 00 
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    1591:	49 39 85 e8 01 00 00 	cmp    %rax,0x1e8(%r13)
azx_setup_controller():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1330
    1598:	74 1c                	je     15b6 <azx_pcm_prepare+0x345>
    159a:	49 8b 45 38          	mov    0x38(%r13),%rax
azx_pcm_prepare():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1695
    159e:	8b 40 70             	mov    0x70(%rax),%eax
    15a1:	a8 01                	test   $0x1,%al
    15a3:	75 11                	jne    15b6 <azx_pcm_prepare+0x345>
readw():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:57
    15a5:	49 8b 85 d0 01 00 00 	mov    0x1d0(%r13),%rax
    15ac:	49 8b 55 38          	mov    0x38(%r13),%rdx
azx_pcm_prepare():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1696
    15b0:	83 c8 01             	or     $0x1,%eax
    15b3:	89 42 70             	mov    %eax,0x70(%rdx)
    15b6:	48 8b 53 58          	mov    0x58(%rbx),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1698
    15ba:	8b 02                	mov    (%rdx),%eax
    15bc:	83 c8 1c             	or     $0x1c,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1702
    15bf:	89 02                	mov    %eax,(%rdx)
    15c1:	41 83 7c 24 3c 00    	cmpl   $0x0,0x3c(%r12)
    15c7:	75 12                	jne    15db <azx_pcm_prepare+0x36a>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1703
    15c9:	48 8b 43 58          	mov    0x58(%rbx),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1704
    15cd:	66 8b 40 10          	mov    0x10(%rax),%ax
    15d1:	0f b7 c0             	movzwl %ax,%eax
    15d4:	ff c0                	inc    %eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1705
    15d6:	89 43 44             	mov    %eax,0x44(%rbx)
    15d9:	eb 07                	jmp    15e2 <azx_pcm_prepare+0x371>
    15db:	c7 43 44 00 00 00 00 	movl   $0x0,0x44(%rbx)
    15e2:	41 83 7d 14 0a       	cmpl   $0xa,0x14(%r13)
    15e7:	0f b6 53 74          	movzbl 0x74(%rbx),%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1707
    15eb:	75 0d                	jne    15fa <azx_pcm_prepare+0x389>
    15ed:	41 8b 45 20          	mov    0x20(%r13),%eax
    15f1:	89 d1                	mov    %edx,%ecx
    15f3:	29 c1                	sub    %eax,%ecx
    15f5:	39 c2                	cmp    %eax,%edx
    15f7:	0f 47 d1             	cmova  %ecx,%edx
azx_pcm_hw_free():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1635
    15fa:	8b 4b 70             	mov    0x70(%rbx),%ecx
    15fd:	49 8b 7e 08          	mov    0x8(%r14),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1633
    1601:	4d 89 e0             	mov    %r12,%r8
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1636
    1604:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1634
    1609:	e8 00 00 00 00       	callq  160e <azx_pcm_prepare+0x39d>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1635
    160e:	48 83 c4 38          	add    $0x38,%rsp
    1612:	5b                   	pop    %rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1636
    1613:	5d                   	pop    %rbp
    1614:	41 5c                	pop    %r12
    1616:	41 5d                	pop    %r13
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    1618:	41 5e                	pop    %r14
    161a:	41 5f                	pop    %r15
    161c:	c3                   	retq   

000000000000161d <azx_pcm_hw_free>:
    161d:	53                   	push   %rbx
    161e:	48 8b 87 c0 00 00 00 	mov    0xc0(%rdi),%rax
    1625:	48 89 fb             	mov    %rdi,%rbx
    1628:	48 63 4f 3c          	movslq 0x3c(%rdi),%rcx
    162c:	48 8b 57 10          	mov    0x10(%rdi),%rdx
azx_pcm_hw_free():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1642
    1630:	48 8b 80 48 01 00 00 	mov    0x148(%rax),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1643
    1637:	48 8b 74 ca 10       	mov    0x10(%rdx,%rcx,8),%rsi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1644
    163c:	31 c9                	xor    %ecx,%ecx
    163e:	48 8b 78 58          	mov    0x58(%rax),%rdi
    1642:	89 4f 18             	mov    %ecx,0x18(%rdi)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1646
    1645:	48 8b 78 58          	mov    0x58(%rax),%rdi
    1649:	89 4f 1c             	mov    %ecx,0x1c(%rdi)
    164c:	48 8b 78 58          	mov    0x58(%rax),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1648
    1650:	89 0f                	mov    %ecx,(%rdi)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1649
    1652:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%rax)
azx_pcm_hw_params():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1622
    1659:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%rax)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1623
    1660:	c7 40 70 00 00 00 00 	movl   $0x0,0x70(%rax)
    1667:	48 8b 7a 08          	mov    0x8(%rdx),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1625
    166b:	48 89 da             	mov    %rbx,%rdx
    166e:	e8 00 00 00 00       	callq  1673 <azx_pcm_hw_free+0x56>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1626
    1673:	48 89 df             	mov    %rbx,%rdi
    1676:	5b                   	pop    %rbx
    1677:	e9 00 00 00 00       	jmpq   167c <azx_pcm_hw_params>

000000000000167c <azx_pcm_hw_params>:
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1627
    167c:	48 83 ec 08          	sub    $0x8,%rsp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1628
    1680:	48 8b 87 c0 00 00 00 	mov    0xc0(%rdi),%rax
    1687:	48 8b 80 48 01 00 00 	mov    0x148(%rax),%rax
azx_pcm_close():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1601
    168e:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%rax)
    1695:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%rax)
    169c:	c7 40 70 00 00 00 00 	movl   $0x0,0x70(%rax)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1603
    16a3:	8b b6 7c 01 00 00    	mov    0x17c(%rsi),%esi
    16a9:	41 58                	pop    %r8
    16ab:	e9 00 00 00 00       	jmpq   16b0 <azx_pcm_close>

00000000000016b0 <azx_pcm_close>:
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1605
    16b0:	41 57                	push   %r15
    16b2:	41 56                	push   %r14
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1608
    16b4:	49 89 fe             	mov    %rdi,%r14
    16b7:	41 55                	push   %r13
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1609
    16b9:	41 54                	push   %r12
    16bb:	55                   	push   %rbp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1605
    16bc:	53                   	push   %rbx
    16bd:	48 83 ec 08          	sub    $0x8,%rsp
    16c1:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1608
    16c5:	48 63 47 3c          	movslq 0x3c(%rdi),%rax
    16c9:	4c 8b 3b             	mov    (%rbx),%r15
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1609
    16cc:	4c 8b 64 c3 10       	mov    0x10(%rbx,%rax,8),%r12
    16d1:	48 8b 87 c0 00 00 00 	mov    0xc0(%rdi),%rax
spin_unlock_irqrestore():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:340
    16d8:	49 8d 6f 48          	lea    0x48(%r15),%rbp
    16dc:	49 83 c7 44          	add    $0x44,%r15
azx_pcm_close():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1610
    16e0:	4c 8b a8 48 01 00 00 	mov    0x148(%rax),%r13
spin_unlock_irqrestore():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:340
    16e7:	48 89 ef             	mov    %rbp,%rdi
    16ea:	e8 00 00 00 00       	callq  16ef <azx_pcm_close+0x3f>
azx_release_device():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1509
    16ef:	4c 89 ff             	mov    %r15,%rdi
azx_pcm_close():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1614
    16f2:	e8 00 00 00 00       	callq  16f7 <azx_pcm_close+0x47>
    16f7:	41 80 65 7c fd       	andb   $0xfd,0x7c(%r13)
    16fc:	48 89 c6             	mov    %rax,%rsi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1615
    16ff:	4c 89 ff             	mov    %r15,%rdi
    1702:	49 c7 45 68 00 00 00 	movq   $0x0,0x68(%r13)
    1709:	00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1616
    170a:	e8 00 00 00 00       	callq  170f <azx_pcm_close+0x5f>
    170f:	41 80 65 7c fe       	andb   $0xfe,0x7c(%r13)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1618
    1714:	4c 89 f2             	mov    %r14,%rdx
    1717:	4c 89 e7             	mov    %r12,%rdi
    171a:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    171e:	41 ff 54 24 30       	callq  *0x30(%r12)
azx_pcm_open():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1543
    1723:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    1727:	e8 00 00 00 00       	callq  172c <azx_pcm_close+0x7c>
    172c:	48 89 ef             	mov    %rbp,%rdi
    172f:	e8 00 00 00 00       	callq  1734 <azx_pcm_close+0x84>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1545
    1734:	41 59                	pop    %r9
    1736:	5b                   	pop    %rbx
    1737:	5d                   	pop    %rbp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1548
    1738:	41 5c                	pop    %r12
    173a:	41 5d                	pop    %r13
    173c:	41 5e                	pop    %r14
    173e:	31 c0                	xor    %eax,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1546
    1740:	41 5f                	pop    %r15
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1545
    1742:	c3                   	retq   

0000000000001743 <azx_pcm_open>:
    1743:	41 57                	push   %r15
    1745:	41 56                	push   %r14
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1552
    1747:	41 55                	push   %r13
    1749:	41 54                	push   %r12
    174b:	49 89 fc             	mov    %rdi,%r12
    174e:	55                   	push   %rbp
    174f:	53                   	push   %rbx
    1750:	48 83 ec 18          	sub    $0x18,%rsp
    1754:	4c 8b 77 10          	mov    0x10(%rdi),%r14
azx_assign_device():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1486
    1758:	48 63 47 3c          	movslq 0x3c(%rdi),%rax
    175c:	48 8b af c0 00 00 00 	mov    0xc0(%rdi),%rbp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1487
    1763:	4d 8b 3e             	mov    (%r14),%r15
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1488
    1766:	4d 8b 6c c6 10       	mov    0x10(%r14,%rax,8),%r13
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1490
    176b:	49 8d 47 48          	lea    0x48(%r15),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1491
    176f:	48 89 c7             	mov    %rax,%rdi
    1772:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1777:	e8 00 00 00 00       	callq  177c <azx_pcm_open+0x39>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1494
    177c:	41 83 7c 24 3c 00    	cmpl   $0x0,0x3c(%r12)
    1782:	75 0a                	jne    178e <azx_pcm_open+0x4b>
    1784:	41 8b 4f 1c          	mov    0x1c(%r15),%ecx
    1788:	41 8b 77 18          	mov    0x18(%r15),%esi
    178c:	eb 08                	jmp    1796 <azx_pcm_open+0x53>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1496
    178e:	41 8b 4f 24          	mov    0x24(%r15),%ecx
    1792:	41 8b 77 20          	mov    0x20(%r15),%esi
    1796:	31 d2                	xor    %edx,%edx
    1798:	31 c0                	xor    %eax,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1493
    179a:	eb 27                	jmp    17c3 <azx_pcm_open+0x80>
    179c:	48 63 db             	movslq %ebx,%rbx
    179f:	48 c1 e3 07          	shl    $0x7,%rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1542
    17a3:	49 03 5f 68          	add    0x68(%r15),%rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1493
    17a7:	f6 43 7c 01          	testb  $0x1,0x7c(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1499
    17ab:	74 05                	je     17b2 <azx_pcm_open+0x6f>
    17ad:	48 89 d3             	mov    %rdx,%rbx
    17b0:	eb 0c                	jmp    17be <azx_pcm_open+0x7b>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1500
    17b2:	49 8b 14 24          	mov    (%r12),%rdx
azx_pcm_open():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1558
    17b6:	8b 7b 78             	mov    0x78(%rbx),%edi
    17b9:	3b 7a 18             	cmp    0x18(%rdx),%edi
    17bc:	74 0f                	je     17cd <azx_pcm_open+0x8a>
    17be:	ff c0                	inc    %eax
    17c0:	48 89 da             	mov    %rbx,%rdx
    17c3:	39 f0                	cmp    %esi,%eax
azx_assign_device():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1501
    17c5:	8d 1c 08             	lea    (%rax,%rcx,1),%ebx
azx_pcm_open():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1558
    17c8:	7c d2                	jl     179c <azx_pcm_open+0x59>
    17ca:	48 89 d3             	mov    %rdx,%rbx
azx_assign_device():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1501
    17cd:	48 85 db             	test   %rbx,%rbx
    17d0:	0f 84 a6 00 00 00    	je     187c <azx_pcm_open+0x139>
azx_pcm_open():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1563
    17d6:	80 4b 7c 01          	orb    $0x1,0x7c(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1559
    17da:	48 8d bd 58 01 00 00 	lea    0x158(%rbp),%rdi
    17e1:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1560
    17e8:	49 8b 04 24          	mov    (%r12),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1561
    17ec:	b9 14 00 00 00       	mov    $0x14,%ecx
    17f1:	8b 40 18             	mov    0x18(%rax),%eax
    17f4:	89 43 78             	mov    %eax,0x78(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1562
    17f7:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
    17f9:	48 89 ef             	mov    %rbp,%rdi
    17fc:	41 8b 45 04          	mov    0x4(%r13),%eax
    1800:	89 85 74 01 00 00    	mov    %eax,0x174(%rbp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1564
    1806:	41 8b 45 08          	mov    0x8(%r13),%eax
    180a:	89 85 78 01 00 00    	mov    %eax,0x178(%rbp)
    1810:	49 8b 45 18          	mov    0x18(%r13),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1565
    1814:	48 89 85 60 01 00 00 	mov    %rax,0x160(%rbp)
    181b:	41 8b 45 10          	mov    0x10(%r13),%eax
    181f:	89 85 68 01 00 00    	mov    %eax,0x168(%rbp)
    1825:	e8 00 00 00 00       	callq  182a <azx_pcm_open+0xe7>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1567
    182a:	be 0f 00 00 00       	mov    $0xf,%esi
    182f:	48 89 ef             	mov    %rbp,%rdi
    1832:	e8 00 00 00 00       	callq  1837 <azx_pcm_open+0xf4>
    1837:	31 f6                	xor    %esi,%esi
    1839:	b9 80 00 00 00       	mov    $0x80,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1569
    183e:	ba 12 00 00 00       	mov    $0x12,%edx
    1843:	48 89 ef             	mov    %rbp,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1570
    1846:	e8 00 00 00 00       	callq  184b <azx_pcm_open+0x108>
    184b:	31 f6                	xor    %esi,%esi
    184d:	b9 80 00 00 00       	mov    $0x80,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1571
    1852:	ba 0e 00 00 00       	mov    $0xe,%edx
    1857:	48 89 ef             	mov    %rbp,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1555
    185a:	e8 00 00 00 00       	callq  185f <azx_pcm_open+0x11c>
    185f:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    1863:	e8 00 00 00 00       	callq  1868 <azx_pcm_open+0x125>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1556
    1868:	49 8b 76 08          	mov    0x8(%r14),%rsi
azx_release_device():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1509
    186c:	4c 89 e2             	mov    %r12,%rdx
azx_pcm_open():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1573
    186f:	4c 89 ef             	mov    %r13,%rdi
    1872:	41 ff 55 28          	callq  *0x28(%r13)
    1876:	85 c0                	test   %eax,%eax
    1878:	79 32                	jns    18ac <azx_pcm_open+0x169>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1574
    187a:	eb 11                	jmp    188d <azx_pcm_open+0x14a>
    187c:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    1881:	e8 00 00 00 00       	callq  1886 <azx_pcm_open+0x143>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1575
    1886:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1589
    188b:	eb 61                	jmp    18ee <azx_pcm_open+0x1ab>
    188d:	80 63 7c fe          	andb   $0xfe,0x7c(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1577
    1891:	49 8b 7e 08          	mov    0x8(%r14),%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1589
    1895:	89 04 24             	mov    %eax,(%rsp)
    1898:	e8 00 00 00 00       	callq  189d <azx_pcm_open+0x15a>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1591
    189d:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
spin_unlock_irqrestore():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:340
    18a2:	e8 00 00 00 00       	callq  18a7 <azx_pcm_open+0x164>
azx_pcm_open():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1590
    18a7:	8b 04 24             	mov    (%rsp),%eax
spin_unlock_irqrestore():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:340
    18aa:	eb 42                	jmp    18ee <azx_pcm_open+0x1ab>
    18ac:	48 89 ef             	mov    %rbp,%rdi
azx_pcm_open():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1595
    18af:	49 83 c7 44          	add    $0x44,%r15
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1594
    18b3:	e8 00 00 00 00       	callq  18b8 <azx_pcm_open+0x175>
    18b8:	4c 89 ff             	mov    %r15,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1595
    18bb:	e8 00 00 00 00       	callq  18c0 <azx_pcm_open+0x17d>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1596
    18c0:	80 63 7c fd          	andb   $0xfd,0x7c(%rbx)
    18c4:	48 89 c6             	mov    %rax,%rsi
    18c7:	4c 89 ff             	mov    %r15,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1598
    18ca:	4c 89 63 68          	mov    %r12,0x68(%rbx)
    18ce:	e8 00 00 00 00       	callq  18d3 <azx_pcm_open+0x190>
    18d3:	4c 89 e7             	mov    %r12,%rdi
    18d6:	48 89 9d 48 01 00 00 	mov    %rbx,0x148(%rbp)
azx_get_response():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:853
    18dd:	e8 00 00 00 00       	callq  18e2 <azx_pcm_open+0x19f>
    18e2:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    18e7:	e8 00 00 00 00       	callq  18ec <azx_pcm_open+0x1a9>
    18ec:	31 c0                	xor    %eax,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:854
    18ee:	48 83 c4 18          	add    $0x18,%rsp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:855
    18f2:	5b                   	pop    %rbx
    18f3:	5d                   	pop    %rbp
    18f4:	41 5c                	pop    %r12
    18f6:	41 5d                	pop    %r13
    18f8:	41 5e                	pop    %r14
    18fa:	41 5f                	pop    %r15
    18fc:	c3                   	retq   

00000000000018fd <azx_get_response>:
    18fd:	41 57                	push   %r15
azx_rirb_get_response():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:685
    18ff:	41 56                	push   %r14
spin_lock_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:310
    1901:	41 89 f6             	mov    %esi,%r14d
    1904:	41 55                	push   %r13
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:155
    1906:	41 54                	push   %r12
azx_rirb_get_response():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:685
    1908:	55                   	push   %rbp
    1909:	48 89 fd             	mov    %rdi,%rbp
    190c:	53                   	push   %rbx
    190d:	48 83 ec 28          	sub    $0x28,%rsp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:722
    1911:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    1915:	f6 83 f4 01 00 00 04 	testb  $0x4,0x1f4(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:678
    191c:	0f 85 8c 00 00 00    	jne    19ae <azx_get_response+0xb1>
    1922:	41 89 f5             	mov    %esi,%r13d
    1925:	4c 8d 63 44          	lea    0x44(%rbx),%r12
    1929:	45 31 ff             	xor    %r15d,%r15d
    192c:	49 8d 45 50          	lea    0x50(%r13),%rax
    1930:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:680
    1935:	49 8d 45 7c          	lea    0x7c(%r13),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:678
    1939:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:680
    193e:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 1945 <azx_get_response+0x48>
    1945:	bf e8 03 00 00       	mov    $0x3e8,%edi
    194a:	48 89 04 24          	mov    %rax,(%rsp)
spin_lock_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:310
    194e:	e8 00 00 00 00       	callq  1953 <azx_get_response+0x56>
    1953:	48 03 04 24          	add    (%rsp),%rax
azx_rirb_get_response():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:682
    1957:	44 88 7c 24 17       	mov    %r15b,0x17(%rsp)
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
    195c:	48 89 04 24          	mov    %rax,(%rsp)
    1960:	80 7c 24 17 00       	cmpb   $0x0,0x17(%rsp)
arch_local_irq_enable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/paravirt.h:868
    1965:	75 09                	jne    1970 <azx_get_response+0x73>
    1967:	f6 83 f4 01 00 00 08 	testb  $0x8,0x1f4(%rbx)
azx_rirb_get_response():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:685
    196e:	74 1c                	je     198c <azx_get_response+0x8f>
    1970:	4c 89 e7             	mov    %r12,%rdi
    1973:	e8 00 00 00 00       	callq  1978 <azx_get_response+0x7b>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:687
    1978:	48 89 df             	mov    %rbx,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:689
    197b:	e8 16 e9 ff ff       	callq  296 <azx_update_rirb>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:690
    1980:	66 41 ff 04 24       	incw   (%r12)
    1985:	ff 14 25 00 00 00 00 	callq  *0x0
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:691
    198c:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    1991:	83 7c 83 04 00       	cmpl   $0x0,0x4(%rbx,%rax,4)
    1996:	75 26                	jne    19be <azx_get_response+0xc1>
    1998:	80 a5 68 01 00 00 ef 	andb   $0xef,0x168(%rbp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:693
    199f:	45 85 ff             	test   %r15d,%r15d
    19a2:	75 0a                	jne    19ae <azx_get_response+0xb1>
    19a4:	c7 83 f0 01 00 00 00 	movl   $0x0,0x1f0(%rbx)
    19ab:	00 00 00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:695
    19ae:	45 89 f6             	mov    %r14d,%r14d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:696
    19b1:	42 8b 84 b3 64 01 00 	mov    0x164(%rbx,%r14,4),%eax
    19b8:	00 
    19b9:	e9 65 01 00 00       	jmpq   1b23 <azx_get_response+0x226>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:698
    19be:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 19c5 <azx_get_response+0xc8>
    19c5:	48 39 04 24          	cmp    %rax,(%rsp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:699
    19c9:	78 29                	js     19f4 <azx_get_response+0xf7>
    19cb:	f6 85 68 01 00 00 01 	testb  $0x1,0x168(%rbp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:703
    19d2:	74 0c                	je     19e0 <azx_get_response+0xe3>
    19d4:	bf 02 00 00 00       	mov    $0x2,%edi
    19d9:	e8 00 00 00 00       	callq  19de <azx_get_response+0xe1>
    19de:	eb 80                	jmp    1960 <azx_get_response+0x63>
    19e0:	bf c6 a7 00 00       	mov    $0xa7c6,%edi
    19e5:	e8 00 00 00 00       	callq  19ea <azx_get_response+0xed>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:708
    19ea:	e8 00 00 00 00       	callq  19ef <azx_get_response+0xf2>
    19ef:	e9 6c ff ff ff       	jmpq   1960 <azx_get_response+0x63>
    19f4:	8a 93 f4 01 00 00    	mov    0x1f4(%rbx),%dl
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:714
    19fa:	f6 c2 08             	test   $0x8,%dl
    19fd:	75 41                	jne    1a40 <azx_get_response+0x143>
    19ff:	8b 83 f0 01 00 00    	mov    0x1f0(%rbx),%eax
    1a05:	83 f8 01             	cmp    $0x1,%eax
    1a08:	7f 13                	jg     1a1d <azx_get_response+0x120>
    1a0a:	ff c0                	inc    %eax
    1a0c:	41 bf 01 00 00 00    	mov    $0x1,%r15d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:717
    1a12:	89 83 f0 01 00 00    	mov    %eax,0x1f0(%rbx)
    1a18:	e9 21 ff ff ff       	jmpq   193e <azx_get_response+0x41>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:721
    1a1d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:722
    1a22:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1a29:	8b 74 83 08          	mov    0x8(%rbx,%rax,4),%esi
    1a2d:	31 c0                	xor    %eax,%eax
    1a2f:	e8 00 00 00 00       	callq  1a34 <azx_get_response+0x137>
    1a34:	80 8b f4 01 00 00 08 	orb    $0x8,0x1f4(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:725
    1a3b:	e9 fe fe ff ff       	jmpq   193e <azx_get_response+0x41>
    1a40:	f6 c2 10             	test   $0x10,%dl
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:727
    1a43:	74 5a                	je     1a9f <azx_get_response+0x1a2>
    1a45:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:726
    1a4a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:727
    1a51:	8b 74 83 08          	mov    0x8(%rbx,%rax,4),%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:728
    1a55:	31 c0                	xor    %eax,%eax
    1a57:	e8 00 00 00 00       	callq  1a5c <azx_get_response+0x15f>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:729
    1a5c:	8b 7b 40             	mov    0x40(%rbx),%edi
    1a5f:	48 89 de             	mov    %rbx,%rsi
    1a62:	e8 00 00 00 00       	callq  1a67 <azx_get_response+0x16a>
    1a67:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    1a6b:	c7 43 40 ff ff ff ff 	movl   $0xffffffff,0x40(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:730
    1a72:	e8 00 00 00 00       	callq  1a77 <azx_get_response+0x17a>
    1a77:	80 a3 f4 01 00 00 ef 	andb   $0xef,0x1f4(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:736
    1a7e:	be 01 00 00 00       	mov    $0x1,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:747
    1a83:	48 89 df             	mov    %rbx,%rdi
    1a86:	e8 84 e6 ff ff       	callq  10f <azx_acquire_irq>
    1a8b:	85 c0                	test   %eax,%eax
    1a8d:	0f 89 ab fe ff ff    	jns    193e <azx_get_response+0x41>
    1a93:	80 8d 68 01 00 00 10 	orb    $0x10,0x168(%rbp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:748
    1a9a:	e9 81 00 00 00       	jmpq   1b20 <azx_get_response+0x223>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:749
    1a9f:	83 c8 ff             	or     $0xffffffffffffffff,%eax
    1aa2:	80 e2 40             	and    $0x40,%dl
    1aa5:	75 7c                	jne    1b23 <azx_get_response+0x226>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:753
    1aa7:	8a 85 68 01 00 00    	mov    0x168(%rbp),%al
    1aad:	88 c2                	mov    %al,%dl
    1aaf:	83 ca 10             	or     $0x10,%edx
    1ab2:	88 95 68 01 00 00    	mov    %dl,0x168(%rbp)
    1ab8:	83 e2 62             	and    $0x62,%edx
    1abb:	80 fa 02             	cmp    $0x2,%dl
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:756
    1abe:	75 0b                	jne    1acb <azx_get_response+0x1ce>
    1ac0:	83 c8 30             	or     $0x30,%eax
    1ac3:	88 85 68 01 00 00    	mov    %al,0x168(%rbp)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:757
    1ac9:	eb 55                	jmp    1b20 <azx_get_response+0x223>
    1acb:	42 8b b4 ab f8 01 00 	mov    0x1f8(%rbx,%r13,4),%esi
    1ad2:	00 
writeb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:64
    1ad3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1ada:	31 c0                	xor    %eax,%eax
    1adc:	e8 00 00 00 00       	callq  1ae1 <azx_get_response+0x1e4>
    1ae1:	80 8b f4 01 00 00 04 	orb    $0x4,0x1f4(%rbx)
arch_local_irq_enable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/paravirt.h:868
    1ae8:	4c 89 e7             	mov    %r12,%rdi
    1aeb:	80 a5 68 01 00 00 df 	andb   $0xdf,0x168(%rbp)
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
    1af2:	e8 00 00 00 00       	callq  1af7 <azx_get_response+0x1fa>
azx_rirb_get_response():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:761
    1af7:	48 8b 53 38          	mov    0x38(%rbx),%rdx
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    1afb:	31 c0                	xor    %eax,%eax
    1afd:	88 42 5c             	mov    %al,0x5c(%rdx)
azx_get_response():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:859
    1b00:	48 8b 53 38          	mov    0x38(%rbx),%rdx
    1b04:	88 42 4c             	mov    %al,0x4c(%rdx)
    1b07:	66 41 ff 04 24       	incw   (%r12)
    1b0c:	ff 14 25 00 00 00 00 	callq  *0x0
azx_command_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:590
    1b13:	48 8b 53 38          	mov    0x38(%rbx),%rdx
azx_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:840
    1b17:	8b 42 08             	mov    0x8(%rdx),%eax
azx_command_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:588
    1b1a:	80 e4 fe             	and    $0xfe,%ah
    1b1d:	89 42 08             	mov    %eax,0x8(%rdx)
azx_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:840
    1b20:	83 c8 ff             	or     $0xffffffffffffffff,%eax
    1b23:	48 83 c4 28          	add    $0x28,%rsp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:841
    1b27:	5b                   	pop    %rbx
    1b28:	5d                   	pop    %rbp
    1b29:	41 5c                	pop    %r12
azx_command_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:590
    1b2b:	41 5d                	pop    %r13
    1b2d:	41 5e                	pop    %r14
azx_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:843
    1b2f:	41 5f                	pop    %r15
    1b31:	c3                   	retq   

0000000000001b32 <azx_send_cmd>:
    1b32:	41 55                	push   %r13
    1b34:	31 c0                	xor    %eax,%eax
    1b36:	89 c1                	mov    %eax,%ecx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:844
    1b38:	41 54                	push   %r12
    1b3a:	41 89 f4             	mov    %esi,%r12d
    1b3d:	55                   	push   %rbp
    1b3e:	89 f5                	mov    %esi,%ebp
    1b40:	c1 ed 1c             	shr    $0x1c,%ebp
    1b43:	53                   	push   %rbx
    1b44:	48 83 ec 08          	sub    $0x8,%rsp
azx_command_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:590
    1b48:	83 fd 08             	cmp    $0x8,%ebp
azx_single_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:803
    1b4b:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    1b4f:	0f 42 cd             	cmovb  %ebp,%ecx
azx_command_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:590
    1b52:	89 c9                	mov    %ecx,%ecx
azx_single_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:803
    1b54:	89 b4 8a f8 01 00 00 	mov    %esi,0x1f8(%rdx,%rcx,4)
    1b5b:	f6 82 f4 01 00 00 04 	testb  $0x4,0x1f4(%rdx)
readw():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:57
    1b62:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    1b66:	0f 84 c8 00 00 00    	je     1c34 <azx_send_cmd+0x102>
    1b6c:	83 fd 08             	cmp    $0x8,%ebp
    1b6f:	41 bd 32 00 00 00    	mov    $0x32,%r13d
azx_single_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:808
    1b75:	0f 43 e8             	cmovae %eax,%ebp
writew():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:65
    1b78:	80 a7 68 01 00 00 ef 	andb   $0xef,0x168(%rdi)
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    1b7f:	e9 90 00 00 00       	jmpq   1c14 <azx_send_cmd+0xe2>
readw():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:57
    1b84:	48 8b 43 38          	mov    0x38(%rbx),%rax
    1b88:	66 8b 40 68          	mov    0x68(%rax),%ax
azx_single_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:811
    1b8c:	a8 01                	test   $0x1,%al
writew():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:65
    1b8e:	75 7a                	jne    1c0a <azx_send_cmd+0xd8>
    1b90:	48 8b 53 38          	mov    0x38(%rbx),%rdx
    1b94:	66 8b 42 68          	mov    0x68(%rdx),%ax
    1b98:	83 c8 02             	or     $0x2,%eax
readw():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:57
    1b9b:	66 89 42 68          	mov    %ax,0x68(%rdx)
    1b9f:	48 8b 43 38          	mov    0x38(%rbx),%rax
azx_single_wait_for_response():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:782
    1ba3:	44 89 60 60          	mov    %r12d,0x60(%rax)
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
    1ba7:	48 8b 53 38          	mov    0x38(%rbx),%rdx
    1bab:	66 8b 42 68          	mov    0x68(%rdx),%ax
azx_single_wait_for_response():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:784
    1baf:	83 c8 01             	or     $0x1,%eax
    1bb2:	66 89 42 68          	mov    %ax,0x68(%rdx)
    1bb6:	41 bc 32 00 00 00    	mov    $0x32,%r12d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:787
    1bbc:	eb 2b                	jmp    1be9 <azx_send_cmd+0xb7>
    1bbe:	48 8b 43 38          	mov    0x38(%rbx),%rax
    1bc2:	66 8b 40 68          	mov    0x68(%rax),%ax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:780
    1bc6:	a8 02                	test   $0x2,%al
    1bc8:	74 15                	je     1bdf <azx_send_cmd+0xad>
    1bca:	48 8b 43 38          	mov    0x38(%rbx),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:789
    1bce:	8b 40 64             	mov    0x64(%rax),%eax
    1bd1:	89 ed                	mov    %ebp,%ebp
    1bd3:	89 84 ab 64 01 00 00 	mov    %eax,0x164(%rbx,%rbp,4)
    1bda:	e9 9d 00 00 00       	jmpq   1c7c <azx_send_cmd+0x14a>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:792
    1bdf:	bf c7 10 00 00       	mov    $0x10c7,%edi
    1be4:	e8 00 00 00 00       	callq  1be9 <azx_send_cmd+0xb7>
azx_single_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:815
    1be9:	41 ff cc             	dec    %r12d
    1bec:	41 83 fc ff          	cmp    $0xffffffffffffffff,%r12d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:804
    1bf0:	75 cc                	jne    1bbe <azx_send_cmd+0x8c>
    1bf2:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1bf9:	89 ed                	mov    %ebp,%ebp
    1bfb:	e8 00 00 00 00       	callq  1c00 <azx_send_cmd+0xce>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:817
    1c00:	44 89 a4 ab 64 01 00 	mov    %r12d,0x164(%rbx,%rbp,4)
    1c07:	00 
    1c08:	eb 23                	jmp    1c2d <azx_send_cmd+0xfb>
    1c0a:	bf c7 10 00 00       	mov    $0x10c7,%edi
    1c0f:	e8 00 00 00 00       	callq  1c14 <azx_send_cmd+0xe2>
azx_command_addr():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:590
    1c14:	41 ff cd             	dec    %r13d
    1c17:	41 83 fd ff          	cmp    $0xffffffffffffffff,%r13d
spin_lock_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/spinlock.h:310
    1c1b:	0f 85 63 ff ff ff    	jne    1b84 <azx_send_cmd+0x52>
readb():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:56
    1c21:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
azx_corb_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:620
    1c28:	e8 00 00 00 00       	callq  1c2d <azx_send_cmd+0xfb>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:624
    1c2d:	b8 fb ff ff ff       	mov    $0xfffffffb,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:621
    1c32:	eb 4a                	jmp    1c7e <azx_send_cmd+0x14c>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:625
    1c34:	48 8d 7b 44          	lea    0x44(%rbx),%rdi
    1c38:	83 fd 08             	cmp    $0x8,%ebp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:622
    1c3b:	0f 43 e8             	cmovae %eax,%ebp
    1c3e:	e8 00 00 00 00       	callq  1c43 <azx_send_cmd+0x111>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:625
    1c43:	48 8b 43 38          	mov    0x38(%rbx),%rax
writel():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:66
    1c47:	8a 40 48             	mov    0x48(%rax),%al
    1c4a:	89 ed                	mov    %ebp,%ebp
    1c4c:	0f b6 c0             	movzbl %al,%eax
__ticket_spin_unlock():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/spinlock.h:154
    1c4f:	ff 84 ab 44 01 00 00 	incl   0x144(%rbx,%rbp,4)
arch_local_irq_enable():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/paravirt.h:868
    1c56:	ff c0                	inc    %eax
    1c58:	48 8b 93 d8 00 00 00 	mov    0xd8(%rbx),%rdx
azx_send_cmd():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:848
    1c5f:	25 ff 00 00 00       	and    $0xff,%eax
azx_halt():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2234
    1c64:	89 c1                	mov    %eax,%ecx
    1c66:	44 89 24 8a          	mov    %r12d,(%rdx,%rcx,4)
    1c6a:	48 8b 53 38          	mov    0x38(%rbx),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2235
    1c6e:	89 42 48             	mov    %eax,0x48(%rdx)
    1c71:	66 ff 43 44          	incw   0x44(%rbx)
    1c75:	ff 14 25 00 00 00 00 	callq  *0x0
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2236
    1c7c:	31 c0                	xor    %eax,%eax
    1c7e:	41 5a                	pop    %r10
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2238
    1c80:	5b                   	pop    %rbx
    1c81:	5d                   	pop    %rbp
    1c82:	41 5c                	pop    %r12
    1c84:	41 5d                	pop    %r13
kzalloc():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/slab.h:319
    1c86:	c3                   	retq   

0000000000001c87 <azx_halt>:
    1c87:	53                   	push   %rbx
    1c88:	48 8d 9f c8 fd ff ff 	lea    -0x238(%rdi),%rbx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/slab.h:322
    1c8f:	48 8b bf 90 fe ff ff 	mov    -0x170(%rdi),%rdi
azx_attach_pcm_stream():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2018
    1c96:	e8 00 00 00 00       	callq  1c9b <azx_halt+0x14>
    1c9b:	48 89 df             	mov    %rbx,%rdi
    1c9e:	e8 d7 ee ff ff       	callq  b7a <azx_stop_chip>
    1ca3:	b8 01 00 00 00       	mov    $0x1,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2022
    1ca8:	5b                   	pop    %rbx
    1ca9:	c3                   	retq   

0000000000001caa <T.729>:
    1caa:	48 83 ec 08          	sub    $0x8,%rsp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2019
    1cae:	be d0 80 00 00       	mov    $0x80d0,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2025
    1cb3:	58                   	pop    %rax
    1cb4:	e9 00 00 00 00       	jmpq   1cb9 <azx_attach_pcm_stream>

0000000000001cb9 <azx_attach_pcm_stream>:
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2026
    1cb9:	41 56                	push   %r14
    1cbb:	41 55                	push   %r13
    1cbd:	49 89 f5             	mov    %rsi,%r13
    1cc0:	41 54                	push   %r12
    1cc2:	55                   	push   %rbp
    1cc3:	53                   	push   %rbx
    1cc4:	48 89 d3             	mov    %rdx,%rbx
    1cc7:	48 83 ec 10          	sub    $0x10,%rsp
    1ccb:	44 8b a2 9c 00 00 00 	mov    0x9c(%rdx),%r12d
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2028
    1cd2:	48 8b 6f 08          	mov    0x8(%rdi),%rbp
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2030
    1cd6:	41 83 fc 09          	cmp    $0x9,%r12d
    1cda:	7e 1b                	jle    1cf7 <azx_attach_pcm_stream+0x3e>
    1cdc:	44 89 e6             	mov    %r12d,%esi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2031
    1cdf:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1ce6:	31 c0                	xor    %eax,%eax
    1ce8:	e8 00 00 00 00       	callq  1ced <azx_attach_pcm_stream+0x34>
    1ced:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
    1cf2:	e9 36 01 00 00       	jmpq   1e2d <azx_attach_pcm_stream+0x174>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2032
    1cf7:	49 63 c4             	movslq %r12d,%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2034
    1cfa:	48 83 7c c5 70 00    	cmpq   $0x0,0x70(%rbp,%rax,8)
    1d00:	74 1b                	je     1d1d <azx_attach_pcm_stream+0x64>
    1d02:	44 89 e6             	mov    %r12d,%esi
    1d05:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1d0c:	31 c0                	xor    %eax,%eax
    1d0e:	e8 00 00 00 00       	callq  1d13 <azx_attach_pcm_stream+0x5a>
    1d13:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2038
    1d18:	e9 10 01 00 00       	jmpq   1e2d <azx_attach_pcm_stream+0x174>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2040
    1d1d:	8b 4a 08             	mov    0x8(%rdx),%ecx
    1d20:	44 8b 42 50          	mov    0x50(%rdx),%r8d
    1d24:	4c 8d 4c 24 08       	lea    0x8(%rsp),%r9
    1d29:	48 8b 33             	mov    (%rbx),%rsi
    1d2c:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
    1d30:	44 89 e2             	mov    %r12d,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2041
    1d33:	e8 00 00 00 00       	callq  1d38 <azx_attach_pcm_stream+0x7f>
    1d38:	85 c0                	test   %eax,%eax
    1d3a:	0f 88 ed 00 00 00    	js     1e2d <azx_attach_pcm_stream+0x174>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2042
    1d40:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    1d45:	48 8b 33             	mov    (%rbx),%rsi
    1d48:	ba 50 00 00 00       	mov    $0x50,%edx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2044
    1d4d:	48 83 c7 64          	add    $0x64,%rdi
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2045
    1d51:	e8 00 00 00 00       	callq  1d56 <azx_attach_pcm_stream+0x9d>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2046
    1d56:	bf 20 00 00 00       	mov    $0x20,%edi
    1d5b:	e8 4a ff ff ff       	callq  1caa <T.729>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2047
    1d60:	49 89 c6             	mov    %rax,%r14
    1d63:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
    1d68:	4d 85 f6             	test   %r14,%r14
    1d6b:	0f 84 bc 00 00 00    	je     1e2d <azx_attach_pcm_stream+0x174>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2048
    1d71:	49 89 2e             	mov    %rbp,(%r14)
    1d74:	4d 89 6e 08          	mov    %r13,0x8(%r14)
    1d78:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2049
    1d7d:	4c 89 b0 b0 01 00 00 	mov    %r14,0x1b0(%rax)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2050
    1d84:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    1d89:	48 c7 80 b8 01 00 00 	movq   $0x0,0x1b8(%rax)
    1d90:	00 00 00 00 
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2051
    1d94:	83 bb 98 00 00 00 03 	cmpl   $0x3,0x98(%rbx)
    1d9b:	75 0b                	jne    1da8 <azx_attach_pcm_stream+0xef>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2053
    1d9d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    1da2:	66 c7 40 20 02 00    	movw   $0x2,0x20(%rax)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2054
    1da8:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2055
    1dad:	4d 63 e4             	movslq %r12d,%r12
    1db0:	4a 89 44 e5 70       	mov    %rax,0x70(%rbp,%r12,8)
    1db5:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    1dba:	48 89 83 a0 00 00 00 	mov    %rax,0xa0(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2053
    1dc1:	48 8d 43 08          	lea    0x8(%rbx),%rax
    1dc5:	49 89 46 10          	mov    %rax,0x10(%r14)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2054
    1dc9:	83 7b 08 00          	cmpl   $0x0,0x8(%rbx)
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2055
    1dcd:	74 13                	je     1de2 <azx_attach_pcm_stream+0x129>
    1dcf:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    1dd4:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
    1ddb:	31 f6                	xor    %esi,%esi
    1ddd:	e8 00 00 00 00       	callq  1de2 <azx_attach_pcm_stream+0x129>
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2058
    1de2:	48 8d 43 50          	lea    0x50(%rbx),%rax
    1de6:	49 89 46 18          	mov    %rax,0x18(%r14)
    1dea:	83 7b 50 00          	cmpl   $0x0,0x50(%rbx)
    1dee:	74 16                	je     1e06 <azx_attach_pcm_stream+0x14d>
    1df0:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    1df5:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
    1dfc:	be 01 00 00 00       	mov    $0x1,%esi
    1e01:	e8 00 00 00 00       	callq  1e06 <azx_attach_pcm_stream+0x14d>
    1e06:	48 8b 55 08          	mov    0x8(%rbp),%rdx
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:2062
    1e0a:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    1e0f:	41 b8 00 00 00 02    	mov    $0x2000000,%r8d
    1e15:	b9 00 00 01 00       	mov    $0x10000,%ecx
    1e1a:	be 03 00 00 00       	mov    $0x3,%esi
    1e1f:	48 81 c2 90 00 00 00 	add    $0x90,%rdx
    1e26:	e8 00 00 00 00       	callq  1e2b <azx_attach_pcm_stream+0x172>
    1e2b:	31 c0                	xor    %eax,%eax
    1e2d:	5a                   	pop    %rdx
    1e2e:	59                   	pop    %rcx
    1e2f:	5b                   	pop    %rbx
    1e30:	5d                   	pop    %rbp
    1e31:	41 5c                	pop    %r12
    1e33:	41 5d                	pop    %r13
    1e35:	41 5e                	pop    %r14
    1e37:	c3                   	retq   

Disassembly of section .exit.text:

0000000000000000 <cleanup_module>:
cleanup_module():
   0:	48 83 ec 08          	sub    $0x8,%rsp
   4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
   b:	58                   	pop    %rax
   c:	e9 00 00 00 00       	jmpq   11 <beep_mode+0x1>

Disassembly of section .devexit.text:

0000000000000000 <azx_remove>:
azx_remove():
   0:	53                   	push   %rbx
   1:	48 8d 9f 90 00 00 00 	lea    0x90(%rdi),%rbx
   8:	48 89 df             	mov    %rbx,%rdi
   b:	e8 00 00 00 00       	callq  10 <azx_remove+0x10>
  10:	48 89 c7             	mov    %rax,%rdi
  13:	e8 00 00 00 00       	callq  18 <azx_remove+0x18>
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	31 f6                	xor    %esi,%esi
  1d:	5b                   	pop    %rbx
  1e:	e9 00 00 00 00       	jmpq   23 <__param_power_save+0x3>

Disassembly of section .devinit.text:

0000000000000000 <azx_codec_create>:
azx_codec_create():
   0:	41 57                	push   %r15
   2:	31 c0                	xor    %eax,%eax
   4:	b9 14 00 00 00       	mov    $0x14,%ecx
   9:	48 89 f2             	mov    %rsi,%rdx
   c:	41 56                	push   %r14
   e:	41 55                	push   %r13
  10:	41 54                	push   %r12
  12:	55                   	push   %rbp
  13:	53                   	push   %rbx
  14:	48 89 fb             	mov    %rdi,%rbx
  17:	48 83 ec 68          	sub    $0x68,%rsp
  1b:	48 89 e7             	mov    %rsp,%rdi
  1e:	48 89 e6             	mov    %rsp,%rsi
  21:	f3 ab                	rep stos %eax,%es:(%rdi)
  23:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  28:	48 8d 93 c8 00 00 00 	lea    0xc8(%rbx),%rdx
  2f:	48 89 1c 24          	mov    %rbx,(%rsp)
  33:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
  3a:	00 00 
  3c:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
  43:	00 00 
  45:	48 8b 43 08          	mov    0x8(%rbx),%rax
  49:	48 8b 3b             	mov    (%rbx),%rdi
  4c:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
  53:	00 00 
  55:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
  5c:	00 00 
  5e:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
  65:	00 00 
  67:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
  6e:	00 00 
  70:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  75:	e8 00 00 00 00       	callq  7a <azx_codec_create+0x7a>
  7a:	85 c0                	test   %eax,%eax
  7c:	0f 88 6c 01 00 00    	js     1ee <azx_codec_create+0x1ee>
  82:	83 7b 14 08          	cmpl   $0x8,0x14(%rbx)
  86:	75 0e                	jne    96 <azx_codec_create+0x96>
  88:	48 8b 83 c8 00 00 00 	mov    0xc8(%rbx),%rax
  8f:	80 88 68 01 00 00 01 	orb    $0x1,0x168(%rax)
  96:	48 63 43 14          	movslq 0x14(%rbx),%rax
  9a:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  a0:	8b 2c 85 00 00 00 00 	mov    0x0(,%rax,4),%ebp
  a7:	b8 04 00 00 00       	mov    $0x4,%eax
  ac:	85 ed                	test   %ebp,%ebp
  ae:	0f 44 e8             	cmove  %eax,%ebp
  b1:	45 31 ed             	xor    %r13d,%r13d
  b4:	e9 b6 00 00 00       	jmpq   16f <azx_codec_create+0x16f>
  b9:	0f b7 83 c0 00 00 00 	movzwl 0xc0(%rbx),%eax
  c0:	45 89 e6             	mov    %r12d,%r14d
  c3:	44 88 e9             	mov    %r13b,%cl
  c6:	23 83 c4 00 00 00    	and    0xc4(%rbx),%eax
  cc:	41 d3 e6             	shl    %cl,%r14d
  cf:	44 85 f0             	test   %r14d,%eax
  d2:	0f 84 94 00 00 00    	je     16c <azx_codec_create+0x16c>
  d8:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
  df:	48 81 c7 e8 00 00 00 	add    $0xe8,%rdi
  e6:	e8 00 00 00 00       	callq  eb <azx_codec_create+0xeb>
  eb:	80 8b f4 01 00 00 40 	orb    $0x40,0x1f4(%rbx)
  f2:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
  f9:	44 89 ee             	mov    %r13d,%esi
  fc:	c1 e6 1c             	shl    $0x1c,%esi
  ff:	81 ce 00 00 0f 00    	or     $0xf0000,%esi
 105:	e8 00 00 00 00       	callq  10a <azx_codec_create+0x10a>
 10a:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
 111:	44 89 ee             	mov    %r13d,%esi
 114:	e8 00 00 00 00       	callq  119 <azx_codec_create+0x119>
 119:	80 a3 f4 01 00 00 bf 	andb   $0xbf,0x1f4(%rbx)
 120:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
 127:	41 89 c7             	mov    %eax,%r15d
 12a:	48 81 c7 e8 00 00 00 	add    $0xe8,%rdi
 131:	e8 00 00 00 00       	callq  136 <azx_codec_create+0x136>
 136:	41 ff c7             	inc    %r15d
 139:	75 31                	jne    16c <azx_codec_create+0x16c>
 13b:	44 89 ee             	mov    %r13d,%esi
 13e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 145:	31 c0                	xor    %eax,%eax
 147:	e8 00 00 00 00       	callq  14c <azx_codec_create+0x14c>
 14c:	41 f7 d6             	not    %r14d
 14f:	66 44 21 b3 c0 00 00 	and    %r14w,0xc0(%rbx)
 156:	00 
 157:	48 89 df             	mov    %rbx,%rdi
 15a:	e8 00 00 00 00       	callq  15f <azx_codec_create+0x15f>
 15f:	be 01 00 00 00       	mov    $0x1,%esi
 164:	48 89 df             	mov    %rbx,%rdi
 167:	e8 00 00 00 00       	callq  16c <azx_codec_create+0x16c>
 16c:	41 ff c5             	inc    %r13d
 16f:	41 39 ed             	cmp    %ebp,%r13d
 172:	0f 8c 41 ff ff ff    	jl     b9 <azx_codec_create+0xb9>
 178:	45 31 e4             	xor    %r12d,%r12d
 17b:	45 31 ff             	xor    %r15d,%r15d
 17e:	41 be 01 00 00 00    	mov    $0x1,%r14d
 184:	4c 8d 6c 24 58       	lea    0x58(%rsp),%r13
 189:	eb 46                	jmp    1d1 <azx_codec_create+0x1d1>
 18b:	0f b7 83 c0 00 00 00 	movzwl 0xc0(%rbx),%eax
 192:	44 89 f2             	mov    %r14d,%edx
 195:	44 88 f9             	mov    %r15b,%cl
 198:	23 83 c4 00 00 00    	and    0xc4(%rbx),%eax
 19e:	d3 e2                	shl    %cl,%edx
 1a0:	85 d0                	test   %edx,%eax
 1a2:	74 2a                	je     1ce <azx_codec_create+0x1ce>
 1a4:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
 1ab:	4c 89 ea             	mov    %r13,%rdx
 1ae:	44 89 fe             	mov    %r15d,%esi
 1b1:	e8 00 00 00 00       	callq  1b6 <azx_codec_create+0x1b6>
 1b6:	85 c0                	test   %eax,%eax
 1b8:	78 14                	js     1ce <azx_codec_create+0x1ce>
 1ba:	8b 93 d0 00 00 00    	mov    0xd0(%rbx),%edx
 1c0:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
 1c5:	41 ff c4             	inc    %r12d
 1c8:	89 90 c8 00 00 00    	mov    %edx,0xc8(%rax)
 1ce:	41 ff c7             	inc    %r15d
 1d1:	41 39 ef             	cmp    %ebp,%r15d
 1d4:	7c b5                	jl     18b <azx_codec_create+0x18b>
 1d6:	31 c0                	xor    %eax,%eax
 1d8:	45 85 e4             	test   %r12d,%r12d
 1db:	75 11                	jne    1ee <azx_codec_create+0x1ee>
 1dd:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 1e4:	e8 00 00 00 00       	callq  1e9 <azx_codec_create+0x1e9>
 1e9:	b8 fa ff ff ff       	mov    $0xfffffffa,%eax
 1ee:	48 83 c4 68          	add    $0x68,%rsp
 1f2:	5b                   	pop    %rbx
 1f3:	5d                   	pop    %rbp
 1f4:	41 5c                	pop    %r12
 1f6:	41 5d                	pop    %r13
 1f8:	41 5e                	pop    %r14
 1fa:	41 5f                	pop    %r15
 1fc:	c3                   	retq   

00000000000001fd <azx_probe>:
azx_probe():
 1fd:	41 57                	push   %r15
 1ff:	41 56                	push   %r14
 201:	41 be ed ff ff ff    	mov    $0xffffffed,%r14d
 207:	41 55                	push   %r13
 209:	41 54                	push   %r12
 20b:	55                   	push   %rbp
 20c:	48 89 fd             	mov    %rdi,%rbp
 20f:	53                   	push   %rbx
 210:	48 89 f3             	mov    %rsi,%rbx
 213:	48 83 ec 28          	sub    $0x28,%rsp
 217:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 21d <azx_probe+0x20>
 21d:	83 fa 1f             	cmp    $0x1f,%edx
 220:	0f 8f 35 08 00 00    	jg     a5b <azx_probe+0x85e>
 226:	48 63 c2             	movslq %edx,%rax
 229:	83 3c 85 00 00 00 00 	cmpl   $0x0,0x0(,%rax,4)
 230:	00 
 231:	75 13                	jne    246 <azx_probe+0x49>
 233:	ff c2                	inc    %edx
 235:	41 be fe ff ff ff    	mov    $0xfffffffe,%r14d
 23b:	89 15 00 00 00 00    	mov    %edx,0x0(%rip)        # 241 <azx_probe+0x44>
 241:	e9 15 08 00 00       	jmpq   a5b <azx_probe+0x85e>
 246:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 24d:	00 
 24e:	8b 3c 85 00 00 00 00 	mov    0x0(,%rax,4),%edi
 255:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
 25a:	31 c9                	xor    %ecx,%ecx
 25c:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
 263:	e8 00 00 00 00       	callq  268 <azx_probe+0x6b>
 268:	85 c0                	test   %eax,%eax
 26a:	41 89 c6             	mov    %eax,%r14d
 26d:	79 13                	jns    282 <azx_probe+0x85>
 26f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 276:	31 c0                	xor    %eax,%eax
 278:	e8 00 00 00 00       	callq  27d <azx_probe+0x80>
 27d:	e9 d9 07 00 00       	jmpq   a5b <azx_probe+0x85e>
 282:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 287:	4c 8d bd 90 00 00 00 	lea    0x90(%rbp),%r15
 28e:	48 89 ef             	mov    %rbp,%rdi
 291:	4c 89 b8 40 02 00 00 	mov    %r15,0x240(%rax)
 298:	48 8b 5b 18          	mov    0x18(%rbx),%rbx
 29c:	44 8b 2d 00 00 00 00 	mov    0x0(%rip),%r13d        # 2a3 <azx_probe+0xa6>
 2a3:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
 2a8:	48 89 1c 24          	mov    %rbx,(%rsp)
 2ac:	e8 00 00 00 00       	callq  2b1 <azx_probe+0xb4>
 2b1:	85 c0                	test   %eax,%eax
 2b3:	41 89 c6             	mov    %eax,%r14d
 2b6:	0f 88 95 07 00 00    	js     a51 <azx_probe+0x854>
 2bc:	bf 50 02 00 00       	mov    $0x250,%edi
 2c1:	e8 00 00 00 00       	callq  2c6 <azx_probe+0xc9>
 2c6:	48 85 c0             	test   %rax,%rax
 2c9:	48 89 c3             	mov    %rax,%rbx
 2cc:	75 21                	jne    2ef <azx_probe+0xf2>
 2ce:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 2d5:	31 c0                	xor    %eax,%eax
 2d7:	41 be f4 ff ff ff    	mov    $0xfffffff4,%r14d
 2dd:	e8 00 00 00 00       	callq  2e2 <azx_probe+0xe5>
 2e2:	48 89 ef             	mov    %rbp,%rdi
 2e5:	e8 00 00 00 00       	callq  2ea <azx_probe+0xed>
 2ea:	e9 62 07 00 00       	jmpq   a51 <azx_probe+0x854>
 2ef:	48 8d 78 48          	lea    0x48(%rax),%rdi
 2f3:	c7 40 44 00 00 00 00 	movl   $0x0,0x44(%rax)
 2fa:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
 301:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 308:	e8 00 00 00 00       	callq  30d <azx_probe+0x110>
 30d:	4c 89 23             	mov    %r12,(%rbx)
 310:	48 89 6b 08          	mov    %rbp,0x8(%rbx)
 314:	c7 43 40 ff ff ff ff 	movl   $0xffffffff,0x40(%rbx)
 31b:	8b 04 24             	mov    (%rsp),%eax
 31e:	89 43 14             	mov    %eax,0x14(%rbx)
 321:	83 3d 00 00 00 00 00 	cmpl   $0x0,0x0(%rip)        # 328 <azx_probe+0x12b>
 328:	8a 83 f4 01 00 00    	mov    0x1f4(%rbx),%al
 32e:	7c 08                	jl     338 <azx_probe+0x13b>
 330:	0f 95 c2             	setne  %dl
 333:	c1 e2 04             	shl    $0x4,%edx
 336:	eb 48                	jmp    380 <azx_probe+0x183>
 338:	83 c8 10             	or     $0x10,%eax
 33b:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 342:	48 89 ef             	mov    %rbp,%rdi
 345:	88 83 f4 01 00 00    	mov    %al,0x1f4(%rbx)
 34b:	e8 00 00 00 00       	callq  350 <azx_probe+0x153>
 350:	48 85 c0             	test   %rax,%rax
 353:	49 89 c6             	mov    %rax,%r14
 356:	74 35                	je     38d <azx_probe+0x190>
 358:	0f b7 50 02          	movzwl 0x2(%rax),%edx
 35c:	0f b7 30             	movzwl (%rax),%esi
 35f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 366:	8b 48 08             	mov    0x8(%rax),%ecx
 369:	31 c0                	xor    %eax,%eax
 36b:	e8 00 00 00 00       	callq  370 <azx_probe+0x173>
 370:	41 8b 56 08          	mov    0x8(%r14),%edx
 374:	8a 83 f4 01 00 00    	mov    0x1f4(%rbx),%al
 37a:	83 e2 01             	and    $0x1,%edx
 37d:	c1 e2 04             	shl    $0x4,%edx
 380:	83 e0 ef             	and    $0xffffffffffffffef,%eax
 383:	09 d0                	or     %edx,%eax
 385:	88 83 f4 01 00 00    	mov    %al,0x1f4(%rbx)
 38b:	eb 1b                	jmp    3a8 <azx_probe+0x1ab>
 38d:	83 7b 14 08          	cmpl   $0x8,0x14(%rbx)
 391:	75 15                	jne    3a8 <azx_probe+0x1ab>
 393:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 39a:	31 c0                	xor    %eax,%eax
 39c:	e8 00 00 00 00       	callq  3a1 <azx_probe+0x1a4>
 3a1:	80 a3 f4 01 00 00 ef 	andb   $0xef,0x1f4(%rbx)
 3a8:	48 8d 83 20 02 00 00 	lea    0x220(%rbx),%rax
 3af:	44 89 6b 10          	mov    %r13d,0x10(%rbx)
 3b3:	48 c7 83 18 02 00 00 	movq   $0x20100,0x218(%rbx)
 3ba:	00 01 02 00 
 3be:	48 c7 83 30 02 00 00 	movq   $0x0,0x230(%rbx)
 3c5:	00 00 00 00 
 3c9:	48 89 83 20 02 00 00 	mov    %rax,0x220(%rbx)
 3d0:	48 89 83 28 02 00 00 	mov    %rax,0x228(%rbx)
 3d7:	49 63 c5             	movslq %r13d,%rax
 3da:	8b 04 85 00 00 00 00 	mov    0x0(,%rax,4),%eax
 3e1:	8d 50 ff             	lea    -0x1(%rax),%edx
 3e4:	83 fa 02             	cmp    $0x2,%edx
 3e7:	76 51                	jbe    43a <azx_probe+0x23d>
 3e9:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
 3ed:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 3f4:	e8 00 00 00 00       	callq  3f9 <azx_probe+0x1fc>
 3f9:	48 85 c0             	test   %rax,%rax
 3fc:	49 89 c6             	mov    %rax,%r14
 3ff:	74 1e                	je     41f <azx_probe+0x222>
 401:	0f b7 48 02          	movzwl 0x2(%rax),%ecx
 405:	0f b7 10             	movzwl (%rax),%edx
 408:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 40f:	8b 70 08             	mov    0x8(%rax),%esi
 412:	31 c0                	xor    %eax,%eax
 414:	e8 00 00 00 00       	callq  419 <azx_probe+0x21c>
 419:	41 8b 46 08          	mov    0x8(%r14),%eax
 41d:	eb 1b                	jmp    43a <azx_probe+0x23d>
 41f:	8b 53 14             	mov    0x14(%rbx),%edx
 422:	31 c0                	xor    %eax,%eax
 424:	8d 4a fd             	lea    -0x3(%rdx),%ecx
 427:	83 f9 02             	cmp    $0x2,%ecx
 42a:	77 0e                	ja     43a <azx_probe+0x23d>
 42c:	48 63 d2             	movslq %edx,%rdx
 42f:	48 83 ea 03          	sub    $0x3,%rdx
 433:	8b 04 95 00 00 00 00 	mov    0x0(,%rdx,4),%eax
 43a:	89 83 ec 01 00 00    	mov    %eax,0x1ec(%rbx)
 440:	89 83 e8 01 00 00    	mov    %eax,0x1e8(%rbx)
 446:	49 63 c5             	movslq %r13d,%rax
 449:	8b 04 85 00 00 00 00 	mov    0x0(,%rax,4),%eax
 450:	89 83 c4 00 00 00    	mov    %eax,0xc4(%rbx)
 456:	ff c0                	inc    %eax
 458:	75 3a                	jne    494 <azx_probe+0x297>
 45a:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
 45e:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 465:	e8 00 00 00 00       	callq  46a <azx_probe+0x26d>
 46a:	48 85 c0             	test   %rax,%rax
 46d:	49 89 c6             	mov    %rax,%r14
 470:	74 22                	je     494 <azx_probe+0x297>
 472:	0f b7 48 02          	movzwl 0x2(%rax),%ecx
 476:	0f b7 10             	movzwl (%rax),%edx
 479:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 480:	8b 70 08             	mov    0x8(%rax),%esi
 483:	31 c0                	xor    %eax,%eax
 485:	e8 00 00 00 00       	callq  48a <azx_probe+0x28d>
 48a:	41 8b 46 08          	mov    0x8(%r14),%eax
 48e:	89 83 c4 00 00 00    	mov    %eax,0xc4(%rbx)
 494:	8b b3 c4 00 00 00    	mov    0xc4(%rbx),%esi
 49a:	83 fe ff             	cmp    $0xffffffffffffffff,%esi
 49d:	74 25                	je     4c4 <azx_probe+0x2c7>
 49f:	f7 c6 00 01 00 00    	test   $0x100,%esi
 4a5:	74 1d                	je     4c4 <azx_probe+0x2c7>
 4a7:	66 81 e6 ff 00       	and    $0xff,%si
 4ac:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 4b3:	31 c0                	xor    %eax,%eax
 4b5:	66 89 b3 c0 00 00 00 	mov    %si,0xc0(%rbx)
 4bc:	0f b7 f6             	movzwl %si,%esi
 4bf:	e8 00 00 00 00       	callq  4c4 <azx_probe+0x2c7>
 4c4:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 4ca <azx_probe+0x2cd>
 4ca:	8a 83 f4 01 00 00    	mov    0x1f4(%rbx),%al
 4d0:	83 e2 01             	and    $0x1,%edx
 4d3:	83 e0 fb             	and    $0xfffffffffffffffb,%eax
 4d6:	c1 e2 02             	shl    $0x2,%edx
 4d9:	09 d0                	or     %edx,%eax
 4db:	49 63 d5             	movslq %r13d,%rdx
 4de:	88 83 f4 01 00 00    	mov    %al,0x1f4(%rbx)
 4e4:	83 3c 95 00 00 00 00 	cmpl   $0x0,0x0(,%rdx,4)
 4eb:	00 
 4ec:	79 15                	jns    503 <azx_probe+0x306>
 4ee:	8b 43 14             	mov    0x14(%rbx),%eax
 4f1:	83 f8 02             	cmp    $0x2,%eax
 4f4:	19 c0                	sbb    %eax,%eax
 4f6:	83 e0 e1             	and    $0xffffffffffffffe1,%eax
 4f9:	83 c0 20             	add    $0x20,%eax
 4fc:	89 04 95 00 00 00 00 	mov    %eax,0x0(,%rdx,4)
 503:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 50a:	48 89 ef             	mov    %rbp,%rdi
 50d:	e8 00 00 00 00       	callq  512 <azx_probe+0x315>
 512:	85 c0                	test   %eax,%eax
 514:	41 89 c6             	mov    %eax,%r14d
 517:	79 15                	jns    52e <azx_probe+0x331>
 519:	48 89 df             	mov    %rbx,%rdi
 51c:	e8 00 00 00 00       	callq  521 <azx_probe+0x324>
 521:	48 89 ef             	mov    %rbp,%rdi
 524:	e8 00 00 00 00       	callq  529 <azx_probe+0x32c>
 529:	e9 23 05 00 00       	jmpq   a51 <azx_probe+0x854>
 52e:	48 8b 85 e8 02 00 00 	mov    0x2e8(%rbp),%rax
 535:	31 f6                	xor    %esi,%esi
 537:	48 89 ef             	mov    %rbp,%rdi
 53a:	48 89 43 30          	mov    %rax,0x30(%rbx)
 53e:	e8 00 00 00 00       	callq  543 <azx_probe+0x346>
 543:	48 85 c0             	test   %rax,%rax
 546:	48 89 43 38          	mov    %rax,0x38(%rbx)
 54a:	75 17                	jne    563 <azx_probe+0x366>
 54c:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 553:	41 be fa ff ff ff    	mov    $0xfffffffa,%r14d
 559:	e8 00 00 00 00       	callq  55e <azx_probe+0x361>
 55e:	e9 64 03 00 00       	jmpq   8c7 <azx_probe+0x6ca>
 563:	f6 83 f4 01 00 00 10 	testb  $0x10,0x1f4(%rbx)
 56a:	74 18                	je     584 <azx_probe+0x387>
 56c:	be 01 00 00 00       	mov    $0x1,%esi
 571:	48 89 ef             	mov    %rbp,%rdi
 574:	e8 00 00 00 00       	callq  579 <azx_probe+0x37c>
 579:	85 c0                	test   %eax,%eax
 57b:	79 07                	jns    584 <azx_probe+0x387>
 57d:	80 a3 f4 01 00 00 ef 	andb   $0xef,0x1f4(%rbx)
 584:	31 f6                	xor    %esi,%esi
 586:	48 89 df             	mov    %rbx,%rdi
 589:	e8 00 00 00 00       	callq  58e <azx_probe+0x391>
 58e:	85 c0                	test   %eax,%eax
 590:	0f 88 2b 03 00 00    	js     8c1 <azx_probe+0x6c4>
 596:	48 89 ef             	mov    %rbp,%rdi
 599:	e8 00 00 00 00       	callq  59e <azx_probe+0x3a1>
 59e:	8b 7b 40             	mov    0x40(%rbx),%edi
 5a1:	e8 00 00 00 00       	callq  5a6 <azx_probe+0x3a9>
 5a6:	48 8b 43 38          	mov    0x38(%rbx),%rax
 5aa:	66 8b 10             	mov    (%rax),%dx
 5ad:	66 89 14 24          	mov    %dx,(%rsp)
 5b1:	8b 43 14             	mov    0x14(%rbx),%eax
 5b4:	83 e8 03             	sub    $0x3,%eax
 5b7:	83 f8 01             	cmp    $0x1,%eax
 5ba:	77 32                	ja     5ee <azx_probe+0x3f1>
 5bc:	31 d2                	xor    %edx,%edx
 5be:	be 85 43 00 00       	mov    $0x4385,%esi
 5c3:	bf 02 10 00 00       	mov    $0x1002,%edi
 5c8:	e8 00 00 00 00       	callq  5cd <azx_probe+0x3d0>
 5cd:	48 85 c0             	test   %rax,%rax
 5d0:	74 1c                	je     5ee <azx_probe+0x3f1>
 5d2:	8b 14 24             	mov    (%rsp),%edx
 5d5:	8b 0c 24             	mov    (%rsp),%ecx
 5d8:	48 89 c7             	mov    %rax,%rdi
 5db:	83 e2 fe             	and    $0xfffffffffffffffe,%edx
 5de:	80 78 48 2f          	cmpb   $0x2f,0x48(%rax)
 5e2:	0f 46 ca             	cmovbe %edx,%ecx
 5e5:	66 89 0c 24          	mov    %cx,(%rsp)
 5e9:	e8 00 00 00 00       	callq  5ee <azx_probe+0x3f1>
 5ee:	8b 04 24             	mov    (%rsp),%eax
 5f1:	8b 14 24             	mov    (%rsp),%edx
 5f4:	83 e0 fe             	and    $0xfffffffffffffffe,%eax
 5f7:	83 7b 14 09          	cmpl   $0x9,0x14(%rbx)
 5fb:	0f 44 d0             	cmove  %eax,%edx
 5fe:	66 89 14 24          	mov    %dx,(%rsp)
 602:	80 e2 01             	and    $0x1,%dl
 605:	74 2d                	je     634 <azx_probe+0x437>
 607:	48 83 ce ff          	or     $0xffffffffffffffff,%rsi
 60b:	4c 89 ff             	mov    %r15,%rdi
 60e:	e8 00 00 00 00       	callq  613 <azx_probe+0x416>
 613:	85 c0                	test   %eax,%eax
 615:	75 1d                	jne    634 <azx_probe+0x437>
 617:	48 83 ce ff          	or     $0xffffffffffffffff,%rsi
 61b:	4c 89 ff             	mov    %r15,%rdi
 61e:	e8 00 00 00 00       	callq  623 <azx_probe+0x426>
 623:	85 c0                	test   %eax,%eax
 625:	74 37                	je     65e <azx_probe+0x461>
 627:	48 c7 85 50 02 00 00 	movq   $0xffffffffffffffff,0x250(%rbp)
 62e:	ff ff ff ff 
 632:	eb 2a                	jmp    65e <azx_probe+0x461>
 634:	be ff ff ff ff       	mov    $0xffffffff,%esi
 639:	4c 89 ff             	mov    %r15,%rdi
 63c:	e8 00 00 00 00       	callq  641 <azx_probe+0x444>
 641:	be ff ff ff ff       	mov    $0xffffffff,%esi
 646:	4c 89 ff             	mov    %r15,%rdi
 649:	e8 00 00 00 00       	callq  64e <azx_probe+0x451>
 64e:	85 c0                	test   %eax,%eax
 650:	74 0c                	je     65e <azx_probe+0x461>
 652:	be ff ff ff ff       	mov    $0xffffffff,%esi
 657:	48 89 b5 50 02 00 00 	mov    %rsi,0x250(%rbp)
 65e:	8b 0c 24             	mov    (%rsp),%ecx
 661:	89 ca                	mov    %ecx,%edx
 663:	0f b6 c5             	movzbl %ch,%eax
 666:	66 c1 ea 0c          	shr    $0xc,%dx
 66a:	83 e0 0f             	and    $0xf,%eax
 66d:	0f b7 d2             	movzwl %dx,%edx
 670:	89 43 20             	mov    %eax,0x20(%rbx)
 673:	85 d2                	test   %edx,%edx
 675:	89 53 18             	mov    %edx,0x18(%rbx)
 678:	75 3f                	jne    6b9 <azx_probe+0x4bc>
 67a:	85 c0                	test   %eax,%eax
 67c:	75 3b                	jne    6b9 <azx_probe+0x4bc>
 67e:	8b 43 14             	mov    0x14(%rbx),%eax
 681:	83 f8 04             	cmp    $0x4,%eax
 684:	74 15                	je     69b <azx_probe+0x49e>
 686:	83 f8 07             	cmp    $0x7,%eax
 689:	75 20                	jne    6ab <azx_probe+0x4ae>
 68b:	c7 43 18 06 00 00 00 	movl   $0x6,0x18(%rbx)
 692:	c7 43 20 05 00 00 00 	movl   $0x5,0x20(%rbx)
 699:	eb 1e                	jmp    6b9 <azx_probe+0x4bc>
 69b:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%rbx)
 6a2:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%rbx)
 6a9:	eb 0e                	jmp    6b9 <azx_probe+0x4bc>
 6ab:	c7 43 18 04 00 00 00 	movl   $0x4,0x18(%rbx)
 6b2:	c7 43 20 04 00 00 00 	movl   $0x4,0x20(%rbx)
 6b9:	8b 7b 20             	mov    0x20(%rbx),%edi
 6bc:	48 ba ff ff ff ff ff 	movabs $0x1ffffffffffffff,%rdx
 6c3:	ff ff 01 
 6c6:	31 c0                	xor    %eax,%eax
 6c8:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%rbx)
 6cf:	89 7b 1c             	mov    %edi,0x1c(%rbx)
 6d2:	03 7b 18             	add    0x18(%rbx),%edi
 6d5:	89 7b 28             	mov    %edi,0x28(%rbx)
 6d8:	48 63 ff             	movslq %edi,%rdi
 6db:	48 39 d7             	cmp    %rdx,%rdi
 6de:	77 0e                	ja     6ee <azx_probe+0x4f1>
 6e0:	48 c1 e7 07          	shl    $0x7,%rdi
 6e4:	be d0 80 00 00       	mov    $0x80d0,%esi
 6e9:	e8 00 00 00 00       	callq  6ee <azx_probe+0x4f1>
 6ee:	31 ed                	xor    %ebp,%ebp
 6f0:	48 85 c0             	test   %rax,%rax
 6f3:	48 89 43 68          	mov    %rax,0x68(%rbx)
 6f7:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 6fe:	75 3f                	jne    73f <azx_probe+0x542>
 700:	eb 31                	jmp    733 <azx_probe+0x536>
 702:	48 63 cd             	movslq %ebp,%rcx
 705:	48 81 c6 90 00 00 00 	add    $0x90,%rsi
 70c:	ba 00 10 00 00       	mov    $0x1000,%edx
 711:	48 c1 e1 07          	shl    $0x7,%rcx
 715:	48 03 4b 68          	add    0x68(%rbx),%rcx
 719:	bf 02 00 00 00       	mov    $0x2,%edi
 71e:	e8 00 00 00 00       	callq  723 <azx_probe+0x526>
 723:	85 c0                	test   %eax,%eax
 725:	41 89 c6             	mov    %eax,%r14d
 728:	79 13                	jns    73d <azx_probe+0x540>
 72a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 731:	31 c0                	xor    %eax,%eax
 733:	e8 00 00 00 00       	callq  738 <azx_probe+0x53b>
 738:	e9 8a 01 00 00       	jmpq   8c7 <azx_probe+0x6ca>
 73d:	ff c5                	inc    %ebp
 73f:	8b 53 28             	mov    0x28(%rbx),%edx
 742:	48 8b 73 08          	mov    0x8(%rbx),%rsi
 746:	39 d5                	cmp    %edx,%ebp
 748:	7c b8                	jl     702 <azx_probe+0x505>
 74a:	c1 e2 03             	shl    $0x3,%edx
 74d:	48 8d 8b b8 01 00 00 	lea    0x1b8(%rbx),%rcx
 754:	48 81 c6 90 00 00 00 	add    $0x90,%rsi
 75b:	bf 02 00 00 00       	mov    $0x2,%edi
 760:	48 63 d2             	movslq %edx,%rdx
 763:	e8 00 00 00 00       	callq  768 <azx_probe+0x56b>
 768:	85 c0                	test   %eax,%eax
 76a:	41 89 c6             	mov    %eax,%r14d
 76d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 774:	78 bb                	js     731 <azx_probe+0x534>
 776:	48 8b 73 08          	mov    0x8(%rbx),%rsi
 77a:	48 8d 8b 88 01 00 00 	lea    0x188(%rbx),%rcx
 781:	ba 00 10 00 00       	mov    $0x1000,%edx
 786:	bf 02 00 00 00       	mov    $0x2,%edi
 78b:	48 81 c6 90 00 00 00 	add    $0x90,%rsi
 792:	e8 00 00 00 00       	callq  797 <azx_probe+0x59a>
 797:	85 c0                	test   %eax,%eax
 799:	41 89 c6             	mov    %eax,%r14d
 79c:	78 0e                	js     7ac <azx_probe+0x5af>
 79e:	ba 80 00 00 00       	mov    $0x80,%edx
 7a3:	31 c9                	xor    %ecx,%ecx
 7a5:	be 01 00 00 00       	mov    $0x1,%esi
 7aa:	eb 4d                	jmp    7f9 <azx_probe+0x5fc>
 7ac:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 7b3:	e9 79 ff ff ff       	jmpq   731 <azx_probe+0x534>
 7b8:	8d 3c cd 00 00 00 00 	lea    0x0(,%rcx,8),%edi
 7bf:	48 63 c1             	movslq %ecx,%rax
 7c2:	48 c1 e0 07          	shl    $0x7,%rax
 7c6:	48 03 43 68          	add    0x68(%rbx),%rax
 7ca:	48 63 ff             	movslq %edi,%rdi
 7cd:	48 03 bb c8 01 00 00 	add    0x1c8(%rbx),%rdi
 7d4:	48 89 78 30          	mov    %rdi,0x30(%rax)
 7d8:	48 63 fa             	movslq %edx,%rdi
 7db:	48 03 7b 38          	add    0x38(%rbx),%rdi
 7df:	83 c2 20             	add    $0x20,%edx
 7e2:	88 48 75             	mov    %cl,0x75(%rax)
 7e5:	48 89 78 58          	mov    %rdi,0x58(%rax)
 7e9:	89 f7                	mov    %esi,%edi
 7eb:	d3 e7                	shl    %cl,%edi
 7ed:	89 78 60             	mov    %edi,0x60(%rax)
 7f0:	8d 79 01             	lea    0x1(%rcx),%edi
 7f3:	ff c1                	inc    %ecx
 7f5:	40 88 78 74          	mov    %dil,0x74(%rax)
 7f9:	3b 4b 28             	cmp    0x28(%rbx),%ecx
 7fc:	7c ba                	jl     7b8 <azx_probe+0x5bb>
 7fe:	48 89 df             	mov    %rbx,%rdi
 801:	4d 63 ed             	movslq %r13d,%r13
 804:	e8 00 00 00 00       	callq  809 <azx_probe+0x60c>
 809:	42 8b 34 ad 00 00 00 	mov    0x0(,%r13,4),%esi
 810:	00 
 811:	48 89 df             	mov    %rbx,%rdi
 814:	d1 ee                	shr    %esi
 816:	83 f6 01             	xor    $0x1,%esi
 819:	83 e6 01             	and    $0x1,%esi
 81c:	e8 00 00 00 00       	callq  821 <azx_probe+0x624>
 821:	66 83 bb c0 00 00 00 	cmpw   $0x0,0xc0(%rbx)
 828:	00 
 829:	75 19                	jne    844 <azx_probe+0x647>
 82b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 832:	31 c0                	xor    %eax,%eax
 834:	41 be ed ff ff ff    	mov    $0xffffffed,%r14d
 83a:	e8 00 00 00 00       	callq  83f <azx_probe+0x642>
 83f:	e9 83 00 00 00       	jmpq   8c7 <azx_probe+0x6ca>
 844:	4c 89 e7             	mov    %r12,%rdi
 847:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx
 84e:	48 89 da             	mov    %rbx,%rdx
 851:	be 00 20 00 00       	mov    $0x2000,%esi
 856:	e8 00 00 00 00       	callq  85b <azx_probe+0x65e>
 85b:	85 c0                	test   %eax,%eax
 85d:	41 89 c6             	mov    %eax,%r14d
 860:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 867:	0f 88 c4 fe ff ff    	js     731 <azx_probe+0x534>
 86d:	49 8d 7c 24 14       	lea    0x14(%r12),%rdi
 872:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 879:	49 8d 6c 24 24       	lea    0x24(%r12),%rbp
 87e:	e8 00 00 00 00       	callq  883 <azx_probe+0x686>
 883:	48 63 43 14          	movslq 0x14(%rbx),%rax
 887:	48 89 ef             	mov    %rbp,%rdi
 88a:	ba 20 00 00 00       	mov    $0x20,%edx
 88f:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 896:	00 
 897:	e8 00 00 00 00       	callq  89c <azx_probe+0x69f>
 89c:	44 8b 4b 40          	mov    0x40(%rbx),%r9d
 8a0:	4c 8b 43 30          	mov    0x30(%rbx),%r8
 8a4:	49 8d 7c 24 44       	lea    0x44(%r12),%rdi
 8a9:	48 89 e9             	mov    %rbp,%rcx
 8ac:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
 8b3:	be 50 00 00 00       	mov    $0x50,%esi
 8b8:	31 c0                	xor    %eax,%eax
 8ba:	e8 00 00 00 00       	callq  8bf <azx_probe+0x6c2>
 8bf:	eb 19                	jmp    8da <azx_probe+0x6dd>
 8c1:	41 be f0 ff ff ff    	mov    $0xfffffff0,%r14d
 8c7:	48 89 df             	mov    %rbx,%rdi
 8ca:	e8 00 00 00 00       	callq  8cf <azx_probe+0x6d2>
 8cf:	45 85 f6             	test   %r14d,%r14d
 8d2:	0f 88 79 01 00 00    	js     a51 <azx_probe+0x854>
 8d8:	31 db                	xor    %ebx,%ebx
 8da:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 8df:	48 89 df             	mov    %rbx,%rdi
 8e2:	48 89 98 70 01 00 00 	mov    %rbx,0x170(%rax)
 8e9:	48 63 05 00 00 00 00 	movslq 0x0(%rip),%rax        # 8f0 <azx_probe+0x6f3>
 8f0:	8b 14 85 00 00 00 00 	mov    0x0(,%rax,4),%edx
 8f7:	89 93 d0 00 00 00    	mov    %edx,0xd0(%rbx)
 8fd:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 904:	00 
 905:	e8 f6 f6 ff ff       	callq  0 <azx_codec_create>
 90a:	85 c0                	test   %eax,%eax
 90c:	41 89 c6             	mov    %eax,%r14d
 90f:	0f 88 3c 01 00 00    	js     a51 <azx_probe+0x854>
 915:	48 63 05 00 00 00 00 	movslq 0x0(%rip),%rax        # 91c <azx_probe+0x71f>
 91c:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 923:	00 
 924:	48 85 f6             	test   %rsi,%rsi
 927:	74 39                	je     962 <azx_probe+0x765>
 929:	80 3e 00             	cmpb   $0x0,(%rsi)
 92c:	74 34                	je     962 <azx_probe+0x765>
 92e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 935:	31 c0                	xor    %eax,%eax
 937:	e8 00 00 00 00       	callq  93c <azx_probe+0x73f>
 93c:	48 63 05 00 00 00 00 	movslq 0x0(%rip),%rax        # 943 <azx_probe+0x746>
 943:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
 94a:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 951:	00 
 952:	e8 00 00 00 00       	callq  957 <azx_probe+0x75a>
 957:	85 c0                	test   %eax,%eax
 959:	41 89 c6             	mov    %eax,%r14d
 95c:	0f 88 ef 00 00 00    	js     a51 <azx_probe+0x854>
 962:	48 63 05 00 00 00 00 	movslq 0x0(%rip),%rax        # 969 <azx_probe+0x76c>
 969:	f6 04 85 00 00 00 00 	testb  $0x1,0x0(,%rax,4)
 970:	01 
 971:	75 38                	jne    9ab <azx_probe+0x7ae>
 973:	48 8b 83 c8 00 00 00 	mov    0xc8(%rbx),%rax
 97a:	48 8b 68 58          	mov    0x58(%rax),%rbp
 97e:	eb 0c                	jmp    98c <azx_probe+0x78f>
 980:	48 89 ef             	mov    %rbp,%rdi
 983:	e8 00 00 00 00       	callq  988 <azx_probe+0x78b>
 988:	48 8b 6d 10          	mov    0x10(%rbp),%rbp
 98c:	48 83 ed 10          	sub    $0x10,%rbp
 990:	48 8b 45 10          	mov    0x10(%rbp),%rax
 994:	48 8d 55 10          	lea    0x10(%rbp),%rdx
 998:	0f 18 08             	prefetcht0 (%rax)
 99b:	48 8b 83 c8 00 00 00 	mov    0xc8(%rbx),%rax
 9a2:	48 83 c0 58          	add    $0x58,%rax
 9a6:	48 39 c2             	cmp    %rax,%rdx
 9a9:	75 d5                	jne    980 <azx_probe+0x783>
 9ab:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
 9b2:	e8 00 00 00 00       	callq  9b7 <azx_probe+0x7ba>
 9b7:	85 c0                	test   %eax,%eax
 9b9:	41 89 c6             	mov    %eax,%r14d
 9bc:	0f 88 8f 00 00 00    	js     a51 <azx_probe+0x854>
 9c2:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
 9c9:	e8 00 00 00 00       	callq  9ce <azx_probe+0x7d1>
 9ce:	85 c0                	test   %eax,%eax
 9d0:	41 89 c6             	mov    %eax,%r14d
 9d3:	78 7c                	js     a51 <azx_probe+0x854>
 9d5:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
 9da:	e8 00 00 00 00       	callq  9df <azx_probe+0x7e2>
 9df:	85 c0                	test   %eax,%eax
 9e1:	41 89 c6             	mov    %eax,%r14d
 9e4:	78 6b                	js     a51 <azx_probe+0x854>
 9e6:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
 9eb:	4c 89 ff             	mov    %r15,%rdi
 9ee:	e8 00 00 00 00       	callq  9f3 <azx_probe+0x7f6>
 9f3:	48 8b 83 c8 00 00 00 	mov    0xc8(%rbx),%rax
 9fa:	80 8b f4 01 00 00 01 	orb    $0x1,0x1f4(%rbx)
 a01:	48 8b 68 58          	mov    0x58(%rax),%rbp
 a05:	eb 0c                	jmp    a13 <azx_probe+0x816>
 a07:	48 89 ef             	mov    %rbp,%rdi
 a0a:	e8 00 00 00 00       	callq  a0f <azx_probe+0x812>
 a0f:	48 8b 6d 10          	mov    0x10(%rbp),%rbp
 a13:	48 83 ed 10          	sub    $0x10,%rbp
 a17:	48 8b 45 10          	mov    0x10(%rbp),%rax
 a1b:	48 8d 55 10          	lea    0x10(%rbp),%rdx
 a1f:	0f 18 08             	prefetcht0 (%rax)
 a22:	48 8b 83 c8 00 00 00 	mov    0xc8(%rbx),%rax
 a29:	48 83 c0 58          	add    $0x58,%rax
 a2d:	48 39 c2             	cmp    %rax,%rdx
 a30:	75 d5                	jne    a07 <azx_probe+0x80a>
 a32:	48 8d bb 38 02 00 00 	lea    0x238(%rbx),%rdi
 a39:	48 c7 83 38 02 00 00 	movq   $0x0,0x238(%rbx)
 a40:	00 00 00 00 
 a44:	e8 00 00 00 00       	callq  a49 <azx_probe+0x84c>
 a49:	ff 05 00 00 00 00    	incl   0x0(%rip)        # a4f <azx_probe+0x852>
 a4f:	eb 0a                	jmp    a5b <azx_probe+0x85e>
 a51:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
 a56:	e8 00 00 00 00       	callq  a5b <azx_probe+0x85e>
 a5b:	48 83 c4 28          	add    $0x28,%rsp
 a5f:	44 89 f0             	mov    %r14d,%eax
 a62:	5b                   	pop    %rbx
 a63:	5d                   	pop    %rbp
 a64:	41 5c                	pop    %r12
 a66:	41 5d                	pop    %r13
 a68:	41 5e                	pop    %r14
 a6a:	41 5f                	pop    %r15
 a6c:	c3                   	retq   

Disassembly of section .init.text:

0000000000000000 <init_module>:
init_module():
   0:	48 83 ec 08          	sub    $0x8,%rsp
   4:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
   b:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
  12:	41 5b                	pop    %r11
  14:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  1b:	e9 00 00 00 00       	jmpq   20 <__param_power_save>

Disassembly of section .rodata:

0000000000000000 <azx_pcm_hw>:
   0:	03 01                	add    (%rcx),%eax
   2:	c9                   	leaveq 
   3:	00 00                	add    %al,(%rax)
   5:	00 00                	add    %al,(%rax)
   7:	00 04 00             	add    %al,(%rax,%rax,1)
   a:	00 00                	add    %al,(%rax)
   c:	00 00                	add    %al,(%rax)
   e:	00 00                	add    %al,(%rax)
  10:	80 00 00             	addb   $0x0,(%rax)
  13:	00 80 bb 00 00 80    	add    %al,-0x7fffff45(%rax)
  19:	bb 00 00 02 00       	mov    $0x20000,%ebx
  1e:	00 00                	add    %al,(%rax)
  20:	02 00                	add    (%rax),%al
	...
  2a:	00 40 00             	add    %al,0x0(%rax)
  2d:	00 00                	add    %al,(%rax)
  2f:	00 80 00 00 00 00    	add    %al,0x0(%rax)
  35:	00 00                	add    %al,(%rax)
  37:	00 00                	add    %al,(%rax)
  39:	00 00                	add    %al,(%rax)
  3b:	20 00                	and    %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
  3f:	00 02                	add    %al,(%rdx)
  41:	00 00                	add    %al,(%rax)
  43:	00 20                	add    %ah,(%rax)
	...

0000000000000050 <__func__.36134>:
  50:	61                   	(bad)  
  51:	7a 78                	jp     cb <__param_str_beep_mode+0x3>
  53:	5f                   	pop    %rdi
  54:	73 69                	jae    bf <__param_str_power_save+0x7>
  56:	6e                   	outsb  %ds:(%rsi),(%dx)
  57:	67 6c                	insb   (%dx),%es:(%edi)
  59:	65                   	gs
  5a:	5f                   	pop    %rdi
  5b:	73 65                	jae    c2 <__param_str_power_save+0xa>
  5d:	6e                   	outsb  %ds:(%rsi),(%dx)
  5e:	64                   	fs
  5f:	5f                   	pop    %rdi
  60:	63 6d 64             	movslq 0x64(%rbp),%ebp
	...

0000000000000070 <__func__.36108>:
  70:	61                   	(bad)  
  71:	7a 78                	jp     eb <__param_arr_beep_mode+0xb>
  73:	5f                   	pop    %rdi
  74:	73 69                	jae    df <__param_str_beep_mode+0x17>
  76:	6e                   	outsb  %ds:(%rsi),(%dx)
  77:	67 6c                	insb   (%dx),%es:(%edi)
  79:	65                   	gs
  7a:	5f                   	pop    %rdi
  7b:	77 61                	ja     de <__param_str_beep_mode+0x16>
  7d:	69 74 5f 66 6f 72 5f 	imul   $0x725f726f,0x66(%rdi,%rbx,2),%esi
  84:	72 
  85:	65                   	gs
  86:	73 70                	jae    f8 <__param_arr_beep_mode+0x18>
  88:	6f                   	outsl  %ds:(%rsi),(%dx)
  89:	6e                   	outsb  %ds:(%rsi),(%dx)
  8a:	73 65                	jae    f1 <__param_arr_beep_mode+0x11>
  8c:	00 00                	add    %al,(%rax)
	...

0000000000000090 <CSWTCH.727>:
  90:	03 00                	add    (%rax),%eax
  92:	00 00                	add    %al,(%rax)
  94:	00 00                	add    %al,(%rax)
  96:	00 00                	add    %al,(%rax)
  98:	03 00                	add    (%rax),%eax
  9a:	00 00                	add    %al,(%rax)
  9c:	00 00                	add    %al,(%rax)
	...

00000000000000a0 <__param_str_power_save_controller>:
  a0:	70 6f                	jo     111 <__param_arr_patch+0x1>
  a2:	77 65                	ja     109 <__param_str_patch+0x1>
  a4:	72 5f                	jb     105 <__param_arr_beep_mode+0x25>
  a6:	73 61                	jae    109 <__param_str_patch+0x1>
  a8:	76 65                	jbe    10f <__param_str_patch+0x7>
  aa:	5f                   	pop    %rdi
  ab:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
  ae:	74 72                	je     122 <__param_arr_patch+0x12>
  b0:	6f                   	outsl  %ds:(%rsi),(%dx)
  b1:	6c                   	insb   (%dx),%es:(%rdi)
  b2:	6c                   	insb   (%dx),%es:(%rdi)
  b3:	65                   	gs
  b4:	72 00                	jb     b6 <__param_str_power_save_controller+0x16>
	...

00000000000000b8 <__param_str_power_save>:
  b8:	70 6f                	jo     129 <__param_arr_patch+0x19>
  ba:	77 65                	ja     121 <__param_arr_patch+0x11>
  bc:	72 5f                	jb     11d <__param_arr_patch+0xd>
  be:	73 61                	jae    121 <__param_arr_patch+0x11>
  c0:	76 65                	jbe    127 <__param_arr_patch+0x17>
  c2:	00 00                	add    %al,(%rax)
  c4:	00 00                	add    %al,(%rax)
	...

00000000000000c8 <__param_str_beep_mode>:
  c8:	62                   	(bad)  
  c9:	65                   	gs
  ca:	65                   	gs
  cb:	70 5f                	jo     12c <__param_arr_patch+0x1c>
  cd:	6d                   	insl   (%dx),%es:(%rdi)
  ce:	6f                   	outsl  %ds:(%rsi),(%dx)
  cf:	64 65 00 00          	fs add %al,%fs:%gs:(%rax)
	...

00000000000000e0 <__param_arr_beep_mode>:
  e0:	20 00                	and    %al,(%rax)
	...
  f6:	00 00                	add    %al,(%rax)
  f8:	04 00                	add    $0x0,%al
	...

0000000000000108 <__param_str_patch>:
 108:	70 61                	jo     16b <__param_str_probe_only+0x13>
 10a:	74 63                	je     16f <__param_str_probe_only+0x17>
 10c:	68 00 00 00 20       	pushq  $0x20000000

0000000000000110 <__param_arr_patch>:
 110:	20 00                	and    %al,(%rax)
	...
 126:	00 00                	add    %al,(%rax)
 128:	08 00                	or     %al,(%rax)
	...

0000000000000138 <__param_str_enable_msi>:
 138:	65 6e                	outsb  %gs:(%rsi),(%dx)
 13a:	61                   	(bad)  
 13b:	62                   	(bad)  
 13c:	6c                   	insb   (%dx),%es:(%rdi)
 13d:	65                   	gs
 13e:	5f                   	pop    %rdi
 13f:	6d                   	insl   (%dx),%es:(%rdi)
 140:	73 69                	jae    1ab <__param_str_probe_mask+0x13>
 142:	00 00                	add    %al,(%rax)
 144:	00 00                	add    %al,(%rax)
	...

0000000000000148 <__param_str_single_cmd>:
 148:	73 69                	jae    1b3 <__param_arr_probe_mask+0x3>
 14a:	6e                   	outsb  %ds:(%rsi),(%dx)
 14b:	67 6c                	insb   (%dx),%es:(%edi)
 14d:	65                   	gs
 14e:	5f                   	pop    %rdi
 14f:	63 6d 64             	movslq 0x64(%rbp),%ebp
 152:	00 00                	add    %al,(%rax)
 154:	00 00                	add    %al,(%rax)
	...

0000000000000158 <__param_str_probe_only>:
 158:	70 72                	jo     1cc <__param_arr_probe_mask+0x1c>
 15a:	6f                   	outsl  %ds:(%rsi),(%dx)
 15b:	62                   	(bad)  
 15c:	65                   	gs
 15d:	5f                   	pop    %rdi
 15e:	6f                   	outsl  %ds:(%rsi),(%dx)
 15f:	6e                   	outsb  %ds:(%rsi),(%dx)
 160:	6c                   	insb   (%dx),%es:(%rdi)
 161:	79 00                	jns    163 <__param_str_probe_only+0xb>
	...

0000000000000170 <__param_arr_probe_only>:
 170:	20 00                	and    %al,(%rax)
	...
 186:	00 00                	add    %al,(%rax)
 188:	04 00                	add    $0x0,%al
	...

0000000000000198 <__param_str_probe_mask>:
 198:	70 72                	jo     20c <__param_arr_bdl_pos_adj+0x1c>
 19a:	6f                   	outsl  %ds:(%rsi),(%dx)
 19b:	62                   	(bad)  
 19c:	65                   	gs
 19d:	5f                   	pop    %rdi
 19e:	6d                   	insl   (%dx),%es:(%rdi)
 19f:	61                   	(bad)  
 1a0:	73 6b                	jae    20d <__param_arr_bdl_pos_adj+0x1d>
	...

00000000000001b0 <__param_arr_probe_mask>:
 1b0:	20 00                	and    %al,(%rax)
	...
 1c6:	00 00                	add    %al,(%rax)
 1c8:	04 00                	add    $0x0,%al
	...

00000000000001d8 <__param_str_bdl_pos_adj>:
 1d8:	62                   	(bad)  
 1d9:	64                   	fs
 1da:	6c                   	insb   (%dx),%es:(%rdi)
 1db:	5f                   	pop    %rdi
 1dc:	70 6f                	jo     24d <__param_arr_position_fix+0x1d>
 1de:	73 5f                	jae    23f <__param_arr_position_fix+0xf>
 1e0:	61                   	(bad)  
 1e1:	64                   	fs
 1e2:	6a 00                	pushq  $0x0
	...

00000000000001f0 <__param_arr_bdl_pos_adj>:
 1f0:	20 00                	and    %al,(%rax)
	...
 206:	00 00                	add    %al,(%rax)
 208:	04 00                	add    $0x0,%al
	...

0000000000000218 <__param_str_position_fix>:
 218:	70 6f                	jo     289 <__param_str_enable+0x1>
 21a:	73 69                	jae    285 <__param_arr_model+0x25>
 21c:	74 69                	je     287 <__param_arr_model+0x27>
 21e:	6f                   	outsl  %ds:(%rsi),(%dx)
 21f:	6e                   	outsb  %ds:(%rsi),(%dx)
 220:	5f                   	pop    %rdi
 221:	66 69 78 00 00 00    	imul   $0x0,0x0(%rax),%di
	...

0000000000000230 <__param_arr_position_fix>:
 230:	20 00                	and    %al,(%rax)
	...
 246:	00 00                	add    %al,(%rax)
 248:	04 00                	add    $0x0,%al
	...

0000000000000258 <__param_str_model>:
 258:	6d                   	insl   (%dx),%es:(%rdi)
 259:	6f                   	outsl  %ds:(%rsi),(%dx)
 25a:	64                   	fs
 25b:	65                   	gs
 25c:	6c                   	insb   (%dx),%es:(%rdi)
 25d:	00 00                	add    %al,(%rax)
	...

0000000000000260 <__param_arr_model>:
 260:	20 00                	and    %al,(%rax)
	...
 276:	00 00                	add    %al,(%rax)
 278:	08 00                	or     %al,(%rax)
	...

0000000000000288 <__param_str_enable>:
 288:	65 6e                	outsb  %gs:(%rsi),(%dx)
 28a:	61                   	(bad)  
 28b:	62                   	(bad)  
 28c:	6c                   	insb   (%dx),%es:(%rdi)
 28d:	65 00 00             	add    %al,%gs:(%rax)

0000000000000290 <__param_arr_enable>:
 290:	20 00                	and    %al,(%rax)
	...
 2a6:	00 00                	add    %al,(%rax)
 2a8:	04 00                	add    $0x0,%al
	...

00000000000002b8 <__param_str_id>:
 2b8:	69 64 00 00 00 00 00 	imul   $0x0,0x0(%rax,%rax,1),%esp
 2bf:	00 

00000000000002c0 <__param_arr_id>:
 2c0:	20 00                	and    %al,(%rax)
	...
 2d6:	00 00                	add    %al,(%rax)
 2d8:	08 00                	or     %al,(%rax)
	...

00000000000002e8 <__param_str_index>:
 2e8:	69 6e 64 65 78 00 00 	imul   $0x7865,0x64(%rsi),%ebp
	...

00000000000002f0 <__param_arr_index>:
 2f0:	20 00                	and    %al,(%rax)
	...
 306:	00 00                	add    %al,(%rax)
 308:	04 00                	add    $0x0,%al
	...

Disassembly of section .rodata.str1.1:

0000000000000000 <.rodata.str1.1>:
   0:	68 64 61 5f 69       	pushq  $0x695f6164
   5:	6e                   	outsb  %ds:(%rsi),(%dx)
   6:	74 65                	je     6d <.rodata.str1.1+0x6d>
   8:	6c                   	insb   (%dx),%es:(%rdi)
   9:	00 3c 33             	add    %bh,(%rbx,%rsi,1)
   c:	3e                   	ds
   d:	68 64 61 2d 69       	pushq  $0x692d6164
  12:	6e                   	outsb  %ds:(%rsi),(%dx)
  13:	74 65                	je     7a <.rodata.str1.1+0x7a>
  15:	6c                   	insb   (%dx),%es:(%rdi)
  16:	3a 20                	cmp    (%rax),%ah
  18:	75 6e                	jne    88 <.rodata.str1.1+0x88>
  1a:	61                   	(bad)  
  1b:	62                   	(bad)  
  1c:	6c                   	insb   (%dx),%es:(%rdi)
  1d:	65 20 74 6f 20       	and    %dh,%gs:0x20(%rdi,%rbp,2)
  22:	67 72 61             	addr32 jb 86 <.rodata.str1.1+0x86>
  25:	62                   	(bad)  
  26:	20 49 52             	and    %cl,0x52(%rcx)
  29:	51                   	push   %rcx
  2a:	20 25 64 2c 20 64    	and    %ah,0x64202c64(%rip)        # 64202c94 <azx_attach_pcm_stream+0x64200fdb>
  30:	69 73 61 62 6c 69 6e 	imul   $0x6e696c62,0x61(%rbx),%esi
  37:	67 20 64 65 76       	and    %ah,0x76(%ebp,%eiz,2)
  3c:	69 63 65 0a 00 3c 34 	imul   $0x343c000a,0x65(%rbx),%esp
  43:	3e                   	ds
  44:	68 64 61 2d 69       	pushq  $0x692d6164
  49:	6e                   	outsb  %ds:(%rsi),(%dx)
  4a:	74 65                	je     b1 <.rodata.str1.1+0xb1>
  4c:	6c                   	insb   (%dx),%es:(%rdi)
  4d:	3a 20                	cmp    (%rax),%ah
  4f:	49 6e                	rex.WB outsb %ds:(%rsi),(%dx)
  51:	76 61                	jbe    b4 <.rodata.str1.1+0xb4>
  53:	6c                   	insb   (%dx),%es:(%rdi)
  54:	69 64 20 70 6f 73 69 	imul   $0x7469736f,0x70(%rax,%riz,1),%esp
  5b:	74 
  5c:	69 6f 6e 20 62 75 66 	imul   $0x66756220,0x6e(%rdi),%ebp
  63:	66                   	data16
  64:	65                   	gs
  65:	72 2c                	jb     93 <.rodata.str1.1+0x93>
  67:	20 75 73             	and    %dh,0x73(%rbp)
  6a:	69 6e 67 20 4c 50 49 	imul   $0x49504c20,0x67(%rsi),%ebp
  71:	42 20 72 65          	rex.X and %sil,0x65(%rdx)
  75:	61                   	(bad)  
  76:	64 20 6d 65          	and    %ch,%fs:0x65(%rbp)
  7a:	74 68                	je     e4 <.rodata.str1.1+0xe4>
  7c:	6f                   	outsl  %ds:(%rsi),(%dx)
  7d:	64 20 69 6e          	and    %ch,%fs:0x6e(%rcx)
  81:	73 74                	jae    f7 <.rodata.str1.1+0xf7>
  83:	65                   	gs
  84:	61                   	(bad)  
  85:	64 2e 0a 00          	fs or  %cs:%fs:(%rax),%al
  89:	68 64 61 2d 69       	pushq  $0x692d6164
  8e:	6e                   	outsb  %ds:(%rsi),(%dx)
  8f:	74 65                	je     f6 <.rodata.str1.1+0xf6>
  91:	6c                   	insb   (%dx),%es:(%rdi)
  92:	3a 20                	cmp    (%rax),%ah
  94:	7a 65                	jp     fb <.rodata.str1.1+0xfb>
  96:	72 6f                	jb     107 <.rodata.str1.1+0x107>
  98:	20 61 7a             	and    %ah,0x7a(%rcx)
  9b:	78 5f                	js     fc <.rodata.str1.1+0xfc>
  9d:	64                   	fs
  9e:	65                   	gs
  9f:	76 2d                	jbe    ce <.rodata.str1.1+0xce>
  a1:	3e 70 65             	jo,pt  109 <.rodata.str1.1+0x109>
  a4:	72 69                	jb     10f <.rodata.str1.1+0x10f>
  a6:	6f                   	outsl  %ds:(%rsi),(%dx)
  a7:	64                   	fs
  a8:	5f                   	pop    %rdi
  a9:	62                   	(bad)  
  aa:	79 74                	jns    120 <.rodata.str1.1+0x120>
  ac:	65                   	gs
  ad:	73 00                	jae    af <.rodata.str1.1+0xaf>
  af:	2f                   	(bad)  
  b0:	62                   	(bad)  
  b1:	75 69                	jne    11c <.rodata.str1.1+0x11c>
  b3:	6c                   	insb   (%dx),%es:(%rdi)
  b4:	64                   	fs
  b5:	2f                   	(bad)  
  b6:	62                   	(bad)  
  b7:	75 69                	jne    122 <.rodata.str1.1+0x122>
  b9:	6c                   	insb   (%dx),%es:(%rdi)
  ba:	64                   	fs
  bb:	64                   	fs
  bc:	2d 6c 69 6e 75       	sub    $0x756e696c,%eax
  c1:	78 2d                	js     f0 <.rodata.str1.1+0xf0>
  c3:	32 2e                	xor    (%rsi),%ch
  c5:	36                   	ss
  c6:	5f                   	pop    %rdi
  c7:	32 2e                	xor    (%rsi),%ch
  c9:	36 2e 33 38          	ss xor %cs:%ss:(%rax),%edi
  cd:	2d 32 2d 61 6d       	sub    $0x6d612d32,%eax
  d2:	64                   	fs
  d3:	36                   	ss
  d4:	34 2d                	xor    $0x2d,%al
  d6:	36 47 39 66 6d       	rex.RXB cmp %r12d,%ss:0x6d(%r14)
  db:	56                   	push   %rsi
  dc:	2f                   	(bad)  
  dd:	6c                   	insb   (%dx),%es:(%rdi)
  de:	69 6e 75 78 2d 32 2e 	imul   $0x2e322d78,0x75(%rsi),%ebp
  e5:	36                   	ss
  e6:	2d 32 2e 36 2e       	sub    $0x2e362e32,%eax
  eb:	33 38                	xor    (%rax),%edi
  ed:	2f                   	(bad)  
  ee:	64                   	fs
  ef:	65                   	gs
  f0:	62                   	(bad)  
  f1:	69 61 6e 2f 62 75 69 	imul   $0x6975622f,0x6e(%rcx),%esp
  f8:	6c                   	insb   (%dx),%es:(%rdi)
  f9:	64                   	fs
  fa:	2f                   	(bad)  
  fb:	73 6f                	jae    16c <.rodata.str1.1+0x16c>
  fd:	75 72                	jne    171 <.rodata.str1.1+0x171>
  ff:	63 65 5f             	movslq 0x5f(%rbp),%esp
 102:	61                   	(bad)  
 103:	6d                   	insl   (%dx),%es:(%rdi)
 104:	64                   	fs
 105:	36                   	ss
 106:	34 5f                	xor    $0x5f,%al
 108:	6e                   	outsb  %ds:(%rsi),(%dx)
 109:	6f                   	outsl  %ds:(%rsi),(%dx)
 10a:	6e                   	outsb  %ds:(%rsi),(%dx)
 10b:	65                   	gs
 10c:	2f                   	(bad)  
 10d:	73 6f                	jae    17e <.rodata.str1.1+0x17e>
 10f:	75 6e                	jne    17f <.rodata.str1.1+0x17f>
 111:	64                   	fs
 112:	2f                   	(bad)  
 113:	70 63                	jo     178 <.rodata.str1.1+0x178>
 115:	69 2f 68 64 61 2f    	imul   $0x2f616468,(%rdi),%ebp
 11b:	68 64 61 5f 69       	pushq  $0x695f6164
 120:	6e                   	outsb  %ds:(%rsi),(%dx)
 121:	74 65                	je     188 <.rodata.str1.1+0x188>
 123:	6c                   	insb   (%dx),%es:(%rdi)
 124:	2e 63 00             	movslq %cs:(%rax),%eax
 127:	3c 33                	cmp    $0x33,%al
 129:	3e                   	ds
 12a:	68 64 61 2d 69       	pushq  $0x692d6164
 12f:	6e                   	outsb  %ds:(%rsi),(%dx)
 130:	74 65                	je     197 <.rodata.str1.1+0x197>
 132:	6c                   	insb   (%dx),%es:(%rdi)
 133:	3a 20                	cmp    (%rax),%ah
 135:	73 70                	jae    1a7 <.rodata.str1.1+0x1a7>
 137:	75 72                	jne    1ab <.rodata.str1.1+0x1ab>
 139:	69 6f 75 73 20 72 65 	imul   $0x65722073,0x75(%rdi),%ebp
 140:	73 70                	jae    1b2 <.rodata.str1.1+0x1b2>
 142:	6f                   	outsl  %ds:(%rsi),(%dx)
 143:	6e                   	outsb  %ds:(%rsi),(%dx)
 144:	73 65                	jae    1ab <.rodata.str1.1+0x1ab>
 146:	20 25 23 78 3a 25    	and    %ah,0x253a7823(%rip)        # 253a796f <azx_attach_pcm_stream+0x253a5cb6>
 14c:	23 78 2c             	and    0x2c(%rax),%edi
 14f:	20 6c 61 73          	and    %ch,0x73(%rcx,%riz,2)
 153:	74 20                	je     175 <.rodata.str1.1+0x175>
 155:	63 6d 64             	movslq 0x64(%rbp),%ebp
 158:	3d 25 23 30 38       	cmp    $0x38302325,%eax
 15d:	78 0a                	js     169 <.rodata.str1.1+0x169>
 15f:	00 3c 34             	add    %bh,(%rsp,%rsi,1)
 162:	3e                   	ds
 163:	68 64 61 2d 69       	pushq  $0x692d6164
 168:	6e                   	outsb  %ds:(%rsi),(%dx)
 169:	74 65                	je     1d0 <.rodata.str1.1+0x1d0>
 16b:	6c                   	insb   (%dx),%es:(%rdi)
 16c:	3a 20                	cmp    (%rax),%ah
 16e:	49 52                	rex.WB push %r10
 170:	51                   	push   %rcx
 171:	20 74 69 6d          	and    %dh,0x6d(%rcx,%rbp,2)
 175:	69 6e 67 20 77 6f 72 	imul   $0x726f7720,0x67(%rsi),%ebp
 17c:	6b 61 72 6f          	imul   $0x6f,0x72(%rcx),%esp
 180:	75 6e                	jne    1f0 <.rodata.str1.1+0x1f0>
 182:	64 20 69 73          	and    %ch,%fs:0x73(%rcx)
 186:	20 61 63             	and    %ah,0x63(%rcx)
 189:	74 69                	je     1f4 <.rodata.str1.1+0x1f4>
 18b:	76 61                	jbe    1ee <.rodata.str1.1+0x1ee>
 18d:	74 65                	je     1f4 <.rodata.str1.1+0x1f4>
 18f:	64 20 66 6f          	and    %ah,%fs:0x6f(%rsi)
 193:	72 20                	jb     1b5 <.rodata.str1.1+0x1b5>
 195:	63 61 72             	movslq 0x72(%rcx),%esp
 198:	64 20 23             	and    %ah,%fs:(%rbx)
 19b:	25 64 2e 20 53       	and    $0x53202e64,%eax
 1a0:	75 67                	jne    209 <.rodata.str1.1+0x209>
 1a2:	67                   	addr32
 1a3:	65                   	gs
 1a4:	73 74                	jae    21a <.rodata.str1.1+0x21a>
 1a6:	20 61 20             	and    %ah,0x20(%rcx)
 1a9:	62                   	(bad)  
 1aa:	69 67 67 65 72 20 62 	imul   $0x62207265,0x67(%rdi),%esp
 1b1:	64                   	fs
 1b2:	6c                   	insb   (%dx),%es:(%rdi)
 1b3:	5f                   	pop    %rdi
 1b4:	70 6f                	jo     225 <.rodata.str1.1+0x225>
 1b6:	73 5f                	jae    217 <.rodata.str1.1+0x217>
 1b8:	61                   	(bad)  
 1b9:	64                   	fs
 1ba:	6a 2e                	pushq  $0x2e
 1bc:	0a 00                	or     (%rax),%al
 1be:	3c 33                	cmp    $0x33,%al
 1c0:	3e                   	ds
 1c1:	68 64 61 2d 69       	pushq  $0x692d6164
 1c6:	6e                   	outsb  %ds:(%rsi),(%dx)
 1c7:	74 65                	je     22e <.rodata.str1.1+0x22e>
 1c9:	6c                   	insb   (%dx),%es:(%rdi)
 1ca:	3a 20                	cmp    (%rax),%ah
 1cc:	70 63                	jo     231 <.rodata.str1.1+0x231>
 1ce:	69 5f 65 6e 61 62 6c 	imul   $0x6c62616e,0x65(%rdi),%ebx
 1d5:	65                   	gs
 1d6:	5f                   	pop    %rdi
 1d7:	64                   	fs
 1d8:	65                   	gs
 1d9:	76 69                	jbe    244 <.rodata.str1.1+0x244>
 1db:	63 65 20             	movslq 0x20(%rbp),%esp
 1de:	66                   	data16
 1df:	61                   	(bad)  
 1e0:	69 6c 65 64 2c 20 64 	imul   $0x6964202c,0x64(%rbp,%riz,2),%ebp
 1e7:	69 
 1e8:	73 61                	jae    24b <.rodata.str1.1+0x24b>
 1ea:	62                   	(bad)  
 1eb:	6c                   	insb   (%dx),%es:(%rdi)
 1ec:	69 6e 67 20 64 65 76 	imul   $0x76656420,0x67(%rsi),%ebp
 1f3:	69 63 65 0a 00 3c 33 	imul   $0x333c000a,0x65(%rbx),%esp
 1fa:	3e                   	ds
 1fb:	68 64 61 2d 69       	pushq  $0x692d6164
 200:	6e                   	outsb  %ds:(%rsi),(%dx)
 201:	74 65                	je     268 <.rodata.str1.1+0x268>
 203:	6c                   	insb   (%dx),%es:(%rdi)
 204:	3a 20                	cmp    (%rax),%ah
 206:	69 6e 76 61 6c 69 64 	imul   $0x64696c61,0x76(%rsi),%ebp
 20d:	20 66 6f             	and    %ah,0x6f(%rsi)
 210:	72 6d                	jb     27f <.rodata.str1.1+0x27f>
 212:	61                   	(bad)  
 213:	74 5f                	je     274 <.rodata.str1.1+0x274>
 215:	76 61                	jbe    278 <.rodata.str1.1+0x278>
 217:	6c                   	insb   (%dx),%es:(%rdi)
 218:	2c 20                	sub    $0x20,%al
 21a:	72 61                	jb     27d <.rodata.str1.1+0x27d>
 21c:	74 65                	je     283 <.rodata.str1.1+0x283>
 21e:	3d 25 64 2c 20       	cmp    $0x202c6425,%eax
 223:	63 68 3d             	movslq 0x3d(%rax),%ebp
 226:	25 64 2c 20 66       	and    $0x66202c64,%eax
 22b:	6f                   	outsl  %ds:(%rsi),(%dx)
 22c:	72 6d                	jb     29b <.rodata.str1.1+0x29b>
 22e:	61                   	(bad)  
 22f:	74 3d                	je     26e <.rodata.str1.1+0x26e>
 231:	25 64 0a 00 3c       	and    $0x3c000a64,%eax
 236:	34 3e                	xor    $0x3e,%al
 238:	68 64 61 2d 69       	pushq  $0x692d6164
 23d:	6e                   	outsb  %ds:(%rsi),(%dx)
 23e:	74 65                	je     2a5 <.rodata.str1.1+0x2a5>
 240:	6c                   	insb   (%dx),%es:(%rdi)
 241:	3a 20                	cmp    (%rax),%ah
 243:	54                   	push   %rsp
 244:	6f                   	outsl  %ds:(%rsi),(%dx)
 245:	6f                   	outsl  %ds:(%rsi),(%dx)
 246:	20 62 69             	and    %ah,0x69(%rdx)
 249:	67 20 61 64          	and    %ah,0x64(%ecx)
 24d:	6a 75                	pushq  $0x75
 24f:	73 74                	jae    2c5 <.rodata.str1.1+0x2c5>
 251:	6d                   	insl   (%dx),%es:(%rdi)
 252:	65 6e                	outsb  %gs:(%rsi),(%dx)
 254:	74 20                	je     276 <.rodata.str1.1+0x276>
 256:	25 64 0a 00 3c       	and    $0x3c000a64,%eax
 25b:	33 3e                	xor    (%rsi),%edi
 25d:	68 64 61 2d 69       	pushq  $0x692d6164
 262:	6e                   	outsb  %ds:(%rsi),(%dx)
 263:	74 65                	je     2ca <.rodata.str1.1+0x2ca>
 265:	6c                   	insb   (%dx),%es:(%rdi)
 266:	3a 20                	cmp    (%rax),%ah
 268:	54                   	push   %rsp
 269:	6f                   	outsl  %ds:(%rsi),(%dx)
 26a:	6f                   	outsl  %ds:(%rsi),(%dx)
 26b:	20 6d 61             	and    %ch,0x61(%rbp)
 26e:	6e                   	outsb  %ds:(%rsi),(%dx)
 26f:	79 20                	jns    291 <.rodata.str1.1+0x291>
 271:	42                   	rex.X
 272:	44                   	rex.R
 273:	4c 20 65 6e          	rex.WR and %r12b,0x6e(%rbp)
 277:	74 72                	je     2eb <.rodata.str1.1+0x2eb>
 279:	69 65 73 3a 20 62 75 	imul   $0x7562203a,0x73(%rbp),%esp
 280:	66                   	data16
 281:	66                   	data16
 282:	65                   	gs
 283:	72 3d                	jb     2c2 <.rodata.str1.1+0x2c2>
 285:	25 64 2c 20 70       	and    $0x70202c64,%eax
 28a:	65                   	gs
 28b:	72 69                	jb     2f6 <.rodata.str1.1+0x2f6>
 28d:	6f                   	outsl  %ds:(%rsi),(%dx)
 28e:	64                   	fs
 28f:	3d 25 64 0a 00       	cmp    $0xa6425,%eax
 294:	3c 34                	cmp    $0x34,%al
 296:	3e                   	ds
 297:	68 64 61 2d 69       	pushq  $0x692d6164
 29c:	6e                   	outsb  %ds:(%rsi),(%dx)
 29d:	74 65                	je     304 <.rodata.str1.1+0x304>
 29f:	6c                   	insb   (%dx),%es:(%rdi)
 2a0:	3a 20                	cmp    (%rax),%ah
 2a2:	61                   	(bad)  
 2a3:	7a 78                	jp     31d <.rodata.str1.1+0x31d>
 2a5:	5f                   	pop    %rdi
 2a6:	67                   	addr32
 2a7:	65                   	gs
 2a8:	74 5f                	je     309 <.rodata.str1.1+0x309>
 2aa:	72 65                	jb     311 <.rodata.str1.1+0x311>
 2ac:	73 70                	jae    31e <.rodata.str1.1+0x31e>
 2ae:	6f                   	outsl  %ds:(%rsi),(%dx)
 2af:	6e                   	outsb  %ds:(%rsi),(%dx)
 2b0:	73 65                	jae    317 <.rodata.str1.1+0x317>
 2b2:	20 74 69 6d          	and    %dh,0x6d(%rcx,%rbp,2)
 2b6:	65 6f                	outsl  %gs:(%rsi),(%dx)
 2b8:	75 74                	jne    32e <.rodata.str1.1+0x32e>
 2ba:	2c 20                	sub    $0x20,%al
 2bc:	73 77                	jae    335 <.rodata.str1.1+0x335>
 2be:	69 74 63 68 69 6e 67 	imul   $0x20676e69,0x68(%rbx,%riz,2),%esi
 2c5:	20 
 2c6:	74 6f                	je     337 <.rodata.str1.1+0x337>
 2c8:	20 70 6f             	and    %dh,0x6f(%rax)
 2cb:	6c                   	insb   (%dx),%es:(%rdi)
 2cc:	6c                   	insb   (%dx),%es:(%rdi)
 2cd:	69 6e 67 20 6d 6f 64 	imul   $0x646f6d20,0x67(%rsi),%ebp
 2d4:	65 3a 20             	cmp    %gs:(%rax),%ah
 2d7:	6c                   	insb   (%dx),%es:(%rdi)
 2d8:	61                   	(bad)  
 2d9:	73 74                	jae    34f <.rodata.str1.1+0x34f>
 2db:	20 63 6d             	and    %ah,0x6d(%rbx)
 2de:	64                   	fs
 2df:	3d 30 78 25 30       	cmp    $0x30257830,%eax
 2e4:	38 78 0a             	cmp    %bh,0xa(%rax)
 2e7:	00 3c 34             	add    %bh,(%rsp,%rsi,1)
 2ea:	3e                   	ds
 2eb:	68 64 61 2d 69       	pushq  $0x692d6164
 2f0:	6e                   	outsb  %ds:(%rsi),(%dx)
 2f1:	74 65                	je     358 <.rodata.str1.1+0x358>
 2f3:	6c                   	insb   (%dx),%es:(%rdi)
 2f4:	3a 20                	cmp    (%rax),%ah
 2f6:	4e 6f                	rex.WRX outsl %ds:(%rsi),(%dx)
 2f8:	20 72 65             	and    %dh,0x65(%rdx)
 2fb:	73 70                	jae    36d <.rodata.str1.1+0x36d>
 2fd:	6f                   	outsl  %ds:(%rsi),(%dx)
 2fe:	6e                   	outsb  %ds:(%rsi),(%dx)
 2ff:	73 65                	jae    366 <.rodata.str1.1+0x366>
 301:	20 66 72             	and    %ah,0x72(%rsi)
 304:	6f                   	outsl  %ds:(%rsi),(%dx)
 305:	6d                   	insl   (%dx),%es:(%rdi)
 306:	20 63 6f             	and    %ah,0x6f(%rbx)
 309:	64 65 63 2c 20       	fs movslq %fs:%gs:(%rax,%riz,1),%ebp
 30e:	64 69 73 61 62 6c 69 	imul   $0x6e696c62,%fs:0x61(%rbx),%esi
 315:	6e 
 316:	67 20 4d 53          	and    %cl,0x53(%ebp)
 31a:	49 3a 20             	rex.WB cmp (%r8),%spl
 31d:	6c                   	insb   (%dx),%es:(%rdi)
 31e:	61                   	(bad)  
 31f:	73 74                	jae    395 <.rodata.str1.1+0x395>
 321:	20 63 6d             	and    %ah,0x6d(%rbx)
 324:	64                   	fs
 325:	3d 30 78 25 30       	cmp    $0x30257830,%eax
 32a:	38 78 0a             	cmp    %bh,0xa(%rax)
 32d:	00 3c 33             	add    %bh,(%rbx,%rsi,1)
 330:	3e                   	ds
 331:	68 64 61 5f 69       	pushq  $0x695f6164
 336:	6e                   	outsb  %ds:(%rsi),(%dx)
 337:	74 65                	je     39e <.rodata.str1.1+0x39e>
 339:	6c                   	insb   (%dx),%es:(%rdi)
 33a:	3a 20                	cmp    (%rax),%ah
 33c:	61                   	(bad)  
 33d:	7a 78                	jp     3b7 <.rodata.str1.1+0x3b7>
 33f:	5f                   	pop    %rdi
 340:	67                   	addr32
 341:	65                   	gs
 342:	74 5f                	je     3a3 <.rodata.str1.1+0x3a3>
 344:	72 65                	jb     3ab <.rodata.str1.1+0x3ab>
 346:	73 70                	jae    3b8 <.rodata.str1.1+0x3b8>
 348:	6f                   	outsl  %ds:(%rsi),(%dx)
 349:	6e                   	outsb  %ds:(%rsi),(%dx)
 34a:	73 65                	jae    3b1 <.rodata.str1.1+0x3b1>
 34c:	20 74 69 6d          	and    %dh,0x6d(%rcx,%rbp,2)
 350:	65 6f                	outsl  %gs:(%rsi),(%dx)
 352:	75 74                	jne    3c8 <.rodata.str1.1+0x3c8>
 354:	2c 20                	sub    $0x20,%al
 356:	73 77                	jae    3cf <.rodata.str1.1+0x3cf>
 358:	69 74 63 68 69 6e 67 	imul   $0x20676e69,0x68(%rbx,%riz,2),%esi
 35f:	20 
 360:	74 6f                	je     3d1 <.rodata.str1.1+0x3d1>
 362:	20 73 69             	and    %dh,0x69(%rbx)
 365:	6e                   	outsb  %ds:(%rsi),(%dx)
 366:	67 6c                	insb   (%dx),%es:(%edi)
 368:	65                   	gs
 369:	5f                   	pop    %rdi
 36a:	63 6d 64             	movslq 0x64(%rbp),%ebp
 36d:	20 6d 6f             	and    %ch,0x6f(%rbp)
 370:	64 65 3a 20          	fs cmp %fs:%gs:(%rax),%ah
 374:	6c                   	insb   (%dx),%es:(%rdi)
 375:	61                   	(bad)  
 376:	73 74                	jae    3ec <.rodata.str1.1+0x3ec>
 378:	20 63 6d             	and    %ah,0x6d(%rbx)
 37b:	64                   	fs
 37c:	3d 30 78 25 30       	cmp    $0x30257830,%eax
 381:	38 78 0a             	cmp    %bh,0xa(%rax)
 384:	00 3c 34             	add    %bh,(%rsp,%rsi,1)
 387:	3e                   	ds
 388:	68 64 61 2d 69       	pushq  $0x692d6164
 38d:	6e                   	outsb  %ds:(%rsi),(%dx)
 38e:	74 65                	je     3f5 <.rodata.str1.1+0x3f5>
 390:	6c                   	insb   (%dx),%es:(%rdi)
 391:	3a 20                	cmp    (%rax),%ah
 393:	43 6f                	rex.XB outsl %ds:(%rsi),(%dx)
 395:	64 65 63 20          	fs movslq %fs:%gs:(%rax),%esp
 399:	23 25 64 20 70 72    	and    0x72702064(%rip),%esp        # 72702403 <azx_attach_pcm_stream+0x7270074a>
 39f:	6f                   	outsl  %ds:(%rsi),(%dx)
 3a0:	62                   	(bad)  
 3a1:	65 20 65 72          	and    %ah,%gs:0x72(%rbp)
 3a5:	72 6f                	jb     416 <.rodata.str1.1+0x416>
 3a7:	72 3b                	jb     3e4 <.rodata.str1.1+0x3e4>
 3a9:	20 64 69 73          	and    %ah,0x73(%rcx,%rbp,2)
 3ad:	61                   	(bad)  
 3ae:	62                   	(bad)  
 3af:	6c                   	insb   (%dx),%es:(%rdi)
 3b0:	69 6e 67 20 69 74 2e 	imul   $0x2e746920,0x67(%rsi),%ebp
 3b7:	2e 2e 0a 00          	cs or  %cs:(%rax),%al
 3bb:	3c 33                	cmp    $0x33,%al
 3bd:	3e                   	ds
 3be:	68 64 61 2d 69       	pushq  $0x692d6164
 3c3:	6e                   	outsb  %ds:(%rsi),(%dx)
 3c4:	74 65                	je     42b <.rodata.str1.1+0x42b>
 3c6:	6c                   	insb   (%dx),%es:(%rdi)
 3c7:	3a 20                	cmp    (%rax),%ah
 3c9:	6e                   	outsb  %ds:(%rsi),(%dx)
 3ca:	6f                   	outsl  %ds:(%rsi),(%dx)
 3cb:	20 63 6f             	and    %ah,0x6f(%rbx)
 3ce:	64 65 63 73 20       	fs movslq %fs:%gs:0x20(%rbx),%esi
 3d3:	69 6e 69 74 69 61 6c 	imul   $0x6c616974,0x69(%rsi),%ebp
 3da:	69 7a 65 64 0a 00 73 	imul   $0x73000a64,0x65(%rdx),%edi
 3e1:	6e                   	outsb  %ds:(%rsi),(%dx)
 3e2:	64                   	fs
 3e3:	5f                   	pop    %rdi
 3e4:	68 64 61 5f 69       	pushq  $0x695f6164
 3e9:	6e                   	outsb  %ds:(%rsi),(%dx)
 3ea:	74 65                	je     451 <.rodata.str1.1+0x451>
 3ec:	6c                   	insb   (%dx),%es:(%rdi)
 3ed:	00 3c 33             	add    %bh,(%rbx,%rsi,1)
 3f0:	3e                   	ds
 3f1:	68 64 61 2d 69       	pushq  $0x692d6164
 3f6:	6e                   	outsb  %ds:(%rsi),(%dx)
 3f7:	74 65                	je     45e <.rodata.str1.1+0x45e>
 3f9:	6c                   	insb   (%dx),%es:(%rdi)
 3fa:	3a 20                	cmp    (%rax),%ah
 3fc:	49 6e                	rex.WB outsb %ds:(%rsi),(%dx)
 3fe:	76 61                	jbe    461 <.rodata.str1.1+0x461>
 400:	6c                   	insb   (%dx),%es:(%rdi)
 401:	69 64 20 50 43 4d 20 	imul   $0x64204d43,0x50(%rax,%riz,1),%esp
 408:	64 
 409:	65                   	gs
 40a:	76 69                	jbe    475 <.rodata.str1.1+0x475>
 40c:	63 65 20             	movslq 0x20(%rbp),%esp
 40f:	6e                   	outsb  %ds:(%rsi),(%dx)
 410:	75 6d                	jne    47f <.rodata.str1.1+0x47f>
 412:	62                   	(bad)  
 413:	65                   	gs
 414:	72 20                	jb     436 <.rodata.str1.1+0x436>
 416:	25 64 0a 00 3c       	and    $0x3c000a64,%eax
 41b:	33 3e                	xor    (%rsi),%edi
 41d:	68 64 61 2d 69       	pushq  $0x692d6164
 422:	6e                   	outsb  %ds:(%rsi),(%dx)
 423:	74 65                	je     48a <.rodata.str1.1+0x48a>
 425:	6c                   	insb   (%dx),%es:(%rdi)
 426:	3a 20                	cmp    (%rax),%ah
 428:	50                   	push   %rax
 429:	43                   	rex.XB
 42a:	4d 20 25 64 20 61 6c 	rex.WRB and %r12b,0x6c612064(%rip)        # 6c612495 <azx_attach_pcm_stream+0x6c6107dc>
 431:	72 65                	jb     498 <.rodata.str1.1+0x498>
 433:	61                   	(bad)  
 434:	64                   	fs
 435:	79 20                	jns    457 <.rodata.str1.1+0x457>
 437:	65                   	gs
 438:	78 69                	js     4a3 <.rodata.str1.1+0x4a3>
 43a:	73 74                	jae    4b0 <.rodata.str1.1+0x4b0>
 43c:	73 0a                	jae    448 <.rodata.str1.1+0x448>
 43e:	00 3c 33             	add    %bh,(%rbx,%rsi,1)
 441:	3e                   	ds
 442:	68 64 61 2d 69       	pushq  $0x692d6164
 447:	6e                   	outsb  %ds:(%rsi),(%dx)
 448:	74 65                	je     4af <.rodata.str1.1+0x4af>
 44a:	6c                   	insb   (%dx),%es:(%rdi)
 44b:	3a 20                	cmp    (%rax),%ah
 44d:	45 72 72             	rex.RB jb 4c2 <.rodata.str1.1+0x4c2>
 450:	6f                   	outsl  %ds:(%rsi),(%dx)
 451:	72 20                	jb     473 <.rodata.str1.1+0x473>
 453:	63 72 65             	movslq 0x65(%rdx),%esi
 456:	61                   	(bad)  
 457:	74 69                	je     4c2 <.rodata.str1.1+0x4c2>
 459:	6e                   	outsb  %ds:(%rsi),(%dx)
 45a:	67 20 63 61          	and    %ah,0x61(%ebx)
 45e:	72 64                	jb     4c4 <.rodata.str1.1+0x4c4>
 460:	21 0a                	and    %ecx,(%rdx)
 462:	00 3c 33             	add    %bh,(%rbx,%rsi,1)
 465:	3e                   	ds
 466:	68 64 61 2d 69       	pushq  $0x692d6164
 46b:	6e                   	outsb  %ds:(%rsi),(%dx)
 46c:	74 65                	je     4d3 <.rodata.str1.1+0x4d3>
 46e:	6c                   	insb   (%dx),%es:(%rdi)
 46f:	3a 20                	cmp    (%rax),%ah
 471:	63 61 6e             	movslq 0x6e(%rcx),%esp
 474:	6e                   	outsb  %ds:(%rsi),(%dx)
 475:	6f                   	outsl  %ds:(%rsi),(%dx)
 476:	74 20                	je     498 <.rodata.str1.1+0x498>
 478:	61                   	(bad)  
 479:	6c                   	insb   (%dx),%es:(%rdi)
 47a:	6c                   	insb   (%dx),%es:(%rdi)
 47b:	6f                   	outsl  %ds:(%rsi),(%dx)
 47c:	63 61 74             	movslq 0x74(%rcx),%esp
 47f:	65 20 63 68          	and    %ah,%gs:0x68(%rbx)
 483:	69 70 0a 00 26 63 68 	imul   $0x68632600,0xa(%rax),%esi
 48a:	69 70 2d 3e 6f 70 65 	imul   $0x65706f3e,0x2d(%rax),%esi
 491:	6e                   	outsb  %ds:(%rsi),(%dx)
 492:	5f                   	pop    %rdi
 493:	6d                   	insl   (%dx),%es:(%rdi)
 494:	75 74                	jne    50a <.rodata.str1.1+0x50a>
 496:	65                   	gs
 497:	78 00                	js     499 <.rodata.str1.1+0x499>
 499:	3c 36                	cmp    $0x36,%al
 49b:	3e                   	ds
 49c:	68 64 61 5f 69       	pushq  $0x695f6164
 4a1:	6e                   	outsb  %ds:(%rsi),(%dx)
 4a2:	74 65                	je     509 <.rodata.str1.1+0x509>
 4a4:	6c                   	insb   (%dx),%es:(%rdi)
 4a5:	3a 20                	cmp    (%rax),%ah
 4a7:	6d                   	insl   (%dx),%es:(%rdi)
 4a8:	73 69                	jae    513 <.rodata.str1.1+0x513>
 4aa:	20 66 6f             	and    %ah,0x6f(%rsi)
 4ad:	72 20                	jb     4cf <.rodata.str1.1+0x4cf>
 4af:	64                   	fs
 4b0:	65                   	gs
 4b1:	76 69                	jbe    51c <.rodata.str1.1+0x51c>
 4b3:	63 65 20             	movslq 0x20(%rbp),%esp
 4b6:	25 30 34 78 3a       	and    $0x3a783430,%eax
 4bb:	25 30 34 78 20       	and    $0x20783430,%eax
 4c0:	73 65                	jae    527 <.rodata.str1.1+0x527>
 4c2:	74 20                	je     4e4 <.rodata.str1.1+0x4e4>
 4c4:	74 6f                	je     535 <.rodata.str1.1+0x535>
 4c6:	20 25 64 0a 00 3c    	and    %ah,0x3c000a64(%rip)        # 3c000f30 <azx_attach_pcm_stream+0x3bfff277>
 4cc:	36                   	ss
 4cd:	3e                   	ds
 4ce:	68 64 61 5f 69       	pushq  $0x695f6164
 4d3:	6e                   	outsb  %ds:(%rsi),(%dx)
 4d4:	74 65                	je     53b <.rodata.str1.1+0x53b>
 4d6:	6c                   	insb   (%dx),%es:(%rdi)
 4d7:	3a 20                	cmp    (%rax),%ah
 4d9:	44 69 73 61 62 6c 65 	imul   $0x20656c62,0x61(%rbx),%r14d
 4e0:	20 
 4e1:	4d 53                	rex.WRB push %r11
 4e3:	49 20 66 6f          	rex.WB and %spl,0x6f(%r14)
 4e7:	72 20                	jb     509 <.rodata.str1.1+0x509>
 4e9:	4e 76 69             	rex.WRX jbe 555 <.rodata.str1.1+0x555>
 4ec:	64 69 61 20 63 68 69 	imul   $0x70696863,%fs:0x20(%rcx),%esp
 4f3:	70 
 4f4:	73 65                	jae    55b <.rodata.str1.1+0x55b>
 4f6:	74 0a                	je     502 <.rodata.str1.1+0x502>
 4f8:	00 3c 36             	add    %bh,(%rsi,%rsi,1)
 4fb:	3e                   	ds
 4fc:	68 64 61 5f 69       	pushq  $0x695f6164
 501:	6e                   	outsb  %ds:(%rsi),(%dx)
 502:	74 65                	je     569 <.rodata.str1.1+0x569>
 504:	6c                   	insb   (%dx),%es:(%rdi)
 505:	3a 20                	cmp    (%rax),%ah
 507:	70 6f                	jo     578 <.rodata.str1.1+0x578>
 509:	73 69                	jae    574 <.rodata.str1.1+0x574>
 50b:	74 69                	je     576 <.rodata.str1.1+0x576>
 50d:	6f                   	outsl  %ds:(%rsi),(%dx)
 50e:	6e                   	outsb  %ds:(%rsi),(%dx)
 50f:	5f                   	pop    %rdi
 510:	66 69 78 20 73 65    	imul   $0x6573,0x20(%rax),%di
 516:	74 20                	je     538 <.rodata.str1.1+0x538>
 518:	74 6f                	je     589 <.rodata.str1.1+0x589>
 51a:	20 25 64 20 66 6f    	and    %ah,0x6f662064(%rip)        # 6f662584 <azx_attach_pcm_stream+0x6f6608cb>
 520:	72 20                	jb     542 <.rodata.str1.1+0x542>
 522:	64                   	fs
 523:	65                   	gs
 524:	76 69                	jbe    58f <.rodata.str1.1+0x58f>
 526:	63 65 20             	movslq 0x20(%rbp),%esp
 529:	25 30 34 78 3a       	and    $0x3a783430,%eax
 52e:	25 30 34 78 0a       	and    $0xa783430,%eax
 533:	00 3c 36             	add    %bh,(%rsi,%rsi,1)
 536:	3e                   	ds
 537:	68 64 61 5f 69       	pushq  $0x695f6164
 53c:	6e                   	outsb  %ds:(%rsi),(%dx)
 53d:	74 65                	je     5a4 <.rodata.str1.1+0x5a4>
 53f:	6c                   	insb   (%dx),%es:(%rdi)
 540:	3a 20                	cmp    (%rax),%ah
 542:	70 72                	jo     5b6 <.rodata.str1.1+0x5b6>
 544:	6f                   	outsl  %ds:(%rsi),(%dx)
 545:	62                   	(bad)  
 546:	65                   	gs
 547:	5f                   	pop    %rdi
 548:	6d                   	insl   (%dx),%es:(%rdi)
 549:	61                   	(bad)  
 54a:	73 6b                	jae    5b7 <.rodata.str1.1+0x5b7>
 54c:	20 73 65             	and    %dh,0x65(%rbx)
 54f:	74 20                	je     571 <.rodata.str1.1+0x571>
 551:	74 6f                	je     5c2 <.rodata.str1.1+0x5c2>
 553:	20 30                	and    %dh,(%rax)
 555:	78 25                	js     57c <.rodata.str1.1+0x57c>
 557:	78 20                	js     579 <.rodata.str1.1+0x579>
 559:	66 6f                	outsw  %ds:(%rsi),(%dx)
 55b:	72 20                	jb     57d <.rodata.str1.1+0x57d>
 55d:	64                   	fs
 55e:	65                   	gs
 55f:	76 69                	jbe    5ca <.rodata.str1.1+0x5ca>
 561:	63 65 20             	movslq 0x20(%rbp),%esp
 564:	25 30 34 78 3a       	and    $0x3a783430,%eax
 569:	25 30 34 78 0a       	and    $0xa783430,%eax
 56e:	00 3c 36             	add    %bh,(%rsi,%rsi,1)
 571:	3e                   	ds
 572:	68 64 61 5f 69       	pushq  $0x695f6164
 577:	6e                   	outsb  %ds:(%rsi),(%dx)
 578:	74 65                	je     5df <.rodata.str1.1+0x5df>
 57a:	6c                   	insb   (%dx),%es:(%rdi)
 57b:	3a 20                	cmp    (%rax),%ah
 57d:	63 6f 64             	movslq 0x64(%rdi),%ebp
 580:	65 63 5f 6d          	movslq %gs:0x6d(%rdi),%ebx
 584:	61                   	(bad)  
 585:	73 6b                	jae    5f2 <.rodata.str1.1+0x5f2>
 587:	20 66 6f             	and    %ah,0x6f(%rsi)
 58a:	72 63                	jb     5ef <.rodata.str1.1+0x5ef>
 58c:	65 64 20 74 6f 20    	gs and %dh,%fs:%gs:0x20(%rdi,%rbp,2)
 592:	30 78 25             	xor    %bh,0x25(%rax)
 595:	78 0a                	js     5a1 <.rodata.str1.1+0x5a1>
 597:	00 49 43             	add    %cl,0x43(%rcx)
 59a:	48 20 48 44          	rex.W and %cl,0x44(%rax)
 59e:	20 61 75             	and    %ah,0x75(%rcx)
 5a1:	64 69 6f 00 3c 33 3e 	imul   $0x683e333c,%fs:0x0(%rdi),%ebp
 5a8:	68 
 5a9:	64                   	fs
 5aa:	61                   	(bad)  
 5ab:	2d 69 6e 74 65       	sub    $0x65746e69,%eax
 5b0:	6c                   	insb   (%dx),%es:(%rdi)
 5b1:	3a 20                	cmp    (%rax),%ah
 5b3:	69 6f 72 65 6d 61 70 	imul   $0x70616d65,0x72(%rdi),%ebp
 5ba:	20 65 72             	and    %ah,0x72(%rbp)
 5bd:	72 6f                	jb     62e <.rodata.str1.1+0x62e>
 5bf:	72 0a                	jb     5cb <.rodata.str1.1+0x5cb>
 5c1:	00 3c 33             	add    %bh,(%rbx,%rsi,1)
 5c4:	3e                   	ds
 5c5:	68 64 61 2d 69       	pushq  $0x692d6164
 5ca:	6e                   	outsb  %ds:(%rsi),(%dx)
 5cb:	74 65                	je     632 <.rodata.str1.1+0x632>
 5cd:	6c                   	insb   (%dx),%es:(%rdi)
 5ce:	3a 20                	cmp    (%rax),%ah
 5d0:	63 61 6e             	movslq 0x6e(%rcx),%esp
 5d3:	6e                   	outsb  %ds:(%rsi),(%dx)
 5d4:	6f                   	outsl  %ds:(%rsi),(%dx)
 5d5:	74 20                	je     5f7 <.rodata.str1.1+0x5f7>
 5d7:	6d                   	insl   (%dx),%es:(%rdi)
 5d8:	61                   	(bad)  
 5d9:	6c                   	insb   (%dx),%es:(%rdi)
 5da:	6c                   	insb   (%dx),%es:(%rdi)
 5db:	6f                   	outsl  %ds:(%rsi),(%dx)
 5dc:	63 20                	movslq (%rax),%esp
 5de:	61                   	(bad)  
 5df:	7a 78                	jp     659 <.rodata.str1.1+0x659>
 5e1:	5f                   	pop    %rdi
 5e2:	64                   	fs
 5e3:	65                   	gs
 5e4:	76 0a                	jbe    5f0 <.rodata.str1.1+0x5f0>
 5e6:	00 3c 33             	add    %bh,(%rbx,%rsi,1)
 5e9:	3e                   	ds
 5ea:	68 64 61 2d 69       	pushq  $0x692d6164
 5ef:	6e                   	outsb  %ds:(%rsi),(%dx)
 5f0:	74 65                	je     657 <.rodata.str1.1+0x657>
 5f2:	6c                   	insb   (%dx),%es:(%rdi)
 5f3:	3a 20                	cmp    (%rax),%ah
 5f5:	63 61 6e             	movslq 0x6e(%rcx),%esp
 5f8:	6e                   	outsb  %ds:(%rsi),(%dx)
 5f9:	6f                   	outsl  %ds:(%rsi),(%dx)
 5fa:	74 20                	je     61c <.rodata.str1.1+0x61c>
 5fc:	61                   	(bad)  
 5fd:	6c                   	insb   (%dx),%es:(%rdi)
 5fe:	6c                   	insb   (%dx),%es:(%rdi)
 5ff:	6f                   	outsl  %ds:(%rsi),(%dx)
 600:	63 61 74             	movslq 0x74(%rcx),%esp
 603:	65 20 42 44          	and    %al,%gs:0x44(%rdx)
 607:	4c 0a 00             	rex.WR or (%rax),%r8b
 60a:	3c 33                	cmp    $0x33,%al
 60c:	3e                   	ds
 60d:	68 64 61 2d 69       	pushq  $0x692d6164
 612:	6e                   	outsb  %ds:(%rsi),(%dx)
 613:	74 65                	je     67a <.rodata.str1.1+0x67a>
 615:	6c                   	insb   (%dx),%es:(%rdi)
 616:	3a 20                	cmp    (%rax),%ah
 618:	63 61 6e             	movslq 0x6e(%rcx),%esp
 61b:	6e                   	outsb  %ds:(%rsi),(%dx)
 61c:	6f                   	outsl  %ds:(%rsi),(%dx)
 61d:	74 20                	je     63f <.rodata.str1.1+0x63f>
 61f:	61                   	(bad)  
 620:	6c                   	insb   (%dx),%es:(%rdi)
 621:	6c                   	insb   (%dx),%es:(%rdi)
 622:	6f                   	outsl  %ds:(%rsi),(%dx)
 623:	63 61 74             	movslq 0x74(%rcx),%esp
 626:	65 20 70 6f          	and    %dh,%gs:0x6f(%rax)
 62a:	73 62                	jae    68e <.rodata.str1.1+0x68e>
 62c:	75 66                	jne    694 <.rodata.str1.1+0x694>
 62e:	0a 00                	or     (%rax),%al
 630:	3c 33                	cmp    $0x33,%al
 632:	3e                   	ds
 633:	68 64 61 2d 69       	pushq  $0x692d6164
 638:	6e                   	outsb  %ds:(%rsi),(%dx)
 639:	74 65                	je     6a0 <.rodata.str1.1+0x6a0>
 63b:	6c                   	insb   (%dx),%es:(%rdi)
 63c:	3a 20                	cmp    (%rax),%ah
 63e:	63 61 6e             	movslq 0x6e(%rcx),%esp
 641:	6e                   	outsb  %ds:(%rsi),(%dx)
 642:	6f                   	outsl  %ds:(%rsi),(%dx)
 643:	74 20                	je     665 <.rodata.str1.1+0x665>
 645:	61                   	(bad)  
 646:	6c                   	insb   (%dx),%es:(%rdi)
 647:	6c                   	insb   (%dx),%es:(%rdi)
 648:	6f                   	outsl  %ds:(%rsi),(%dx)
 649:	63 61 74             	movslq 0x74(%rcx),%esp
 64c:	65 20 43 4f          	and    %al,%gs:0x4f(%rbx)
 650:	52                   	push   %rdx
 651:	42 2f                	rex.X (bad) 
 653:	52                   	push   %rdx
 654:	49 52                	rex.WB push %r10
 656:	42 0a 00             	rex.X or (%rax),%al
 659:	3c 33                	cmp    $0x33,%al
 65b:	3e                   	ds
 65c:	68 64 61 2d 69       	pushq  $0x692d6164
 661:	6e                   	outsb  %ds:(%rsi),(%dx)
 662:	74 65                	je     6c9 <.rodata.str1.1+0x6c9>
 664:	6c                   	insb   (%dx),%es:(%rdi)
 665:	3a 20                	cmp    (%rax),%ah
 667:	6e                   	outsb  %ds:(%rsi),(%dx)
 668:	6f                   	outsl  %ds:(%rsi),(%dx)
 669:	20 63 6f             	and    %ah,0x6f(%rbx)
 66c:	64 65 63 73 20       	fs movslq %fs:%gs:0x20(%rbx),%esi
 671:	66 6f                	outsw  %ds:(%rsi),(%dx)
 673:	75 6e                	jne    6e3 <.rodata.str1.1+0x6e3>
 675:	64 21 0a             	and    %ecx,%fs:(%rdx)
 678:	00 3c 33             	add    %bh,(%rbx,%rsi,1)
 67b:	3e                   	ds
 67c:	68 64 61 2d 69       	pushq  $0x692d6164
 681:	6e                   	outsb  %ds:(%rsi),(%dx)
 682:	74 65                	je     6e9 <.rodata.str1.1+0x6e9>
 684:	6c                   	insb   (%dx),%es:(%rdi)
 685:	3a 20                	cmp    (%rax),%ah
 687:	45 72 72             	rex.RB jb 6fc <.rodata.str1.1+0x6fc>
 68a:	6f                   	outsl  %ds:(%rsi),(%dx)
 68b:	72 20                	jb     6ad <.rodata.str1.1+0x6ad>
 68d:	63 72 65             	movslq 0x65(%rdx),%esi
 690:	61                   	(bad)  
 691:	74 69                	je     6fc <.rodata.str1.1+0x6fc>
 693:	6e                   	outsb  %ds:(%rsi),(%dx)
 694:	67 20 64 65 76       	and    %ah,0x76(%ebp,%eiz,2)
 699:	69 63 65 20 5b 63 61 	imul   $0x61635b20,0x65(%rbx),%esp
 6a0:	72 64                	jb     706 <.rodata.str1.1+0x706>
 6a2:	5d                   	pop    %rbp
 6a3:	21 0a                	and    %ecx,(%rdx)
 6a5:	00 48 44             	add    %cl,0x44(%rax)
 6a8:	41 2d 49 6e 74 65    	rex.B sub $0x65746e49,%eax
 6ae:	6c                   	insb   (%dx),%es:(%rdi)
 6af:	00 25 73 20 61 74    	add    %ah,0x74612073(%rip)        # 74612728 <azx_attach_pcm_stream+0x74610a6f>
 6b5:	20 30                	and    %dh,(%rax)
 6b7:	78 25                	js     6de <.rodata.str1.1+0x6de>
 6b9:	6c                   	insb   (%dx),%es:(%rdi)
 6ba:	78 20                	js     6dc <.rodata.str1.1+0x6dc>
 6bc:	69 72 71 20 25 69 00 	imul   $0x692520,0x71(%rdx),%esi
 6c3:	3c 33                	cmp    $0x33,%al
 6c5:	3e                   	ds
 6c6:	68 64 61 2d 69       	pushq  $0x692d6164
 6cb:	6e                   	outsb  %ds:(%rsi),(%dx)
 6cc:	74 65                	je     733 <.rodata.str1.1+0x733>
 6ce:	6c                   	insb   (%dx),%es:(%rdi)
 6cf:	3a 20                	cmp    (%rax),%ah
 6d1:	41 70 70             	rex.B jo 744 <.rodata.str1.1+0x744>
 6d4:	6c                   	insb   (%dx),%es:(%rdi)
 6d5:	79 69                	jns    740 <.rodata.str1.1+0x740>
 6d7:	6e                   	outsb  %ds:(%rsi),(%dx)
 6d8:	67 20 70 61          	and    %dh,0x61(%eax)
 6dc:	74 63                	je     741 <.rodata.str1.1+0x741>
 6de:	68 20 66 69 72       	pushq  $0x72696620
 6e3:	6d                   	insl   (%dx),%es:(%rdi)
 6e4:	77 61                	ja     747 <.rodata.str1.1+0x747>
 6e6:	72 65                	jb     74d <.rodata.str1.1+0x74d>
 6e8:	20 27                	and    %ah,(%rdi)
 6ea:	25 73 27 0a 00       	and    $0xa2773,%eax
 6ef:	48                   	rex.W
 6f0:	44                   	rex.R
 6f1:	41 20 49 6e          	and    %cl,0x6e(%r9)
 6f5:	74 65                	je     75c <.rodata.str1.1+0x75c>
 6f7:	6c                   	insb   (%dx),%es:(%rdi)
 6f8:	00 48 44             	add    %cl,0x44(%rax)
 6fb:	41 20 49 6e          	and    %cl,0x6e(%r9)
 6ff:	74 65                	je     766 <.rodata.str1.1+0x766>
 701:	6c                   	insb   (%dx),%es:(%rdi)
 702:	20 50 43             	and    %dl,0x43(%rax)
 705:	48 00 48 44          	rex.W add %cl,0x44(%rax)
 709:	41 20 49 6e          	and    %cl,0x6e(%r9)
 70d:	74 65                	je     774 <.rodata.str1.1+0x774>
 70f:	6c                   	insb   (%dx),%es:(%rdi)
 710:	20 4d 49             	and    %cl,0x49(%rbp)
 713:	44 00 48 44          	add    %r9b,0x44(%rax)
 717:	41 20 41 54          	and    %al,0x54(%r9)
 71b:	49 20 53 42          	rex.WB and %dl,0x42(%r11)
 71f:	00 48 44             	add    %cl,0x44(%rax)
 722:	41 20 41 54          	and    %al,0x54(%r9)
 726:	49 20 48 44          	rex.WB and %cl,0x44(%r8)
 72a:	4d                   	rex.WRB
 72b:	49 00 48 44          	rex.WB add %cl,0x44(%r8)
 72f:	41 20 56 49          	and    %dl,0x49(%r14)
 733:	41 20 56 54          	and    %dl,0x54(%r14)
 737:	38 32                	cmp    %dh,(%rdx)
 739:	78 78                	js     7b3 <__mod_alias139+0x7>
 73b:	00 48 44             	add    %cl,0x44(%rax)
 73e:	41 20 53 49          	and    %dl,0x49(%r11)
 742:	53                   	push   %rbx
 743:	39 36                	cmp    %esi,(%rsi)
 745:	36 00 48 44          	add    %cl,%ss:0x44(%rax)
 749:	41 20 55 4c          	and    %dl,0x4c(%r13)
 74d:	49 20 4d 35          	rex.WB and %cl,0x35(%r13)
 751:	34 36                	xor    $0x36,%al
 753:	31 00                	xor    %eax,(%rax)
 755:	48                   	rex.W
 756:	44                   	rex.R
 757:	41 20 4e 56          	and    %cl,0x56(%r14)
 75b:	69 64 69 61 00 48 44 	imul   $0x41444800,0x61(%rcx,%rbp,2),%esp
 762:	41 
 763:	20 54 65 72          	and    %dl,0x72(%rbp,%riz,2)
 767:	61                   	(bad)  
 768:	64 69 63 69 00 48 44 	imul   $0x41444800,%fs:0x69(%rbx),%esp
 76f:	41 
 770:	20 43 72             	and    %al,0x72(%rbx)
 773:	65                   	gs
 774:	61                   	(bad)  
 775:	74 69                	je     7e0 <__mod_alias138+0x9>
 777:	76 65                	jbe    7de <__mod_alias138+0x7>
 779:	00 48 44             	add    %cl,0x44(%rax)
 77c:	2d 41 75 64 69       	sub    $0x69647541,%eax
 781:	6f                   	outsl  %ds:(%rsi),(%dx)
 782:	20 47 65             	and    %al,0x65(%rdi)
 785:	6e                   	outsb  %ds:(%rsi),(%dx)
 786:	65                   	gs
 787:	72 69                	jb     7f2 <__mod_alias138+0x1b>
 789:	63 00                	movslq (%rax),%eax

Disassembly of section .parainstructions:

0000000000000000 <.parainstructions>:
	...
   8:	31 07                	xor    %eax,(%rdi)
   a:	01 00                	add    %eax,(%rax)
	...
  18:	31 07                	xor    %eax,(%rdi)
  1a:	01 00                	add    %eax,(%rax)
	...
  28:	31 07                	xor    %eax,(%rdi)
  2a:	01 00                	add    %eax,(%rax)
	...
  38:	31 07                	xor    %eax,(%rdi)
  3a:	01 00                	add    %eax,(%rax)
	...
  48:	31 07                	xor    %eax,(%rdi)
  4a:	01 00                	add    %eax,(%rax)
	...
  58:	31 07                	xor    %eax,(%rdi)
  5a:	01 00                	add    %eax,(%rax)
	...
  68:	31 07                	xor    %eax,(%rdi)
  6a:	01 00                	add    %eax,(%rax)
	...
  78:	31 07                	xor    %eax,(%rdi)
  7a:	01 00                	add    %eax,(%rax)

Disassembly of section .modinfo:

0000000000000000 <__mod_description147>:
   0:	64                   	fs
   1:	65                   	gs
   2:	73 63                	jae    67 <__mod_power_save_controller116+0x3e>
   4:	72 69                	jb     6f <__mod_power_save_controllertype115+0x6>
   6:	70 74                	jo     7c <__mod_power_save_controllertype115+0x13>
   8:	69 6f 6e 3d 49 6e 74 	imul   $0x746e493d,0x6e(%rdi),%ebp
   f:	65                   	gs
  10:	6c                   	insb   (%dx),%es:(%rdi)
  11:	20 48 44             	and    %cl,0x44(%rax)
  14:	41 20 64 72 69       	and    %spl,0x69(%r10,%rsi,2)
  19:	76 65                	jbe    80 <__mod_power_save_controllertype115+0x17>
  1b:	72 00                	jb     1d <__mod_license119>

000000000000001d <__mod_license119>:
  1d:	6c                   	insb   (%dx),%es:(%rdi)
  1e:	69 63 65 6e 73 65 3d 	imul   $0x3d65736e,0x65(%rbx),%esp
  25:	47 50                	rex.RXB push %r8
  27:	4c 00 70 61          	rex.WR add %r14b,0x61(%rax)

0000000000000029 <__mod_power_save_controller116>:
  29:	70 61                	jo     8c <__mod_power_save_controllertype115+0x23>
  2b:	72 6d                	jb     9a <__mod_power_save108+0xd>
  2d:	3d 70 6f 77 65       	cmp    $0x65776f70,%eax
  32:	72 5f                	jb     93 <__mod_power_save108+0x6>
  34:	73 61                	jae    97 <__mod_power_save108+0xa>
  36:	76 65                	jbe    9d <__mod_power_save108+0x10>
  38:	5f                   	pop    %rdi
  39:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
  3c:	74 72                	je     b0 <__mod_power_save108+0x23>
  3e:	6f                   	outsl  %ds:(%rsi),(%dx)
  3f:	6c                   	insb   (%dx),%es:(%rdi)
  40:	6c                   	insb   (%dx),%es:(%rdi)
  41:	65                   	gs
  42:	72 3a                	jb     7e <__mod_power_save_controllertype115+0x15>
  44:	52                   	push   %rdx
  45:	65                   	gs
  46:	73 65                	jae    ad <__mod_power_save108+0x20>
  48:	74 20                	je     6a <__mod_power_save_controllertype115+0x1>
  4a:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
  4d:	74 72                	je     c1 <__mod_power_save108+0x34>
  4f:	6f                   	outsl  %ds:(%rsi),(%dx)
  50:	6c                   	insb   (%dx),%es:(%rdi)
  51:	6c                   	insb   (%dx),%es:(%rdi)
  52:	65                   	gs
  53:	72 20                	jb     75 <__mod_power_save_controllertype115+0xc>
  55:	69 6e 20 70 6f 77 65 	imul   $0x65776f70,0x20(%rsi),%ebp
  5c:	72 20                	jb     7e <__mod_power_save_controllertype115+0x15>
  5e:	73 61                	jae    c1 <__mod_power_save108+0x34>
  60:	76 65                	jbe    c7 <__mod_power_save108+0x3a>
  62:	20 6d 6f             	and    %ch,0x6f(%rbp)
  65:	64 65 2e 00 70 61    	fs gs add %dh,%cs:%fs:%gs:0x61(%rax)

0000000000000069 <__mod_power_save_controllertype115>:
  69:	70 61                	jo     cc <__mod_power_save108+0x3f>
  6b:	72 6d                	jb     da <__mod_power_savetype106+0x4>
  6d:	74 79                	je     e8 <__mod_power_savetype106+0x12>
  6f:	70 65                	jo     d6 <__mod_power_savetype106>
  71:	3d 70 6f 77 65       	cmp    $0x65776f70,%eax
  76:	72 5f                	jb     d7 <__mod_power_savetype106+0x1>
  78:	73 61                	jae    db <__mod_power_savetype106+0x5>
  7a:	76 65                	jbe    e1 <__mod_power_savetype106+0xb>
  7c:	5f                   	pop    %rdi
  7d:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
  80:	74 72                	je     f4 <__mod_beep_mode101+0x6>
  82:	6f                   	outsl  %ds:(%rsi),(%dx)
  83:	6c                   	insb   (%dx),%es:(%rdi)
  84:	6c                   	insb   (%dx),%es:(%rdi)
  85:	65                   	gs
  86:	72 3a                	jb     c2 <__mod_power_save108+0x35>
  88:	62                   	(bad)  
  89:	6f                   	outsl  %ds:(%rsi),(%dx)
  8a:	6f                   	outsl  %ds:(%rsi),(%dx)
  8b:	6c                   	insb   (%dx),%es:(%rdi)
	...

000000000000008d <__mod_power_save108>:
  8d:	70 61                	jo     f0 <__mod_beep_mode101+0x2>
  8f:	72 6d                	jb     fe <__mod_beep_mode101+0x10>
  91:	3d 70 6f 77 65       	cmp    $0x65776f70,%eax
  96:	72 5f                	jb     f7 <__mod_beep_mode101+0x9>
  98:	73 61                	jae    fb <__mod_beep_mode101+0xd>
  9a:	76 65                	jbe    101 <__mod_beep_mode101+0x13>
  9c:	3a 41 75             	cmp    0x75(%rcx),%al
  9f:	74 6f                	je     110 <__mod_beep_mode101+0x22>
  a1:	6d                   	insl   (%dx),%es:(%rdi)
  a2:	61                   	(bad)  
  a3:	74 69                	je     10e <__mod_beep_mode101+0x20>
  a5:	63 20                	movslq (%rax),%esp
  a7:	70 6f                	jo     118 <__mod_beep_mode101+0x2a>
  a9:	77 65                	ja     110 <__mod_beep_mode101+0x22>
  ab:	72 2d                	jb     da <__mod_power_savetype106+0x4>
  ad:	73 61                	jae    110 <__mod_beep_mode101+0x22>
  af:	76 69                	jbe    11a <__mod_beep_mode101+0x2c>
  b1:	6e                   	outsb  %ds:(%rsi),(%dx)
  b2:	67 20 74 69 6d       	and    %dh,0x6d(%ecx,%ebp,2)
  b7:	65 6f                	outsl  %gs:(%rsi),(%dx)
  b9:	75 74                	jne    12f <__mod_beep_mode101+0x41>
  bb:	20 28                	and    %ch,(%rax)
  bd:	69 6e 20 73 65 63 6f 	imul   $0x6f636573,0x20(%rsi),%ebp
  c4:	6e                   	outsb  %ds:(%rsi),(%dx)
  c5:	64                   	fs
  c6:	2c 20                	sub    $0x20,%al
  c8:	30 20                	xor    %ah,(%rax)
  ca:	3d 20 64 69 73       	cmp    $0x73696420,%eax
  cf:	61                   	(bad)  
  d0:	62                   	(bad)  
  d1:	6c                   	insb   (%dx),%es:(%rdi)
  d2:	65 29 2e             	sub    %ebp,%gs:(%rsi)
	...

00000000000000d6 <__mod_power_savetype106>:
  d6:	70 61                	jo     139 <__mod_beep_mode101+0x4b>
  d8:	72 6d                	jb     147 <__mod_beep_mode101+0x59>
  da:	74 79                	je     155 <__mod_beep_modetype99+0x5>
  dc:	70 65                	jo     143 <__mod_beep_mode101+0x55>
  de:	3d 70 6f 77 65       	cmp    $0x65776f70,%eax
  e3:	72 5f                	jb     144 <__mod_beep_mode101+0x56>
  e5:	73 61                	jae    148 <__mod_beep_mode101+0x5a>
  e7:	76 65                	jbe    14e <__mod_beep_mode101+0x60>
  e9:	3a 69 6e             	cmp    0x6e(%rcx),%ch
  ec:	74 00                	je     ee <__mod_beep_mode101>

00000000000000ee <__mod_beep_mode101>:
  ee:	70 61                	jo     151 <__mod_beep_modetype99+0x1>
  f0:	72 6d                	jb     15f <__mod_beep_modetype99+0xf>
  f2:	3d 62 65 65 70       	cmp    $0x70656562,%eax
  f7:	5f                   	pop    %rdi
  f8:	6d                   	insl   (%dx),%es:(%rdi)
  f9:	6f                   	outsl  %ds:(%rsi),(%dx)
  fa:	64 65 3a 53 65       	fs cmp %fs:%gs:0x65(%rbx),%dl
  ff:	6c                   	insb   (%dx),%es:(%rdi)
 100:	65 63 74 20 48       	movslq %gs:0x48(%rax,%riz,1),%esi
 105:	44                   	rex.R
 106:	41 20 42 65          	and    %al,0x65(%r10)
 10a:	65                   	gs
 10b:	70 20                	jo     12d <__mod_beep_mode101+0x3f>
 10d:	72 65                	jb     174 <__mod_patch96+0x4>
 10f:	67 69 73 74 72 61 74 	imul   $0x69746172,0x74(%ebx),%esi
 116:	69 
 117:	6f                   	outsl  %ds:(%rsi),(%dx)
 118:	6e                   	outsb  %ds:(%rsi),(%dx)
 119:	20 6d 6f             	and    %ch,0x6f(%rbp)
 11c:	64 65 20 28          	fs and %ch,%fs:%gs:(%rax)
 120:	30 3d 6f 66 66 2c    	xor    %bh,0x2c66666f(%rip)        # 2c666795 <azx_attach_pcm_stream+0x2c664adc>
 126:	20 31                	and    %dh,(%rcx)
 128:	3d 6f 6e 2c 20       	cmp    $0x202c6e6f,%eax
 12d:	32 3d 6d 75 74 65    	xor    0x6574756d(%rip),%bh        # 657476a0 <azx_attach_pcm_stream+0x657459e7>
 133:	20 73 77             	and    %dh,0x77(%rbx)
 136:	69 74 63 68 20 6f 6e 	imul   $0x2f6e6f20,0x68(%rbx,%riz,2),%esi
 13d:	2f 
 13e:	6f                   	outsl  %ds:(%rsi),(%dx)
 13f:	66 66 29 20          	data32 sub %sp,(%rax)
 143:	28 64 65 66          	sub    %ah,0x66(%rbp,%riz,2)
 147:	61                   	(bad)  
 148:	75 6c                	jne    1b6 <__mod_patchtype95+0x12>
 14a:	74 3d                	je     189 <__mod_patch96+0x19>
 14c:	31 29                	xor    %ebp,(%rcx)
 14e:	2e 00 70 61          	add    %dh,%cs:0x61(%rax)

0000000000000150 <__mod_beep_modetype99>:
 150:	70 61                	jo     1b3 <__mod_patchtype95+0xf>
 152:	72 6d                	jb     1c1 <__mod_patchtype95+0x1d>
 154:	74 79                	je     1cf <__mod_enable_msi93+0xd>
 156:	70 65                	jo     1bd <__mod_patchtype95+0x19>
 158:	3d 62 65 65 70       	cmp    $0x70656562,%eax
 15d:	5f                   	pop    %rdi
 15e:	6d                   	insl   (%dx),%es:(%rdi)
 15f:	6f                   	outsl  %ds:(%rsi),(%dx)
 160:	64 65 3a 61 72       	fs cmp %fs:%gs:0x72(%rcx),%ah
 165:	72 61                	jb     1c8 <__mod_enable_msi93+0x6>
 167:	79 20                	jns    189 <__mod_patch96+0x19>
 169:	6f                   	outsl  %ds:(%rsi),(%dx)
 16a:	66                   	data16
 16b:	20 69 6e             	and    %ch,0x6e(%rcx)
 16e:	74 00                	je     170 <__mod_patch96>

0000000000000170 <__mod_patch96>:
 170:	70 61                	jo     1d3 <__mod_enable_msi93+0x11>
 172:	72 6d                	jb     1e1 <__mod_enable_msi93+0x1f>
 174:	3d 70 61 74 63       	cmp    $0x63746170,%eax
 179:	68 3a 50 61 74       	pushq  $0x7461503a
 17e:	63 68 20             	movslq 0x20(%rax),%ebp
 181:	66 69 6c 65 20 66 6f 	imul   $0x6f66,0x20(%rbp,%riz,2),%bp
 188:	72 20                	jb     1aa <__mod_patchtype95+0x6>
 18a:	49 6e                	rex.WB outsb %ds:(%rsi),(%dx)
 18c:	74 65                	je     1f3 <__mod_enable_msi93+0x31>
 18e:	6c                   	insb   (%dx),%es:(%rdi)
 18f:	20 48 44             	and    %cl,0x44(%rax)
 192:	20 61 75             	and    %ah,0x75(%rcx)
 195:	64 69 6f 20 69 6e 74 	imul   $0x65746e69,%fs:0x20(%rdi),%ebp
 19c:	65 
 19d:	72 66                	jb     205 <__mod_enable_msitype92+0xb>
 19f:	61                   	(bad)  
 1a0:	63 65 2e             	movslq 0x2e(%rbp),%esp
	...

00000000000001a4 <__mod_patchtype95>:
 1a4:	70 61                	jo     207 <__mod_enable_msitype92+0xd>
 1a6:	72 6d                	jb     215 <__mod_single_cmd91+0x3>
 1a8:	74 79                	je     223 <__mod_single_cmd91+0x11>
 1aa:	70 65                	jo     211 <__mod_enable_msitype92+0x17>
 1ac:	3d 70 61 74 63       	cmp    $0x63746170,%eax
 1b1:	68 3a 61 72 72       	pushq  $0x7272613a
 1b6:	61                   	(bad)  
 1b7:	79 20                	jns    1d9 <__mod_enable_msi93+0x17>
 1b9:	6f                   	outsl  %ds:(%rsi),(%dx)
 1ba:	66                   	data16
 1bb:	20 63 68             	and    %ah,0x68(%rbx)
 1be:	61                   	(bad)  
 1bf:	72 70                	jb     231 <__mod_single_cmd91+0x1f>
	...

00000000000001c2 <__mod_enable_msi93>:
 1c2:	70 61                	jo     225 <__mod_single_cmd91+0x13>
 1c4:	72 6d                	jb     233 <__mod_single_cmd91+0x21>
 1c6:	3d 65 6e 61 62       	cmp    $0x62616e65,%eax
 1cb:	6c                   	insb   (%dx),%es:(%rdi)
 1cc:	65                   	gs
 1cd:	5f                   	pop    %rdi
 1ce:	6d                   	insl   (%dx),%es:(%rdi)
 1cf:	73 69                	jae    23a <__mod_single_cmd91+0x28>
 1d1:	3a 45 6e             	cmp    0x6e(%rbp),%al
 1d4:	61                   	(bad)  
 1d5:	62                   	(bad)  
 1d6:	6c                   	insb   (%dx),%es:(%rdi)
 1d7:	65 20 4d 65          	and    %cl,%gs:0x65(%rbp)
 1db:	73 73                	jae    250 <__mod_single_cmd91+0x3e>
 1dd:	61                   	(bad)  
 1de:	67 65 20 53 69       	and    %dl,%gs:0x69(%ebx)
 1e3:	67 6e                	outsb  %ds:(%esi),(%dx)
 1e5:	61                   	(bad)  
 1e6:	6c                   	insb   (%dx),%es:(%rdi)
 1e7:	65 64 20 49 6e       	gs and %cl,%fs:%gs:0x6e(%rcx)
 1ec:	74 65                	je     253 <__mod_single_cmd91+0x41>
 1ee:	72 72                	jb     262 <__mod_single_cmd91+0x50>
 1f0:	75 70                	jne    262 <__mod_single_cmd91+0x50>
 1f2:	74 20                	je     214 <__mod_single_cmd91+0x2>
 1f4:	28 4d 53             	sub    %cl,0x53(%rbp)
 1f7:	49 29 00             	sub    %rax,(%r8)

00000000000001fa <__mod_enable_msitype92>:
 1fa:	70 61                	jo     25d <__mod_single_cmd91+0x4b>
 1fc:	72 6d                	jb     26b <__mod_single_cmdtype89+0x5>
 1fe:	74 79                	je     279 <__mod_single_cmdtype89+0x13>
 200:	70 65                	jo     267 <__mod_single_cmdtype89+0x1>
 202:	3d 65 6e 61 62       	cmp    $0x62616e65,%eax
 207:	6c                   	insb   (%dx),%es:(%rdi)
 208:	65                   	gs
 209:	5f                   	pop    %rdi
 20a:	6d                   	insl   (%dx),%es:(%rdi)
 20b:	73 69                	jae    276 <__mod_single_cmdtype89+0x10>
 20d:	3a 69 6e             	cmp    0x6e(%rcx),%ch
 210:	74 00                	je     212 <__mod_single_cmd91>

0000000000000212 <__mod_single_cmd91>:
 212:	70 61                	jo     275 <__mod_single_cmdtype89+0xf>
 214:	72 6d                	jb     283 <__mod_probe_only88+0x4>
 216:	3d 73 69 6e 67       	cmp    $0x676e6973,%eax
 21b:	6c                   	insb   (%dx),%es:(%rdi)
 21c:	65                   	gs
 21d:	5f                   	pop    %rdi
 21e:	63 6d 64             	movslq 0x64(%rbp),%ebp
 221:	3a 55 73             	cmp    0x73(%rbp),%dl
 224:	65 20 73 69          	and    %dh,%gs:0x69(%rbx)
 228:	6e                   	outsb  %ds:(%rsi),(%dx)
 229:	67 6c                	insb   (%dx),%es:(%edi)
 22b:	65 20 63 6f          	and    %ah,%gs:0x6f(%rbx)
 22f:	6d                   	insl   (%dx),%es:(%rdi)
 230:	6d                   	insl   (%dx),%es:(%rdi)
 231:	61                   	(bad)  
 232:	6e                   	outsb  %ds:(%rsi),(%dx)
 233:	64 20 74 6f 20       	and    %dh,%fs:0x20(%rdi,%rbp,2)
 238:	63 6f 6d             	movslq 0x6d(%rdi),%ebp
 23b:	6d                   	insl   (%dx),%es:(%rdi)
 23c:	75 6e                	jne    2ac <__mod_probe_only88+0x2d>
 23e:	69 63 61 74 65 20 77 	imul   $0x77206574,0x61(%rbx),%esp
 245:	69 74 68 20 63 6f 64 	imul   $0x65646f63,0x20(%rax,%rbp,2),%esi
 24c:	65 
 24d:	63 73 20             	movslq 0x20(%rbx),%esi
 250:	28 66 6f             	sub    %ah,0x6f(%rsi)
 253:	72 20                	jb     275 <__mod_single_cmdtype89+0xf>
 255:	64                   	fs
 256:	65                   	gs
 257:	62                   	(bad)  
 258:	75 67                	jne    2c1 <__mod_probe_onlytype87+0x8>
 25a:	67 69 6e 67 20 6f 6e 	imul   $0x6c6e6f20,0x67(%esi),%ebp
 261:	6c 
 262:	79 29                	jns    28d <__mod_probe_only88+0xe>
 264:	2e 00 70 61          	add    %dh,%cs:0x61(%rax)

0000000000000266 <__mod_single_cmdtype89>:
 266:	70 61                	jo     2c9 <__mod_probe_onlytype87+0x10>
 268:	72 6d                	jb     2d7 <__mod_probe_onlytype87+0x1e>
 26a:	74 79                	je     2e5 <__mod_probe_mask86+0xb>
 26c:	70 65                	jo     2d3 <__mod_probe_onlytype87+0x1a>
 26e:	3d 73 69 6e 67       	cmp    $0x676e6973,%eax
 273:	6c                   	insb   (%dx),%es:(%rdi)
 274:	65                   	gs
 275:	5f                   	pop    %rdi
 276:	63 6d 64             	movslq 0x64(%rbp),%ebp
 279:	3a 62 6f             	cmp    0x6f(%rdx),%ah
 27c:	6f                   	outsl  %ds:(%rsi),(%dx)
 27d:	6c                   	insb   (%dx),%es:(%rdi)
	...

000000000000027f <__mod_probe_only88>:
 27f:	70 61                	jo     2e2 <__mod_probe_mask86+0x8>
 281:	72 6d                	jb     2f0 <__mod_probe_mask86+0x16>
 283:	3d 70 72 6f 62       	cmp    $0x626f7270,%eax
 288:	65                   	gs
 289:	5f                   	pop    %rdi
 28a:	6f                   	outsl  %ds:(%rsi),(%dx)
 28b:	6e                   	outsb  %ds:(%rsi),(%dx)
 28c:	6c                   	insb   (%dx),%es:(%rdi)
 28d:	79 3a                	jns    2c9 <__mod_probe_onlytype87+0x10>
 28f:	4f 6e                	rex.WRXB outsb %ds:(%rsi),(%dx)
 291:	6c                   	insb   (%dx),%es:(%rdi)
 292:	79 20                	jns    2b4 <__mod_probe_only88+0x35>
 294:	70 72                	jo     308 <__mod_probe_mask86+0x2e>
 296:	6f                   	outsl  %ds:(%rsi),(%dx)
 297:	62                   	(bad)  
 298:	69 6e 67 20 61 6e 64 	imul   $0x646e6120,0x67(%rsi),%ebp
 29f:	20 6e 6f             	and    %ch,0x6f(%rsi)
 2a2:	20 63 6f             	and    %ah,0x6f(%rbx)
 2a5:	64 65 63 20          	fs movslq %fs:%gs:(%rax),%esp
 2a9:	69 6e 69 74 69 61 6c 	imul   $0x6c616974,0x69(%rsi),%ebp
 2b0:	69 7a 61 74 69 6f 6e 	imul   $0x6e6f6974,0x61(%rdx),%edi
 2b7:	2e 00 70 61          	add    %dh,%cs:0x61(%rax)

00000000000002b9 <__mod_probe_onlytype87>:
 2b9:	70 61                	jo     31c <__mod_probe_masktype85+0xa>
 2bb:	72 6d                	jb     32a <__mod_probe_masktype85+0x18>
 2bd:	74 79                	je     338 <__mod_bdl_pos_adj84+0x5>
 2bf:	70 65                	jo     326 <__mod_probe_masktype85+0x14>
 2c1:	3d 70 72 6f 62       	cmp    $0x626f7270,%eax
 2c6:	65                   	gs
 2c7:	5f                   	pop    %rdi
 2c8:	6f                   	outsl  %ds:(%rsi),(%dx)
 2c9:	6e                   	outsb  %ds:(%rsi),(%dx)
 2ca:	6c                   	insb   (%dx),%es:(%rdi)
 2cb:	79 3a                	jns    307 <__mod_probe_mask86+0x2d>
 2cd:	61                   	(bad)  
 2ce:	72 72                	jb     342 <__mod_bdl_pos_adj84+0xf>
 2d0:	61                   	(bad)  
 2d1:	79 20                	jns    2f3 <__mod_probe_mask86+0x19>
 2d3:	6f                   	outsl  %ds:(%rsi),(%dx)
 2d4:	66                   	data16
 2d5:	20 69 6e             	and    %ch,0x6e(%rcx)
 2d8:	74 00                	je     2da <__mod_probe_mask86>

00000000000002da <__mod_probe_mask86>:
 2da:	70 61                	jo     33d <__mod_bdl_pos_adj84+0xa>
 2dc:	72 6d                	jb     34b <__mod_bdl_pos_adj84+0x18>
 2de:	3d 70 72 6f 62       	cmp    $0x626f7270,%eax
 2e3:	65                   	gs
 2e4:	5f                   	pop    %rdi
 2e5:	6d                   	insl   (%dx),%es:(%rdi)
 2e6:	61                   	(bad)  
 2e7:	73 6b                	jae    354 <__mod_bdl_pos_adj84+0x21>
 2e9:	3a 42 69             	cmp    0x69(%rdx),%al
 2ec:	74 6d                	je     35b <__mod_bdl_pos_adj84+0x28>
 2ee:	61                   	(bad)  
 2ef:	73 6b                	jae    35c <__mod_bdl_pos_adj84+0x29>
 2f1:	20 74 6f 20          	and    %dh,0x20(%rdi,%rbp,2)
 2f5:	70 72                	jo     369 <__mod_bdl_pos_adjtype83+0x5>
 2f7:	6f                   	outsl  %ds:(%rsi),(%dx)
 2f8:	62                   	(bad)  
 2f9:	65 20 63 6f          	and    %ah,%gs:0x6f(%rbx)
 2fd:	64 65 63 73 20       	fs movslq %fs:%gs:0x20(%rbx),%esi
 302:	28 64 65 66          	sub    %ah,0x66(%rbp,%riz,2)
 306:	61                   	(bad)  
 307:	75 6c                	jne    375 <__mod_bdl_pos_adjtype83+0x11>
 309:	74 20                	je     32b <__mod_probe_masktype85+0x19>
 30b:	3d 20 2d 31 29       	cmp    $0x29312d20,%eax
 310:	2e 00 70 61          	add    %dh,%cs:0x61(%rax)

0000000000000312 <__mod_probe_masktype85>:
 312:	70 61                	jo     375 <__mod_bdl_pos_adjtype83+0x11>
 314:	72 6d                	jb     383 <__mod_bdl_pos_adjtype83+0x1f>
 316:	74 79                	je     391 <__mod_position_fix82+0xb>
 318:	70 65                	jo     37f <__mod_bdl_pos_adjtype83+0x1b>
 31a:	3d 70 72 6f 62       	cmp    $0x626f7270,%eax
 31f:	65                   	gs
 320:	5f                   	pop    %rdi
 321:	6d                   	insl   (%dx),%es:(%rdi)
 322:	61                   	(bad)  
 323:	73 6b                	jae    390 <__mod_position_fix82+0xa>
 325:	3a 61 72             	cmp    0x72(%rcx),%ah
 328:	72 61                	jb     38b <__mod_position_fix82+0x5>
 32a:	79 20                	jns    34c <__mod_bdl_pos_adj84+0x19>
 32c:	6f                   	outsl  %ds:(%rsi),(%dx)
 32d:	66                   	data16
 32e:	20 69 6e             	and    %ch,0x6e(%rcx)
 331:	74 00                	je     333 <__mod_bdl_pos_adj84>

0000000000000333 <__mod_bdl_pos_adj84>:
 333:	70 61                	jo     396 <__mod_position_fix82+0x10>
 335:	72 6d                	jb     3a4 <__mod_position_fix82+0x1e>
 337:	3d 62 64 6c 5f       	cmp    $0x5f6c6462,%eax
 33c:	70 6f                	jo     3ad <__mod_position_fix82+0x27>
 33e:	73 5f                	jae    39f <__mod_position_fix82+0x19>
 340:	61                   	(bad)  
 341:	64                   	fs
 342:	6a 3a                	pushq  $0x3a
 344:	42                   	rex.X
 345:	44                   	rex.R
 346:	4c 20 70 6f          	rex.WR and %r14b,0x6f(%rax)
 34a:	73 69                	jae    3b5 <__mod_position_fix82+0x2f>
 34c:	74 69                	je     3b7 <__mod_position_fix82+0x31>
 34e:	6f                   	outsl  %ds:(%rsi),(%dx)
 34f:	6e                   	outsb  %ds:(%rsi),(%dx)
 350:	20 61 64             	and    %ah,0x64(%rcx)
 353:	6a 75                	pushq  $0x75
 355:	73 74                	jae    3cb <__mod_position_fix82+0x45>
 357:	6d                   	insl   (%dx),%es:(%rdi)
 358:	65 6e                	outsb  %gs:(%rsi),(%dx)
 35a:	74 20                	je     37c <__mod_bdl_pos_adjtype83+0x18>
 35c:	6f                   	outsl  %ds:(%rsi),(%dx)
 35d:	66                   	data16
 35e:	66                   	data16
 35f:	73 65                	jae    3c6 <__mod_position_fix82+0x40>
 361:	74 2e                	je     391 <__mod_position_fix82+0xb>
	...

0000000000000364 <__mod_bdl_pos_adjtype83>:
 364:	70 61                	jo     3c7 <__mod_position_fix82+0x41>
 366:	72 6d                	jb     3d5 <__mod_position_fix82+0x4f>
 368:	74 79                	je     3e3 <__mod_position_fixtype80+0x3>
 36a:	70 65                	jo     3d1 <__mod_position_fix82+0x4b>
 36c:	3d 62 64 6c 5f       	cmp    $0x5f6c6462,%eax
 371:	70 6f                	jo     3e2 <__mod_position_fixtype80+0x2>
 373:	73 5f                	jae    3d4 <__mod_position_fix82+0x4e>
 375:	61                   	(bad)  
 376:	64                   	fs
 377:	6a 3a                	pushq  $0x3a
 379:	61                   	(bad)  
 37a:	72 72                	jb     3ee <__mod_position_fixtype80+0xe>
 37c:	61                   	(bad)  
 37d:	79 20                	jns    39f <__mod_position_fix82+0x19>
 37f:	6f                   	outsl  %ds:(%rsi),(%dx)
 380:	66                   	data16
 381:	20 69 6e             	and    %ch,0x6e(%rcx)
 384:	74 00                	je     386 <__mod_position_fix82>

0000000000000386 <__mod_position_fix82>:
 386:	70 61                	jo     3e9 <__mod_position_fixtype80+0x9>
 388:	72 6d                	jb     3f7 <__mod_position_fixtype80+0x17>
 38a:	3d 70 6f 73 69       	cmp    $0x69736f70,%eax
 38f:	74 69                	je     3fa <__mod_position_fixtype80+0x1a>
 391:	6f                   	outsl  %ds:(%rsi),(%dx)
 392:	6e                   	outsb  %ds:(%rsi),(%dx)
 393:	5f                   	pop    %rdi
 394:	66 69 78 3a 44 4d    	imul   $0x4d44,0x3a(%rax),%di
 39a:	41 20 70 6f          	and    %sil,0x6f(%r8)
 39e:	69 6e 74 65 72 20 72 	imul   $0x72207265,0x74(%rsi),%ebp
 3a5:	65                   	gs
 3a6:	61                   	(bad)  
 3a7:	64 20 6d 65          	and    %ch,%fs:0x65(%rbp)
 3ab:	74 68                	je     415 <__mod_model79+0x12>
 3ad:	6f                   	outsl  %ds:(%rsi),(%dx)
 3ae:	64 2e 28 30          	fs sub %dh,%cs:%fs:(%rax)
 3b2:	20 3d 20 61 75 74    	and    %bh,0x74756120(%rip)        # 747564d8 <azx_attach_pcm_stream+0x7475481f>
 3b8:	6f                   	outsl  %ds:(%rsi),(%dx)
 3b9:	2c 20                	sub    $0x20,%al
 3bb:	31 20                	xor    %esp,(%rax)
 3bd:	3d 20 4c 50 49       	cmp    $0x49504c20,%eax
 3c2:	42 2c 20             	rex.X sub $0x20,%al
 3c5:	32 20                	xor    (%rax),%ah
 3c7:	3d 20 50 4f 53       	cmp    $0x534f5020,%eax
 3cc:	42 55                	rex.X push %rbp
 3ce:	46 2c 20             	rex.RX sub $0x20,%al
 3d1:	33 20                	xor    (%rax),%esp
 3d3:	3d 20 56 49 41       	cmp    $0x41495620,%eax
 3d8:	43                   	rex.XB
 3d9:	4f                   	rex.WRXB
 3da:	4d                   	rex.WRB
 3db:	42                   	rex.X
 3dc:	4f 29 2e             	rex.WRXB sub %r13,(%r14)
	...

00000000000003e0 <__mod_position_fixtype80>:
 3e0:	70 61                	jo     443 <__mod_modeltype78+0x1a>
 3e2:	72 6d                	jb     451 <__mod_enable77+0xa>
 3e4:	74 79                	je     45f <__mod_enable77+0x18>
 3e6:	70 65                	jo     44d <__mod_enable77+0x6>
 3e8:	3d 70 6f 73 69       	cmp    $0x69736f70,%eax
 3ed:	74 69                	je     458 <__mod_enable77+0x11>
 3ef:	6f                   	outsl  %ds:(%rsi),(%dx)
 3f0:	6e                   	outsb  %ds:(%rsi),(%dx)
 3f1:	5f                   	pop    %rdi
 3f2:	66 69 78 3a 61 72    	imul   $0x7261,0x3a(%rax),%di
 3f8:	72 61                	jb     45b <__mod_enable77+0x14>
 3fa:	79 20                	jns    41c <__mod_model79+0x19>
 3fc:	6f                   	outsl  %ds:(%rsi),(%dx)
 3fd:	66                   	data16
 3fe:	20 69 6e             	and    %ch,0x6e(%rcx)
 401:	74 00                	je     403 <__mod_model79>

0000000000000403 <__mod_model79>:
 403:	70 61                	jo     466 <__mod_enable77+0x1f>
 405:	72 6d                	jb     474 <__mod_enabletype76>
 407:	3d 6d 6f 64 65       	cmp    $0x65646f6d,%eax
 40c:	6c                   	insb   (%dx),%es:(%rdi)
 40d:	3a 55 73             	cmp    0x73(%rbp),%dl
 410:	65 20 74 68 65       	and    %dh,%gs:0x65(%rax,%rbp,2)
 415:	20 67 69             	and    %ah,0x69(%rdi)
 418:	76 65                	jbe    47f <__mod_enabletype76+0xb>
 41a:	6e                   	outsb  %ds:(%rsi),(%dx)
 41b:	20 62 6f             	and    %ah,0x6f(%rdx)
 41e:	61                   	(bad)  
 41f:	72 64                	jb     485 <__mod_enabletype76+0x11>
 421:	20 6d 6f             	and    %ch,0x6f(%rbp)
 424:	64                   	fs
 425:	65                   	gs
 426:	6c                   	insb   (%dx),%es:(%rdi)
 427:	2e 00 70 61          	add    %dh,%cs:0x61(%rax)

0000000000000429 <__mod_modeltype78>:
 429:	70 61                	jo     48c <__mod_enabletype76+0x18>
 42b:	72 6d                	jb     49a <__mod_id75+0x8>
 42d:	74 79                	je     4a8 <__mod_id75+0x16>
 42f:	70 65                	jo     496 <__mod_id75+0x4>
 431:	3d 6d 6f 64 65       	cmp    $0x65646f6d,%eax
 436:	6c                   	insb   (%dx),%es:(%rdi)
 437:	3a 61 72             	cmp    0x72(%rcx),%ah
 43a:	72 61                	jb     49d <__mod_id75+0xb>
 43c:	79 20                	jns    45e <__mod_enable77+0x17>
 43e:	6f                   	outsl  %ds:(%rsi),(%dx)
 43f:	66                   	data16
 440:	20 63 68             	and    %ah,0x68(%rbx)
 443:	61                   	(bad)  
 444:	72 70                	jb     4b6 <__mod_id75+0x24>
	...

0000000000000447 <__mod_enable77>:
 447:	70 61                	jo     4aa <__mod_id75+0x18>
 449:	72 6d                	jb     4b8 <__mod_id75+0x26>
 44b:	3d 65 6e 61 62       	cmp    $0x62616e65,%eax
 450:	6c                   	insb   (%dx),%es:(%rdi)
 451:	65 3a 45 6e          	cmp    %gs:0x6e(%rbp),%al
 455:	61                   	(bad)  
 456:	62                   	(bad)  
 457:	6c                   	insb   (%dx),%es:(%rdi)
 458:	65 20 49 6e          	and    %cl,%gs:0x6e(%rcx)
 45c:	74 65                	je     4c3 <__mod_idtype74+0x1>
 45e:	6c                   	insb   (%dx),%es:(%rdi)
 45f:	20 48 44             	and    %cl,0x44(%rax)
 462:	20 61 75             	and    %ah,0x75(%rcx)
 465:	64 69 6f 20 69 6e 74 	imul   $0x65746e69,%fs:0x20(%rdi),%ebp
 46c:	65 
 46d:	72 66                	jb     4d5 <__mod_idtype74+0x13>
 46f:	61                   	(bad)  
 470:	63 65 2e             	movslq 0x2e(%rbp),%esp
	...

0000000000000474 <__mod_enabletype76>:
 474:	70 61                	jo     4d7 <__mod_idtype74+0x15>
 476:	72 6d                	jb     4e5 <__mod_index73+0x8>
 478:	74 79                	je     4f3 <__mod_index73+0x16>
 47a:	70 65                	jo     4e1 <__mod_index73+0x4>
 47c:	3d 65 6e 61 62       	cmp    $0x62616e65,%eax
 481:	6c                   	insb   (%dx),%es:(%rdi)
 482:	65 3a 61 72          	cmp    %gs:0x72(%rcx),%ah
 486:	72 61                	jb     4e9 <__mod_index73+0xc>
 488:	79 20                	jns    4aa <__mod_id75+0x18>
 48a:	6f                   	outsl  %ds:(%rsi),(%dx)
 48b:	66                   	data16
 48c:	20 62 6f             	and    %ah,0x6f(%rdx)
 48f:	6f                   	outsl  %ds:(%rsi),(%dx)
 490:	6c                   	insb   (%dx),%es:(%rdi)
	...

0000000000000492 <__mod_id75>:
 492:	70 61                	jo     4f5 <__mod_index73+0x18>
 494:	72 6d                	jb     503 <__mod_index73+0x26>
 496:	3d 69 64 3a 49       	cmp    $0x493a6469,%eax
 49b:	44 20 73 74          	and    %r14b,0x74(%rbx)
 49f:	72 69                	jb     50a <__mod_index73+0x2d>
 4a1:	6e                   	outsb  %ds:(%rsi),(%dx)
 4a2:	67 20 66 6f          	and    %ah,0x6f(%esi)
 4a6:	72 20                	jb     4c8 <__mod_idtype74+0x6>
 4a8:	49 6e                	rex.WB outsb %ds:(%rsi),(%dx)
 4aa:	74 65                	je     511 <__mod_index73+0x34>
 4ac:	6c                   	insb   (%dx),%es:(%rdi)
 4ad:	20 48 44             	and    %cl,0x44(%rax)
 4b0:	20 61 75             	and    %ah,0x75(%rcx)
 4b3:	64 69 6f 20 69 6e 74 	imul   $0x65746e69,%fs:0x20(%rdi),%ebp
 4ba:	65 
 4bb:	72 66                	jb     523 <__mod_indextype72+0x11>
 4bd:	61                   	(bad)  
 4be:	63 65 2e             	movslq 0x2e(%rbp),%esp
	...

00000000000004c2 <__mod_idtype74>:
 4c2:	70 61                	jo     525 <__mod_indextype72+0x13>
 4c4:	72 6d                	jb     533 <__mod_alias154+0x3>
 4c6:	74 79                	je     541 <__mod_alias154+0x11>
 4c8:	70 65                	jo     52f <__mod_indextype72+0x1d>
 4ca:	3d 69 64 3a 61       	cmp    $0x613a6469,%eax
 4cf:	72 72                	jb     543 <__mod_alias154+0x13>
 4d1:	61                   	(bad)  
 4d2:	79 20                	jns    4f4 <__mod_index73+0x17>
 4d4:	6f                   	outsl  %ds:(%rsi),(%dx)
 4d5:	66                   	data16
 4d6:	20 63 68             	and    %ah,0x68(%rbx)
 4d9:	61                   	(bad)  
 4da:	72 70                	jb     54c <__mod_alias154+0x1c>
	...

00000000000004dd <__mod_index73>:
 4dd:	70 61                	jo     540 <__mod_alias154+0x10>
 4df:	72 6d                	jb     54e <__mod_alias154+0x1e>
 4e1:	3d 69 6e 64 65       	cmp    $0x65646e69,%eax
 4e6:	78 3a                	js     522 <__mod_indextype72+0x10>
 4e8:	49 6e                	rex.WB outsb %ds:(%rsi),(%dx)
 4ea:	64                   	fs
 4eb:	65                   	gs
 4ec:	78 20                	js     50e <__mod_index73+0x31>
 4ee:	76 61                	jbe    551 <__mod_alias154+0x21>
 4f0:	6c                   	insb   (%dx),%es:(%rdi)
 4f1:	75 65                	jne    558 <__mod_alias153>
 4f3:	20 66 6f             	and    %ah,0x6f(%rsi)
 4f6:	72 20                	jb     518 <__mod_indextype72+0x6>
 4f8:	49 6e                	rex.WB outsb %ds:(%rsi),(%dx)
 4fa:	74 65                	je     561 <__mod_alias153+0x9>
 4fc:	6c                   	insb   (%dx),%es:(%rdi)
 4fd:	20 48 44             	and    %cl,0x44(%rax)
 500:	20 61 75             	and    %ah,0x75(%rcx)
 503:	64 69 6f 20 69 6e 74 	imul   $0x65746e69,%fs:0x20(%rdi),%ebp
 50a:	65 
 50b:	72 66                	jb     573 <__mod_alias153+0x1b>
 50d:	61                   	(bad)  
 50e:	63 65 2e             	movslq 0x2e(%rbp),%esp
	...

0000000000000512 <__mod_indextype72>:
 512:	70 61                	jo     575 <__mod_alias153+0x1d>
 514:	72 6d                	jb     583 <__mod_alias152+0x3>
 516:	74 79                	je     591 <__mod_alias152+0x11>
 518:	70 65                	jo     57f <__mod_alias153+0x27>
 51a:	3d 69 6e 64 65       	cmp    $0x65646e69,%eax
 51f:	78 3a                	js     55b <__mod_alias153+0x3>
 521:	61                   	(bad)  
 522:	72 72                	jb     596 <__mod_alias152+0x16>
 524:	61                   	(bad)  
 525:	79 20                	jns    547 <__mod_alias154+0x17>
 527:	6f                   	outsl  %ds:(%rsi),(%dx)
 528:	66                   	data16
 529:	20 69 6e             	and    %ch,0x6e(%rcx)
 52c:	74 00                	je     52e <__mod_indextype72+0x1c>
	...

0000000000000530 <__mod_alias154>:
 530:	61                   	(bad)  
 531:	6c                   	insb   (%dx),%es:(%rdi)
 532:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 539:	3a 76 30             	cmp    0x30(%rsi),%dh
 53c:	30 30                	xor    %dh,(%rax)
 53e:	30 31                	xor    %dh,(%rcx)
 540:	30 32                	xor    %dh,(%rdx)
 542:	32 64 2a 73          	xor    0x73(%rdx,%rbp,1),%ah
 546:	76 2a                	jbe    572 <__mod_alias153+0x1a>
 548:	73 64                	jae    5ae <__mod_alias151+0x3>
 54a:	2a 62 63             	sub    0x63(%rdx),%ah
 54d:	30 34 73             	xor    %dh,(%rbx,%rsi,2)
 550:	63 30                	movslq (%rax),%esi
 552:	33 69 30             	xor    0x30(%rcx),%ebp
 555:	30 2a                	xor    %ch,(%rdx)
	...

0000000000000558 <__mod_alias153>:
 558:	61                   	(bad)  
 559:	6c                   	insb   (%dx),%es:(%rdi)
 55a:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 561:	3a 76 30             	cmp    0x30(%rsi),%dh
 564:	30 30                	xor    %dh,(%rax)
 566:	30 31                	xor    %dh,(%rcx)
 568:	30 30                	xor    %dh,(%rax)
 56a:	32 64 2a 73          	xor    0x73(%rdx,%rbp,1),%ah
 56e:	76 2a                	jbe    59a <__mod_alias152+0x1a>
 570:	73 64                	jae    5d6 <__mod_alias150>
 572:	2a 62 63             	sub    0x63(%rdx),%ah
 575:	30 34 73             	xor    %dh,(%rbx,%rsi,2)
 578:	63 30                	movslq (%rax),%esi
 57a:	33 69 30             	xor    0x30(%rcx),%ebp
 57d:	30 2a                	xor    %ch,(%rdx)
	...

0000000000000580 <__mod_alias152>:
 580:	61                   	(bad)  
 581:	6c                   	insb   (%dx),%es:(%rdi)
 582:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 589:	3a 76 30             	cmp    0x30(%rsi),%dh
 58c:	30 30                	xor    %dh,(%rax)
 58e:	30 31                	xor    %dh,(%rcx)
 590:	35 41 44 64 30       	xor    $0x30644441,%eax
 595:	30 30                	xor    %dh,(%rax)
 597:	30 31                	xor    %dh,(%rcx)
 599:	39 37                	cmp    %esi,(%rdi)
 59b:	37                   	(bad)  
 59c:	73 76                	jae    614 <__mod_alias149+0x13>
 59e:	2a 73 64             	sub    0x64(%rbx),%dh
 5a1:	2a 62 63             	sub    0x63(%rdx),%ah
 5a4:	2a 73 63             	sub    0x63(%rbx),%dh
 5a7:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

00000000000005ab <__mod_alias151>:
 5ab:	61                   	(bad)  
 5ac:	6c                   	insb   (%dx),%es:(%rdi)
 5ad:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 5b4:	3a 76 30             	cmp    0x30(%rsi),%dh
 5b7:	30 30                	xor    %dh,(%rax)
 5b9:	30 31                	xor    %dh,(%rcx)
 5bb:	37                   	(bad)  
 5bc:	46 33 64 30 30       	xor    0x30(%rax,%r14,1),%r12d
 5c1:	30 30                	xor    %dh,(%rax)
 5c3:	33 30                	xor    (%rax),%esi
 5c5:	31 30                	xor    %esi,(%rax)
 5c7:	73 76                	jae    63f <__mod_alias148+0x13>
 5c9:	2a 73 64             	sub    0x64(%rbx),%dh
 5cc:	2a 62 63             	sub    0x63(%rdx),%ah
 5cf:	2a 73 63             	sub    0x63(%rbx),%dh
 5d2:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

00000000000005d6 <__mod_alias150>:
 5d6:	61                   	(bad)  
 5d7:	6c                   	insb   (%dx),%es:(%rdi)
 5d8:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 5df:	3a 76 30             	cmp    0x30(%rsi),%dh
 5e2:	30 30                	xor    %dh,(%rax)
 5e4:	30 31                	xor    %dh,(%rcx)
 5e6:	31 30                	xor    %esi,(%rax)
 5e8:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 5ec:	30 30                	xor    %dh,(%rax)
 5ee:	30 30                	xor    %dh,(%rax)
 5f0:	30 39                	xor    %bh,(%rcx)
 5f2:	73 76                	jae    66a <__mod_alias147+0x16>
 5f4:	2a 73 64             	sub    0x64(%rbx),%dh
 5f7:	2a 62 63             	sub    0x63(%rdx),%ah
 5fa:	2a 73 63             	sub    0x63(%rbx),%dh
 5fd:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000601 <__mod_alias149>:
 601:	61                   	(bad)  
 602:	6c                   	insb   (%dx),%es:(%rdi)
 603:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 60a:	3a 76 30             	cmp    0x30(%rsi),%dh
 60d:	30 30                	xor    %dh,(%rax)
 60f:	30 36                	xor    %dh,(%rsi)
 611:	35 34 39 64 30       	xor    $0x30643934,%eax
 616:	30 30                	xor    %dh,(%rax)
 618:	30 31                	xor    %dh,(%rcx)
 61a:	32 30                	xor    (%rax),%dh
 61c:	30 73 76             	xor    %dh,0x76(%rbx)
 61f:	2a 73 64             	sub    0x64(%rbx),%dh
 622:	2a 62 63             	sub    0x63(%rdx),%ah
 625:	2a 73 63             	sub    0x63(%rbx),%dh
 628:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

000000000000062c <__mod_alias148>:
 62c:	61                   	(bad)  
 62d:	6c                   	insb   (%dx),%es:(%rdi)
 62e:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 635:	3a 76 30             	cmp    0x30(%rsi),%dh
 638:	30 30                	xor    %dh,(%rax)
 63a:	30 31                	xor    %dh,(%rcx)
 63c:	30 44 45 64          	xor    %al,0x64(%rbp,%rax,2)
 640:	2a 73 76             	sub    0x76(%rbx),%dh
 643:	2a 73 64             	sub    0x64(%rbx),%dh
 646:	2a 62 63             	sub    0x63(%rdx),%ah
 649:	30 34 73             	xor    %dh,(%rbx,%rsi,2)
 64c:	63 30                	movslq (%rax),%esi
 64e:	33 69 30             	xor    0x30(%rcx),%ebp
 651:	30 2a                	xor    %ch,(%rdx)
	...

0000000000000654 <__mod_alias147>:
 654:	61                   	(bad)  
 655:	6c                   	insb   (%dx),%es:(%rdi)
 656:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 65d:	3a 76 30             	cmp    0x30(%rsi),%dh
 660:	30 30                	xor    %dh,(%rax)
 662:	30 31                	xor    %dh,(%rcx)
 664:	30 42 39             	xor    %al,0x39(%rdx)
 667:	64 30 30             	xor    %dh,%fs:(%rax)
 66a:	30 30                	xor    %dh,(%rax)
 66c:	35 34 36 31 73       	xor    $0x73313634,%eax
 671:	76 2a                	jbe    69d <__mod_alias146+0x1e>
 673:	73 64                	jae    6d9 <__mod_alias144+0x4>
 675:	2a 62 63             	sub    0x63(%rdx),%ah
 678:	2a 73 63             	sub    0x63(%rbx),%dh
 67b:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

000000000000067f <__mod_alias146>:
 67f:	61                   	(bad)  
 680:	6c                   	insb   (%dx),%es:(%rdi)
 681:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 688:	3a 76 30             	cmp    0x30(%rsi),%dh
 68b:	30 30                	xor    %dh,(%rax)
 68d:	30 31                	xor    %dh,(%rcx)
 68f:	30 33                	xor    %dh,(%rbx)
 691:	39 64 30 30          	cmp    %esp,0x30(%rax,%rsi,1)
 695:	30 30                	xor    %dh,(%rax)
 697:	37                   	(bad)  
 698:	35 30 32 73 76       	xor    $0x76733230,%eax
 69d:	2a 73 64             	sub    0x64(%rbx),%dh
 6a0:	2a 62 63             	sub    0x63(%rdx),%ah
 6a3:	2a 73 63             	sub    0x63(%rbx),%dh
 6a6:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

00000000000006aa <__mod_alias145>:
 6aa:	61                   	(bad)  
 6ab:	6c                   	insb   (%dx),%es:(%rdi)
 6ac:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 6b3:	3a 76 30             	cmp    0x30(%rsi),%dh
 6b6:	30 30                	xor    %dh,(%rax)
 6b8:	30 31                	xor    %dh,(%rcx)
 6ba:	31 30                	xor    %esi,(%rax)
 6bc:	36 64 30 30          	ss xor %dh,%ss:%fs:(%rax)
 6c0:	30 30                	xor    %dh,(%rax)
 6c2:	33 32                	xor    (%rdx),%esi
 6c4:	38 38                	cmp    %bh,(%rax)
 6c6:	73 76                	jae    73e <__mod_alias142+0x13>
 6c8:	2a 73 64             	sub    0x64(%rbx),%dh
 6cb:	2a 62 63             	sub    0x63(%rdx),%ah
 6ce:	2a 73 63             	sub    0x63(%rbx),%dh
 6d1:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

00000000000006d5 <__mod_alias144>:
 6d5:	61                   	(bad)  
 6d6:	6c                   	insb   (%dx),%es:(%rdi)
 6d7:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 6de:	3a 76 30             	cmp    0x30(%rsi),%dh
 6e1:	30 30                	xor    %dh,(%rax)
 6e3:	30 31                	xor    %dh,(%rcx)
 6e5:	30 30                	xor    %dh,(%rax)
 6e7:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 6eb:	30 30                	xor    %dh,(%rax)
 6ed:	41                   	rex.B
 6ee:	41 34 38             	rex.B xor $0x38,%al
 6f1:	73 76                	jae    769 <__mod_alias141+0x13>
 6f3:	2a 73 64             	sub    0x64(%rbx),%dh
 6f6:	2a 62 63             	sub    0x63(%rdx),%ah
 6f9:	2a 73 63             	sub    0x63(%rbx),%dh
 6fc:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000700 <__mod_alias143>:
 700:	61                   	(bad)  
 701:	6c                   	insb   (%dx),%es:(%rdi)
 702:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 709:	3a 76 30             	cmp    0x30(%rsi),%dh
 70c:	30 30                	xor    %dh,(%rax)
 70e:	30 31                	xor    %dh,(%rcx)
 710:	30 30                	xor    %dh,(%rax)
 712:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 716:	30 30                	xor    %dh,(%rax)
 718:	41                   	rex.B
 719:	41 34 30             	rex.B xor $0x30,%al
 71c:	73 76                	jae    794 <__mod_alias140+0x13>
 71e:	2a 73 64             	sub    0x64(%rbx),%dh
 721:	2a 62 63             	sub    0x63(%rdx),%ah
 724:	2a 73 63             	sub    0x63(%rbx),%dh
 727:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

000000000000072b <__mod_alias142>:
 72b:	61                   	(bad)  
 72c:	6c                   	insb   (%dx),%es:(%rdi)
 72d:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 734:	3a 76 30             	cmp    0x30(%rsi),%dh
 737:	30 30                	xor    %dh,(%rax)
 739:	30 31                	xor    %dh,(%rcx)
 73b:	30 30                	xor    %dh,(%rax)
 73d:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 741:	30 30                	xor    %dh,(%rax)
 743:	41                   	rex.B
 744:	41 33 38             	xor    (%r8),%edi
 747:	73 76                	jae    7bf <__mod_alias139+0x13>
 749:	2a 73 64             	sub    0x64(%rbx),%dh
 74c:	2a 62 63             	sub    0x63(%rdx),%ah
 74f:	2a 73 63             	sub    0x63(%rbx),%dh
 752:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000756 <__mod_alias141>:
 756:	61                   	(bad)  
 757:	6c                   	insb   (%dx),%es:(%rdi)
 758:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 75f:	3a 76 30             	cmp    0x30(%rsi),%dh
 762:	30 30                	xor    %dh,(%rax)
 764:	30 31                	xor    %dh,(%rcx)
 766:	30 30                	xor    %dh,(%rax)
 768:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 76c:	30 30                	xor    %dh,(%rax)
 76e:	41                   	rex.B
 76f:	41 33 30             	xor    (%r8),%esi
 772:	73 76                	jae    7ea <__mod_alias138+0x13>
 774:	2a 73 64             	sub    0x64(%rbx),%dh
 777:	2a 62 63             	sub    0x63(%rdx),%ah
 77a:	2a 73 63             	sub    0x63(%rbx),%dh
 77d:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000781 <__mod_alias140>:
 781:	61                   	(bad)  
 782:	6c                   	insb   (%dx),%es:(%rdi)
 783:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 78a:	3a 76 30             	cmp    0x30(%rsi),%dh
 78d:	30 30                	xor    %dh,(%rax)
 78f:	30 31                	xor    %dh,(%rcx)
 791:	30 30                	xor    %dh,(%rax)
 793:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 797:	30 30                	xor    %dh,(%rax)
 799:	41                   	rex.B
 79a:	41 32 38             	xor    (%r8),%dil
 79d:	73 76                	jae    815 <__mod_alias137+0x13>
 79f:	2a 73 64             	sub    0x64(%rbx),%dh
 7a2:	2a 62 63             	sub    0x63(%rdx),%ah
 7a5:	2a 73 63             	sub    0x63(%rbx),%dh
 7a8:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

00000000000007ac <__mod_alias139>:
 7ac:	61                   	(bad)  
 7ad:	6c                   	insb   (%dx),%es:(%rdi)
 7ae:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 7b5:	3a 76 30             	cmp    0x30(%rsi),%dh
 7b8:	30 30                	xor    %dh,(%rax)
 7ba:	30 31                	xor    %dh,(%rcx)
 7bc:	30 30                	xor    %dh,(%rax)
 7be:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 7c2:	30 30                	xor    %dh,(%rax)
 7c4:	41                   	rex.B
 7c5:	41 32 30             	xor    (%r8),%sil
 7c8:	73 76                	jae    840 <__mod_alias136+0x13>
 7ca:	2a 73 64             	sub    0x64(%rbx),%dh
 7cd:	2a 62 63             	sub    0x63(%rdx),%ah
 7d0:	2a 73 63             	sub    0x63(%rbx),%dh
 7d3:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

00000000000007d7 <__mod_alias138>:
 7d7:	61                   	(bad)  
 7d8:	6c                   	insb   (%dx),%es:(%rdi)
 7d9:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 7e0:	3a 76 30             	cmp    0x30(%rsi),%dh
 7e3:	30 30                	xor    %dh,(%rax)
 7e5:	30 31                	xor    %dh,(%rcx)
 7e7:	30 30                	xor    %dh,(%rax)
 7e9:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 7ed:	30 30                	xor    %dh,(%rax)
 7ef:	41                   	rex.B
 7f0:	41 31 38             	xor    %edi,(%r8)
 7f3:	73 76                	jae    86b <__mod_alias135+0x13>
 7f5:	2a 73 64             	sub    0x64(%rbx),%dh
 7f8:	2a 62 63             	sub    0x63(%rdx),%ah
 7fb:	2a 73 63             	sub    0x63(%rbx),%dh
 7fe:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000802 <__mod_alias137>:
 802:	61                   	(bad)  
 803:	6c                   	insb   (%dx),%es:(%rdi)
 804:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 80b:	3a 76 30             	cmp    0x30(%rsi),%dh
 80e:	30 30                	xor    %dh,(%rax)
 810:	30 31                	xor    %dh,(%rcx)
 812:	30 30                	xor    %dh,(%rax)
 814:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 818:	30 30                	xor    %dh,(%rax)
 81a:	41                   	rex.B
 81b:	41 31 30             	xor    %esi,(%r8)
 81e:	73 76                	jae    896 <__mod_alias134+0x13>
 820:	2a 73 64             	sub    0x64(%rbx),%dh
 823:	2a 62 63             	sub    0x63(%rdx),%ah
 826:	2a 73 63             	sub    0x63(%rbx),%dh
 829:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

000000000000082d <__mod_alias136>:
 82d:	61                   	(bad)  
 82e:	6c                   	insb   (%dx),%es:(%rdi)
 82f:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 836:	3a 76 30             	cmp    0x30(%rsi),%dh
 839:	30 30                	xor    %dh,(%rax)
 83b:	30 31                	xor    %dh,(%rcx)
 83d:	30 30                	xor    %dh,(%rax)
 83f:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 843:	30 30                	xor    %dh,(%rax)
 845:	41                   	rex.B
 846:	41 30 38             	xor    %dil,(%r8)
 849:	73 76                	jae    8c1 <__mod_alias133+0x13>
 84b:	2a 73 64             	sub    0x64(%rbx),%dh
 84e:	2a 62 63             	sub    0x63(%rdx),%ah
 851:	2a 73 63             	sub    0x63(%rbx),%dh
 854:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000858 <__mod_alias135>:
 858:	61                   	(bad)  
 859:	6c                   	insb   (%dx),%es:(%rdi)
 85a:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 861:	3a 76 30             	cmp    0x30(%rsi),%dh
 864:	30 30                	xor    %dh,(%rax)
 866:	30 31                	xor    %dh,(%rcx)
 868:	30 30                	xor    %dh,(%rax)
 86a:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 86e:	30 30                	xor    %dh,(%rax)
 870:	41                   	rex.B
 871:	41 30 30             	xor    %sil,(%r8)
 874:	73 76                	jae    8ec <__mod_alias132+0x13>
 876:	2a 73 64             	sub    0x64(%rbx),%dh
 879:	2a 62 63             	sub    0x63(%rdx),%ah
 87c:	2a 73 63             	sub    0x63(%rbx),%dh
 87f:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000883 <__mod_alias134>:
 883:	61                   	(bad)  
 884:	6c                   	insb   (%dx),%es:(%rdi)
 885:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 88c:	3a 76 30             	cmp    0x30(%rsi),%dh
 88f:	30 30                	xor    %dh,(%rax)
 891:	30 31                	xor    %dh,(%rcx)
 893:	30 30                	xor    %dh,(%rax)
 895:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 899:	30 30                	xor    %dh,(%rax)
 89b:	39 37                	cmp    %esi,(%rdi)
 89d:	30 46 73             	xor    %al,0x73(%rsi)
 8a0:	76 2a                	jbe    8cc <__mod_alias133+0x1e>
 8a2:	73 64                	jae    908 <__mod_alias131+0x4>
 8a4:	2a 62 63             	sub    0x63(%rdx),%ah
 8a7:	2a 73 63             	sub    0x63(%rbx),%dh
 8aa:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

00000000000008ae <__mod_alias133>:
 8ae:	61                   	(bad)  
 8af:	6c                   	insb   (%dx),%es:(%rdi)
 8b0:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 8b7:	3a 76 30             	cmp    0x30(%rsi),%dh
 8ba:	30 30                	xor    %dh,(%rax)
 8bc:	30 31                	xor    %dh,(%rcx)
 8be:	30 30                	xor    %dh,(%rax)
 8c0:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 8c4:	30 30                	xor    %dh,(%rax)
 8c6:	39 36                	cmp    %esi,(%rsi)
 8c8:	30 46 73             	xor    %al,0x73(%rsi)
 8cb:	76 2a                	jbe    8f7 <__mod_alias132+0x1e>
 8cd:	73 64                	jae    933 <__mod_alias130+0x4>
 8cf:	2a 62 63             	sub    0x63(%rdx),%ah
 8d2:	2a 73 63             	sub    0x63(%rbx),%dh
 8d5:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

00000000000008d9 <__mod_alias132>:
 8d9:	61                   	(bad)  
 8da:	6c                   	insb   (%dx),%es:(%rdi)
 8db:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 8e2:	3a 76 30             	cmp    0x30(%rsi),%dh
 8e5:	30 30                	xor    %dh,(%rax)
 8e7:	30 31                	xor    %dh,(%rcx)
 8e9:	30 30                	xor    %dh,(%rax)
 8eb:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 8ef:	30 30                	xor    %dh,(%rax)
 8f1:	37                   	(bad)  
 8f2:	39 31                	cmp    %esi,(%rcx)
 8f4:	39 73 76             	cmp    %esi,0x76(%rbx)
 8f7:	2a 73 64             	sub    0x64(%rbx),%dh
 8fa:	2a 62 63             	sub    0x63(%rdx),%ah
 8fd:	2a 73 63             	sub    0x63(%rbx),%dh
 900:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000904 <__mod_alias131>:
 904:	61                   	(bad)  
 905:	6c                   	insb   (%dx),%es:(%rdi)
 906:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 90d:	3a 76 30             	cmp    0x30(%rsi),%dh
 910:	30 30                	xor    %dh,(%rax)
 912:	30 31                	xor    %dh,(%rcx)
 914:	30 30                	xor    %dh,(%rax)
 916:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 91a:	30 30                	xor    %dh,(%rax)
 91c:	37                   	(bad)  
 91d:	39 33                	cmp    %esi,(%rbx)
 91f:	42 73 76             	rex.X jae 998 <__mod_alias128+0x13>
 922:	2a 73 64             	sub    0x64(%rbx),%dh
 925:	2a 62 63             	sub    0x63(%rdx),%ah
 928:	2a 73 63             	sub    0x63(%rbx),%dh
 92b:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

000000000000092f <__mod_alias130>:
 92f:	61                   	(bad)  
 930:	6c                   	insb   (%dx),%es:(%rdi)
 931:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 938:	3a 76 30             	cmp    0x30(%rsi),%dh
 93b:	30 30                	xor    %dh,(%rax)
 93d:	30 31                	xor    %dh,(%rcx)
 93f:	30 30                	xor    %dh,(%rax)
 941:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 945:	30 30                	xor    %dh,(%rax)
 947:	34 33                	xor    $0x33,%al
 949:	38 33                	cmp    %dh,(%rbx)
 94b:	73 76                	jae    9c3 <__mod_alias127+0x16>
 94d:	2a 73 64             	sub    0x64(%rbx),%dh
 950:	2a 62 63             	sub    0x63(%rdx),%ah
 953:	2a 73 63             	sub    0x63(%rbx),%dh
 956:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

000000000000095a <__mod_alias129>:
 95a:	61                   	(bad)  
 95b:	6c                   	insb   (%dx),%es:(%rdi)
 95c:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 963:	3a 76 30             	cmp    0x30(%rsi),%dh
 966:	30 30                	xor    %dh,(%rax)
 968:	30 31                	xor    %dh,(%rcx)
 96a:	30 30                	xor    %dh,(%rax)
 96c:	32 64 30 30          	xor    0x30(%rax,%rsi,1),%ah
 970:	30 30                	xor    %dh,(%rax)
 972:	34 33                	xor    $0x33,%al
 974:	37                   	(bad)  
 975:	42 73 76             	rex.X jae 9ee <__mod_alias126+0x16>
 978:	2a 73 64             	sub    0x64(%rbx),%dh
 97b:	2a 62 63             	sub    0x63(%rdx),%ah
 97e:	2a 73 63             	sub    0x63(%rbx),%dh
 981:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000985 <__mod_alias128>:
 985:	61                   	(bad)  
 986:	6c                   	insb   (%dx),%es:(%rdi)
 987:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 98e:	3a 76 30             	cmp    0x30(%rsi),%dh
 991:	30 30                	xor    %dh,(%rax)
 993:	30 38                	xor    %bh,(%rax)
 995:	30 38                	xor    %bh,(%rax)
 997:	36 64 2a 73 76       	ss sub %ss:%fs:0x76(%rbx),%dh
 99c:	2a 73 64             	sub    0x64(%rbx),%dh
 99f:	2a 62 63             	sub    0x63(%rdx),%ah
 9a2:	30 34 73             	xor    %dh,(%rbx,%rsi,2)
 9a5:	63 30                	movslq (%rax),%esi
 9a7:	33 69 30             	xor    0x30(%rcx),%ebp
 9aa:	30 2a                	xor    %ch,(%rdx)
	...

00000000000009ad <__mod_alias127>:
 9ad:	61                   	(bad)  
 9ae:	6c                   	insb   (%dx),%es:(%rdi)
 9af:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 9b6:	3a 76 30             	cmp    0x30(%rsi),%dh
 9b9:	30 30                	xor    %dh,(%rax)
 9bb:	30 38                	xor    %bh,(%rax)
 9bd:	30 38                	xor    %bh,(%rax)
 9bf:	36 64 30 30          	ss xor %dh,%ss:%fs:(%rax)
 9c3:	30 30                	xor    %dh,(%rax)
 9c5:	38 31                	cmp    %dh,(%rcx)
 9c7:	31 42 73             	xor    %eax,0x73(%rdx)
 9ca:	76 2a                	jbe    9f6 <__mod_alias126+0x1e>
 9cc:	73 64                	jae    a32 <__module_depends+0x2>
 9ce:	2a 62 63             	sub    0x63(%rdx),%ah
 9d1:	2a 73 63             	sub    0x63(%rbx),%dh
 9d4:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

00000000000009d8 <__mod_alias126>:
 9d8:	61                   	(bad)  
 9d9:	6c                   	insb   (%dx),%es:(%rdi)
 9da:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 9e1:	3a 76 30             	cmp    0x30(%rsi),%dh
 9e4:	30 30                	xor    %dh,(%rax)
 9e6:	30 38                	xor    %bh,(%rax)
 9e8:	30 38                	xor    %bh,(%rax)
 9ea:	36 64 30 30          	ss xor %dh,%ss:%fs:(%rax)
 9ee:	30 30                	xor    %dh,(%rax)
 9f0:	31 44 32 30          	xor    %eax,0x30(%rdx,%rsi,1)
 9f4:	73 76                	jae    a6c <__mod_vermagic5+0x2>
 9f6:	2a 73 64             	sub    0x64(%rbx),%dh
 9f9:	2a 62 63             	sub    0x63(%rdx),%ah
 9fc:	2a 73 63             	sub    0x63(%rbx),%dh
 9ff:	2a 69 2a             	sub    0x2a(%rcx),%ch
	...

0000000000000a03 <__mod_alias125>:
 a03:	61                   	(bad)  
 a04:	6c                   	insb   (%dx),%es:(%rdi)
 a05:	69 61 73 3d 70 63 69 	imul   $0x6963703d,0x73(%rcx),%esp
 a0c:	3a 76 30             	cmp    0x30(%rsi),%dh
 a0f:	30 30                	xor    %dh,(%rax)
 a11:	30 38                	xor    %bh,(%rax)
 a13:	30 38                	xor    %bh,(%rax)
 a15:	36 64 30 30          	ss xor %dh,%ss:%fs:(%rax)
 a19:	30 30                	xor    %dh,(%rax)
 a1b:	31 43 32             	xor    %eax,0x32(%rbx)
 a1e:	30 73 76             	xor    %dh,0x76(%rbx)
 a21:	2a 73 64             	sub    0x64(%rbx),%dh
 a24:	2a 62 63             	sub    0x63(%rdx),%ah
 a27:	2a 73 63             	sub    0x63(%rbx),%dh
 a2a:	2a 69 2a             	sub    0x2a(%rcx),%ch
 a2d:	00 00                	add    %al,(%rax)
	...

0000000000000a30 <__module_depends>:
 a30:	64                   	fs
 a31:	65                   	gs
 a32:	70 65                	jo     a99 <__mod_vermagic5+0x2f>
 a34:	6e                   	outsb  %ds:(%rsi),(%dx)
 a35:	64                   	fs
 a36:	73 3d                	jae    a75 <__mod_vermagic5+0xb>
 a38:	73 6e                	jae    aa8 <__mod_vermagic5+0x3e>
 a3a:	64                   	fs
 a3b:	2d 68 64 61 2d       	sub    $0x2d616468,%eax
 a40:	63 6f 64             	movslq 0x64(%rdi),%ebp
 a43:	65 63 2c 73          	movslq %gs:(%rbx,%rsi,2),%ebp
 a47:	6e                   	outsb  %ds:(%rsi),(%dx)
 a48:	64                   	fs
 a49:	2d 70 63 6d 2c       	sub    $0x2c6d6370,%eax
 a4e:	73 6e                	jae    abe <__mod_vermagic5+0x54>
 a50:	64                   	fs
 a51:	2c 73                	sub    $0x73,%al
 a53:	6e                   	outsb  %ds:(%rsi),(%dx)
 a54:	64                   	fs
 a55:	2d 70 61 67 65       	sub    $0x65676170,%eax
 a5a:	2d 61 6c 6c 6f       	sub    $0x6f6c6c61,%eax
 a5f:	63 00                	movslq (%rax),%eax

0000000000000a61 <__mod_intree17>:
 a61:	69 6e 74 72 65 65 3d 	imul   $0x3d656572,0x74(%rsi),%ebp
 a68:	59                   	pop    %rcx
	...

0000000000000a6a <__mod_vermagic5>:
 a6a:	76 65                	jbe    ad1 <__mod_vermagic5+0x67>
 a6c:	72 6d                	jb     adb <__mod_vermagic5+0x71>
 a6e:	61                   	(bad)  
 a6f:	67 69 63 3d 32 2e 36 	imul   $0x2e362e32,0x3d(%ebx),%esp
 a76:	2e 
 a77:	33 38                	xor    (%rax),%edi
 a79:	2d 32 2d 61 6d       	sub    $0x6d612d32,%eax
 a7e:	64                   	fs
 a7f:	36                   	ss
 a80:	34 20                	xor    $0x20,%al
 a82:	53                   	push   %rbx
 a83:	4d 50                	rex.WRB push %r8
 a85:	20 6d 6f             	and    %ch,0x6f(%rbp)
 a88:	64                   	fs
 a89:	5f                   	pop    %rdi
 a8a:	75 6e                	jne    afa <__mod_vermagic5+0x90>
 a8c:	6c                   	insb   (%dx),%es:(%rdi)
 a8d:	6f                   	outsl  %ds:(%rsi),(%dx)
 a8e:	61                   	(bad)  
 a8f:	64 20 6d 6f          	and    %ch,%fs:0x6f(%rbp)
 a93:	64                   	fs
 a94:	76 65                	jbe    afb <__mod_vermagic5+0x91>
 a96:	72 73                	jb     b0b <__mod_vermagic5+0xa1>
 a98:	69                   	.byte 0x69
 a99:	6f                   	outsl  %ds:(%rsi),(%dx)
 a9a:	6e                   	outsb  %ds:(%rsi),(%dx)
 a9b:	73 20                	jae    abd <__mod_vermagic5+0x53>
	...

Disassembly of section __param:

0000000000000000 <__param_power_save_controller>:
	...
  10:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
  11:	01 00                	add    %eax,(%rax)
	...

0000000000000020 <__param_power_save>:
	...
  30:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
  31:	01 00                	add    %eax,(%rax)
	...

0000000000000040 <__param_beep_mode>:
	...
  50:	24 01                	and    $0x1,%al
	...

0000000000000060 <__param_patch>:
	...
  70:	24 01                	and    $0x1,%al
	...

0000000000000080 <__param_enable_msi>:
	...
  90:	24 01                	and    $0x1,%al
	...

00000000000000a0 <__param_single_cmd>:
	...
  b0:	24 01                	and    $0x1,%al
	...

00000000000000c0 <__param_probe_only>:
	...
  d0:	24 01                	and    $0x1,%al
	...

00000000000000e0 <__param_probe_mask>:
	...
  f0:	24 01                	and    $0x1,%al
	...

0000000000000100 <__param_bdl_pos_adj>:
	...
 110:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
 111:	01 00                	add    %eax,(%rax)
	...

0000000000000120 <__param_position_fix>:
	...
 130:	24 01                	and    $0x1,%al
	...

0000000000000140 <__param_model>:
	...
 150:	24 01                	and    $0x1,%al
	...

0000000000000160 <__param_enable>:
	...
 170:	24 01                	and    $0x1,%al
	...

0000000000000180 <__param_id>:
	...
 190:	24 01                	and    $0x1,%al
	...

00000000000001a0 <__param_index>:
	...
 1b0:	24 01                	and    $0x1,%al
	...

Disassembly of section .devinit.rodata:

0000000000000000 <__mod_pci_device_table>:
   0:	86 80 00 00 20 1c    	xchg   %al,0x1c200000(%rax)
   6:	00 00                	add    %al,(%rax)
   8:	ff                   	(bad)  
   9:	ff                   	(bad)  
   a:	ff                   	(bad)  
   b:	ff                   	(bad)  
   c:	ff                   	(bad)  
   d:	ff                   	(bad)  
   e:	ff                   	(bad)  
   f:	ff 00                	incl   (%rax)
  11:	00 00                	add    %al,(%rax)
  13:	00 00                	add    %al,(%rax)
  15:	00 00                	add    %al,(%rax)
  17:	00 01                	add    %al,(%rcx)
  19:	00 00                	add    %al,(%rax)
  1b:	00 00                	add    %al,(%rax)
  1d:	00 00                	add    %al,(%rax)
  1f:	00 86 80 00 00 20    	add    %al,0x20000080(%rsi)
  25:	1d 00 00 ff ff       	sbb    $0xffff0000,%eax
  2a:	ff                   	(bad)  
  2b:	ff                   	(bad)  
  2c:	ff                   	(bad)  
  2d:	ff                   	(bad)  
  2e:	ff                   	(bad)  
  2f:	ff 00                	incl   (%rax)
  31:	00 00                	add    %al,(%rax)
  33:	00 00                	add    %al,(%rax)
  35:	00 00                	add    %al,(%rax)
  37:	00 01                	add    %al,(%rcx)
  39:	00 00                	add    %al,(%rax)
  3b:	00 00                	add    %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
  3f:	00 86 80 00 00 1b    	add    %al,0x1b000080(%rsi)
  45:	81 00 00 ff ff ff    	addl   $0xffffff00,(%rax)
  4b:	ff                   	(bad)  
  4c:	ff                   	(bad)  
  4d:	ff                   	(bad)  
  4e:	ff                   	(bad)  
  4f:	ff 00                	incl   (%rax)
  51:	00 00                	add    %al,(%rax)
  53:	00 00                	add    %al,(%rax)
  55:	00 00                	add    %al,(%rax)
  57:	00 02                	add    %al,(%rdx)
  59:	00 00                	add    %al,(%rax)
  5b:	00 00                	add    %al,(%rax)
  5d:	00 00                	add    %al,(%rax)
  5f:	00 86 80 00 00 ff    	add    %al,-0xffff80(%rsi)
  65:	ff                   	(bad)  
  66:	ff                   	(bad)  
  67:	ff                   	(bad)  
  68:	ff                   	(bad)  
  69:	ff                   	(bad)  
  6a:	ff                   	(bad)  
  6b:	ff                   	(bad)  
  6c:	ff                   	(bad)  
  6d:	ff                   	(bad)  
  6e:	ff                   	(bad)  
  6f:	ff 00                	incl   (%rax)
  71:	03 04 00             	add    (%rax,%rax,1),%eax
  74:	ff                   	(bad)  
  75:	ff                   	(bad)  
  76:	ff 00                	incl   (%rax)
	...
  80:	02 10                	add    (%rax),%dl
  82:	00 00                	add    %al,(%rax)
  84:	7b 43                	jnp    c9 <__mod_pci_device_table+0xc9>
  86:	00 00                	add    %al,(%rax)
  88:	ff                   	(bad)  
  89:	ff                   	(bad)  
  8a:	ff                   	(bad)  
  8b:	ff                   	(bad)  
  8c:	ff                   	(bad)  
  8d:	ff                   	(bad)  
  8e:	ff                   	(bad)  
  8f:	ff 00                	incl   (%rax)
  91:	00 00                	add    %al,(%rax)
  93:	00 00                	add    %al,(%rax)
  95:	00 00                	add    %al,(%rax)
  97:	00 03                	add    %al,(%rbx)
  99:	00 00                	add    %al,(%rax)
  9b:	00 00                	add    %al,(%rax)
  9d:	00 00                	add    %al,(%rax)
  9f:	00 02                	add    %al,(%rdx)
  a1:	10 00                	adc    %al,(%rax)
  a3:	00 83 43 00 00 ff    	add    %al,-0xffffbd(%rbx)
  a9:	ff                   	(bad)  
  aa:	ff                   	(bad)  
  ab:	ff                   	(bad)  
  ac:	ff                   	(bad)  
  ad:	ff                   	(bad)  
  ae:	ff                   	(bad)  
  af:	ff 00                	incl   (%rax)
  b1:	00 00                	add    %al,(%rax)
  b3:	00 00                	add    %al,(%rax)
  b5:	00 00                	add    %al,(%rax)
  b7:	00 03                	add    %al,(%rbx)
  b9:	00 00                	add    %al,(%rax)
  bb:	00 00                	add    %al,(%rax)
  bd:	00 00                	add    %al,(%rax)
  bf:	00 02                	add    %al,(%rdx)
  c1:	10 00                	adc    %al,(%rax)
  c3:	00 3b                	add    %bh,(%rbx)
  c5:	79 00                	jns    c7 <__mod_pci_device_table+0xc7>
  c7:	00 ff                	add    %bh,%bh
  c9:	ff                   	(bad)  
  ca:	ff                   	(bad)  
  cb:	ff                   	(bad)  
  cc:	ff                   	(bad)  
  cd:	ff                   	(bad)  
  ce:	ff                   	(bad)  
  cf:	ff 00                	incl   (%rax)
  d1:	00 00                	add    %al,(%rax)
  d3:	00 00                	add    %al,(%rax)
  d5:	00 00                	add    %al,(%rax)
  d7:	00 04 00             	add    %al,(%rax,%rax,1)
  da:	00 00                	add    %al,(%rax)
  dc:	00 00                	add    %al,(%rax)
  de:	00 00                	add    %al,(%rax)
  e0:	02 10                	add    (%rax),%dl
  e2:	00 00                	add    %al,(%rax)
  e4:	19 79 00             	sbb    %edi,0x0(%rcx)
  e7:	00 ff                	add    %bh,%bh
  e9:	ff                   	(bad)  
  ea:	ff                   	(bad)  
  eb:	ff                   	(bad)  
  ec:	ff                   	(bad)  
  ed:	ff                   	(bad)  
  ee:	ff                   	(bad)  
  ef:	ff 00                	incl   (%rax)
  f1:	00 00                	add    %al,(%rax)
  f3:	00 00                	add    %al,(%rax)
  f5:	00 00                	add    %al,(%rax)
  f7:	00 04 00             	add    %al,(%rax,%rax,1)
  fa:	00 00                	add    %al,(%rax)
  fc:	00 00                	add    %al,(%rax)
  fe:	00 00                	add    %al,(%rax)
 100:	02 10                	add    (%rax),%dl
 102:	00 00                	add    %al,(%rax)
 104:	0f 96 00             	setbe  (%rax)
 107:	00 ff                	add    %bh,%bh
 109:	ff                   	(bad)  
 10a:	ff                   	(bad)  
 10b:	ff                   	(bad)  
 10c:	ff                   	(bad)  
 10d:	ff                   	(bad)  
 10e:	ff                   	(bad)  
 10f:	ff 00                	incl   (%rax)
 111:	00 00                	add    %al,(%rax)
 113:	00 00                	add    %al,(%rax)
 115:	00 00                	add    %al,(%rax)
 117:	00 04 00             	add    %al,(%rax,%rax,1)
 11a:	00 00                	add    %al,(%rax)
 11c:	00 00                	add    %al,(%rax)
 11e:	00 00                	add    %al,(%rax)
 120:	02 10                	add    (%rax),%dl
 122:	00 00                	add    %al,(%rax)
 124:	0f 97 00             	seta   (%rax)
 127:	00 ff                	add    %bh,%bh
 129:	ff                   	(bad)  
 12a:	ff                   	(bad)  
 12b:	ff                   	(bad)  
 12c:	ff                   	(bad)  
 12d:	ff                   	(bad)  
 12e:	ff                   	(bad)  
 12f:	ff 00                	incl   (%rax)
 131:	00 00                	add    %al,(%rax)
 133:	00 00                	add    %al,(%rax)
 135:	00 00                	add    %al,(%rax)
 137:	00 04 00             	add    %al,(%rax,%rax,1)
 13a:	00 00                	add    %al,(%rax)
 13c:	00 00                	add    %al,(%rax)
 13e:	00 00                	add    %al,(%rax)
 140:	02 10                	add    (%rax),%dl
 142:	00 00                	add    %al,(%rax)
 144:	00 aa 00 00 ff ff    	add    %ch,-0x10000(%rdx)
 14a:	ff                   	(bad)  
 14b:	ff                   	(bad)  
 14c:	ff                   	(bad)  
 14d:	ff                   	(bad)  
 14e:	ff                   	(bad)  
 14f:	ff 00                	incl   (%rax)
 151:	00 00                	add    %al,(%rax)
 153:	00 00                	add    %al,(%rax)
 155:	00 00                	add    %al,(%rax)
 157:	00 04 00             	add    %al,(%rax,%rax,1)
 15a:	00 00                	add    %al,(%rax)
 15c:	00 00                	add    %al,(%rax)
 15e:	00 00                	add    %al,(%rax)
 160:	02 10                	add    (%rax),%dl
 162:	00 00                	add    %al,(%rax)
 164:	08 aa 00 00 ff ff    	or     %ch,-0x10000(%rdx)
 16a:	ff                   	(bad)  
 16b:	ff                   	(bad)  
 16c:	ff                   	(bad)  
 16d:	ff                   	(bad)  
 16e:	ff                   	(bad)  
 16f:	ff 00                	incl   (%rax)
 171:	00 00                	add    %al,(%rax)
 173:	00 00                	add    %al,(%rax)
 175:	00 00                	add    %al,(%rax)
 177:	00 04 00             	add    %al,(%rax,%rax,1)
 17a:	00 00                	add    %al,(%rax)
 17c:	00 00                	add    %al,(%rax)
 17e:	00 00                	add    %al,(%rax)
 180:	02 10                	add    (%rax),%dl
 182:	00 00                	add    %al,(%rax)
 184:	10 aa 00 00 ff ff    	adc    %ch,-0x10000(%rdx)
 18a:	ff                   	(bad)  
 18b:	ff                   	(bad)  
 18c:	ff                   	(bad)  
 18d:	ff                   	(bad)  
 18e:	ff                   	(bad)  
 18f:	ff 00                	incl   (%rax)
 191:	00 00                	add    %al,(%rax)
 193:	00 00                	add    %al,(%rax)
 195:	00 00                	add    %al,(%rax)
 197:	00 04 00             	add    %al,(%rax,%rax,1)
 19a:	00 00                	add    %al,(%rax)
 19c:	00 00                	add    %al,(%rax)
 19e:	00 00                	add    %al,(%rax)
 1a0:	02 10                	add    (%rax),%dl
 1a2:	00 00                	add    %al,(%rax)
 1a4:	18 aa 00 00 ff ff    	sbb    %ch,-0x10000(%rdx)
 1aa:	ff                   	(bad)  
 1ab:	ff                   	(bad)  
 1ac:	ff                   	(bad)  
 1ad:	ff                   	(bad)  
 1ae:	ff                   	(bad)  
 1af:	ff 00                	incl   (%rax)
 1b1:	00 00                	add    %al,(%rax)
 1b3:	00 00                	add    %al,(%rax)
 1b5:	00 00                	add    %al,(%rax)
 1b7:	00 04 00             	add    %al,(%rax,%rax,1)
 1ba:	00 00                	add    %al,(%rax)
 1bc:	00 00                	add    %al,(%rax)
 1be:	00 00                	add    %al,(%rax)
 1c0:	02 10                	add    (%rax),%dl
 1c2:	00 00                	add    %al,(%rax)
 1c4:	20 aa 00 00 ff ff    	and    %ch,-0x10000(%rdx)
 1ca:	ff                   	(bad)  
 1cb:	ff                   	(bad)  
 1cc:	ff                   	(bad)  
 1cd:	ff                   	(bad)  
 1ce:	ff                   	(bad)  
 1cf:	ff 00                	incl   (%rax)
 1d1:	00 00                	add    %al,(%rax)
 1d3:	00 00                	add    %al,(%rax)
 1d5:	00 00                	add    %al,(%rax)
 1d7:	00 04 00             	add    %al,(%rax,%rax,1)
 1da:	00 00                	add    %al,(%rax)
 1dc:	00 00                	add    %al,(%rax)
 1de:	00 00                	add    %al,(%rax)
 1e0:	02 10                	add    (%rax),%dl
 1e2:	00 00                	add    %al,(%rax)
 1e4:	28 aa 00 00 ff ff    	sub    %ch,-0x10000(%rdx)
 1ea:	ff                   	(bad)  
 1eb:	ff                   	(bad)  
 1ec:	ff                   	(bad)  
 1ed:	ff                   	(bad)  
 1ee:	ff                   	(bad)  
 1ef:	ff 00                	incl   (%rax)
 1f1:	00 00                	add    %al,(%rax)
 1f3:	00 00                	add    %al,(%rax)
 1f5:	00 00                	add    %al,(%rax)
 1f7:	00 04 00             	add    %al,(%rax,%rax,1)
 1fa:	00 00                	add    %al,(%rax)
 1fc:	00 00                	add    %al,(%rax)
 1fe:	00 00                	add    %al,(%rax)
 200:	02 10                	add    (%rax),%dl
 202:	00 00                	add    %al,(%rax)
 204:	30 aa 00 00 ff ff    	xor    %ch,-0x10000(%rdx)
 20a:	ff                   	(bad)  
 20b:	ff                   	(bad)  
 20c:	ff                   	(bad)  
 20d:	ff                   	(bad)  
 20e:	ff                   	(bad)  
 20f:	ff 00                	incl   (%rax)
 211:	00 00                	add    %al,(%rax)
 213:	00 00                	add    %al,(%rax)
 215:	00 00                	add    %al,(%rax)
 217:	00 04 00             	add    %al,(%rax,%rax,1)
 21a:	00 00                	add    %al,(%rax)
 21c:	00 00                	add    %al,(%rax)
 21e:	00 00                	add    %al,(%rax)
 220:	02 10                	add    (%rax),%dl
 222:	00 00                	add    %al,(%rax)
 224:	38 aa 00 00 ff ff    	cmp    %ch,-0x10000(%rdx)
 22a:	ff                   	(bad)  
 22b:	ff                   	(bad)  
 22c:	ff                   	(bad)  
 22d:	ff                   	(bad)  
 22e:	ff                   	(bad)  
 22f:	ff 00                	incl   (%rax)
 231:	00 00                	add    %al,(%rax)
 233:	00 00                	add    %al,(%rax)
 235:	00 00                	add    %al,(%rax)
 237:	00 04 00             	add    %al,(%rax,%rax,1)
 23a:	00 00                	add    %al,(%rax)
 23c:	00 00                	add    %al,(%rax)
 23e:	00 00                	add    %al,(%rax)
 240:	02 10                	add    (%rax),%dl
 242:	00 00                	add    %al,(%rax)
 244:	40 aa                	stos   %al,%es:(%rdi)
 246:	00 00                	add    %al,(%rax)
 248:	ff                   	(bad)  
 249:	ff                   	(bad)  
 24a:	ff                   	(bad)  
 24b:	ff                   	(bad)  
 24c:	ff                   	(bad)  
 24d:	ff                   	(bad)  
 24e:	ff                   	(bad)  
 24f:	ff 00                	incl   (%rax)
 251:	00 00                	add    %al,(%rax)
 253:	00 00                	add    %al,(%rax)
 255:	00 00                	add    %al,(%rax)
 257:	00 04 00             	add    %al,(%rax,%rax,1)
 25a:	00 00                	add    %al,(%rax)
 25c:	00 00                	add    %al,(%rax)
 25e:	00 00                	add    %al,(%rax)
 260:	02 10                	add    (%rax),%dl
 262:	00 00                	add    %al,(%rax)
 264:	48 aa                	rex.W stos %al,%es:(%rdi)
 266:	00 00                	add    %al,(%rax)
 268:	ff                   	(bad)  
 269:	ff                   	(bad)  
 26a:	ff                   	(bad)  
 26b:	ff                   	(bad)  
 26c:	ff                   	(bad)  
 26d:	ff                   	(bad)  
 26e:	ff                   	(bad)  
 26f:	ff 00                	incl   (%rax)
 271:	00 00                	add    %al,(%rax)
 273:	00 00                	add    %al,(%rax)
 275:	00 00                	add    %al,(%rax)
 277:	00 04 00             	add    %al,(%rax,%rax,1)
 27a:	00 00                	add    %al,(%rax)
 27c:	00 00                	add    %al,(%rax)
 27e:	00 00                	add    %al,(%rax)
 280:	06                   	(bad)  
 281:	11 00                	adc    %eax,(%rax)
 283:	00 88 32 00 00 ff    	add    %cl,-0xffffce(%rax)
 289:	ff                   	(bad)  
 28a:	ff                   	(bad)  
 28b:	ff                   	(bad)  
 28c:	ff                   	(bad)  
 28d:	ff                   	(bad)  
 28e:	ff                   	(bad)  
 28f:	ff 00                	incl   (%rax)
 291:	00 00                	add    %al,(%rax)
 293:	00 00                	add    %al,(%rax)
 295:	00 00                	add    %al,(%rax)
 297:	00 05 00 00 00 00    	add    %al,0x0(%rip)        # 29d <__mod_pci_device_table+0x29d>
 29d:	00 00                	add    %al,(%rax)
 29f:	00 39                	add    %bh,(%rcx)
 2a1:	10 00                	adc    %al,(%rax)
 2a3:	00 02                	add    %al,(%rdx)
 2a5:	75 00                	jne    2a7 <__mod_pci_device_table+0x2a7>
 2a7:	00 ff                	add    %bh,%bh
 2a9:	ff                   	(bad)  
 2aa:	ff                   	(bad)  
 2ab:	ff                   	(bad)  
 2ac:	ff                   	(bad)  
 2ad:	ff                   	(bad)  
 2ae:	ff                   	(bad)  
 2af:	ff 00                	incl   (%rax)
 2b1:	00 00                	add    %al,(%rax)
 2b3:	00 00                	add    %al,(%rax)
 2b5:	00 00                	add    %al,(%rax)
 2b7:	00 06                	add    %al,(%rsi)
 2b9:	00 00                	add    %al,(%rax)
 2bb:	00 00                	add    %al,(%rax)
 2bd:	00 00                	add    %al,(%rax)
 2bf:	00 b9 10 00 00 61    	add    %bh,0x61000010(%rcx)
 2c5:	54                   	push   %rsp
 2c6:	00 00                	add    %al,(%rax)
 2c8:	ff                   	(bad)  
 2c9:	ff                   	(bad)  
 2ca:	ff                   	(bad)  
 2cb:	ff                   	(bad)  
 2cc:	ff                   	(bad)  
 2cd:	ff                   	(bad)  
 2ce:	ff                   	(bad)  
 2cf:	ff 00                	incl   (%rax)
 2d1:	00 00                	add    %al,(%rax)
 2d3:	00 00                	add    %al,(%rax)
 2d5:	00 00                	add    %al,(%rax)
 2d7:	00 07                	add    %al,(%rdi)
 2d9:	00 00                	add    %al,(%rax)
 2db:	00 00                	add    %al,(%rax)
 2dd:	00 00                	add    %al,(%rax)
 2df:	00 de                	add    %bl,%dh
 2e1:	10 00                	adc    %al,(%rax)
 2e3:	00 ff                	add    %bh,%bh
 2e5:	ff                   	(bad)  
 2e6:	ff                   	(bad)  
 2e7:	ff                   	(bad)  
 2e8:	ff                   	(bad)  
 2e9:	ff                   	(bad)  
 2ea:	ff                   	(bad)  
 2eb:	ff                   	(bad)  
 2ec:	ff                   	(bad)  
 2ed:	ff                   	(bad)  
 2ee:	ff                   	(bad)  
 2ef:	ff 00                	incl   (%rax)
 2f1:	03 04 00             	add    (%rax,%rax,1),%eax
 2f4:	ff                   	(bad)  
 2f5:	ff                   	(bad)  
 2f6:	ff 00                	incl   (%rax)
 2f8:	08 00                	or     %al,(%rax)
 2fa:	00 00                	add    %al,(%rax)
 2fc:	00 00                	add    %al,(%rax)
 2fe:	00 00                	add    %al,(%rax)
 300:	49                   	rex.WB
 301:	65 00 00             	add    %al,%gs:(%rax)
 304:	00 12                	add    %dl,(%rdx)
 306:	00 00                	add    %al,(%rax)
 308:	ff                   	(bad)  
 309:	ff                   	(bad)  
 30a:	ff                   	(bad)  
 30b:	ff                   	(bad)  
 30c:	ff                   	(bad)  
 30d:	ff                   	(bad)  
 30e:	ff                   	(bad)  
 30f:	ff 00                	incl   (%rax)
 311:	00 00                	add    %al,(%rax)
 313:	00 00                	add    %al,(%rax)
 315:	00 00                	add    %al,(%rax)
 317:	00 09                	add    %cl,(%rcx)
 319:	00 00                	add    %al,(%rax)
 31b:	00 00                	add    %al,(%rax)
 31d:	00 00                	add    %al,(%rax)
 31f:	00 02                	add    %al,(%rdx)
 321:	11 00                	adc    %eax,(%rax)
 323:	00 09                	add    %cl,(%rcx)
 325:	00 00                	add    %al,(%rax)
 327:	00 ff                	add    %bh,%bh
 329:	ff                   	(bad)  
 32a:	ff                   	(bad)  
 32b:	ff                   	(bad)  
 32c:	ff                   	(bad)  
 32d:	ff                   	(bad)  
 32e:	ff                   	(bad)  
 32f:	ff 00                	incl   (%rax)
 331:	00 00                	add    %al,(%rax)
 333:	00 00                	add    %al,(%rax)
 335:	00 00                	add    %al,(%rax)
 337:	00 0a                	add    %cl,(%rdx)
 339:	00 00                	add    %al,(%rax)
 33b:	00 00                	add    %al,(%rax)
 33d:	00 00                	add    %al,(%rax)
 33f:	00 f3                	add    %dh,%bl
 341:	17                   	(bad)  
 342:	00 00                	add    %al,(%rax)
 344:	10 30                	adc    %dh,(%rax)
 346:	00 00                	add    %al,(%rax)
 348:	ff                   	(bad)  
 349:	ff                   	(bad)  
 34a:	ff                   	(bad)  
 34b:	ff                   	(bad)  
 34c:	ff                   	(bad)  
 34d:	ff                   	(bad)  
 34e:	ff                   	(bad)  
 34f:	ff 00                	incl   (%rax)
 351:	00 00                	add    %al,(%rax)
 353:	00 00                	add    %al,(%rax)
 355:	00 00                	add    %al,(%rax)
 357:	00 0b                	add    %cl,(%rbx)
 359:	00 00                	add    %al,(%rax)
 35b:	00 00                	add    %al,(%rax)
 35d:	00 00                	add    %al,(%rax)
 35f:	00 ad 15 00 00 77    	add    %ch,0x77000015(%rbp)
 365:	19 00                	sbb    %eax,(%rax)
 367:	00 ff                	add    %bh,%bh
 369:	ff                   	(bad)  
 36a:	ff                   	(bad)  
 36b:	ff                   	(bad)  
 36c:	ff                   	(bad)  
 36d:	ff                   	(bad)  
 36e:	ff                   	(bad)  
 36f:	ff 00                	incl   (%rax)
 371:	00 00                	add    %al,(%rax)
 373:	00 00                	add    %al,(%rax)
 375:	00 00                	add    %al,(%rax)
 377:	00 0b                	add    %cl,(%rbx)
 379:	00 00                	add    %al,(%rax)
 37b:	00 00                	add    %al,(%rax)
 37d:	00 00                	add    %al,(%rax)
 37f:	00 02                	add    %al,(%rdx)
 381:	10 00                	adc    %al,(%rax)
 383:	00 ff                	add    %bh,%bh
 385:	ff                   	(bad)  
 386:	ff                   	(bad)  
 387:	ff                   	(bad)  
 388:	ff                   	(bad)  
 389:	ff                   	(bad)  
 38a:	ff                   	(bad)  
 38b:	ff                   	(bad)  
 38c:	ff                   	(bad)  
 38d:	ff                   	(bad)  
 38e:	ff                   	(bad)  
 38f:	ff 00                	incl   (%rax)
 391:	03 04 00             	add    (%rax,%rax,1),%eax
 394:	ff                   	(bad)  
 395:	ff                   	(bad)  
 396:	ff 00                	incl   (%rax)
 398:	0b 00                	or     (%rax),%eax
 39a:	00 00                	add    %al,(%rax)
 39c:	00 00                	add    %al,(%rax)
 39e:	00 00                	add    %al,(%rax)
 3a0:	22 10                	and    (%rax),%dl
 3a2:	00 00                	add    %al,(%rax)
 3a4:	ff                   	(bad)  
 3a5:	ff                   	(bad)  
 3a6:	ff                   	(bad)  
 3a7:	ff                   	(bad)  
 3a8:	ff                   	(bad)  
 3a9:	ff                   	(bad)  
 3aa:	ff                   	(bad)  
 3ab:	ff                   	(bad)  
 3ac:	ff                   	(bad)  
 3ad:	ff                   	(bad)  
 3ae:	ff                   	(bad)  
 3af:	ff 00                	incl   (%rax)
 3b1:	03 04 00             	add    (%rax,%rax,1),%eax
 3b4:	ff                   	(bad)  
 3b5:	ff                   	(bad)  
 3b6:	ff 00                	incl   (%rax)
 3b8:	0b 00                	or     (%rax),%eax
	...

Disassembly of section __versions:

0000000000000000 <____versions>:
       0:	aa                   	stos   %al,%es:(%rdi)
       1:	3c 0e                	cmp    $0xe,%al
       3:	86 00                	xchg   %al,(%rax)
       5:	00 00                	add    %al,(%rax)
       7:	00 6d 6f             	add    %ch,0x6f(%rbp)
       a:	64                   	fs
       b:	75 6c                	jne    79 <____versions+0x79>
       d:	65                   	gs
       e:	5f                   	pop    %rdi
       f:	6c                   	insb   (%dx),%es:(%rdi)
      10:	61                   	(bad)  
      11:	79 6f                	jns    82 <____versions+0x82>
      13:	75 74                	jne    89 <____versions+0x89>
	...
      3d:	00 00                	add    %al,(%rax)
      3f:	00 59 b4             	add    %bl,-0x4c(%rcx)
      42:	dd 56 00             	fstl   0x0(%rsi)
      45:	00 00                	add    %al,(%rax)
      47:	00 70 63             	add    %dh,0x63(%rax)
      4a:	69 5f 62 75 73 5f 72 	imul   $0x725f7375,0x62(%rdi),%ebx
      51:	65                   	gs
      52:	61                   	(bad)  
      53:	64                   	fs
      54:	5f                   	pop    %rdi
      55:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
      58:	66 69 67 5f 62 79    	imul   $0x7962,0x5f(%rdi),%sp
      5e:	74 65                	je     c5 <____versions+0xc5>
	...
      80:	5c                   	pop    %rsp
      81:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
      82:	34 5a                	xor    $0x5a,%al
      84:	00 00                	add    %al,(%rax)
      86:	00 00                	add    %al,(%rax)
      88:	5f                   	pop    %rdi
      89:	5f                   	pop    %rdi
      8a:	6b 6d 61 6c          	imul   $0x6c,0x61(%rbp),%ebp
      8e:	6c                   	insb   (%dx),%es:(%rdi)
      8f:	6f                   	outsl  %ds:(%rsi),(%dx)
      90:	63 00                	movslq (%rax),%eax
	...
      be:	00 00                	add    %al,(%rax)
      c0:	f9                   	stc    
      c1:	82                   	(bad)  
      c2:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
      c3:	f9                   	stc    
      c4:	00 00                	add    %al,(%rax)
      c6:	00 00                	add    %al,(%rax)
      c8:	6d                   	insl   (%dx),%es:(%rdi)
      c9:	73 6c                	jae    137 <____versions+0x137>
      cb:	65                   	gs
      cc:	65                   	gs
      cd:	70 00                	jo     cf <____versions+0xcf>
	...
      ff:	00 57 d5             	add    %dl,-0x2b(%rdi)
     102:	dc a5 00 00 00 00    	fsubl  0x0(%rbp)
     108:	73 6e                	jae    178 <____versions+0x178>
     10a:	64                   	fs
     10b:	5f                   	pop    %rdi
     10c:	68 64 61 5f 63       	pushq  $0x635f6164
     111:	6f                   	outsl  %ds:(%rsi),(%dx)
     112:	64 65 63 5f 70       	fs movslq %fs:%gs:0x70(%rdi),%ebx
     117:	72 65                	jb     17e <____versions+0x17e>
     119:	70 61                	jo     17c <____versions+0x17c>
     11b:	72 65                	jb     182 <____versions+0x182>
	...
     13d:	00 00                	add    %al,(%rax)
     13f:	00 8a 92 0c a9 00    	add    %cl,0xa90c92(%rdx)
     145:	00 00                	add    %al,(%rax)
     147:	00 70 61             	add    %dh,0x61(%rax)
     14a:	72 61                	jb     1ad <____versions+0x1ad>
     14c:	6d                   	insl   (%dx),%es:(%rdi)
     14d:	5f                   	pop    %rdi
     14e:	6f                   	outsl  %ds:(%rsi),(%dx)
     14f:	70 73                	jo     1c4 <____versions+0x1c4>
     151:	5f                   	pop    %rdi
     152:	69 6e 74 00 00 00 00 	imul   $0x0,0x74(%rsi),%ebp
	...
     17d:	00 00                	add    %al,(%rax)
     17f:	00 69 b7             	add    %ch,-0x49(%rcx)
     182:	82                   	(bad)  
     183:	55                   	push   %rbp
     184:	00 00                	add    %al,(%rax)
     186:	00 00                	add    %al,(%rax)
     188:	64                   	fs
     189:	65                   	gs
     18a:	76 5f                	jbe    1eb <____versions+0x1eb>
     18c:	73 65                	jae    1f3 <____versions+0x1f3>
     18e:	74 5f                	je     1ef <____versions+0x1ef>
     190:	64                   	fs
     191:	72 76                	jb     209 <____versions+0x209>
     193:	64                   	fs
     194:	61                   	(bad)  
     195:	74 61                	je     1f8 <____versions+0x1f8>
	...
     1bf:	00 34 c6             	add    %dh,(%rsi,%rax,8)
     1c2:	90                   	nop
     1c3:	67 00 00             	add    %al,(%eax)
     1c6:	00 00                	add    %al,(%rax)
     1c8:	73 6e                	jae    238 <____versions+0x238>
     1ca:	64                   	fs
     1cb:	5f                   	pop    %rdi
     1cc:	70 63                	jo     231 <____versions+0x231>
     1ce:	6d                   	insl   (%dx),%es:(%rdi)
     1cf:	5f                   	pop    %rdi
     1d0:	68 77 5f 63 6f       	pushq  $0x6f635f77
     1d5:	6e                   	outsb  %ds:(%rsi),(%dx)
     1d6:	73 74                	jae    24c <____versions+0x24c>
     1d8:	72 61                	jb     23b <____versions+0x23b>
     1da:	69 6e 74 5f 73 74 65 	imul   $0x6574735f,0x74(%rsi),%ebp
     1e1:	70 00                	jo     1e3 <____versions+0x1e3>
	...
     1ff:	00 5c ab 72          	add    %bl,0x72(%rbx,%rbp,4)
     203:	7c 00                	jl     205 <____versions+0x205>
     205:	00 00                	add    %al,(%rax)
     207:	00 73 6e             	add    %dh,0x6e(%rbx)
     20a:	64                   	fs
     20b:	5f                   	pop    %rdi
     20c:	70 63                	jo     271 <____versions+0x271>
     20e:	6d                   	insl   (%dx),%es:(%rdi)
     20f:	5f                   	pop    %rdi
     210:	70 65                	jo     277 <____versions+0x277>
     212:	72 69                	jb     27d <____versions+0x27d>
     214:	6f                   	outsl  %ds:(%rsi),(%dx)
     215:	64                   	fs
     216:	5f                   	pop    %rdi
     217:	65                   	gs
     218:	6c                   	insb   (%dx),%es:(%rdi)
     219:	61                   	(bad)  
     21a:	70 73                	jo     28f <____versions+0x28f>
     21c:	65 64 00 00          	gs add %al,%fs:%gs:(%rax)
	...
     240:	5d                   	pop    %rbp
     241:	bd 1b be 00 00       	mov    $0xbe1b,%ebp
     246:	00 00                	add    %al,(%rax)
     248:	73 6e                	jae    2b8 <____versions+0x2b8>
     24a:	64                   	fs
     24b:	5f                   	pop    %rdi
     24c:	63 61 72             	movslq 0x72(%rcx),%esp
     24f:	64                   	fs
     250:	5f                   	pop    %rdi
     251:	63 72 65             	movslq 0x65(%rdx),%esi
     254:	61                   	(bad)  
     255:	74 65                	je     2bc <____versions+0x2bc>
	...
     27f:	00 61 72             	add    %ah,0x72(%rcx)
     282:	c1 11 00             	rcll   $0x0,(%rcx)
     285:	00 00                	add    %al,(%rax)
     287:	00 73 6e             	add    %dh,0x6e(%rbx)
     28a:	64                   	fs
     28b:	5f                   	pop    %rdi
     28c:	64                   	fs
     28d:	6d                   	insl   (%dx),%es:(%rdi)
     28e:	61                   	(bad)  
     28f:	5f                   	pop    %rdi
     290:	61                   	(bad)  
     291:	6c                   	insb   (%dx),%es:(%rdi)
     292:	6c                   	insb   (%dx),%es:(%rdi)
     293:	6f                   	outsl  %ds:(%rsi),(%dx)
     294:	63 5f 70             	movslq 0x70(%rdi),%ebx
     297:	61                   	(bad)  
     298:	67                   	addr32
     299:	65                   	gs
     29a:	73 00                	jae    29c <____versions+0x29c>
	...
     2c0:	0d 4e 01 78 00       	or     $0x78014e,%eax
     2c5:	00 00                	add    %al,(%rax)
     2c7:	00 64 6d 61          	add    %ah,0x61(%rbp,%rbp,2)
     2cb:	5f                   	pop    %rdi
     2cc:	73 65                	jae    333 <____versions+0x333>
     2ce:	74 5f                	je     32f <____versions+0x32f>
     2d0:	6d                   	insl   (%dx),%es:(%rdi)
     2d1:	61                   	(bad)  
     2d2:	73 6b                	jae    33f <____versions+0x33f>
	...
     300:	13 ba 10 19 00 00    	adc    0x1910(%rdx),%edi
     306:	00 00                	add    %al,(%rax)
     308:	70 63                	jo     36d <____versions+0x36d>
     30a:	69 5f 64 69 73 61 62 	imul   $0x62617369,0x64(%rdi),%ebx
     311:	6c                   	insb   (%dx),%es:(%rdi)
     312:	65                   	gs
     313:	5f                   	pop    %rdi
     314:	64                   	fs
     315:	65                   	gs
     316:	76 69                	jbe    381 <____versions+0x381>
     318:	63 65 00             	movslq 0x0(%rbp),%esp
	...
     33f:	00 72 42             	add    %dh,0x42(%rdx)
     342:	d5                   	(bad)  
     343:	b3 00                	mov    $0x0,%bl
     345:	00 00                	add    %al,(%rax)
     347:	00 73 6e             	add    %dh,0x6e(%rbx)
     34a:	64                   	fs
     34b:	5f                   	pop    %rdi
     34c:	70 63                	jo     3b1 <____versions+0x3b1>
     34e:	69 5f 71 75 69 72 6b 	imul   $0x6b726975,0x71(%rdi),%ebx
     355:	5f                   	pop    %rdi
     356:	6c                   	insb   (%dx),%es:(%rdi)
     357:	6f                   	outsl  %ds:(%rsi),(%dx)
     358:	6f                   	outsl  %ds:(%rsi),(%dx)
     359:	6b 75 70 00          	imul   $0x0,0x70(%rbp),%esi
	...
     37d:	00 00                	add    %al,(%rax)
     37f:	00 36                	add    %dh,(%rsi)
     381:	fd                   	std    
     382:	ff 5a 00             	lcallq *0x0(%rdx)
     385:	00 00                	add    %al,(%rax)
     387:	00 71 75             	add    %dh,0x75(%rcx)
     38a:	65                   	gs
     38b:	75 65                	jne    3f2 <____versions+0x3f2>
     38d:	5f                   	pop    %rdi
     38e:	77 6f                	ja     3ff <____versions+0x3ff>
     390:	72 6b                	jb     3fd <____versions+0x3fd>
	...
     3be:	00 00                	add    %al,(%rax)
     3c0:	d6                   	(bad)  
     3c1:	df e3                	(bad)  
     3c3:	ea                   	(bad)  
     3c4:	00 00                	add    %al,(%rax)
     3c6:	00 00                	add    %al,(%rax)
     3c8:	5f                   	pop    %rdi
     3c9:	5f                   	pop    %rdi
     3ca:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
     3cd:	73 74                	jae    443 <____versions+0x443>
     3cf:	5f                   	pop    %rdi
     3d0:	75 64                	jne    436 <____versions+0x436>
     3d2:	65                   	gs
     3d3:	6c                   	insb   (%dx),%es:(%rdi)
     3d4:	61                   	(bad)  
     3d5:	79 00                	jns    3d7 <____versions+0x3d7>
	...
     3ff:	00 a5 18 cc 5e 00    	add    %ah,0x5ecc18(%rbp)
     405:	00 00                	add    %al,(%rax)
     407:	00 70 63             	add    %dh,0x63(%rax)
     40a:	69 5f 72 65 6c 65 61 	imul   $0x61656c65,0x72(%rdi),%ebx
     411:	73 65                	jae    478 <____versions+0x478>
     413:	5f                   	pop    %rdi
     414:	72 65                	jb     47b <____versions+0x47b>
     416:	67 69 6f 6e 73 00 00 	imul   $0x73,0x6e(%edi),%ebp
     41d:	00 
	...
     43e:	00 00                	add    %al,(%rax)
     440:	05 b3 7b 67 00       	add    $0x677bb3,%eax
     445:	00 00                	add    %al,(%rax)
     447:	00 70 61             	add    %dh,0x61(%rax)
     44a:	72 61                	jb     4ad <____versions+0x4ad>
     44c:	6d                   	insl   (%dx),%es:(%rdi)
     44d:	5f                   	pop    %rdi
     44e:	6f                   	outsl  %ds:(%rsi),(%dx)
     44f:	70 73                	jo     4c4 <____versions+0x4c4>
     451:	5f                   	pop    %rdi
     452:	62                   	(bad)  
     453:	6f                   	outsl  %ds:(%rsi),(%dx)
     454:	6f                   	outsl  %ds:(%rsi),(%dx)
     455:	6c                   	insb   (%dx),%es:(%rdi)
	...
     47e:	00 00                	add    %al,(%rax)
     480:	06                   	(bad)  
     481:	6d                   	insl   (%dx),%es:(%rdi)
     482:	39 3f                	cmp    %edi,(%rdi)
     484:	00 00                	add    %al,(%rax)
     486:	00 00                	add    %al,(%rax)
     488:	6d                   	insl   (%dx),%es:(%rdi)
     489:	75 74                	jne    4ff <____versions+0x4ff>
     48b:	65                   	gs
     48c:	78 5f                	js     4ed <____versions+0x4ed>
     48e:	75 6e                	jne    4fe <____versions+0x4fe>
     490:	6c                   	insb   (%dx),%es:(%rdi)
     491:	6f                   	outsl  %ds:(%rsi),(%dx)
     492:	63 6b 00             	movslq 0x0(%rbx),%ebp
	...
     4bd:	00 00                	add    %al,(%rax)
     4bf:	00 4a f4             	add    %cl,-0xc(%rdx)
     4c2:	69 cb 00 00 00 00    	imul   $0x0,%ebx,%ecx
     4c8:	70 63                	jo     52d <____versions+0x52d>
     4ca:	69 5f 62 75 73 5f 77 	imul   $0x775f7375,0x62(%rdi),%ebx
     4d1:	72 69                	jb     53c <____versions+0x53c>
     4d3:	74 65                	je     53a <____versions+0x53a>
     4d5:	5f                   	pop    %rdi
     4d6:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
     4d9:	66 69 67 5f 77 6f    	imul   $0x6f77,0x5f(%rdi),%sp
     4df:	72 64                	jb     545 <____versions+0x545>
	...
     4fd:	00 00                	add    %al,(%rax)
     4ff:	00 cd                	add    %cl,%ch
     501:	6e                   	outsb  %ds:(%rsi),(%dx)
     502:	3d e5 00 00 00       	cmp    $0xe5,%eax
     507:	00 73 6e             	add    %dh,0x6e(%rbx)
     50a:	64                   	fs
     50b:	5f                   	pop    %rdi
     50c:	68 64 61 5f 62       	pushq  $0x625f6164
     511:	75 69                	jne    57c <____versions+0x57c>
     513:	6c                   	insb   (%dx),%es:(%rdi)
     514:	64                   	fs
     515:	5f                   	pop    %rdi
     516:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
     519:	74 72                	je     58d <____versions+0x58d>
     51b:	6f                   	outsl  %ds:(%rsi),(%dx)
     51c:	6c                   	insb   (%dx),%es:(%rdi)
     51d:	73 00                	jae    51f <____versions+0x51f>
	...
     53f:	00 76 b0             	add    %dh,-0x50(%rsi)
     542:	77 08                	ja     54c <____versions+0x54c>
     544:	00 00                	add    %al,(%rax)
     546:	00 00                	add    %al,(%rax)
     548:	73 6e                	jae    5b8 <____versions+0x5b8>
     54a:	64                   	fs
     54b:	5f                   	pop    %rdi
     54c:	70 63                	jo     5b1 <____versions+0x5b1>
     54e:	6d                   	insl   (%dx),%es:(%rdi)
     54f:	5f                   	pop    %rdi
     550:	68 77 5f 63 6f       	pushq  $0x6f635f77
     555:	6e                   	outsb  %ds:(%rsi),(%dx)
     556:	73 74                	jae    5cc <____versions+0x5cc>
     558:	72 61                	jb     5bb <____versions+0x5bb>
     55a:	69 6e 74 5f 69 6e 74 	imul   $0x746e695f,0x74(%rsi),%ebp
     561:	65                   	gs
     562:	67                   	addr32
     563:	65                   	gs
     564:	72 00                	jb     566 <____versions+0x566>
	...
     57e:	00 00                	add    %al,(%rax)
     580:	eb f9                	jmp    57b <____versions+0x57b>
     582:	8b 1e                	mov    (%rsi),%ebx
     584:	00 00                	add    %al,(%rax)
     586:	00 00                	add    %al,(%rax)
     588:	73 6e                	jae    5f8 <____versions+0x5f8>
     58a:	64                   	fs
     58b:	5f                   	pop    %rdi
     58c:	68 64 61 5f 72       	pushq  $0x725f6164
     591:	65                   	gs
     592:	73 75                	jae    609 <____versions+0x609>
     594:	6d                   	insl   (%dx),%es:(%rdi)
     595:	65 00 00             	add    %al,%gs:(%rax)
	...
     5c0:	58                   	pop    %rax
     5c1:	08 a5 16 00 00 00    	or     %ah,0x16(%rbp)
     5c7:	00 73 6e             	add    %dh,0x6e(%rbx)
     5ca:	64                   	fs
     5cb:	5f                   	pop    %rdi
     5cc:	63 61 72             	movslq 0x72(%rcx),%esp
     5cf:	64                   	fs
     5d0:	5f                   	pop    %rdi
     5d1:	64 69 73 63 6f 6e 6e 	imul   $0x656e6e6f,%fs:0x63(%rbx),%esi
     5d8:	65 
     5d9:	63 74 00 00          	movslq 0x0(%rax,%rax,1),%esi
	...
     5fd:	00 00                	add    %al,(%rax)
     5ff:	00 68 c2             	add    %ch,-0x3e(%rax)
     602:	11 7d 00             	adc    %edi,0x0(%rbp)
     605:	00 00                	add    %al,(%rax)
     607:	00 6a 69             	add    %ch,0x69(%rdx)
     60a:	66 66 69 65 73 00 00 	data32 imul $0x0,0x73(%rbp),%sp
	...
     641:	21 0d ab 00 00 00    	and    %ecx,0xab(%rip)        # 6f2 <____versions+0x6f2>
     647:	00 73 6e             	add    %dh,0x6e(%rbx)
     64a:	64                   	fs
     64b:	5f                   	pop    %rdi
     64c:	70 63                	jo     6b1 <____versions+0x6b1>
     64e:	6d                   	insl   (%dx),%es:(%rdi)
     64f:	5f                   	pop    %rdi
     650:	73 75                	jae    6c7 <____versions+0x6c7>
     652:	73 70                	jae    6c4 <____versions+0x6c4>
     654:	65 6e                	outsb  %gs:(%rsi),(%dx)
     656:	64                   	fs
     657:	5f                   	pop    %rdi
     658:	61                   	(bad)  
     659:	6c                   	insb   (%dx),%es:(%rdi)
     65a:	6c                   	insb   (%dx),%es:(%rdi)
	...
     67f:	00 d1                	add    %dl,%cl
     681:	eb c1                	jmp    644 <____versions+0x644>
     683:	ac                   	lods   %ds:(%rsi),%al
     684:	00 00                	add    %al,(%rax)
     686:	00 00                	add    %al,(%rax)
     688:	70 61                	jo     6eb <____versions+0x6eb>
     68a:	72 61                	jb     6ed <____versions+0x6ed>
     68c:	6d                   	insl   (%dx),%es:(%rdi)
     68d:	5f                   	pop    %rdi
     68e:	6f                   	outsl  %ds:(%rsi),(%dx)
     68f:	70 73                	jo     704 <____versions+0x704>
     691:	5f                   	pop    %rdi
     692:	63 68 61             	movslq 0x61(%rax),%ebp
     695:	72 70                	jb     707 <____versions+0x707>
	...
     6bf:	00 14 f7             	add    %dl,(%rdi,%rsi,8)
     6c2:	0c 02                	or     $0x2,%al
     6c4:	00 00                	add    %al,(%rax)
     6c6:	00 00                	add    %al,(%rax)
     6c8:	70 63                	jo     72d <____versions+0x72d>
     6ca:	69 5f 73 65 74 5f 6d 	imul   $0x6d5f7465,0x73(%rdi),%ebx
     6d1:	61                   	(bad)  
     6d2:	73 74                	jae    748 <____versions+0x748>
     6d4:	65                   	gs
     6d5:	72 00                	jb     6d7 <____versions+0x6d7>
	...
     6ff:	00 e2                	add    %ah,%dl
     701:	de 15 f0 00 00 00    	ficom  0xf0(%rip)        # 7f7 <____versions+0x7f7>
     707:	00 73 6e             	add    %dh,0x6e(%rbx)
     70a:	64                   	fs
     70b:	5f                   	pop    %rdi
     70c:	70 63                	jo     771 <____versions+0x771>
     70e:	6d                   	insl   (%dx),%es:(%rdi)
     70f:	5f                   	pop    %rdi
     710:	73 67                	jae    779 <____versions+0x779>
     712:	62                   	(bad)  
     713:	75 66                	jne    77b <____versions+0x77b>
     715:	5f                   	pop    %rdi
     716:	6f                   	outsl  %ds:(%rsi),(%dx)
     717:	70 73                	jo     78c <____versions+0x78c>
     719:	5f                   	pop    %rdi
     71a:	70 61                	jo     77d <____versions+0x77d>
     71c:	67 65 00 00          	add    %al,%gs:(%eax)
	...
     740:	ed                   	in     (%dx),%eax
     741:	11 f6                	adc    %esi,%esi
     743:	e3 00                	jrcxz  745 <____versions+0x745>
     745:	00 00                	add    %al,(%rax)
     747:	00 73 6e             	add    %dh,0x6e(%rbx)
     74a:	64                   	fs
     74b:	5f                   	pop    %rdi
     74c:	64                   	fs
     74d:	65                   	gs
     74e:	76 69                	jbe    7b9 <____versions+0x7b9>
     750:	63 65 5f             	movslq 0x5f(%rbp),%esp
     753:	6e                   	outsb  %ds:(%rsi),(%dx)
     754:	65                   	gs
     755:	77 00                	ja     757 <____versions+0x757>
	...
     77f:	00 67 c9             	add    %ah,-0x37(%rdi)
     782:	5b                   	pop    %rbx
     783:	90                   	nop
     784:	00 00                	add    %al,(%rax)
     786:	00 00                	add    %al,(%rax)
     788:	73 6e                	jae    7f8 <____versions+0x7f8>
     78a:	64                   	fs
     78b:	5f                   	pop    %rdi
     78c:	68 64 61 5f 73       	pushq  $0x735f6164
     791:	75 73                	jne    806 <____versions+0x806>
     793:	70 65                	jo     7fa <____versions+0x7fa>
     795:	6e                   	outsb  %ds:(%rsi),(%dx)
     796:	64 00 00             	add    %al,%fs:(%rax)
	...
     7bd:	00 00                	add    %al,(%rax)
     7bf:	00 17                	add    %dl,(%rdi)
     7c1:	11 69 d7             	adc    %ebp,-0x29(%rcx)
     7c4:	00 00                	add    %al,(%rax)
     7c6:	00 00                	add    %al,(%rax)
     7c8:	70 63                	jo     82d <____versions+0x82d>
     7ca:	69 5f 72 65 73 74 6f 	imul   $0x6f747365,0x72(%rdi),%ebx
     7d1:	72 65                	jb     838 <____versions+0x838>
     7d3:	5f                   	pop    %rdi
     7d4:	73 74                	jae    84a <____versions+0x84a>
     7d6:	61                   	(bad)  
     7d7:	74 65                	je     83e <____versions+0x83e>
	...
     7fd:	00 00                	add    %al,(%rax)
     7ff:	00 06                	add    %al,(%rsi)
     801:	1a 94 88 00 00 00 00 	sbb    0x0(%rax,%rcx,4),%dl
     808:	5f                   	pop    %rdi
     809:	72 61                	jb     86c <____versions+0x86c>
     80b:	77 5f                	ja     86c <____versions+0x86c>
     80d:	73 70                	jae    87f <____versions+0x87f>
     80f:	69 6e 5f 75 6e 6c 6f 	imul   $0x6f6c6e75,0x5f(%rsi),%ebp
     816:	63 6b 5f             	movslq 0x5f(%rbx),%ebp
     819:	69 72 71 72 65 73 74 	imul   $0x74736572,0x71(%rdx),%esi
     820:	6f                   	outsl  %ds:(%rsi),(%dx)
     821:	72 65                	jb     888 <____versions+0x888>
	...
     83f:	00 b2 25 5f ea 00    	add    %dh,0xea5f25(%rdx)
     845:	00 00                	add    %al,(%rax)
     847:	00 73 6e             	add    %dh,0x6e(%rbx)
     84a:	64                   	fs
     84b:	5f                   	pop    %rdi
     84c:	68 64 61 5f 6c       	pushq  $0x6c5f6164
     851:	6f                   	outsl  %ds:(%rsi),(%dx)
     852:	61                   	(bad)  
     853:	64                   	fs
     854:	5f                   	pop    %rdi
     855:	70 61                	jo     8b8 <____versions+0x8b8>
     857:	74 63                	je     8bc <____versions+0x8bc>
     859:	68 00 00 00 00       	pushq  $0x0
	...
     87e:	00 00                	add    %al,(%rax)
     880:	f6 e6                	mul    %dh
     882:	e6 e9                	out    %al,$0xe9
     884:	00 00                	add    %al,(%rax)
     886:	00 00                	add    %al,(%rax)
     888:	5f                   	pop    %rdi
     889:	5f                   	pop    %rdi
     88a:	6d                   	insl   (%dx),%es:(%rdi)
     88b:	75 74                	jne    901 <____versions+0x901>
     88d:	65                   	gs
     88e:	78 5f                	js     8ef <____versions+0x8ef>
     890:	69 6e 69 74 00 00 00 	imul   $0x74,0x69(%rsi),%ebp
	...
     8bf:	00 49 a0             	add    %cl,-0x60(%rcx)
     8c2:	e1 27                	loope  8eb <____versions+0x8eb>
     8c4:	00 00                	add    %al,(%rax)
     8c6:	00 00                	add    %al,(%rax)
     8c8:	70 72                	jo     93c <____versions+0x93c>
     8ca:	69 6e 74 6b 00 00 00 	imul   $0x6b,0x74(%rsi),%ebp
	...
     8fd:	00 00                	add    %al,(%rax)
     8ff:	00 d4                	add    %dl,%ah
     901:	9e                   	sahf   
     902:	40 07                	rex (bad) 
     904:	00 00                	add    %al,(%rax)
     906:	00 00                	add    %al,(%rax)
     908:	73 6e                	jae    978 <____versions+0x978>
     90a:	64                   	fs
     90b:	5f                   	pop    %rdi
     90c:	70 63                	jo     971 <____versions+0x971>
     90e:	6d                   	insl   (%dx),%es:(%rdi)
     90f:	5f                   	pop    %rdi
     910:	73 65                	jae    977 <____versions+0x977>
     912:	74 5f                	je     973 <____versions+0x973>
     914:	6f                   	outsl  %ds:(%rsi),(%dx)
     915:	70 73                	jo     98a <____versions+0x98a>
	...
     93f:	00 53 fa             	add    %dl,-0x6(%rbx)
     942:	7d 94                	jge    8d8 <____versions+0x8d8>
     944:	00 00                	add    %al,(%rax)
     946:	00 00                	add    %al,(%rax)
     948:	73 6e                	jae    9b8 <____versions+0x9b8>
     94a:	64                   	fs
     94b:	5f                   	pop    %rdi
     94c:	68 64 61 5f 63       	pushq  $0x635f6164
     951:	6f                   	outsl  %ds:(%rsi),(%dx)
     952:	64 65 63 5f 63       	fs movslq %fs:%gs:0x63(%rdi),%ebx
     957:	6f                   	outsl  %ds:(%rsi),(%dx)
     958:	6e                   	outsb  %ds:(%rsi),(%dx)
     959:	66 69 67 75 72 65    	imul   $0x6572,0x75(%rdi),%sp
	...
     97f:	00 0a                	add    %cl,(%rdx)
     981:	6e                   	outsb  %ds:(%rsi),(%dx)
     982:	c7                   	(bad)  
     983:	a1 00 00 00 00 5f 63 	movabs 0x6e6f635f00000000,%eax
     98a:	6f 6e 
     98c:	64                   	fs
     98d:	5f                   	pop    %rdi
     98e:	72 65                	jb     9f5 <____versions+0x9f5>
     990:	73 63                	jae    9f5 <____versions+0x9f5>
     992:	68 65 64 00 00       	pushq  $0x6465
	...
     9bf:	00 26                	add    %ah,(%rsi)
     9c1:	68 4c 8e 00 00       	pushq  $0x8e4c
     9c6:	00 00                	add    %al,(%rax)
     9c8:	73 6e                	jae    a38 <____versions+0xa38>
     9ca:	64                   	fs
     9cb:	5f                   	pop    %rdi
     9cc:	68 64 61 5f 63       	pushq  $0x635f6164
     9d1:	61                   	(bad)  
     9d2:	6c                   	insb   (%dx),%es:(%rdi)
     9d3:	63 5f 73             	movslq 0x73(%rdi),%ebx
     9d6:	74 72                	je     a4a <____versions+0xa4a>
     9d8:	65                   	gs
     9d9:	61                   	(bad)  
     9da:	6d                   	insl   (%dx),%es:(%rdi)
     9db:	5f                   	pop    %rdi
     9dc:	66 6f                	outsw  %ds:(%rsi),(%dx)
     9de:	72 6d                	jb     a4d <____versions+0xa4d>
     9e0:	61                   	(bad)  
     9e1:	74 00                	je     9e3 <____versions+0x9e3>
	...
     9ff:	00 bd 44 21 67 00    	add    %bh,0x672144(%rbp)
     a05:	00 00                	add    %al,(%rax)
     a07:	00 73 74             	add    %dh,0x74(%rbx)
     a0a:	72 6c                	jb     a78 <____versions+0xa78>
     a0c:	63 70 79             	movslq 0x79(%rax),%esi
	...
     a3f:	00 ed                	add    %ch,%ch
     a41:	1f                   	(bad)  
     a42:	ba c4 00 00 00       	mov    $0xc4,%edx
     a47:	00 73 6e             	add    %dh,0x6e(%rbx)
     a4a:	64                   	fs
     a4b:	5f                   	pop    %rdi
     a4c:	68 64 61 5f 70       	pushq  $0x705f6164
     a51:	6f                   	outsl  %ds:(%rsi),(%dx)
     a52:	77 65                	ja     ab9 <____versions+0xab9>
     a54:	72 5f                	jb     ab5 <____versions+0xab5>
     a56:	64 6f                	outsl  %fs:(%rsi),(%dx)
     a58:	77 6e                	ja     ac8 <____versions+0xac8>
	...
     a7e:	00 00                	add    %al,(%rax)
     a80:	d5                   	(bad)  
     a81:	ed                   	in     (%dx),%eax
     a82:	6e                   	outsb  %ds:(%rsi),(%dx)
     a83:	5d                   	pop    %rbp
     a84:	00 00                	add    %al,(%rax)
     a86:	00 00                	add    %al,(%rax)
     a88:	6d                   	insl   (%dx),%es:(%rdi)
     a89:	75 74                	jne    aff <____versions+0xaff>
     a8b:	65                   	gs
     a8c:	78 5f                	js     aed <____versions+0xaed>
     a8e:	6c                   	insb   (%dx),%es:(%rdi)
     a8f:	6f                   	outsl  %ds:(%rsi),(%dx)
     a90:	63 6b 00             	movslq 0x0(%rbx),%ebp
	...
     abf:	00 b5 8a 2c 20 00    	add    %dh,0x202c8a(%rbp)
     ac5:	00 00                	add    %al,(%rax)
     ac7:	00 73 6e             	add    %dh,0x6e(%rbx)
     aca:	64                   	fs
     acb:	5f                   	pop    %rdi
     acc:	70 63                	jo     b31 <____versions+0xb31>
     ace:	6d                   	insl   (%dx),%es:(%rdi)
     acf:	5f                   	pop    %rdi
     ad0:	6c                   	insb   (%dx),%es:(%rdi)
     ad1:	69 62 5f 66 72 65 65 	imul   $0x65657266,0x5f(%rdx),%esp
     ad8:	5f                   	pop    %rdi
     ad9:	70 61                	jo     b3c <____versions+0xb3c>
     adb:	67                   	addr32
     adc:	65                   	gs
     add:	73 00                	jae    adf <____versions+0xadf>
	...
     aff:	00 c7                	add    %al,%bh
     b01:	6d                   	insl   (%dx),%es:(%rdi)
     b02:	9c                   	pushfq 
     b03:	85 00                	test   %eax,(%rax)
     b05:	00 00                	add    %al,(%rax)
     b07:	00 72 65             	add    %dh,0x65(%rdx)
     b0a:	71 75                	jno    b81 <____versions+0xb81>
     b0c:	65                   	gs
     b0d:	73 74                	jae    b83 <____versions+0xb83>
     b0f:	5f                   	pop    %rdi
     b10:	74 68                	je     b7a <____versions+0xb7a>
     b12:	72 65                	jb     b79 <____versions+0xb79>
     b14:	61                   	(bad)  
     b15:	64                   	fs
     b16:	65                   	gs
     b17:	64                   	fs
     b18:	5f                   	pop    %rdi
     b19:	69 72 71 00 00 00 00 	imul   $0x0,0x71(%rdx),%esi
	...
     b40:	77 2c                	ja     b6e <____versions+0xb6e>
     b42:	20 ec                	and    %ch,%ah
     b44:	00 00                	add    %al,(%rax)
     b46:	00 00                	add    %al,(%rax)
     b48:	73 6e                	jae    bb8 <____versions+0xbb8>
     b4a:	64                   	fs
     b4b:	5f                   	pop    %rdi
     b4c:	70 63                	jo     bb1 <____versions+0xbb1>
     b4e:	6d                   	insl   (%dx),%es:(%rdi)
     b4f:	5f                   	pop    %rdi
     b50:	6c                   	insb   (%dx),%es:(%rdi)
     b51:	69 62 5f 69 6f 63 74 	imul   $0x74636f69,0x5f(%rdx),%esp
     b58:	6c                   	insb   (%dx),%es:(%rdi)
	...
     b7d:	00 00                	add    %al,(%rax)
     b7f:	00 66 cb             	add    %ah,-0x35(%rsi)
     b82:	30 55 00             	xor    %dl,0x0(%rbp)
     b85:	00 00                	add    %al,(%rax)
     b87:	00 73 6e             	add    %dh,0x6e(%rbx)
     b8a:	64                   	fs
     b8b:	5f                   	pop    %rdi
     b8c:	70 63                	jo     bf1 <____versions+0xbf1>
     b8e:	6d                   	insl   (%dx),%es:(%rdi)
     b8f:	5f                   	pop    %rdi
     b90:	6c                   	insb   (%dx),%es:(%rdi)
     b91:	69 62 5f 6d 61 6c 6c 	imul   $0x6c6c616d,0x5f(%rdx),%esp
     b98:	6f                   	outsl  %ds:(%rsi),(%dx)
     b99:	63 5f 70             	movslq 0x70(%rdi),%ebx
     b9c:	61                   	(bad)  
     b9d:	67                   	addr32
     b9e:	65                   	gs
     b9f:	73 00                	jae    ba1 <____versions+0xba1>
	...
     bbd:	00 00                	add    %al,(%rax)
     bbf:	00 75 ad             	add    %dh,-0x53(%rbp)
     bc2:	23 e5                	and    %ebp,%esp
     bc4:	00 00                	add    %al,(%rax)
     bc6:	00 00                	add    %al,(%rax)
     bc8:	73 79                	jae    c43 <____versions+0xc43>
     bca:	6e                   	outsb  %ds:(%rsi),(%dx)
     bcb:	63 68 72             	movslq 0x72(%rax),%ebp
     bce:	6f                   	outsl  %ds:(%rsi),(%dx)
     bcf:	6e                   	outsb  %ds:(%rsi),(%dx)
     bd0:	69 7a 65 5f 69 72 71 	imul   $0x7172695f,0x65(%rdx),%edi
	...
     bff:	00 c1                	add    %al,%cl
     c01:	aa                   	stos   %al,%es:(%rdi)
     c02:	80 39 00             	cmpb   $0x0,(%rcx)
     c05:	00 00                	add    %al,(%rax)
     c07:	00 75 6e             	add    %dh,0x6e(%rbp)
     c0a:	72 65                	jb     c71 <____versions+0xc71>
     c0c:	67 69 73 74 65 72 5f 	imul   $0x725f7265,0x74(%ebx),%esi
     c13:	72 
     c14:	65                   	gs
     c15:	62                   	(bad)  
     c16:	6f                   	outsl  %ds:(%rsi),(%dx)
     c17:	6f                   	outsl  %ds:(%rsi),(%dx)
     c18:	74 5f                	je     c79 <____versions+0xc79>
     c1a:	6e                   	outsb  %ds:(%rsi),(%dx)
     c1b:	6f                   	outsl  %ds:(%rsi),(%dx)
     c1c:	74 69                	je     c87 <____versions+0xc87>
     c1e:	66 69 65 72 00 00    	imul   $0x0,0x72(%rbp),%sp
	...
     c40:	69 9e fe 0e 00 00 00 	imul   $0x6e730000,0xefe(%rsi),%ebx
     c47:	00 73 6e 
     c4a:	64                   	fs
     c4b:	5f                   	pop    %rdi
     c4c:	70 63                	jo     cb1 <____versions+0xcb1>
     c4e:	6d                   	insl   (%dx),%es:(%rdi)
     c4f:	5f                   	pop    %rdi
     c50:	73 67                	jae    cb9 <____versions+0xcb9>
     c52:	62                   	(bad)  
     c53:	75 66                	jne    cbb <____versions+0xcbb>
     c55:	5f                   	pop    %rdi
     c56:	67                   	addr32
     c57:	65                   	gs
     c58:	74 5f                	je     cb9 <____versions+0xcb9>
     c5a:	63 68 75             	movslq 0x75(%rax),%ebp
     c5d:	6e                   	outsb  %ds:(%rsi),(%dx)
     c5e:	6b 5f 73 69          	imul   $0x69,0x73(%rdi),%ebx
     c62:	7a 65                	jp     cc9 <____versions+0xcc9>
	...
     c80:	4e                   	rex.WRX
     c81:	4f 76 78             	rex.WRXB jbe cfc <____versions+0xcfc>
     c84:	00 00                	add    %al,(%rax)
     c86:	00 00                	add    %al,(%rax)
     c88:	70 76                	jo     d00 <____versions+0xd00>
     c8a:	5f                   	pop    %rdi
     c8b:	69 72 71 5f 6f 70 73 	imul   $0x73706f5f,0x71(%rdx),%esi
	...
     cbe:	00 00                	add    %al,(%rax)
     cc0:	f5                   	cmc    
     cc1:	a9 8d 8e 00 00       	test   $0x8e8d,%eax
     cc6:	00 00                	add    %al,(%rax)
     cc8:	73 6e                	jae    d38 <____versions+0xd38>
     cca:	64                   	fs
     ccb:	5f                   	pop    %rdi
     ccc:	68 64 61 5f 70       	pushq  $0x705f6164
     cd1:	6f                   	outsl  %ds:(%rsi),(%dx)
     cd2:	77 65                	ja     d39 <____versions+0xd39>
     cd4:	72 5f                	jb     d35 <____versions+0xd35>
     cd6:	75 70                	jne    d48 <____versions+0xd48>
	...
     d00:	7a c0                	jp     cc2 <____versions+0xcc2>
     d02:	bf a1 00 00 00       	mov    $0xa1,%edi
     d07:	00 70 63             	add    %dh,0x63(%rax)
     d0a:	69 5f 62 75 73 5f 72 	imul   $0x725f7375,0x62(%rdi),%ebx
     d11:	65                   	gs
     d12:	61                   	(bad)  
     d13:	64                   	fs
     d14:	5f                   	pop    %rdi
     d15:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
     d18:	66 69 67 5f 77 6f    	imul   $0x6f77,0x5f(%rdi),%sp
     d1e:	72 64                	jb     d84 <____versions+0xd84>
	...
     d40:	d4                   	(bad)  
     d41:	0d 44 5b 00 00       	or     $0x5b44,%eax
     d46:	00 00                	add    %al,(%rax)
     d48:	73 6e                	jae    db8 <____versions+0xdb8>
     d4a:	64                   	fs
     d4b:	5f                   	pop    %rdi
     d4c:	68 64 61 5f 71       	pushq  $0x715f6164
     d51:	75 65                	jne    db8 <____versions+0xdb8>
     d53:	75 65                	jne    dba <____versions+0xdba>
     d55:	5f                   	pop    %rdi
     d56:	75 6e                	jne    dc6 <____versions+0xdc6>
     d58:	73 6f                	jae    dc9 <____versions+0xdc9>
     d5a:	6c                   	insb   (%dx),%es:(%rdi)
     d5b:	5f                   	pop    %rdi
     d5c:	65                   	gs
     d5d:	76 65                	jbe    dc4 <____versions+0xdc4>
     d5f:	6e                   	outsb  %ds:(%rsi),(%dx)
     d60:	74 00                	je     d62 <____versions+0xd62>
	...
     d7e:	00 00                	add    %al,(%rax)
     d80:	9a                   	(bad)  
     d81:	71 c6                	jno    d49 <____versions+0xd49>
     d83:	1c 00                	sbb    $0x0,%al
     d85:	00 00                	add    %al,(%rax)
     d87:	00 72 65             	add    %dh,0x65(%rdx)
     d8a:	67 69 73 74 65 72 5f 	imul   $0x725f7265,0x74(%ebx),%esi
     d91:	72 
     d92:	65                   	gs
     d93:	62                   	(bad)  
     d94:	6f                   	outsl  %ds:(%rsi),(%dx)
     d95:	6f                   	outsl  %ds:(%rsi),(%dx)
     d96:	74 5f                	je     df7 <____versions+0xdf7>
     d98:	6e                   	outsb  %ds:(%rsi),(%dx)
     d99:	6f                   	outsl  %ds:(%rsi),(%dx)
     d9a:	74 69                	je     e05 <____versions+0xe05>
     d9c:	66 69 65 72 00 00    	imul   $0x0,0x72(%rbp),%sp
	...
     dbe:	00 00                	add    %al,(%rax)
     dc0:	59                   	pop    %rcx
     dc1:	93                   	xchg   %eax,%ebx
     dc2:	a0 10 00 00 00 00 70 	movabs 0x6963700000000010,%al
     dc9:	63 69 
     dcb:	5f                   	pop    %rdi
     dcc:	69 6e 74 78 00 00 00 	imul   $0x78,0x74(%rsi),%ebp
	...
     dff:	00 7f b4             	add    %bh,-0x4c(%rdi)
     e02:	8d 86 00 00 00 00    	lea    0x0(%rsi),%eax
     e08:	73 6e                	jae    e78 <____versions+0xe78>
     e0a:	64                   	fs
     e0b:	5f                   	pop    %rdi
     e0c:	68 64 61 5f 62       	pushq  $0x625f6164
     e11:	75 73                	jne    e86 <____versions+0xe86>
     e13:	5f                   	pop    %rdi
     e14:	72 65                	jb     e7b <____versions+0xe7b>
     e16:	62                   	(bad)  
     e17:	6f                   	outsl  %ds:(%rsi),(%dx)
     e18:	6f                   	outsl  %ds:(%rsi),(%dx)
     e19:	74 5f                	je     e7a <____versions+0xe7a>
     e1b:	6e                   	outsb  %ds:(%rsi),(%dx)
     e1c:	6f                   	outsl  %ds:(%rsi),(%dx)
     e1d:	74 69                	je     e88 <____versions+0xe88>
     e1f:	66                   	data16
     e20:	79 00                	jns    e22 <____versions+0xe22>
	...
     e3e:	00 00                	add    %al,(%rax)
     e40:	f6 b1 d1 3b 00 00    	divb   0x3bd1(%rcx)
     e46:	00 00                	add    %al,(%rax)
     e48:	6d                   	insl   (%dx),%es:(%rdi)
     e49:	73 65                	jae    eb0 <____versions+0xeb0>
     e4b:	63 73 5f             	movslq 0x5f(%rbx),%esi
     e4e:	74 6f                	je     ebf <____versions+0xebf>
     e50:	5f                   	pop    %rdi
     e51:	6a 69                	pushq  $0x69
     e53:	66 66 69 65 73 00 00 	data32 imul $0x0,0x73(%rbp),%sp
	...
     e7e:	00 00                	add    %al,(%rax)
     e80:	fb                   	sti    
     e81:	a2 33 f3 00 00 00 00 	movabs %al,0x725f00000000f333
     e88:	5f 72 
     e8a:	61                   	(bad)  
     e8b:	77 5f                	ja     eec <____versions+0xeec>
     e8d:	73 70                	jae    eff <____versions+0xeff>
     e8f:	69 6e 5f 6c 6f 63 6b 	imul   $0x6b636f6c,0x5f(%rsi),%ebp
     e96:	5f                   	pop    %rdi
     e97:	69 72 71 00 00 00 00 	imul   $0x0,0x71(%rdx),%esi
	...
     ebe:	00 00                	add    %al,(%rax)
     ec0:	c9                   	leaveq 
     ec1:	6d                   	insl   (%dx),%es:(%rdi)
     ec2:	db 4f 00             	fisttpl 0x0(%rdi)
     ec5:	00 00                	add    %al,(%rax)
     ec7:	00 73 6e             	add    %dh,0x6e(%rbx)
     eca:	64                   	fs
     ecb:	5f                   	pop    %rdi
     ecc:	64                   	fs
     ecd:	6d                   	insl   (%dx),%es:(%rdi)
     ece:	61                   	(bad)  
     ecf:	5f                   	pop    %rdi
     ed0:	66                   	data16
     ed1:	72 65                	jb     f38 <____versions+0xf38>
     ed3:	65                   	gs
     ed4:	5f                   	pop    %rdi
     ed5:	70 61                	jo     f38 <____versions+0xf38>
     ed7:	67                   	addr32
     ed8:	65                   	gs
     ed9:	73 00                	jae    edb <____versions+0xedb>
	...
     eff:	00 80 fd 78 8d 00    	add    %al,0x8d78fd(%rax)
     f05:	00 00                	add    %al,(%rax)
     f07:	00 73 6e             	add    %dh,0x6e(%rbx)
     f0a:	64                   	fs
     f0b:	5f                   	pop    %rdi
     f0c:	68 64 61 5f 63       	pushq  $0x635f6164
     f11:	6f                   	outsl  %ds:(%rsi),(%dx)
     f12:	64 65 63 5f 6e       	fs movslq %fs:%gs:0x6e(%rdi),%ebx
     f17:	65                   	gs
     f18:	77 00                	ja     f1a <____versions+0xf1a>
	...
     f3e:	00 00                	add    %al,(%rax)
     f40:	e6 5d                	out    %al,$0x5d
     f42:	66 e8 00 00          	callw  f46 <____versions+0xf46>
     f46:	00 00                	add    %al,(%rax)
     f48:	70 63                	jo     fad <____versions+0xfad>
     f4a:	69 5f 75 6e 72 65 67 	imul   $0x6765726e,0x75(%rdi),%ebx
     f51:	69 73 74 65 72 5f 64 	imul   $0x645f7265,0x74(%rbx),%esi
     f58:	72 69                	jb     fc3 <____versions+0xfc3>
     f5a:	76 65                	jbe    fc1 <____versions+0xfc1>
     f5c:	72 00                	jb     f5e <____versions+0xf5e>
	...
     f7e:	00 00                	add    %al,(%rax)
     f80:	ce                   	(bad)  
     f81:	2d 1b 6f 00 00       	sub    $0x6f1b,%eax
     f86:	00 00                	add    %al,(%rax)
     f88:	73 6e                	jae    ff8 <____versions+0xff8>
     f8a:	64                   	fs
     f8b:	5f                   	pop    %rdi
     f8c:	70 63                	jo     ff1 <____versions+0xff1>
     f8e:	6d                   	insl   (%dx),%es:(%rdi)
     f8f:	5f                   	pop    %rdi
     f90:	73 65                	jae    ff7 <____versions+0xff7>
     f92:	74 5f                	je     ff3 <____versions+0xff3>
     f94:	73 79                	jae    100f <____versions+0x100f>
     f96:	6e                   	outsb  %ds:(%rsi),(%dx)
     f97:	63 00                	movslq (%rax),%eax
	...
     fbd:	00 00                	add    %al,(%rax)
     fbf:	00 96 1f 30 69 00    	add    %dl,0x69301f(%rsi)
     fc5:	00 00                	add    %al,(%rax)
     fc7:	00 73 6e             	add    %dh,0x6e(%rbx)
     fca:	64                   	fs
     fcb:	5f                   	pop    %rdi
     fcc:	68 64 61 5f 63       	pushq  $0x635f6164
     fd1:	6f                   	outsl  %ds:(%rsi),(%dx)
     fd2:	64 65 63 5f 63       	fs movslq %fs:%gs:0x63(%rdi),%ebx
     fd7:	6c                   	insb   (%dx),%es:(%rdi)
     fd8:	65                   	gs
     fd9:	61                   	(bad)  
     fda:	6e                   	outsb  %ds:(%rsi),(%dx)
     fdb:	75 70                	jne    104d <____versions+0x104d>
	...
     ffd:	00 00                	add    %al,(%rax)
     fff:	00 4d d7             	add    %cl,-0x29(%rbp)
    1002:	43                   	rex.XB
    1003:	64 00 00             	add    %al,%fs:(%rax)
    1006:	00 00                	add    %al,(%rax)
    1008:	5f                   	pop    %rdi
    1009:	72 61                	jb     106c <____versions+0x106c>
    100b:	77 5f                	ja     106c <____versions+0x106c>
    100d:	73 70                	jae    107f <____versions+0x107f>
    100f:	69 6e 5f 6c 6f 63 6b 	imul   $0x6b636f6c,0x5f(%rsi),%ebp
	...
    103e:	00 00                	add    %al,(%rax)
    1040:	ee                   	out    %al,(%dx)
    1041:	26                   	es
    1042:	3d 4d 00 00 00       	cmp    $0x4d,%eax
    1047:	00 70 63             	add    %dh,0x63(%rax)
    104a:	69 5f 69 6f 72 65 6d 	imul   $0x6d65726f,0x69(%rdi),%ebx
    1051:	61                   	(bad)  
    1052:	70 5f                	jo     10b3 <____versions+0x10b3>
    1054:	62                   	(bad)  
    1055:	61                   	(bad)  
    1056:	72 00                	jb     1058 <____versions+0x1058>
	...
    1080:	d8 70 7c             	fdivs  0x7c(%rax)
    1083:	58                   	pop    %rax
    1084:	00 00                	add    %al,(%rax)
    1086:	00 00                	add    %al,(%rax)
    1088:	5f                   	pop    %rdi
    1089:	72 61                	jb     10ec <____versions+0x10ec>
    108b:	77 5f                	ja     10ec <____versions+0x10ec>
    108d:	73 70                	jae    10ff <____versions+0x10ff>
    108f:	69 6e 5f 6c 6f 63 6b 	imul   $0x6b636f6c,0x5f(%rsi),%ebp
    1096:	5f                   	pop    %rdi
    1097:	69 72 71 73 61 76 65 	imul   $0x65766173,0x71(%rdx),%esi
	...
    10be:	00 00                	add    %al,(%rax)
    10c0:	99                   	cltd   
    10c1:	bc 8e 73 00 00       	mov    $0x738e,%esp
    10c6:	00 00                	add    %al,(%rax)
    10c8:	73 6e                	jae    1138 <____versions+0x1138>
    10ca:	64                   	fs
    10cb:	5f                   	pop    %rdi
    10cc:	68 64 61 5f 62       	pushq  $0x625f6164
    10d1:	75 69                	jne    113c <____versions+0x113c>
    10d3:	6c                   	insb   (%dx),%es:(%rdi)
    10d4:	64                   	fs
    10d5:	5f                   	pop    %rdi
    10d6:	70 63                	jo     113b <____versions+0x113b>
    10d8:	6d                   	insl   (%dx),%es:(%rdi)
    10d9:	73 00                	jae    10db <____versions+0x10db>
	...
    10ff:	00 68 7f             	add    %ch,0x7f(%rax)
    1102:	9c                   	pushfq 
    1103:	f0 00 00             	lock add %al,(%rax)
    1106:	00 00                	add    %al,(%rax)
    1108:	5f                   	pop    %rdi
    1109:	5f                   	pop    %rdi
    110a:	77 61                	ja     116d <____versions+0x116d>
    110c:	6b 65 5f 75          	imul   $0x75,0x5f(%rbp),%esp
    1110:	70 00                	jo     1112 <____versions+0x1112>
	...
    113e:	00 00                	add    %al,(%rax)
    1140:	92                   	xchg   %eax,%edx
    1141:	50                   	push   %rax
    1142:	34 9b                	xor    $0x9b,%al
    1144:	00 00                	add    %al,(%rax)
    1146:	00 00                	add    %al,(%rax)
    1148:	70 63                	jo     11ad <____versions+0x11ad>
    114a:	69 5f 73 65 74 5f 70 	imul   $0x705f7465,0x73(%rdi),%ebx
    1151:	6f                   	outsl  %ds:(%rsi),(%dx)
    1152:	77 65                	ja     11b9 <____versions+0x11b9>
    1154:	72 5f                	jb     11b5 <____versions+0x11b5>
    1156:	73 74                	jae    11cc <____versions+0x11cc>
    1158:	61                   	(bad)  
    1159:	74 65                	je     11c0 <____versions+0x11c0>
	...
    117f:	00 e2                	add    %ah,%dl
    1181:	87 e3                	xchg   %esp,%ebx
    1183:	4d 00 00             	rex.WRB add %r8b,(%r8)
    1186:	00 00                	add    %al,(%rax)
    1188:	70 63                	jo     11ed <____versions+0x11ed>
    118a:	69 5f 62 75 73 5f 77 	imul   $0x775f7375,0x62(%rdi),%ebx
    1191:	72 69                	jb     11fc <____versions+0x11fc>
    1193:	74 65                	je     11fa <____versions+0x11fa>
    1195:	5f                   	pop    %rdi
    1196:	63 6f 6e             	movslq 0x6e(%rdi),%ebp
    1199:	66 69 67 5f 62 79    	imul   $0x7962,0x5f(%rdi),%sp
    119f:	74 65                	je     1206 <____versions+0x1206>
	...
    11bd:	00 00                	add    %al,(%rax)
    11bf:	00 3a                	add    %bh,(%rdx)
    11c1:	6a d6                	pushq  $0xffffffffffffffd6
    11c3:	08 00                	or     %al,(%rax)
    11c5:	00 00                	add    %al,(%rax)
    11c7:	00 77 61             	add    %dh,0x61(%rdi)
    11ca:	72 6e                	jb     123a <____versions+0x123a>
    11cc:	5f                   	pop    %rdi
    11cd:	73 6c                	jae    123b <____versions+0x123b>
    11cf:	6f                   	outsl  %ds:(%rsi),(%dx)
    11d0:	77 70                	ja     1242 <____versions+0x1242>
    11d2:	61                   	(bad)  
    11d3:	74 68                	je     123d <____versions+0x123d>
    11d5:	5f                   	pop    %rdi
    11d6:	66 6d                	insw   (%dx),%es:(%rdi)
    11d8:	74 00                	je     11da <____versions+0x11da>
	...
    11fe:	00 00                	add    %al,(%rax)
    1200:	ba 0c 7a 03 00       	mov    $0x37a0c,%edx
    1205:	00 00                	add    %al,(%rax)
    1207:	00 6b 66             	add    %ch,0x66(%rbx)
    120a:	72 65                	jb     1271 <____versions+0x1271>
    120c:	65 00 00             	add    %al,%gs:(%rax)
	...
    123f:	00 b3 3e a1 69 00    	add    %dh,0x69a13e(%rbx)
    1245:	00 00                	add    %al,(%rax)
    1247:	00 70 63             	add    %dh,0x63(%rax)
    124a:	69 5f 72 65 71 75 65 	imul   $0x65757165,0x72(%rdi),%ebx
    1251:	73 74                	jae    12c7 <____versions+0x12c7>
    1253:	5f                   	pop    %rdi
    1254:	72 65                	jb     12bb <____versions+0x12bb>
    1256:	67 69 6f 6e 73 00 00 	imul   $0x73,0x6e(%edi),%ebp
    125d:	00 
	...
    127e:	00 00                	add    %al,(%rax)
    1280:	80 98 32 d1 00 00 00 	sbbb   $0x0,0xd132(%rax)
    1287:	00 70 61             	add    %dh,0x61(%rax)
    128a:	72 61                	jb     12ed <____versions+0x12ed>
    128c:	6d                   	insl   (%dx),%es:(%rdi)
    128d:	5f                   	pop    %rdi
    128e:	61                   	(bad)  
    128f:	72 72                	jb     1303 <____versions+0x1303>
    1291:	61                   	(bad)  
    1292:	79 5f                	jns    12f3 <____versions+0x12f3>
    1294:	6f                   	outsl  %ds:(%rsi),(%dx)
    1295:	70 73                	jo     130a <____versions+0x130a>
	...
    12bf:	00 36                	add    %dh,(%rsi)
    12c1:	ff 28                	ljmpq  *(%rax)
    12c3:	47 00 00             	rex.RXB add %r8b,(%r8)
    12c6:	00 00                	add    %al,(%rax)
    12c8:	70 63                	jo     132d <____versions+0x132d>
    12ca:	69 5f 64 69 73 61 62 	imul   $0x62617369,0x64(%rdi),%ebx
    12d1:	6c                   	insb   (%dx),%es:(%rdi)
    12d2:	65                   	gs
    12d3:	5f                   	pop    %rdi
    12d4:	6d                   	insl   (%dx),%es:(%rdi)
    12d5:	73 69                	jae    1340 <____versions+0x1340>
	...
    12ff:	00 72 ad             	add    %dh,-0x53(%rdx)
    1302:	71 62                	jno    1366 <____versions+0x1366>
    1304:	00 00                	add    %al,(%rax)
    1306:	00 00                	add    %al,(%rax)
    1308:	64                   	fs
    1309:	6d                   	insl   (%dx),%es:(%rdi)
    130a:	61                   	(bad)  
    130b:	5f                   	pop    %rdi
    130c:	73 75                	jae    1383 <____versions+0x1383>
    130e:	70 70                	jo     1380 <____versions+0x1380>
    1310:	6f                   	outsl  %ds:(%rsi),(%dx)
    1311:	72 74                	jb     1387 <____versions+0x1387>
    1313:	65 64 00 00          	gs add %al,%fs:%gs:(%rax)
	...
    133f:	00 fc                	add    %bh,%ah
    1341:	b5 28                	mov    $0x28,%ch
    1343:	61                   	(bad)  
    1344:	00 00                	add    %al,(%rax)
    1346:	00 00                	add    %al,(%rax)
    1348:	5f                   	pop    %rdi
    1349:	5f                   	pop    %rdi
    134a:	70 72                	jo     13be <____versions+0x13be>
    134c:	69 6e 74 6b 5f 72 61 	imul   $0x61725f6b,0x74(%rsi),%ebp
    1353:	74 65                	je     13ba <____versions+0x13ba>
    1355:	6c                   	insb   (%dx),%es:(%rdi)
    1356:	69 6d 69 74 00 00 00 	imul   $0x74,0x69(%rbp),%ebp
	...
    137d:	00 00                	add    %al,(%rax)
    137f:	00 53 39             	add    %dl,0x39(%rbx)
    1382:	c0 ed 00             	shr    $0x0,%ch
    1385:	00 00                	add    %al,(%rax)
    1387:	00 69 6f             	add    %ch,0x6f(%rcx)
    138a:	75 6e                	jne    13fa <____versions+0x13fa>
    138c:	6d                   	insl   (%dx),%es:(%rdi)
    138d:	61                   	(bad)  
    138e:	70 00                	jo     1390 <____versions+0x1390>
	...
    13c0:	4d c1                	rex.WRB (bad) 
    13c2:	37                   	(bad)  
    13c3:	33 00                	xor    (%rax),%eax
    13c5:	00 00                	add    %al,(%rax)
    13c7:	00 73 6e             	add    %dh,0x6e(%rbx)
    13ca:	64                   	fs
    13cb:	5f                   	pop    %rdi
    13cc:	68 64 61 5f 62       	pushq  $0x625f6164
    13d1:	75 73                	jne    1446 <____versions+0x1446>
    13d3:	5f                   	pop    %rdi
    13d4:	6e                   	outsb  %ds:(%rsi),(%dx)
    13d5:	65                   	gs
    13d6:	77 00                	ja     13d8 <____versions+0x13d8>
	...
    1400:	88 d0                	mov    %dl,%al
    1402:	69 03 00 00 00 00    	imul   $0x0,(%rbx),%eax
    1408:	5f                   	pop    %rdi
    1409:	5f                   	pop    %rdi
    140a:	70 63                	jo     146f <____versions+0x146f>
    140c:	69 5f 72 65 67 69 73 	imul   $0x73696765,0x72(%rdi),%ebx
    1413:	74 65                	je     147a <____versions+0x147a>
    1415:	72 5f                	jb     1476 <____versions+0x1476>
    1417:	64                   	fs
    1418:	72 69                	jb     1483 <____versions+0x1483>
    141a:	76 65                	jbe    1481 <____versions+0x1481>
    141c:	72 00                	jb     141e <____versions+0x141e>
	...
    143e:	00 00                	add    %al,(%rax)
    1440:	9a                   	(bad)  
    1441:	e1 1c                	loope  145f <____versions+0x145f>
    1443:	66                   	data16
    1444:	00 00                	add    %al,(%rax)
    1446:	00 00                	add    %al,(%rax)
    1448:	70 63                	jo     14ad <____versions+0x14ad>
    144a:	69 5f 67 65 74 5f 64 	imul   $0x645f7465,0x67(%rdi),%ebx
    1451:	65                   	gs
    1452:	76 69                	jbe    14bd <____versions+0x14bd>
    1454:	63 65 00             	movslq 0x0(%rbp),%esp
	...
    147f:	00 43 b4             	add    %al,-0x4c(%rbx)
    1482:	b3 06                	mov    $0x6,%bl
    1484:	00 00                	add    %al,(%rax)
    1486:	00 00                	add    %al,(%rax)
    1488:	73 6e                	jae    14f8 <____versions+0x14f8>
    148a:	64                   	fs
    148b:	5f                   	pop    %rdi
    148c:	70 63                	jo     14f1 <____versions+0x14f1>
    148e:	6d                   	insl   (%dx),%es:(%rdi)
    148f:	5f                   	pop    %rdi
    1490:	6c                   	insb   (%dx),%es:(%rdi)
    1491:	69 62 5f 70 72 65 61 	imul   $0x61657270,0x5f(%rdx),%esp
    1498:	6c                   	insb   (%dx),%es:(%rdi)
    1499:	6c                   	insb   (%dx),%es:(%rdi)
    149a:	6f                   	outsl  %ds:(%rsi),(%dx)
    149b:	63 61 74             	movslq 0x74(%rcx),%esp
    149e:	65                   	gs
    149f:	5f                   	pop    %rdi
    14a0:	70 61                	jo     1503 <____versions+0x1503>
    14a2:	67                   	addr32
    14a3:	65                   	gs
    14a4:	73 5f                	jae    1505 <____versions+0x1505>
    14a6:	66 6f                	outsw  %ds:(%rsi),(%dx)
    14a8:	72 5f                	jb     1509 <____versions+0x1509>
    14aa:	61                   	(bad)  
    14ab:	6c                   	insb   (%dx),%es:(%rdi)
    14ac:	6c                   	insb   (%dx),%es:(%rdi)
	...
    14bd:	00 00                	add    %al,(%rax)
    14bf:	00 7e 0a             	add    %bh,0xa(%rsi)
    14c2:	58                   	pop    %rax
    14c3:	b9 00 00 00 00       	mov    $0x0,%ecx
    14c8:	73 6e                	jae    1538 <____versions+0x1538>
    14ca:	64                   	fs
    14cb:	5f                   	pop    %rdi
    14cc:	63 61 72             	movslq 0x72(%rcx),%esp
    14cf:	64                   	fs
    14d0:	5f                   	pop    %rdi
    14d1:	66                   	data16
    14d2:	72 65                	jb     1539 <____versions+0x1539>
    14d4:	65 00 00             	add    %al,%gs:(%rax)
	...
    14ff:	00 97 66 92 ad 00    	add    %dl,0xad9266(%rdi)
    1505:	00 00                	add    %al,(%rax)
    1507:	00 73 6e             	add    %dh,0x6e(%rbx)
    150a:	64                   	fs
    150b:	5f                   	pop    %rdi
    150c:	63 61 72             	movslq 0x72(%rcx),%esp
    150f:	64                   	fs
    1510:	5f                   	pop    %rdi
    1511:	72 65                	jb     1578 <____versions+0x1578>
    1513:	67 69 73 74 65 72 00 	imul   $0x7265,0x74(%ebx),%esi
    151a:	00 
	...
    153f:	00 f4                	add    %dh,%ah
    1541:	4a 63 fb             	rex.WX movslq %ebx,%rdi
    1544:	00 00                	add    %al,(%rax)
    1546:	00 00                	add    %al,(%rax)
    1548:	70 63                	jo     15ad <____versions+0x15ad>
    154a:	69 5f 64 65 76 5f 70 	imul   $0x705f7665,0x64(%rdi),%ebx
    1551:	75 74                	jne    15c7 <____versions+0x15c7>
	...
    157f:	00 38                	add    %bh,(%rax)
    1581:	30 9e cc 00 00 00    	xor    %bl,0xcc(%rsi)
    1587:	00 73 6e             	add    %dh,0x6e(%rbx)
    158a:	64                   	fs
    158b:	5f                   	pop    %rdi
    158c:	70 63                	jo     15f1 <____versions+0x15f1>
    158e:	6d                   	insl   (%dx),%es:(%rdi)
    158f:	5f                   	pop    %rdi
    1590:	6c                   	insb   (%dx),%es:(%rdi)
    1591:	69 6d 69 74 5f 68 77 	imul   $0x77685f74,0x69(%rbp),%ebp
    1598:	5f                   	pop    %rdi
    1599:	72 61                	jb     15fc <____versions+0x15fc>
    159b:	74 65                	je     1602 <____versions+0x1602>
    159d:	73 00                	jae    159f <____versions+0x159f>
	...
    15bf:	00 72 1e             	add    %dh,0x1e(%rdx)
    15c2:	a7                   	cmpsl  %es:(%rdi),%ds:(%rsi)
    15c3:	28 00                	sub    %al,(%rax)
    15c5:	00 00                	add    %al,(%rax)
    15c7:	00 73 6e             	add    %dh,0x6e(%rbx)
    15ca:	64                   	fs
    15cb:	5f                   	pop    %rdi
    15cc:	70 63                	jo     1631 <____versions+0x1631>
    15ce:	6d                   	insl   (%dx),%es:(%rdi)
    15cf:	5f                   	pop    %rdi
    15d0:	6e                   	outsb  %ds:(%rsi),(%dx)
    15d1:	65                   	gs
    15d2:	77 00                	ja     15d4 <____versions+0x15d4>
	...
    1600:	ae                   	scas   %es:(%rdi),%al
    1601:	ec                   	in     (%dx),%al
    1602:	db 9e 00 00 00 00    	fistpl 0x0(%rsi)
    1608:	73 6e                	jae    1678 <____versions+0x1678>
    160a:	70 72                	jo     167e <____versions+0x167e>
    160c:	69 6e 74 66 00 00 00 	imul   $0x66,0x74(%rsi),%ebp
	...
    163f:	00 4b bb             	add    %cl,-0x45(%rbx)
    1642:	9d                   	popfq  
    1643:	6e                   	outsb  %ds:(%rsi),(%dx)
    1644:	00 00                	add    %al,(%rax)
    1646:	00 00                	add    %al,(%rax)
    1648:	70 63                	jo     16ad <____versions+0x16ad>
    164a:	69 5f 65 6e 61 62 6c 	imul   $0x6c62616e,0x65(%rdi),%ebx
    1651:	65                   	gs
    1652:	5f                   	pop    %rdi
    1653:	6d                   	insl   (%dx),%es:(%rdi)
    1654:	73 69                	jae    16bf <____versions+0x16bf>
    1656:	5f                   	pop    %rdi
    1657:	62                   	(bad)  
    1658:	6c                   	insb   (%dx),%es:(%rdi)
    1659:	6f                   	outsl  %ds:(%rsi),(%dx)
    165a:	63 6b 00             	movslq 0x0(%rbx),%ebp
	...
    167d:	00 00                	add    %al,(%rax)
    167f:	00 43 5f             	add    %al,0x5f(%rbx)
    1682:	06                   	(bad)  
    1683:	1f                   	(bad)  
    1684:	00 00                	add    %al,(%rax)
    1686:	00 00                	add    %al,(%rax)
    1688:	70 63                	jo     16ed <____versions+0x16ed>
    168a:	69 5f 63 68 6f 6f 73 	imul   $0x736f6f68,0x63(%rdi),%ebx
    1691:	65                   	gs
    1692:	5f                   	pop    %rdi
    1693:	73 74                	jae    1709 <____versions+0x1709>
    1695:	61                   	(bad)  
    1696:	74 65                	je     16fd <____versions+0x16fd>
	...
    16c0:	8d 57 e2             	lea    -0x1e(%rdi),%edx
    16c3:	10 00                	adc    %al,(%rax)
    16c5:	00 00                	add    %al,(%rax)
    16c7:	00 70 63             	add    %dh,0x63(%rax)
    16ca:	69 5f 65 6e 61 62 6c 	imul   $0x6c62616e,0x65(%rdi),%ebx
    16d1:	65                   	gs
    16d2:	5f                   	pop    %rdi
    16d3:	64                   	fs
    16d4:	65                   	gs
    16d5:	76 69                	jbe    1740 <____versions+0x1740>
    16d7:	63 65 00             	movslq 0x0(%rbp),%esp
	...
    16fe:	00 00                	add    %al,(%rax)
    1700:	35 e4 3f fd 00       	xor    $0xfd3fe4,%eax
    1705:	00 00                	add    %al,(%rax)
    1707:	00 64 65 76          	add    %ah,0x76(%rbp,%riz,2)
    170b:	5f                   	pop    %rdi
    170c:	67                   	addr32
    170d:	65                   	gs
    170e:	74 5f                	je     176f <____versions+0x176f>
    1710:	64                   	fs
    1711:	72 76                	jb     1789 <____versions+0x1789>
    1713:	64                   	fs
    1714:	61                   	(bad)  
    1715:	74 61                	je     1778 <____versions+0x1778>
	...
    173f:	00 d8                	add    %bl,%al
    1741:	ab                   	stos   %eax,%es:(%rdi)
    1742:	0d f2 00 00 00       	or     $0xf2,%eax
    1747:	00 66 72             	add    %ah,0x72(%rsi)
    174a:	65                   	gs
    174b:	65                   	gs
    174c:	5f                   	pop    %rdi
    174d:	69 72 71 00 00 00 00 	imul   $0x0,0x71(%rdx),%esi
	...
    1780:	2e dd 3a             	fnstsw %cs:(%rdx)
    1783:	06                   	(bad)  
    1784:	00 00                	add    %al,(%rax)
    1786:	00 00                	add    %al,(%rax)
    1788:	70 63                	jo     17ed <____versions+0x17ed>
    178a:	69 5f 73 61 76 65 5f 	imul   $0x5f657661,0x73(%rdi),%ebx
    1791:	73 74                	jae    1807 <azx_pcm_open+0xc4>
    1793:	61                   	(bad)  
    1794:	74 65                	je     17fb <____versions+0x17fb>
	...
    17be:	00 00                	add    %al,(%rax)
    17c0:	1e                   	(bad)  
    17c1:	e4 14                	in     $0x14,%al
    17c3:	e9 00 00 00 00       	jmpq   17c8 <____versions+0x17c8>
    17c8:	73 74                	jae    183e <azx_pcm_open+0xfb>
    17ca:	72 63                	jb     182f <azx_pcm_open+0xec>
    17cc:	70 79                	jo     1847 <azx_pcm_open+0x104>
	...

Disassembly of section .data:

0000000000000000 <power_save_controller>:
   0:	01 00                	add    %eax,(%rax)
	...

0000000000000004 <enable_msi>:
   4:	ff                   	(bad)  
   5:	ff                   	(bad)  
   6:	ff                   	(bad)  
   7:	ff 00                	incl   (%rax)
   9:	00 00                	add    %al,(%rax)
   b:	00 00                	add    %al,(%rax)
   d:	00 00                	add    %al,(%rax)
	...

0000000000000010 <beep_mode>:
  10:	01 00                	add    %eax,(%rax)
  12:	00 00                	add    %al,(%rax)
  14:	01 00                	add    %eax,(%rax)
  16:	00 00                	add    %al,(%rax)
  18:	01 00                	add    %eax,(%rax)
  1a:	00 00                	add    %al,(%rax)
  1c:	01 00                	add    %eax,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	01 00                	add    %eax,(%rax)
  22:	00 00                	add    %al,(%rax)
  24:	01 00                	add    %eax,(%rax)
  26:	00 00                	add    %al,(%rax)
  28:	01 00                	add    %eax,(%rax)
  2a:	00 00                	add    %al,(%rax)
  2c:	01 00                	add    %eax,(%rax)
  2e:	00 00                	add    %al,(%rax)
  30:	01 00                	add    %eax,(%rax)
  32:	00 00                	add    %al,(%rax)
  34:	01 00                	add    %eax,(%rax)
  36:	00 00                	add    %al,(%rax)
  38:	01 00                	add    %eax,(%rax)
  3a:	00 00                	add    %al,(%rax)
  3c:	01 00                	add    %eax,(%rax)
  3e:	00 00                	add    %al,(%rax)
  40:	01 00                	add    %eax,(%rax)
  42:	00 00                	add    %al,(%rax)
  44:	01 00                	add    %eax,(%rax)
  46:	00 00                	add    %al,(%rax)
  48:	01 00                	add    %eax,(%rax)
  4a:	00 00                	add    %al,(%rax)
  4c:	01 00                	add    %eax,(%rax)
  4e:	00 00                	add    %al,(%rax)
  50:	01 00                	add    %eax,(%rax)
  52:	00 00                	add    %al,(%rax)
  54:	01 00                	add    %eax,(%rax)
  56:	00 00                	add    %al,(%rax)
  58:	01 00                	add    %eax,(%rax)
  5a:	00 00                	add    %al,(%rax)
  5c:	01 00                	add    %eax,(%rax)
  5e:	00 00                	add    %al,(%rax)
  60:	01 00                	add    %eax,(%rax)
  62:	00 00                	add    %al,(%rax)
  64:	01 00                	add    %eax,(%rax)
  66:	00 00                	add    %al,(%rax)
  68:	01 00                	add    %eax,(%rax)
  6a:	00 00                	add    %al,(%rax)
  6c:	01 00                	add    %eax,(%rax)
  6e:	00 00                	add    %al,(%rax)
  70:	01 00                	add    %eax,(%rax)
  72:	00 00                	add    %al,(%rax)
  74:	01 00                	add    %eax,(%rax)
  76:	00 00                	add    %al,(%rax)
  78:	01 00                	add    %eax,(%rax)
  7a:	00 00                	add    %al,(%rax)
  7c:	01 00                	add    %eax,(%rax)
  7e:	00 00                	add    %al,(%rax)
  80:	01 00                	add    %eax,(%rax)
  82:	00 00                	add    %al,(%rax)
  84:	01 00                	add    %eax,(%rax)
  86:	00 00                	add    %al,(%rax)
  88:	01 00                	add    %eax,(%rax)
  8a:	00 00                	add    %al,(%rax)
  8c:	01 00                	add    %eax,(%rax)
	...

0000000000000090 <probe_mask>:
  90:	ff                   	(bad)  
  91:	ff                   	(bad)  
  92:	ff                   	(bad)  
  93:	ff                   	(bad)  
  94:	ff                   	(bad)  
  95:	ff                   	(bad)  
  96:	ff                   	(bad)  
  97:	ff                   	(bad)  
  98:	ff                   	(bad)  
  99:	ff                   	(bad)  
  9a:	ff                   	(bad)  
  9b:	ff                   	(bad)  
  9c:	ff                   	(bad)  
  9d:	ff                   	(bad)  
  9e:	ff                   	(bad)  
  9f:	ff                   	(bad)  
  a0:	ff                   	(bad)  
  a1:	ff                   	(bad)  
  a2:	ff                   	(bad)  
  a3:	ff                   	(bad)  
  a4:	ff                   	(bad)  
  a5:	ff                   	(bad)  
  a6:	ff                   	(bad)  
  a7:	ff                   	(bad)  
  a8:	ff                   	(bad)  
  a9:	ff                   	(bad)  
  aa:	ff                   	(bad)  
  ab:	ff                   	(bad)  
  ac:	ff                   	(bad)  
  ad:	ff                   	(bad)  
  ae:	ff                   	(bad)  
  af:	ff                   	(bad)  
  b0:	ff                   	(bad)  
  b1:	ff                   	(bad)  
  b2:	ff                   	(bad)  
  b3:	ff                   	(bad)  
  b4:	ff                   	(bad)  
  b5:	ff                   	(bad)  
  b6:	ff                   	(bad)  
  b7:	ff                   	(bad)  
  b8:	ff                   	(bad)  
  b9:	ff                   	(bad)  
  ba:	ff                   	(bad)  
  bb:	ff                   	(bad)  
  bc:	ff                   	(bad)  
  bd:	ff                   	(bad)  
  be:	ff                   	(bad)  
  bf:	ff                   	(bad)  
  c0:	ff                   	(bad)  
  c1:	ff                   	(bad)  
  c2:	ff                   	(bad)  
  c3:	ff                   	(bad)  
  c4:	ff                   	(bad)  
  c5:	ff                   	(bad)  
  c6:	ff                   	(bad)  
  c7:	ff                   	(bad)  
  c8:	ff                   	(bad)  
  c9:	ff                   	(bad)  
  ca:	ff                   	(bad)  
  cb:	ff                   	(bad)  
  cc:	ff                   	(bad)  
  cd:	ff                   	(bad)  
  ce:	ff                   	(bad)  
  cf:	ff                   	(bad)  
  d0:	ff                   	(bad)  
  d1:	ff                   	(bad)  
  d2:	ff                   	(bad)  
  d3:	ff                   	(bad)  
  d4:	ff                   	(bad)  
  d5:	ff                   	(bad)  
  d6:	ff                   	(bad)  
  d7:	ff                   	(bad)  
  d8:	ff                   	(bad)  
  d9:	ff                   	(bad)  
  da:	ff                   	(bad)  
  db:	ff                   	(bad)  
  dc:	ff                   	(bad)  
  dd:	ff                   	(bad)  
  de:	ff                   	(bad)  
  df:	ff                   	(bad)  
  e0:	ff                   	(bad)  
  e1:	ff                   	(bad)  
  e2:	ff                   	(bad)  
  e3:	ff                   	(bad)  
  e4:	ff                   	(bad)  
  e5:	ff                   	(bad)  
  e6:	ff                   	(bad)  
  e7:	ff                   	(bad)  
  e8:	ff                   	(bad)  
  e9:	ff                   	(bad)  
  ea:	ff                   	(bad)  
  eb:	ff                   	(bad)  
  ec:	ff                   	(bad)  
  ed:	ff                   	(bad)  
  ee:	ff                   	(bad)  
  ef:	ff                   	(bad)  
  f0:	ff                   	(bad)  
  f1:	ff                   	(bad)  
  f2:	ff                   	(bad)  
  f3:	ff                   	(bad)  
  f4:	ff                   	(bad)  
  f5:	ff                   	(bad)  
  f6:	ff                   	(bad)  
  f7:	ff                   	(bad)  
  f8:	ff                   	(bad)  
  f9:	ff                   	(bad)  
  fa:	ff                   	(bad)  
  fb:	ff                   	(bad)  
  fc:	ff                   	(bad)  
  fd:	ff                   	(bad)  
  fe:	ff                   	(bad)  
  ff:	ff                   	(bad)  
 100:	ff                   	(bad)  
 101:	ff                   	(bad)  
 102:	ff                   	(bad)  
 103:	ff                   	(bad)  
 104:	ff                   	(bad)  
 105:	ff                   	(bad)  
 106:	ff                   	(bad)  
 107:	ff                   	(bad)  
 108:	ff                   	(bad)  
 109:	ff                   	(bad)  
 10a:	ff                   	(bad)  
 10b:	ff                   	(bad)  
 10c:	ff                   	(bad)  
 10d:	ff                   	(bad)  
 10e:	ff                   	(bad)  
 10f:	ff                   	(bad)  

0000000000000110 <bdl_pos_adj>:
 110:	ff                   	(bad)  
 111:	ff                   	(bad)  
 112:	ff                   	(bad)  
 113:	ff                   	(bad)  
 114:	ff                   	(bad)  
 115:	ff                   	(bad)  
 116:	ff                   	(bad)  
 117:	ff                   	(bad)  
 118:	ff                   	(bad)  
 119:	ff                   	(bad)  
 11a:	ff                   	(bad)  
 11b:	ff                   	(bad)  
 11c:	ff                   	(bad)  
 11d:	ff                   	(bad)  
 11e:	ff                   	(bad)  
 11f:	ff                   	(bad)  
 120:	ff                   	(bad)  
 121:	ff                   	(bad)  
 122:	ff                   	(bad)  
 123:	ff                   	(bad)  
 124:	ff                   	(bad)  
 125:	ff                   	(bad)  
 126:	ff                   	(bad)  
 127:	ff                   	(bad)  
 128:	ff                   	(bad)  
 129:	ff                   	(bad)  
 12a:	ff                   	(bad)  
 12b:	ff                   	(bad)  
 12c:	ff                   	(bad)  
 12d:	ff                   	(bad)  
 12e:	ff                   	(bad)  
 12f:	ff                   	(bad)  
 130:	ff                   	(bad)  
 131:	ff                   	(bad)  
 132:	ff                   	(bad)  
 133:	ff                   	(bad)  
 134:	ff                   	(bad)  
 135:	ff                   	(bad)  
 136:	ff                   	(bad)  
 137:	ff                   	(bad)  
 138:	ff                   	(bad)  
 139:	ff                   	(bad)  
 13a:	ff                   	(bad)  
 13b:	ff                   	(bad)  
 13c:	ff                   	(bad)  
 13d:	ff                   	(bad)  
 13e:	ff                   	(bad)  
 13f:	ff                   	(bad)  
 140:	ff                   	(bad)  
 141:	ff                   	(bad)  
 142:	ff                   	(bad)  
 143:	ff                   	(bad)  
 144:	ff                   	(bad)  
 145:	ff                   	(bad)  
 146:	ff                   	(bad)  
 147:	ff                   	(bad)  
 148:	ff                   	(bad)  
 149:	ff                   	(bad)  
 14a:	ff                   	(bad)  
 14b:	ff                   	(bad)  
 14c:	ff                   	(bad)  
 14d:	ff                   	(bad)  
 14e:	ff                   	(bad)  
 14f:	ff                   	(bad)  
 150:	ff                   	(bad)  
 151:	ff                   	(bad)  
 152:	ff                   	(bad)  
 153:	ff                   	(bad)  
 154:	ff                   	(bad)  
 155:	ff                   	(bad)  
 156:	ff                   	(bad)  
 157:	ff                   	(bad)  
 158:	ff                   	(bad)  
 159:	ff                   	(bad)  
 15a:	ff                   	(bad)  
 15b:	ff                   	(bad)  
 15c:	ff                   	(bad)  
 15d:	ff                   	(bad)  
 15e:	ff                   	(bad)  
 15f:	ff                   	(bad)  
 160:	ff                   	(bad)  
 161:	ff                   	(bad)  
 162:	ff                   	(bad)  
 163:	ff                   	(bad)  
 164:	ff                   	(bad)  
 165:	ff                   	(bad)  
 166:	ff                   	(bad)  
 167:	ff                   	(bad)  
 168:	ff                   	(bad)  
 169:	ff                   	(bad)  
 16a:	ff                   	(bad)  
 16b:	ff                   	(bad)  
 16c:	ff                   	(bad)  
 16d:	ff                   	(bad)  
 16e:	ff                   	(bad)  
 16f:	ff                   	(bad)  
 170:	ff                   	(bad)  
 171:	ff                   	(bad)  
 172:	ff                   	(bad)  
 173:	ff                   	(bad)  
 174:	ff                   	(bad)  
 175:	ff                   	(bad)  
 176:	ff                   	(bad)  
 177:	ff                   	(bad)  
 178:	ff                   	(bad)  
 179:	ff                   	(bad)  
 17a:	ff                   	(bad)  
 17b:	ff                   	(bad)  
 17c:	ff                   	(bad)  
 17d:	ff                   	(bad)  
 17e:	ff                   	(bad)  
 17f:	ff                   	(bad)  
 180:	ff                   	(bad)  
 181:	ff                   	(bad)  
 182:	ff                   	(bad)  
 183:	ff                   	(bad)  
 184:	ff                   	(bad)  
 185:	ff                   	(bad)  
 186:	ff                   	(bad)  
 187:	ff                   	(bad)  
 188:	ff                   	(bad)  
 189:	ff                   	(bad)  
 18a:	ff                   	(bad)  
 18b:	ff                   	(bad)  
 18c:	ff                   	(bad)  
 18d:	ff                   	(bad)  
 18e:	ff                   	(bad)  
 18f:	ff 01                	incl   (%rcx)

0000000000000190 <enable>:
 190:	01 00                	add    %eax,(%rax)
 192:	00 00                	add    %al,(%rax)
 194:	01 00                	add    %eax,(%rax)
 196:	00 00                	add    %al,(%rax)
 198:	01 00                	add    %eax,(%rax)
 19a:	00 00                	add    %al,(%rax)
 19c:	01 00                	add    %eax,(%rax)
 19e:	00 00                	add    %al,(%rax)
 1a0:	01 00                	add    %eax,(%rax)
 1a2:	00 00                	add    %al,(%rax)
 1a4:	01 00                	add    %eax,(%rax)
 1a6:	00 00                	add    %al,(%rax)
 1a8:	01 00                	add    %eax,(%rax)
 1aa:	00 00                	add    %al,(%rax)
 1ac:	01 00                	add    %eax,(%rax)
 1ae:	00 00                	add    %al,(%rax)
 1b0:	01 00                	add    %eax,(%rax)
 1b2:	00 00                	add    %al,(%rax)
 1b4:	01 00                	add    %eax,(%rax)
 1b6:	00 00                	add    %al,(%rax)
 1b8:	01 00                	add    %eax,(%rax)
 1ba:	00 00                	add    %al,(%rax)
 1bc:	01 00                	add    %eax,(%rax)
 1be:	00 00                	add    %al,(%rax)
 1c0:	01 00                	add    %eax,(%rax)
 1c2:	00 00                	add    %al,(%rax)
 1c4:	01 00                	add    %eax,(%rax)
 1c6:	00 00                	add    %al,(%rax)
 1c8:	01 00                	add    %eax,(%rax)
 1ca:	00 00                	add    %al,(%rax)
 1cc:	01 00                	add    %eax,(%rax)
 1ce:	00 00                	add    %al,(%rax)
 1d0:	01 00                	add    %eax,(%rax)
 1d2:	00 00                	add    %al,(%rax)
 1d4:	01 00                	add    %eax,(%rax)
 1d6:	00 00                	add    %al,(%rax)
 1d8:	01 00                	add    %eax,(%rax)
 1da:	00 00                	add    %al,(%rax)
 1dc:	01 00                	add    %eax,(%rax)
 1de:	00 00                	add    %al,(%rax)
 1e0:	01 00                	add    %eax,(%rax)
 1e2:	00 00                	add    %al,(%rax)
 1e4:	01 00                	add    %eax,(%rax)
 1e6:	00 00                	add    %al,(%rax)
 1e8:	01 00                	add    %eax,(%rax)
 1ea:	00 00                	add    %al,(%rax)
 1ec:	01 00                	add    %eax,(%rax)
 1ee:	00 00                	add    %al,(%rax)
 1f0:	01 00                	add    %eax,(%rax)
 1f2:	00 00                	add    %al,(%rax)
 1f4:	01 00                	add    %eax,(%rax)
 1f6:	00 00                	add    %al,(%rax)
 1f8:	01 00                	add    %eax,(%rax)
 1fa:	00 00                	add    %al,(%rax)
 1fc:	01 00                	add    %eax,(%rax)
 1fe:	00 00                	add    %al,(%rax)
 200:	01 00                	add    %eax,(%rax)
 202:	00 00                	add    %al,(%rax)
 204:	01 00                	add    %eax,(%rax)
 206:	00 00                	add    %al,(%rax)
 208:	01 00                	add    %eax,(%rax)
 20a:	00 00                	add    %al,(%rax)
 20c:	01 00                	add    %eax,(%rax)
	...

0000000000000210 <index>:
 210:	ff                   	(bad)  
 211:	ff                   	(bad)  
 212:	ff                   	(bad)  
 213:	ff                   	(bad)  
 214:	ff                   	(bad)  
 215:	ff                   	(bad)  
 216:	ff                   	(bad)  
 217:	ff                   	(bad)  
 218:	ff                   	(bad)  
 219:	ff                   	(bad)  
 21a:	ff                   	(bad)  
 21b:	ff                   	(bad)  
 21c:	ff                   	(bad)  
 21d:	ff                   	(bad)  
 21e:	ff                   	(bad)  
 21f:	ff                   	(bad)  
 220:	ff                   	(bad)  
 221:	ff                   	(bad)  
 222:	ff                   	(bad)  
 223:	ff                   	(bad)  
 224:	ff                   	(bad)  
 225:	ff                   	(bad)  
 226:	ff                   	(bad)  
 227:	ff                   	(bad)  
 228:	ff                   	(bad)  
 229:	ff                   	(bad)  
 22a:	ff                   	(bad)  
 22b:	ff                   	(bad)  
 22c:	ff                   	(bad)  
 22d:	ff                   	(bad)  
 22e:	ff                   	(bad)  
 22f:	ff                   	(bad)  
 230:	ff                   	(bad)  
 231:	ff                   	(bad)  
 232:	ff                   	(bad)  
 233:	ff                   	(bad)  
 234:	ff                   	(bad)  
 235:	ff                   	(bad)  
 236:	ff                   	(bad)  
 237:	ff                   	(bad)  
 238:	ff                   	(bad)  
 239:	ff                   	(bad)  
 23a:	ff                   	(bad)  
 23b:	ff                   	(bad)  
 23c:	ff                   	(bad)  
 23d:	ff                   	(bad)  
 23e:	ff                   	(bad)  
 23f:	ff                   	(bad)  
 240:	ff                   	(bad)  
 241:	ff                   	(bad)  
 242:	ff                   	(bad)  
 243:	ff                   	(bad)  
 244:	ff                   	(bad)  
 245:	ff                   	(bad)  
 246:	ff                   	(bad)  
 247:	ff                   	(bad)  
 248:	ff                   	(bad)  
 249:	ff                   	(bad)  
 24a:	ff                   	(bad)  
 24b:	ff                   	(bad)  
 24c:	ff                   	(bad)  
 24d:	ff                   	(bad)  
 24e:	ff                   	(bad)  
 24f:	ff                   	(bad)  
 250:	ff                   	(bad)  
 251:	ff                   	(bad)  
 252:	ff                   	(bad)  
 253:	ff                   	(bad)  
 254:	ff                   	(bad)  
 255:	ff                   	(bad)  
 256:	ff                   	(bad)  
 257:	ff                   	(bad)  
 258:	ff                   	(bad)  
 259:	ff                   	(bad)  
 25a:	ff                   	(bad)  
 25b:	ff                   	(bad)  
 25c:	ff                   	(bad)  
 25d:	ff                   	(bad)  
 25e:	ff                   	(bad)  
 25f:	ff                   	(bad)  
 260:	ff                   	(bad)  
 261:	ff                   	(bad)  
 262:	ff                   	(bad)  
 263:	ff                   	(bad)  
 264:	ff                   	(bad)  
 265:	ff                   	(bad)  
 266:	ff                   	(bad)  
 267:	ff                   	(bad)  
 268:	ff                   	(bad)  
 269:	ff                   	(bad)  
 26a:	ff                   	(bad)  
 26b:	ff                   	(bad)  
 26c:	ff                   	(bad)  
 26d:	ff                   	(bad)  
 26e:	ff                   	(bad)  
 26f:	ff                   	(bad)  
 270:	ff                   	(bad)  
 271:	ff                   	(bad)  
 272:	ff                   	(bad)  
 273:	ff                   	(bad)  
 274:	ff                   	(bad)  
 275:	ff                   	(bad)  
 276:	ff                   	(bad)  
 277:	ff                   	(bad)  
 278:	ff                   	(bad)  
 279:	ff                   	(bad)  
 27a:	ff                   	(bad)  
 27b:	ff                   	(bad)  
 27c:	ff                   	(bad)  
 27d:	ff                   	(bad)  
 27e:	ff                   	(bad)  
 27f:	ff                   	(bad)  
 280:	ff                   	(bad)  
 281:	ff                   	(bad)  
 282:	ff                   	(bad)  
 283:	ff                   	(bad)  
 284:	ff                   	(bad)  
 285:	ff                   	(bad)  
 286:	ff                   	(bad)  
 287:	ff                   	(bad)  
 288:	ff                   	(bad)  
 289:	ff                   	(bad)  
 28a:	ff                   	(bad)  
 28b:	ff                   	(bad)  
 28c:	ff                   	(bad)  
 28d:	ff                   	(bad)  
 28e:	ff                   	(bad)  
 28f:	ff 00                	incl   (%rax)

0000000000000290 <driver>:
	...

0000000000000370 <ops.37658>:
	...

0000000000000390 <azx_pcm_ops>:
	...

Disassembly of section .devinit.data:

0000000000000000 <driver_short_names>:
	...

0000000000000060 <msi_black_list>:
  60:	43 10 f2             	rex.XB adc %sil,%r10b
  63:	81 ff ff 00 00 00    	cmp    $0xff,%edi
  69:	00 00                	add    %al,(%rax)
  6b:	00 43 10             	add    %al,0x10(%rbx)
  6e:	f6 81 ff ff 00 00 00 	testb  $0x0,0xffff(%rcx)
  75:	00 00                	add    %al,(%rax)
  77:	00 43 10             	add    %al,0x10(%rbx)
  7a:	2d 82 ff ff 00       	sub    $0xffff82,%eax
  7f:	00 00                	add    %al,(%rax)
  81:	00 00                	add    %al,(%rax)
  83:	00 49 18             	add    %cl,0x18(%rcx)
  86:	88 08                	mov    %cl,(%rax)
  88:	ff                   	(bad)  
  89:	ff 00                	incl   (%rax)
  8b:	00 00                	add    %al,(%rax)
  8d:	00 00                	add    %al,(%rax)
  8f:	00 a0 a0 75 05 ff    	add    %ah,-0xfa8a60(%rax)
  95:	ff 00                	incl   (%rax)
	...

00000000000000b0 <position_fix_list>:
  b0:	25 10 9f 00 ff       	and    $0xff009f10,%eax
  b5:	ff 00                	incl   (%rax)
  b7:	00 01                	add    %al,(%rcx)
  b9:	00 00                	add    %al,(%rax)
  bb:	00 25 10 6f 02 ff    	add    %ah,-0xfd90f0(%rip)        # ffffffffff026fd1 <azx_attach_pcm_stream+0xffffffffff025318>
  c1:	ff 00                	incl   (%rax)
  c3:	00 01                	add    %al,(%rcx)
  c5:	00 00                	add    %al,(%rax)
  c7:	00 28                	add    %ch,(%rax)
  c9:	10 cc                	adc    %cl,%ah
  cb:	01 ff                	add    %edi,%edi
  cd:	ff 00                	incl   (%rax)
  cf:	00 01                	add    %al,(%rcx)
  d1:	00 00                	add    %al,(%rax)
  d3:	00 28                	add    %ch,(%rax)
  d5:	10 de                	adc    %bl,%dh
  d7:	01 ff                	add    %edi,%edi
  d9:	ff 00                	incl   (%rax)
  db:	00 01                	add    %al,(%rcx)
  dd:	00 00                	add    %al,(%rax)
  df:	00 28                	add    %ch,(%rax)
  e1:	10 f6                	adc    %dh,%dh
  e3:	01 ff                	add    %edi,%edi
  e5:	ff 00                	incl   (%rax)
  e7:	00 01                	add    %al,(%rcx)
  e9:	00 00                	add    %al,(%rax)
  eb:	00 28                	add    %ch,(%rax)
  ed:	10 70 04             	adc    %dh,0x4(%rax)
  f0:	ff                   	(bad)  
  f1:	ff 00                	incl   (%rax)
  f3:	00 01                	add    %al,(%rcx)
  f5:	00 00                	add    %al,(%rax)
  f7:	00 3c 10             	add    %bh,(%rax,%rdx,1)
  fa:	6d                   	insl   (%dx),%es:(%rdi)
  fb:	30 ff                	xor    %bh,%bh
  fd:	ff 00                	incl   (%rax)
  ff:	00 01                	add    %al,(%rcx)
 101:	00 00                	add    %al,(%rax)
 103:	00 43 10             	add    %al,0x10(%rbx)
 106:	3d 81 ff ff 00       	cmp    $0xffff81,%eax
 10b:	00 01                	add    %al,(%rcx)
 10d:	00 00                	add    %al,(%rax)
 10f:	00 43 10             	add    %al,0x10(%rbx)
 112:	b3 81                	mov    $0x81,%bl
 114:	ff                   	(bad)  
 115:	ff 00                	incl   (%rax)
 117:	00 01                	add    %al,(%rcx)
 119:	00 00                	add    %al,(%rax)
 11b:	00 43 10             	add    %al,0x10(%rbx)
 11e:	e7 81                	out    %eax,$0x81
 120:	ff                   	(bad)  
 121:	ff 00                	incl   (%rax)
 123:	00 01                	add    %al,(%rcx)
 125:	00 00                	add    %al,(%rax)
 127:	00 43 10             	add    %al,0x10(%rbx)
 12a:	10 84 ff ff 00 00 01 	adc    %al,0x10000ff(%rdi,%rdi,8)
 131:	00 00                	add    %al,(%rax)
 133:	00 4d 10             	add    %cl,0x10(%rbp)
 136:	69 90 ff ff 00 00 01 	imul   $0x1,0xffff(%rax),%edx
 13d:	00 00 00 
 140:	06                   	(bad)  
 141:	11 88 32 ff ff 00    	adc    %ecx,0xffff32(%rax)
 147:	00 01                	add    %al,(%rcx)
 149:	00 00                	add    %al,(%rax)
 14b:	00 79 11             	add    %bh,0x11(%rcx)
 14e:	10 ff                	adc    %bh,%bh
 150:	ff                   	(bad)  
 151:	ff 00                	incl   (%rax)
 153:	00 01                	add    %al,(%rcx)
 155:	00 00                	add    %al,(%rax)
 157:	00 97 12 66 31 ff    	add    %dl,-0xce99ee(%rdi)
 15d:	ff 00                	incl   (%rax)
 15f:	00 01                	add    %al,(%rcx)
 161:	00 00                	add    %al,(%rax)
 163:	00 58 14             	add    %bl,0x14(%rax)
 166:	22 a0 ff ff 00 00    	and    0xffff(%rax),%ah
 16c:	01 00                	add    %eax,(%rax)
 16e:	00 00                	add    %al,(%rax)
 170:	62                   	(bad)  
 171:	14 02                	adc    $0x2,%al
 173:	10 ff                	adc    %bh,%bh
 175:	ff 00                	incl   (%rax)
 177:	00 01                	add    %al,(%rcx)
 179:	00 00                	add    %al,(%rax)
 17b:	00 65 15             	add    %ah,0x15(%rbp)
 17e:	0f 82 ff ff 00 00    	jb     10183 <azx_attach_pcm_stream+0xe4ca>
 184:	01 00                	add    %eax,(%rax)
 186:	00 00                	add    %al,(%rax)
 188:	65                   	gs
 189:	15 18 82 ff ff       	adc    $0xffff8218,%eax
 18e:	00 00                	add    %al,(%rax)
 190:	01 00                	add    %eax,(%rax)
 192:	00 00                	add    %al,(%rax)
 194:	49 18 88 08 ff ff 00 	rex.WB sbb %cl,0xffff08(%r8)
 19b:	00 01                	add    %al,(%rcx)
 19d:	00 00                	add    %al,(%rax)
 19f:	00 86 80 03 25 ff    	add    %al,-0xdafc80(%rsi)
 1a5:	ff 00                	incl   (%rax)
 1a7:	00 01                	add    %al,(%rcx)
 1a9:	00 00                	add    %al,(%rax)
 1ab:	00 86 80 01 d6 ff    	add    %al,-0x29fe80(%rsi)
 1b1:	ff 00                	incl   (%rax)
 1b3:	00 01                	add    %al,(%rcx)
	...

00000000000001d0 <probe_mask_list>:
 1d0:	14 10                	adc    $0x10,%al
 1d2:	b7 05                	mov    $0x5,%bh
 1d4:	ff                   	(bad)  
 1d5:	ff 00                	incl   (%rax)
 1d7:	00 01                	add    %al,(%rcx)
 1d9:	00 00                	add    %al,(%rax)
 1db:	00 aa 17 10 20 ff    	add    %ch,-0xdfefe9(%rdx)
 1e1:	ff 00                	incl   (%rax)
 1e3:	00 01                	add    %al,(%rcx)
 1e5:	00 00                	add    %al,(%rax)
 1e7:	00 aa 17 ac 20 ff    	add    %ch,-0xdf53e9(%rdx)
 1ed:	ff 00                	incl   (%rax)
 1ef:	00 01                	add    %al,(%rcx)
 1f1:	00 00                	add    %al,(%rax)
 1f3:	00 28                	add    %ch,(%rax)
 1f5:	10 ac 20 ff ff 00 00 	adc    %ch,0xffff(%rax,%riz,1)
 1fc:	01 00                	add    %eax,(%rax)
 1fe:	00 00                	add    %al,(%rax)
 200:	c0 17 85             	rclb   $0x85,(%rdi)
 203:	40 ff                	rex (bad) 
 205:	ff 00                	incl   (%rax)
 207:	00 01                	add    %al,(%rcx)
 209:	00 00                	add    %al,(%rax)
 20b:	00 43 10             	add    %al,0x10(%rbx)
 20e:	62                   	(bad)  
 20f:	12 ff                	adc    %bh,%bh
 211:	ff 00                	incl   (%rax)
 213:	00 03                	add    %al,(%rbx)
 215:	01 00                	add    %eax,(%rax)
 217:	00 46 10             	add    %al,0x10(%rsi)
 21a:	62                   	(bad)  
 21b:	12 ff                	adc    %bh,%bh
 21d:	ff 00                	incl   (%rax)
 21f:	00 03                	add    %al,(%rbx)
 221:	01 00                	add    %eax,(%rax)
	...

0000000000000230 <azx_max_codecs>:
	...
 250:	08 00                	or     %al,(%rax)
 252:	00 00                	add    %al,(%rax)
 254:	01 00                	add    %eax,(%rax)
	...

Disassembly of section .gnu.linkonce.this_module:

0000000000000000 <__this_module>:
	...
  18:	73 6e                	jae    88 <__this_module+0x88>
  1a:	64                   	fs
  1b:	5f                   	pop    %rdi
  1c:	68 64 61 5f 69       	pushq  $0x695f6164
  21:	6e                   	outsb  %ds:(%rsi),(%dx)
  22:	74 65                	je     89 <__this_module+0x89>
  24:	6c                   	insb   (%dx),%es:(%rdi)
	...

Disassembly of section .bss:

0000000000000000 <power_save>:
	...

0000000000000010 <id>:
	...

0000000000000110 <__warned.37149>:
request_irq():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/include/linux/interrupt.h:139
 110:	00 00                	add    %al,(%rax)
	...

0000000000000114 <dev.37810>:
 114:	00 00                	add    %al,(%rax)
	...

0000000000000118 <__key.37660>:
	...

0000000000000120 <model>:
	...

0000000000000220 <position_fix>:
	...

00000000000002a0 <probe_only>:
	...

0000000000000320 <single_cmd>:
	...

0000000000000330 <patch>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
alsa_card_azx_exit():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1870
   0:	00 47 43             	add    %al,0x43(%rdi)
pci_get_drvdata():
   3:	43 3a 20             	rex.XB cmp (%r8),%spl
   6:	28 44 65 62          	sub    %al,0x62(%rbp,%riz,2)
   a:	69 61 6e 20 34 2e 34 	imul   $0x342e3420,0x6e(%rcx),%esp
alsa_card_azx_init():
  11:	2e                   	cs
  12:	35 2d 31 34 29       	xor    $0x2934312d,%eax
  17:	20 34 2e             	and    %dh,(%rsi,%rbp,1)
pci_set_drvdata():
  1a:	34 2e                	xor    $0x2e,%al
  1c:	35 00 00 47 43       	xor    $0x43470000,%eax
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
  21:	43 3a 20             	rex.XB cmp (%r8),%spl
readl():
  24:	28 44 65 62          	sub    %al,0x62(%rbp,%riz,2)
azx_get_position():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1874
  28:	69 61 6e 20 34 2e 34 	imul   $0x342e3420,0x6e(%rcx),%esp
readl():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/arch/x86/include/asm/io.h:58
  2f:	2e                   	cs
  30:	35 2d 31 34 29       	xor    $0x2934312d,%eax
azx_via_get_position():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1817
  35:	20 34 2e             	and    %dh,(%rsi,%rbp,1)
  38:	34 2e                	xor    $0x2e,%al
  3a:	35                   	.byte 0x35
	...

Disassembly of section .gnu_debuglink:

0000000000000000 <.gnu_debuglink>:
alsa_card_azx_exit():
/build/buildd-linux-2.6_2.6.38-2-amd64-6G9fmV/linux-2.6-2.6.38/debian/build/source_amd64_none/sound/pci/hda/hda_intel.c:1870
   0:	73 6e                	jae    70 <__func__.36108>
pci_get_drvdata():
   2:	64                   	fs
   3:	2d 68 64 61 2d       	sub    $0x2d616468,%eax
   8:	69 6e 74 65 6c 2e 6b 	imul   $0x6b2e6c65,0x74(%rsi),%ebp
   f:	6f                   	outsl  %ds:(%rsi),(%dx)
alsa_card_azx_exit():
  10:	00 00                	add    %al,(%rax)
alsa_card_azx_init():
  12:	00 00                	add    %al,(%rax)
  14:	02 70 ac             	add    -0x54(%rax),%dh
  17:	8d                   	.byte 0x8d

--=-aZdDwlmqxkIajkvWZLLv--
