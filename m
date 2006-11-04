From: alsa@nymar.demon.co.uk
Subject: Re: Conexant test code.
Date: Sat, 04 Nov 2006 17:56:33 +0000
Message-ID: <E1GgPkv-000Fnr-72@pr-webmail-2.demon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Here's test release 8. 

Another Oops on loading under Toshiba P100

> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> f883ba12
> *pde = 00000000
> Oops: 0002 [#1]
> SMP
> Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device ieee80211_crypt_wep fuse vmnet vmmon nvidiafb nvidia ipw3945 ieee80211 ieee80211_crypt e1000 snd_hda_intel snd_hda_codec snd_pcm snd_timer snd snd_page_allocCPU:    0
> EIP:    0060:[<f883ba12>]    Tainted: P      VLI
> EFLAGS: 00010282   (2.6.18-gentoo-r1 #5)
> EIP is at snd_info_register+0xbd/0xce [snd]
> eax: f473a358   ebx: f4069754   ecx: 00000000   edx: f406979c
> esi: f88463d6   edi: f473a2f0   ebp: f2737ed0   esp: f2737e34
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 9069, ti=f2736000 task=c229d030 task.ti=f2736000)
> Stack: f4069754 f473a214 f8eb237a 00000001 c02f9825 f2737ea8 00000082 c200c260
>        002dc6c0 00000001 dff08a90 6dcb5280 0000005d 00000000 c229d144 c200c260
>        002dc6c0 00000000 dffad560 f2737e90 c0110d91 6dcb5280 6dcb5280 00000282
> Call Trace:
>  [<f8eb237a>] snd_pcm_oss_register_minor+0x105/0x131 [snd_pcm_oss]
>  [<c02f9825>] schedule+0x699/0x73d
>  [<c0110d91>] __activate_task+0x1c/0x29
>  [<c0111f27>] try_to_wake_up+0x2ed/0x2f7
>  [<c0112e90>] __cond_resched+0x16/0x34
>  [<c02f98f3>] cond_resched+0x2a/0x31
>  [<c02f9928>] wait_for_completion+0x18/0xa2
>  [<f885c316>] snd_pcm_notify+0xb4/0xd3 [snd_pcm]
>  [<f884e078>] alsa_pcm_oss_init+0x78/0x86 [snd_pcm_oss]
>  [<c012e3fa>] sys_init_module+0x1574/0x16fb
>  [<c014ab4a>] vfs_read+0x81/0x123
>  [<c0102805>] sysenter_past_esp+0x56/0x79
> Code: 08 89 5a 3c 89 c1 c1 f9 1f 89 42 18 89 4a 1c 8b 43 18 89 53 2c 85 c0 74 > 14 83 c0 40 8b 48 04 8d
> 53 48 89 50 04 89 43 48 89 4a 04 <89> 11 b8 60 42 84 f8 e8 3a e7 ab c7 31 c0 5b 5e c3 8b 40 14 e9
> EIP: [<f883ba12>] snd_info_register+0xbd/0xce [snd] SS:ESP 0068:f2737e34


This time I did remember the "model=test" parameter. That crashed loading the OSS compatibility module

> # /etc/init.d/mpd start
>  * Loading ALSA modules ...
>  *   Loading: snd-card-0 ...                            [ ok ]
>  *   Loading: snd-seq-oss ...                           [ ok ]
>  *   Loading: snd-mixer-oss ...                         [ ok ]
>  *   Loading: snd-pcm-oss ...
> /etc/init.d/alsasound: line 91:  9344 Segmentation fault      /sbin/modprobe ${DRIVER}
                                                    [ !! ]
I'm busy rebuilding mpd without oss support to see if I the patch works without it

Make/Model etc:

Toshiba P100-240 (pspa3e) - Gentoo Linux

> # lspci -s 0:1b -vn
> 00:1b.0 0403: 8086:27d8 (rev 02)
>         Subsystem: 1179:ff31
>         Flags: bus master, fast devsel, latency 0, IRQ 21
>         Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>         Capabilities: [70] Express Unknown type IRQ 0
>         Capabilities: [100] Virtual Channel
>         Capabilities: [130] Unknown (5)

"cat /proc/asound/card0/codec#0" appears to have hung my command shell, and I think the desktop is going to crash soon. I can give the results under vanilla alsa-drivers if that helps. But first I want to post this before everything crashes


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
