From: Peter Surda <shurdeek@panorama.sth.ac.at>
Subject: kernel oops #2
Date: Mon, 18 Feb 2002 19:34:15 +0100
Message-ID: <20020218193415.K2029@shurdeek.cb.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi guys!

1st of all thnx for solving the 1st problem I had, from now on I'll be post=
ing
my problems directly to alsa-devel and not bother with alsa-user.  Until I
decide to subscribe, may I humbly request you to CC me the answers.

So, I seem to have another oops, and as I learned from last one, I did a=20
dmesg|ksymoops and am posting the results:

-----------------------------
ksymoops 2.4.0 on i686 2.4.18-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-pre4/ (default)
     -m /boot/System.map-2.4.18-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says cd8678b=
0, /lib/modules/2.4.18-pre4/kernel/fs/lockd/lockd.o says cd866d0c.  Ignorin=
g /lib/modules/2.4.18-pre4/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says cd85a76=
4, /lib/modules/2.4.18-pre4/kernel/net/sunrpc/sunrpc.o says cd85a444.  Igno=
ring /lib/modules/2.4.18-pre4/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says cd85a7=
68, /lib/modules/2.4.18-pre4/kernel/net/sunrpc/sunrpc.o says cd85a448.  Ign=
oring /lib/modules/2.4.18-pre4/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says cd85a76=
c, /lib/modules/2.4.18-pre4/kernel/net/sunrpc/sunrpc.o says cd85a44c.  Igno=
ring /lib/modules/2.4.18-pre4/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says cd85a76=
0, /lib/modules/2.4.18-pre4/kernel/net/sunrpc/sunrpc.o says cd85a440.  Igno=
ring /lib/modules/2.4.18-pre4/kernel/net/sunrpc/sunrpc.o entry
Unable to handle kernel NULL pointer dereference at virtual address 000000b0
cd984c9a
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<cd984c9a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010256
eax: 00000000   ebx: c1319c08   ecx: c1319c00   edx: 00000000
esi: ca1a2c00   edi: 00000003   ebp: ca1a2e00   esp: c1311ebc
ds: 0018   es: 0018   ss: 0018
Process kapm-idled (pid: 3, stackpage=3Dc1311000)
Stack: 00000000 c1319c08 ca1a2c00 00000003 ca1a2e00 cd991341 00000000 c9066=
200=20
       c1319c08 c131ae54 00000003 00000003 cd99142e ca1a2e00 00000000 c01a5=
19f=20
       c1319c00 00000003 c01a52aa c1319c00 00000003 c131ae40 00000003 00000=
000=20
Call Trace: [<cd991341>] [<cd99142e>] [<c01a519f>] [<c01a52aa>] [<c01a5387>=
]=20
   [<c01a5426>] [<c01258be>] [<c01a53f0>] [<c0125975>] [<c0111920>] [<c0111=
b9a>]=20
   [<c0111d3b>] [<c0112758>] [<c0105000>] [<c0105000>] [<c01055b6>] [<c0112=
4c0>]=20
Code: 8b 9c 02 b0 00 00 00 85 db 0f 84 db 00 00 00 bd 00 e0 ff ff=20

>>EIP; cd984c9a <[snd-pcm]snd_pcm_suspend_all+1a/120>   <=3D=3D=3D=3D=3D
Trace; cd991341 <[snd-card-intel8x0]intel8x0_suspend+71/a0>
Trace; cd99142e <[snd-card-intel8x0]snd_intel8x0_suspend+e/20>
Trace; c01a519f <pci_pm_suspend_device+1f/30>
Trace; c01a52aa <pci_pm_suspend_bus+5a/70>
Trace; c01a5387 <pci_pm_suspend+17/40>
Trace; c01a5426 <pci_pm_callback+36/40>
Trace; c01258be <pm_send+3e/70>
Trace; c01a53f0 <pci_pm_callback+0/40>
Trace; c0125975 <pm_send_all+45/a0>
Trace; c0111920 <send_event+20/70>
Trace; c0111b9a <check_events+10a/1b0>
Trace; c0111d3b <apm_mainloop+7b/140>
Trace; c0112758 <apm+298/2b0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c01055b6 <kernel_thread+26/30>
Trace; c01124c0 <apm+0/2b0>
Code;  cd984c9a <[snd-pcm]snd_pcm_suspend_all+1a/120>
00000000 <_EIP>:
Code;  cd984c9a <[snd-pcm]snd_pcm_suspend_all+1a/120>   <=3D=3D=3D=3D=3D
   0:   8b 9c 02 b0 00 00 00      mov    0xb0(%edx,%eax,1),%ebx   <=3D=3D=
=3D=3D=3D
Code;  cd984ca1 <[snd-pcm]snd_pcm_suspend_all+21/120>
   7:   85 db                     test   %ebx,%ebx
Code;  cd984ca3 <[snd-pcm]snd_pcm_suspend_all+23/120>
   9:   0f 84 db 00 00 00         je     ea <_EIP+0xea> cd984d84 <[snd-pcm]=
snd_pcm_suspend_all+104/120>
Code;  cd984ca9 <[snd-pcm]snd_pcm_suspend_all+29/120>
   f:   bd 00 e0 ff ff            mov    $0xffffe000,%ebp


6 warnings issued.  Results may not be reliable.
-----------------------------

I am unable to find a method how to reproduce it, however right now it
happened when I started a player (aviplay). It happened about 4 times alrea=
dy
if I recall correctly.

Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505=
122023

--
  Hello, this is Bill Gates and I pronounce Monopoly, er, Windows as Window=
s.

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8cUknzogxsPZwLzcRAqLWAJ4spqoHUQNKJZJabWFqT4qdRyr26wCeP/9A
Gdj1JLq/i5JcOy1XheP+YLQ=
=Gaer
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
