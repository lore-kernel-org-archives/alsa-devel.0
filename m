From: Mark Constable <markc@renta.net>
Subject: Re: ALSA AMD OOPS
Date: Thu, 21 Mar 2002 19:29:11 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E16nysn-0007d7-00@usw-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0203210922270.28513-100000@yme.mo.himolde.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Pine.LNX.4.44.0203210922270.28513-100000@yme.mo.himolde.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 21 Mar 2002 18:27, Erik Inge Bols=F8 wrote:
> Does not tell us anything at all. Please, run the oops through ksymoop=
s
> <URL: ftp://ftp.us.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/ >
> and resend.

Here we go, I hope this helps and let me know if there is anything
else I can provide to troubleshoot this.

I would normally consider this some kind of hardware fault but I just
spent over a weeks uptime using the current kernels emu10k1 module and
the same thing happens to my Athlon and Duron boxes. Must be ALSA at
fault.

--markc

markc ~ ksymoops -V < ~/alsa-oops
ksymoops 2.4.3 on i686 2.4.18.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

c01112a3
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01112a3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: f693693c   ebx: f6936938   ecx: 00000000   edx: 00000003
esi: f571cc08   edi: 00000001   ebp: f5909c84   esp: f5909c6c
ds: 0018   es: 0018   ss: 0018
Process alsamixer (pid: 333, stackpage=3Df5909000)
Stack: f6fec8a0 f571cc08 f6fec8e8 f693693c 00000082 00000003 f6936920 f8=
883d61
       f6936920 00000282 bffff5b0 f571cc08 f5909cfc f7718a00 f88847e1 f7=
718a00
       00000001 f571cbc8 00000000 f7718a00 00000028 00000002 00000000 00=
000000
Call Trace: [<f8883d61>] [<f88847e1>] [<c01395f7>] [<c0106d93>]
Code: 8b 01 85 45 fc 74 4d 31 c0 9c 5e fa c7 01 00 00 00 00 83 79

>>EIP; c01112a2 <__wake_up+2a/94>   <=3D=3D=3D=3D=3D
Trace; f8883d60 <[sound]sound_free_dmap+3c/88>
Trace; f88847e0 <[sound]DMAbuf_release+34/f8>
Trace; c01395f6 <sys_ioctl+16a/184>
Trace; c0106d92 <system_call+32/40>
Code;  c01112a2 <__wake_up+2a/94>
00000000 <_EIP>:
Code;  c01112a2 <__wake_up+2a/94>   <=3D=3D=3D=3D=3D
   0:   8b 01                     mov    (%ecx),%eax   <=3D=3D=3D=3D=3D
Code;  c01112a4 <__wake_up+2c/94>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c01112a6 <__wake_up+2e/94>
   5:   74 4d                     je     54 <_EIP+0x54> c01112f6 <__wake=
_up+7e/94>Code;  c01112a8 <__wake_up+30/94>
   7:   31 c0                     xor    %eax,%eax
Code;  c01112aa <__wake_up+32/94>
   9:   9c                        pushf
Code;  c01112ac <__wake_up+34/94>
   a:   5e                        pop    %esi
Code;  c01112ac <__wake_up+34/94>
   b:   fa                        cli
Code;  c01112ae <__wake_up+36/94>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c01112b4 <__wake_up+3c/94>
  12:   83 79 00 00               cmpl   $0x0,0x0(%ecx)

--markc

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
