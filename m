From: David B Harris <david@eelf.ddts.net>
Subject: OOPS with snd-pcm-oss, ALSA 0.9.8, module snd-intel8x0
Date: Sun, 9 Nov 2003 23:00:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031109230049.3ed59cd2.david@eelf.ddts.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__9_Nov_2003_23_00_49_-0500_ZbAa7tEFCaHeaW9L"
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

--Signature=_Sun__9_Nov_2003_23_00_49_-0500_ZbAa7tEFCaHeaW9L
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__9_Nov_2003_23_00_49_-0500_P4Dbi8h6Awmf_CC4"


--Multipart=_Sun__9_Nov_2003_23_00_49_-0500_P4Dbi8h6Awmf_CC4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hey folks. Trying to package up 0.9.8 here, and I'm getting a consistent
crash when using snd-pcm-oss. Underlying module snd-intel8x0, hardware
is an ECS K7S5A ("00:02.7 Multimedia audio controller: Silicon
Integrated Systems [SiS] Sound Controller (rev a0)").

X and all my applications lock, and my keyboard LEDs invert.
Ctrl+Alt+Del doesn't work, but Alt+SysRq+(S,U,B) does. Or, at least, it
reboots at the end, so at least Alt+SysRq+B works ;)

Attached is the except from syslog (garnered after rebooting), and the
ksymoops report.

I've not the slightest idea why it isn't able to resolve function names
- wouldn't surprise me in the least if it makes this report unusable.
Any suggestions would be welcomed (System.map is in sync with the
kernel, everything else is as-is ... perhaps the reboot in between is
enough to cause problems? Everything in userland appears to die, so I
can't SSH in and get a ksymoops going before I reboot, unfortunately.)

This happened with 0.9.7c incidentally (which I'd tried just before
0.9.8 was released).

Anyways, thanks for the effort.

Oh, in closing, I'll note that not using OSS emulation works fine.

--Multipart=_Sun__9_Nov_2003_23_00_49_-0500_P4Dbi8h6Awmf_CC4
Content-Type: text/plain;
 name="syslog.txt"
Content-Disposition: attachment;
 filename="syslog.txt"
Content-Transfer-Encoding: base64

Tm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6ICpwdXQsIGxpbmUgMTI4aXNoOiCLRcBmwfgI
g/CA67KLRcCLVbxmiQLrrItFwDUKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6ICpwdXQs
IGxpbmUgMTI4aXNoOiCLRcBmwfgIg/CA67KLRcCLVbxmiQLrrItFwDUKTm92ICA5IDIxOjEyOjU2
IHdpbGxvdyBrZXJuZWw6IEdwdXQsIGxpbmUgMTI4aXNoOiCLRcBmwfgIg/CA67KLRcCLVbxmiQLr
rItFwDUKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6IEdwdXQsIGxpbmUgMTI4aXNoOiCL
RcBmwfgIg/CA67KLRcCLVbxmiQLrrItFwDUKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6
IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0
dWFsIGFkZHJlc3MgMDAwMDA0MDAKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6IHByaW50
aW5nIGVpcDoKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6IGU0ZTNjNzc0Ck5vdiAgOSAy
MToxMjo1NiB3aWxsb3cga2VybmVsOiAqcGRlID0gMDAwMDAwMDAKTm92ICA5IDIxOjEyOjU2IHdp
bGxvdyBrZXJuZWw6IE9vcHM6IDAwMDIKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6IHNu
ZC1wY20tb3NzIHNuZC1taXhlci1vc3Mgc25kLWludGVsOHgwIHNuZC1wY20gc25kLXRpbWVyIHNu
ZC1hYzk3LWNvZGVjIHNuZC1wYWdlLWFsbG9jIHNuZC1tcHU0MDEtdWFydCBzbmQtcmF3bWlkaSBz
bmQtc2VxLWRldmljZSBzbmQgc291bmRjb3JlIGlkZS1jZCBjZHJvbSB2bW5ldCBwYXJwb3J0X3Bj
IHBhcnBvcnQgdm1tb24gcmFkZW9uIGkyYy1pc2EgaTJjLWRldiBpdDg3IGkyYy1wcm9jIGkyYy1j
b3JlIGlzb2ZzIGF1dG9mcyBuZnNkIG5mcyBzbWJmcyBsb2NrZCBzdW5ycGMgZG0tbW9kIHByaW50
ZXIga2V5YmRldiBoaWQgbW91c2VkZXYgaW5wdXQgYWVzIGNyeXB0b2xvb3AgbG9vcCB0dW4gaXB2
NiBhZl9wYWNrZXQgdmlhLXJoaW5lIG1paSAgCk5vdiAgOSAyMToxMjo1NiB3aWxsb3cga2VybmVs
OiBDUFU6ICAgIDAKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6IEVJUDogICAgMDAxMDpb
PGU0ZTNjNzc0Pl0gICAgVGFpbnRlZDogUEYKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6
IEVGTEFHUzogMDAyMTAyMDYKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6IGVheDogMjFj
Y2ZmODcgICBlYng6IDAwMDAwNDAwICAgZWN4OiAwMDAwMTgwMiAgIGVkeDogMDAwMDA0MDAKTm92
ICA5IDIxOjEyOjU2IHdpbGxvdyBrZXJuZWw6IGVzaTogZGUzMzA3NGMgICBlZGk6IGRlMzMwNzMw
ICAgZWJwOiBkZDAyNWU3YyAgIGVzcDogZGQwMjVlNTgKTm92ICA5IDIxOjEyOjU2IHdpbGxvdyBr
ZXJuZWw6IGRzOiAwMDE4ICAgZXM6IDAwMTggICBzczogMDAxOApOb3YgIDkgMjE6MTI6NTYgd2ls
bG93IGtlcm5lbDogUHJvY2VzcyBtcGxheWVyIChwaWQ6IDE0Mzk5LCBzdGFja3BhZ2U9ZGQwMjUw
MDApCk5vdiAgOSAyMToxMjo1NiB3aWxsb3cga2VybmVsOiBTdGFjazogMDAwMDAwMDEgMDAwMDAw
MDEgMDAwMDAwMDAgZTBhMzcwMDAgMDAwMDAwMDAgMDAwMDAzZjAgMDAwMDE4MDYgMDAwMDA0MDAg
Ck5vdiAgOSAyMToxMjo1NiB3aWxsb3cga2VybmVsOiBkZTMzMDZjMCBjMzA0MTc0MCBlNGUzY2Nl
MCBkZTMzMDZjMCBjMzA0MTc0MCBkNDA2ODhhMCAwMDAwMDQwMCAwMDAwMTgwNiAKTm92ICA5IDIx
OjEyOjU2IHdpbGxvdyBrZXJuZWw6IGRlMzMwNmMwIDAwMDAwNDAwIDAwMDAxODA2IGMzNjU1MDgw
IGU0ZTNhMmMxIGRlMzMwNmMwIGMzMDQxNzQwIGQ0MDY4OGEwIApOb3YgIDkgMjE6MTI6NTYgd2ls
bG93IGtlcm5lbDogQ2FsbCBUcmFjZTogWzxlNGUzY2NlMD5dICBbPGU0ZTNhMmMxPl0gIFs8ZTRl
MzYxZjI+XSAgWzxlNGUzNjZmNz5dICBbPGU0ZTM2ODMxPl0gIFs8ZTRlMzdhMzk+XSAgWzxjMDEz
NzZmOT5dICBbPGMwMTM2MjE3Pl0gIFs8YzAxMzYyODM+XSAgWzxjMDEwOGNhMz5dIApOb3YgIDkg
MjE6MTI6NTYgd2lsbG93IGtlcm5lbDogQ29kZTogODggMDIgOGIgNDUgZGMgOGIgNTUgYmMgMDEg
YzIgOGIgNGQgZjAgODkgNTUgYmMgOGIgNDUgZDggOGIgCg==

--Multipart=_Sun__9_Nov_2003_23_00_49_-0500_P4Dbi8h6Awmf_CC4
Content-Type: text/plain;
 name="ksymoops.txt"
Content-Disposition: attachment;
 filename="ksymoops.txt"
Content-Transfer-Encoding: 7bit

ksymoops 2.4.9 on i686 2.4.22-xfs-a14.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.22-xfs-a14 (specified)
     -m /boot/System.map-2.4.22-xfs-a14 (specified)

Nov  9 21:12:56 willow kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000400
Nov  9 21:12:56 willow kernel: e4e3c774
Nov  9 21:12:56 willow kernel: *pde = 00000000
Nov  9 21:12:56 willow kernel: Oops: 0002
Nov  9 21:12:56 willow kernel: CPU:    0
Nov  9 21:12:56 willow kernel: EIP:    0010:[<e4e3c774>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Nov  9 21:12:56 willow kernel: EFLAGS: 00210206
Nov  9 21:12:56 willow kernel: eax: 21ccff87   ebx: 00000400   ecx: 00001802   edx: 00000400
Nov  9 21:12:56 willow kernel: esi: de33074c   edi: de330730   ebp: dd025e7c   esp: dd025e58
Nov  9 21:12:56 willow kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 21:12:56 willow kernel: Process mplayer (pid: 14399, stackpage=dd025000)
Nov  9 21:12:56 willow kernel: Stack: 00000001 00000001 00000000 e0a37000 00000000 000003f0 00001806 00000400 
Nov  9 21:12:56 willow kernel: de3306c0 c3041740 e4e3cce0 de3306c0 c3041740 d40688a0 00000400 00001806 
Nov  9 21:12:56 willow kernel: de3306c0 00000400 00001806 c3655080 e4e3a2c1 de3306c0 c3041740 d40688a0 
Nov  9 21:12:56 willow kernel: Call Trace: [<e4e3cce0>]  [<e4e3a2c1>]  [<e4e361f2>]  [<e4e366f7>]  [<e4e36831>]  [<e4e37a39>]  [<c01376f9>]  [<c0136217>]  [<c0136283>]  [<c0108ca3>] 
Nov  9 21:12:56 willow kernel: Code: 88 02 8b 45 dc 8b 55 bc 01 c2 8b 4d f0 89 55 bc 8b 45 d8 8b 


>>EIP; e4e3c774 <END_OF_CODE+36238/????>   <=====

>>esi; de33074c <_end+1df71720/20561034>
>>edi; de330730 <_end+1df71704/20561034>
>>ebp; dd025e7c <_end+1cc66e50/20561034>
>>esp; dd025e58 <_end+1cc66e2c/20561034>

Trace; e4e3cce0 <END_OF_CODE+367a4/????>
Trace; e4e3a2c1 <END_OF_CODE+33d85/????>
Trace; e4e361f2 <END_OF_CODE+2fcb6/????>
Trace; e4e366f7 <END_OF_CODE+301bb/????>
Trace; e4e36831 <END_OF_CODE+302f5/????>
Trace; e4e37a39 <END_OF_CODE+314fd/????>
Trace; c01376f9 <fput+d9/100>
Trace; c0136217 <filp_close+37/60>
Trace; c0136283 <sys_close+43/50>
Trace; c0108ca3 <system_call+33/40>

Code;  e4e3c774 <END_OF_CODE+36238/????>
00000000 <_EIP>:
Code;  e4e3c774 <END_OF_CODE+36238/????>   <=====
   0:   88 02                     mov    %al,(%edx)   <=====
Code;  e4e3c776 <END_OF_CODE+3623a/????>
   2:   8b 45 dc                  mov    0xffffffdc(%ebp),%eax
Code;  e4e3c779 <END_OF_CODE+3623d/????>
   5:   8b 55 bc                  mov    0xffffffbc(%ebp),%edx
Code;  e4e3c77c <END_OF_CODE+36240/????>
   8:   01 c2                     add    %eax,%edx
Code;  e4e3c77e <END_OF_CODE+36242/????>
   a:   8b 4d f0                  mov    0xfffffff0(%ebp),%ecx
Code;  e4e3c781 <END_OF_CODE+36245/????>
   d:   89 55 bc                  mov    %edx,0xffffffbc(%ebp)
Code;  e4e3c784 <END_OF_CODE+36248/????>
  10:   8b 45 d8                  mov    0xffffffd8(%ebp),%eax
Code;  e4e3c787 <END_OF_CODE+3624b/????>
  13:   8b 00                     mov    (%eax),%eax


--Multipart=_Sun__9_Nov_2003_23_00_49_-0500_P4Dbi8h6Awmf_CC4--

--Signature=_Sun__9_Nov_2003_23_00_49_-0500_ZbAa7tEFCaHeaW9L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/rw1zuCQ/g7GxJcARAsMgAKCPgdeKtERYhFfqQJPO65eq8iNS4wCdEGnf
80gKZp/qcZIAjVx+fSFy0SM=
=pSb2
-----END PGP SIGNATURE-----

--Signature=_Sun__9_Nov_2003_23_00_49_-0500_ZbAa7tEFCaHeaW9L--


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
