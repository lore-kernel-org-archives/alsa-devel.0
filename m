From: Ludovic Drolez <ludovic.drolez@freealter.com>
Subject: oops with 2.4.22 alsa 0.9.8 and a non-pnp sb16
Date: Sat, 08 Nov 2003 14:06:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FACEA49.4080801@freealter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 Hi !

With a modprobe snd-sb16, I get a modprobe segfault and an oops !

Logs seem to say that it's correclty detected:

isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: No ISAPnP cards found, trying standard ones...
SB 4.13 detected OK (220)

But a few ms after, I get this oops:

Unable to handle kernel paging request at virtual address fffffffc
c0115ae0
*pde = 00002063
Oops: 0000
CPU:    0
EIP:    0010:[<c0115ae0>]    Tainted: GF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010017
eax: c41aa1c4   ebx: 00000000   ecx: 00000001   edx: 00000003
esi: c41aa1c4   edi: 00000003   ebp: c2cc1ea4   esp: c2cc1e90
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 18892, stackpage=c2cc1000)
Stack: 00000001 00000282 cacb4f00 fffffff0 00000005 c41aa000 cac33b9f cacb4f00
       fffffff0 00000005 c41aa000 00000005 caca3730 00000003 00000005 cacb47b3
       c41aa000 00000000 00000000 cacb4f00 00000000 00000000 00000005 00000003
Call Trace:    [<cacb4f00>] [<cac33b9f>] [<cacb4f00>] [<caca3730>] [<cacb47b3>]
  [<cacb4f00>] [<cacb491a>] [<c011972d>] [<cacb4e04>] [<cacb4060>] [<c0108c83>]
Code: 8b 53 fc 8b 02 85 c7 75 17 8b 1b 39 f3 75 f1 ff 75 f0 9d 8d

>>EIP; c0115ae0 <__wake_up+20/60>   <=====

>>eax; c41aa1c4 <_end+3edf5fc/a542438>
>>esi; c41aa1c4 <_end+3edf5fc/a542438>
>>ebp; c2cc1ea4 <_end+29f72dc/a542438>
>>esp; c2cc1e90 <_end+29f72c8/a542438>

Trace; cacb4f00 <[snd-sb16]port+0/20>
Trace; cac33b9f <[snd]snd_card_free+4b/21c>
Trace; cacb4f00 <[snd-sb16]port+0/20>
Trace; caca3730 <[snd-sb16-dsp]snd_sb16dsp_interrupt+0/fc>
Trace; cacb47b3 <[snd-sb16]__module_generic_string_info_parm_csp+333/364>
Trace; cacb4f00 <[snd-sb16]port+0/20>
Trace; cacb491a <[snd-sb16]alsa_card_sb16_init+3a/d0>
Trace; c011972d <sys_init_module+4ed/660>
Trace; cacb4e04 <[snd-sb16].rodata.end+e5/161>
Trace; cacb4060 <[snd-sb16]snd_legacy_auto_probe+0/7>
Trace; c0108c83 <system_call+33/40>

Code;  c0115ae0 <__wake_up+20/60>
00000000 <_EIP>:
Code;  c0115ae0 <__wake_up+20/60>   <=====
   0:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx   <=====
Code;  c0115ae3 <__wake_up+23/60>
   3:   8b 02                     mov    (%edx),%eax
Code;  c0115ae5 <__wake_up+25/60>
   5:   85 c7                     test   %eax,%edi
Code;  c0115ae7 <__wake_up+27/60>
   7:   75 17                     jne    20 <_EIP+0x20> c0115b00 <__wake_up+40/6
0>
Code;  c0115ae9 <__wake_up+29/60>
   9:   8b 1b                     mov    (%ebx),%ebx
Code;  c0115aeb <__wake_up+2b/60>
   b:   39 f3                     cmp    %esi,%ebx
Code;  c0115aed <__wake_up+2d/60>
   d:   75 f1                     jne    0 <_EIP>
Code;  c0115aef <__wake_up+2f/60>
   f:   ff 75 f0                  pushl  0xfffffff0(%ebp)
Code;  c0115af2 <__wake_up+32/60>
  12:   9d                        popf
Code;  c0115af3 <__wake_up+33/60>
  13:   8d 00                     lea    (%eax),%eax





My card worked well with alsa 0.5.x...
Now I cannot unload the module:

Module                  Size  Used by    Tainted: GF
snd-sb16                6024   1  (initializing)
snd-opl3-lib            5248   0  [snd-sb16]
snd-sb16-dsp            5280   0  [snd-sb16]
snd-pcm                54016   0  [snd-sb16-dsp]
snd-page-alloc          5476   0  [snd-pcm]
snd-timer              12704   0  [snd-opl3-lib snd-pcm]
snd-mpu401-uart         2816   0  [snd-sb16]
snd-rawmidi            11872   0  [snd-mpu401-uart]
snd-seq-device          3732   0  [snd-opl3-lib snd-rawmidi]
snd-pnp                 3344   0  [snd-sb16]
snd-sb16-csp           14976   0  [snd-sb16]
snd-sb-common           6592   0  [snd-sb16 snd-sb16-dsp snd-sb16-csp]
snd-hwdep               4128   0  [snd-opl3-lib snd-sb16-csp]
snd                    29792   0  [snd-sb16 snd-opl3-lib snd-sb16-dsp snd-pcm
snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd-sb16-csp snd-sb-common
snd-hwdep]

Is there a way to fix the oops and to force a remove of 'snd-sb16' ?

Cheers,

    Ludovic Drolez.










-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
