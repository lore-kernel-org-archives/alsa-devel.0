From: alfp <alfp@adsmr.co.za>
Subject: [Fwd: Re: crash with rc8]
Date: 05 Mar 2003 16:24:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046874281.14323.19.camel@didjeridu.adsmr.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

-----Forwarded Message-----

> From: alfp <alfp@adsmr.co.za>
> To: Erik Inge Bols=F8 <knan@mo.himolde.no>
> Subject: Re: [Alsa-devel] crash with rc8
> Date: 05 Mar 2003 14:08:03 +0200
>=20
> Sending the output as is.=20
> alf
>=20
> BTW, I changed=20
> /lib/modules/2.4.19-16mdkenterprise/build/include/linux/version.h
> to=20
> read "2.4.19-16mdkenterprise" instead of "2.4.19-16mdkcustom"=20
> for UTS_RELEASE,
> so that the modules gets stored in the right place.
>=20
>=20
> ksymoops 2.4.5 on i686 2.4.19-16mdkenterprise.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.19-16mdkenterprise/ (default)
>      -m /boot/System.map-2.4.19-16mdkenterprise (default)
>=20
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
>=20
> Warning (compare_ksyms_lsmod): module ext3 is in lsmod but not in ksyms, =
probably no symbols exported
> Warning (compare_maps): mismatch on symbol __nvsym03120  , NVdriver says =
f8dfe720, /lib/modules/2.4.19-16mdkenterprise/kernel/drivers/video/NVdriver=
 says f8df6fe0.  Ignoring /lib/modules/2.4.19-16mdkenterprise/kernel/driver=
s/video/NVdriver entry
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010296
> eax: f6384bd8   ebx: 00000000   ecx: 00000000   edx: f6384bd8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6277c5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2288, stackpage=3Df6277000)
> Stack: 00000000 00000000 f63170f4 f6384ba0 f754b800 f8b561a3 f6384bd8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f63170e0 f6384ba0 f62=
77ce4=20
>        f8b66f21 f6384ba0 00015888 f754b800 00000000 f6277ce4 f6384ba0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01b87b0>] [<c0129666>] [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f6384bd8 <_end+3601ace0/3849a158>
> >>edx; f6384bd8 <_end+3601ace0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f6277c5c <_end+35f0dd64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01b87b0 <ide_dma_intr+0/d0>
> Trace; c0129666 <update_process_times+36/b0>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f639a0b8   ebx: 00000000   ecx: 00000000   edx: f639a0b8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6289c5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2282, stackpage=3Df6289000)
> Stack: 00000000 00000000 f63173f4 f639a080 f621bc00 f8b561a3 f639a0b8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f63173e0 f639a080 f62=
89ce4=20
>        f8b66f21 f639a080 00015888 f621bc00 00000000 f6289ce4 f639a080 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f639a0b8 <_end+360301c0/3849a158>
> >>edx; f639a0b8 <_end+360301c0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f6289c5c <_end+35f1fd64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f63848d8   ebx: 00000000   ecx: 00000000   edx: f63848d8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f651bc5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2279, stackpage=3Df651b000)
> Stack: 00000000 00000000 f620ded4 f63848a0 f657ac00 f8b561a3 f63848d8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620dec0 f63848a0 f65=
1bce4=20
>        f8b66f21 f63848a0 00015888 f657ac00 00000000 f651bce4 f63848a0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01b87b0>] [<c010b01b>] [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f63848d8 <_end+3601a9e0/3849a158>
> >>edx; f63848d8 <_end+3601a9e0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f651bc5c <_end+361b1d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01b87b0 <ide_dma_intr+0/d0>
> Trace; c010b01b <handle_IRQ_event+6b/a0>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f637eef8   ebx: 00000000   ecx: 00000000   edx: f637eef8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6241c5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2299, stackpage=3Df6241000)
> Stack: 00000000 00000000 f620d8d4 f637eec0 f61e4c00 f8b561a3 f637eef8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620d8c0 f637eec0 f62=
41ce4=20
>        f8b66f21 f637eec0 00015888 f61e4c00 00000000 f6241ce4 f637eec0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f637eef8 <_end+36015000/3849a158>
> >>edx; f637eef8 <_end+36015000/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f6241c5c <_end+35ed7d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f637edf8   ebx: 00000000   ecx: 00000000   edx: f637edf8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f651bc5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2302, stackpage=3Df651b000)
> Stack: 00000000 00000000 f620dc54 f637edc0 f6278800 f8b561a3 f637edf8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620dc40 f637edc0 f65=
1bce4=20
>        f8b66f21 f637edc0 00015888 f6278800 00000000 f651bce4 f637edc0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f637edf8 <_end+36014f00/3849a158>
> >>edx; f637edf8 <_end+36014f00/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f651bc5c <_end+361b1d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f637ecf8   ebx: 00000000   ecx: 00000000   edx: f637ecf8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6277c5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2303, stackpage=3Df6277000)
> Stack: 00000000 00000000 f620d854 f637ecc0 f74c8c00 f8b561a3 f637ecf8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620d840 f637ecc0 f62=
77ce4=20
>        f8b66f21 f637ecc0 00015888 f74c8c00 00000000 f6277ce4 f637ecc0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f637ecf8 <_end+36014e00/3849a158>
> >>edx; f637ecf8 <_end+36014e00/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f6277c5c <_end+35f0dd64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f637ebf8   ebx: 00000000   ecx: 00000000   edx: f637ebf8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f61d1c5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2304, stackpage=3Df61d1000)
> Stack: 00000000 00000000 f620dcd4 f637ebc0 f61d4000 f8b561a3 f637ebf8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620dcc0 f637ebc0 f61=
d1ce4=20
>        f8b66f21 f637ebc0 00015888 f61d4000 00000000 f61d1ce4 f637ebc0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f637ebf8 <_end+36014d00/3849a158>
> >>edx; f637ebf8 <_end+36014d00/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f61d1c5c <_end+35e67d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f637eaf8   ebx: 00000000   ecx: 00000000   edx: f637eaf8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f622fc5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2301, stackpage=3Df622f000)
> Stack: 00000000 00000000 f620d7d4 f637eac0 f61e7c00 f8b561a3 f637eaf8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620d7c0 f637eac0 f62=
2fce4=20
>        f8b66f21 f637eac0 00015888 f61e7c00 00000000 f622fce4 f637eac0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f637eaf8 <_end+36014c00/3849a158>
> >>edx; f637eaf8 <_end+36014c00/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f622fc5c <_end+35ec5d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f63845d8   ebx: 00000000   ecx: 00000000   edx: f63845d8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6265c5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2293, stackpage=3Df6265000)
> Stack: 00000000 00000000 f620ddd4 f63845a0 f6201c00 f8b561a3 f63845d8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620ddc0 f63845a0 f62=
65ce4=20
>        f8b66f21 f63845a0 00015888 f6201c00 00000000 f6265ce4 f63845a0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f63845d8 <_end+3601a6e0/3849a158>
> >>edx; f63845d8 <_end+3601a6e0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f6265c5c <_end+35efbd64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f6384ed8   ebx: 00000000   ecx: 00000000   edx: f6384ed8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6859c5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2278, stackpage=3Df6859000)
> Stack: 00000000 00000000 f650b4b4 f6384ea0 f621b400 f8b561a3 f6384ed8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f650b4a0 f6384ea0 f68=
59ce4=20
>        f8b66f21 f6384ea0 00015888 f621b400 00000000 f6859ce4 f6384ea0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f6384ed8 <_end+3601afe0/3849a158>
> >>edx; f6384ed8 <_end+3601afe0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f6859c5c <_end+364efd64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f6384cd8   ebx: 00000000   ecx: 00000000   edx: f6384cd8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f64efc5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2277, stackpage=3Df64ef000)
> Stack: 00000000 00000000 f73399d4 f6384ca0 f6214c00 f8b561a3 f6384cd8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f73399c0 f6384ca0 f64=
efce4=20
>        f8b66f21 f6384ca0 00015888 f6214c00 00000000 f64efce4 f6384ca0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f6384cd8 <_end+3601ade0/3849a158>
> >>edx; f6384cd8 <_end+3601ade0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f64efc5c <_end+36185d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f6384dd8   ebx: 00000000   ecx: 00000000   edx: f6384dd8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f627bc5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2287, stackpage=3Df627b000)
> Stack: 00000000 00000000 f6317174 f6384da0 f66d8000 f8b561a3 f6384dd8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f6317160 f6384da0 f62=
7bce4=20
>        f8b66f21 f6384da0 00015888 f66d8000 00000000 f627bce4 f6384da0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c010dda8>] [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f6384dd8 <_end+3601aee0/3849a158>
> >>edx; f6384dd8 <_end+3601aee0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f627bc5c <_end+35f11d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c010dda8 <call_do_IRQ+5/d>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f63847d8   ebx: 00000000   ecx: 00000000   edx: f63847d8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f628dc5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2281, stackpage=3Df628d000)
> Stack: 00000000 00000000 f620de54 f63847a0 f657a400 f8b561a3 f63847d8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620de40 f63847a0 f62=
8dce4=20
>        f8b66f21 f63847a0 00015888 f657a400 00000000 f628dce4 f63847a0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f63847d8 <_end+3601a8e0/3849a158>
> >>edx; f63847d8 <_end+3601a8e0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f628dc5c <_end+35f23d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f63849d8   ebx: 00000000   ecx: 00000000   edx: f63849d8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6275c5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2289, stackpage=3Df6275000)
> Stack: 00000000 00000000 f620df54 f63849a0 f66d8400 f8b561a3 f63849d8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620df40 f63849a0 f62=
75ce4=20
>        f8b66f21 f63849a0 00015888 f66d8400 00000000 f6275ce4 f63849a0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f63849d8 <_end+3601aae0/3849a158>
> >>edx; f63849d8 <_end+3601aae0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f6275c5c <_end+35f0bd64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f637e9f8   ebx: 00000000   ecx: 00000000   edx: f637e9f8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f61edc5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2305, stackpage=3Df61ed000)
> Stack: 00000000 00000000 f620dd54 f637e9c0 f7081800 f8b561a3 f637e9f8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620dd40 f637e9c0 f61=
edce4=20
>        f8b66f21 f637e9c0 00015888 f7081800 00000000 f61edce4 f637e9c0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f637e9f8 <_end+36014b00/3849a158>
> >>edx; f637e9f8 <_end+36014b00/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f61edc5c <_end+35e83d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f639a2b8   ebx: 00000000   ecx: 00000000   edx: f639a2b8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f627dc5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2286, stackpage=3Df627d000)
> Stack: 00000000 00000000 f63171f4 f639a280 f7b2a400 f8b561a3 f639a2b8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f63171e0 f639a280 f62=
7dce4=20
>        f8b66f21 f639a280 00015888 f7b2a400 00000000 f627dce4 f639a280 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c010dda8>] [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f639a2b8 <_end+360303c0/3849a158>
> >>edx; f639a2b8 <_end+360303c0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f627dc5c <_end+35f13d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c010dda8 <call_do_IRQ+5/d>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000008
> f8b410b7
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<f8b410b7>]    Not tainted
> EFLAGS: 00010296
> eax: f63843d8   ebx: 00000000   ecx: 00000000   edx: f63843d8
> esi: 00015888   edi: 00015888   ebp: f638c000   esp: f625fc5c
> ds: 0018   es: 0018   ss: 0018
> Process aplay (pid: 2294, stackpage=3Df625f000)
> Stack: 00000000 00000000 f620d9d4 f63843a0 f72ce000 f8b561a3 f63843d8 000=
15888=20
>        00000000 00000000 00000000 00000000 00000000 f620d9c0 f63843a0 f62=
5fce4=20
>        f8b66f21 f63843a0 00015888 f72ce000 00000000 f625fce4 f63843a0 f8b=
4b4e0=20
> Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4=
ed4a>]
>   [<c01563ff>] [<c0109627>]
> Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8=20
>=20
>=20
> >>EIP; f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>=20
> >>eax; f63843d8 <_end+3601a4e0/3849a158>
> >>edx; f63843d8 <_end+3601a4e0/3849a158>
> >>esi; 00015888 Before first symbol
> >>edi; 00015888 Before first symbol
> >>ebp; f638c000 <_end+36022108/3849a158>
> >>esp; f625fc5c <_end+35ef5d64/3849a158>
>=20
> Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> Trace; f8b66f21 <[snd-emu10k1]snd_emu10k1_playback_hw_params+51/c0>
> Trace; f8b4b4e0 <[snd-pcm]snd_pcm_hw_params+270/2b0>
> Trace; f8b4b594 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
> Trace; f8b4ed4a <[snd-pcm]snd_pcm_playback_ioctl1+5a/360>
> Trace; c01563ff <sys_ioctl+ef/2b0>
> Trace; c0109627 <system_call+33/38>
>=20
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 00000000 <_EIP>:
> Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>   <=3D=3D=3D=
=3D=3D
>    0:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)   <=3D=3D=3D=3D=
=3D
> Code;  f8b410be <[snd-page-alloc]snd_dma_alloc_pages+1e/e0>
>    7:   8b 02                     mov    (%edx),%eax
> Code;  f8b410c0 <[snd-page-alloc]snd_dma_alloc_pages+20/e0>
>    9:   83 f8 02                  cmp    $0x2,%eax
> Code;  f8b410c3 <[snd-page-alloc]snd_dma_alloc_pages+23/e0>
>    c:   0f 84 97 00 00 00         je     a9 <_EIP+0xa9>
> Code;  f8b410c9 <[snd-page-alloc]snd_dma_alloc_pages+29/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
>=20
>=20
> 3 warnings issued.  Results may not be reliable.
> On Wed, 2003-03-05 at 12:43, Erik Inge Bols=F8 wrote:
> > On Wed, 5 Mar 2003, alfp wrote:
> > >Also, dmesg gives me
> > >
> > >Unable to handle kernel NULL pointer dereference at virtual address 00=
000008
> > > printing eip:
> > >f8b410b7
> > >*pde =3D 00000000
> > >Oops: 0002
> > >CPU:    0
> > >EIP:    0010:[<f8b410b7>]    Not tainted
> > >EFLAGS: 00010296
> > >eax: f6384bd8   ebx: 00000000   ecx: 00000000   edx: f6384bd8
> > >esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6277c5c
> > >ds: 0018   es: 0018   ss: 0018
> > >Process aplay (pid: 2288, stackpage=3Df6277000)
> > >Stack: 00000000 00000000 f63170f4 f6384ba0 f754b800 f8b561a3 f6384bd8 =
00015888
> > >       00000000 00000000 00000000 00000000 00000000 f63170e0 f6384ba0 =
f6277ce4
> > >       f8b66f21 f6384ba0 00015888 f754b800 00000000 f6277ce4 f6384ba0 =
f8b4b4e0
> > >Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f=
8b4ed4a>]
> > >  [<c01b87b0>] [<c0129666>] [<c01563ff>] [<c0109627>]
> > >
> > >Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8
> > >
> > >(one for each crashed aplay)
> >=20
> > Install ksymoops, run "dmesg | ksymoops" to decode the oopsen, send the=
m
> > here so we can find out what's wrong. Could be alsa at fault, could be =
the
> > mandrake vendor kernel at fault. The first oops is usually the most
> > reliable.
> >=20
> > Download and compile ksymoops from
> > http://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/
> > if you can't find it in a mandrake rpm.
> >=20
> > --
> > Erik I. Bols=F8 | email: <knan at mo.himolde.no>
> > The UNIX philosophy basically involves giving you enough rope to
> > hang yourself.  And then a couple of feet more, just to be sure.
>=20




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
