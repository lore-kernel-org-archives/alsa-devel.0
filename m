From: Raymond <rayau@netvigator.com>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Fri, 16 Sep 2005 22:16:25 +0800
Message-ID: <432AD3B9.8010200@netvigator.com>
References: <4317CC51.3040709@netvigator.com>	 <200509042134.23916.alien999999999@users.sourceforge.net>	 <1126131309.17399.8.camel@pc-erik.lan>	 <44272.62.59.249.250.1126163238.squirrel@62.59.249.250> <1126668747.6835.11.camel@pc-erik.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1126668747.6835.11.camel@pc-erik.lan>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik <assie2@zonnet.nl>
Cc: alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

  Erik Wrote:
> ok here it is.
>
> [root@pc-erik assie]# cat /proc/asound/au8830/codec97#0/ac97#0-0+regs
> 0:00 = 6940
> 0:02 = 0202
> 0:04 = 0707
> 0:06 = 0007
> 0:08 = 0000
> 0:0a = 0006
> 0:0c = 0007
> 0:0e = 0040
> 0:10 = 0707
> 0:12 = 0707
> 0:14 = 0707
> 0:16 = 0707
> 0:18 = 1d1d
> 0:1a = 0000
> 0:1c = 0a0a
> 0:1e = 0000
> 0:20 = 2000
> 0:22 = 000f
> 0:24 = 0000
> 0:26 = 800f
> 0:28 = 0080
> 0:2a = 0080
> 0:2c = 0000
> 0:2e = 0000
> 0:30 = 0000
> 0:32 = 0000
> 0:34 = 0000
> 0:36 = 0000
> 0:38 = 0404
> 0:3a = 0000
> 0:3c = 0000
> 0:3e = 0000
> 0:40 = 0000
> 0:42 = 0000
> 0:44 = 0000
> 0:46 = 0000
> 0:48 = 0000
> 0:4a = 0000
> 0:4c = 0000
> 0:4e = 0000
> 0:50 = 0000
> 0:52 = 0000
> 0:54 = 0000
> 0:56 = 0000
> 0:58 = 0000
> 0:5a = 0000
> 0:5c = 0000
> 0:5e = 0000
> 0:60 = 0000
> 0:62 = 0000
> 0:64 = 0000
> 0:66 = 0000
> 0:68 = 0000
> 0:6a = 0000
> 0:6c = 0000
> 0:6e = 000c
> 0:70 = 0000
> 0:72 = 0017
> 0:74 = 0380
> 0:76 = abba
> 0:78 = 9380
> 0:7a = 0000
> 0:7c = 8384
> 0:7e = 7608
>
>
>
> 02:08.0 Class 0401: 12eb:0002 (rev fe)
>         Subsystem: 1092:3001
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (1000ns min, 3000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 209
>         Region 0: Memory at 00000000fa000000 (32-bit, non-prefetchable)
> [size=256K]
>         Region 1: I/O ports at b000 [size=8]
>         Region 2: I/O ports at b400 [size=8]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>
>
> On Wed, 2005-09-14 at 12:42 +0800, Raymond wrote:
> > Erik wrote:
> > > yup i have the first problem
> > >  1. the ones where if you get 49% it's loud and on 51% quite 
silently?
> > >
> > > but then from 51 to 100% is again soft to loud .
> > >
> > > next week i can find time to recompile the whole kernel
> > >

Have your try this switch in alsamixer ?

Simple mixer control 'Sigmatel Output Bias',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]

Do this patch fix your problem ?

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/ac97/ac97_codec.c?r1=1.189&r2=1.190

If the above don't work

 >>> Try the following patch to log the read/write of ac97 and post the
 >>> system log using dmesg. (loading au8830 and alsactl restore)
 >>>
 >>>
 >>> alsa-driver-1.0.9b/alsa-kernel/pci/au88x0/au88x0_core.c
 >>> @@ -2520,6 +2515,7 @@
 >>>     vortex_t *card = (vortex_t *) codec->private_data;
 >>>     unsigned int lifeboat = 0;
 >>>
 >>> +    printk(KERN_INFO "ac97 write %.2x : %.4x\n",addr,data);
 >>>     /* wait for transactions to clear */
 >>>     while (!(hwread(card->mmio, VORTEX_CODEC_CTRL) & 0x100)) {
 >>>         udelay(100);
 >>> @@ -2567,6 +2563,7 @@
 >>>         }
 >>>     } while ((data & VORTEX_CODEC_ADDMASK) !=
 >>>          (addr << VORTEX_CODEC_ADDSHIFT));
 >>> +    printk(KERN_INFO "ac97 read  %.2x : %.4x\n",addr,data &
 >>> VORTEX_CODEC_DATMASK);
 >>>
 >>>     /* return data. */
 >>>     return (u16) (data & VORTEX_CODEC_DATMASK);
 >>>
 >>






-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
