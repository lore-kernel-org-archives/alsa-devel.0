From: R CHAN <rspchan@starhub.net.sg>
Subject: Re: Re: ALSA 1.0.0pre1 is released - intel8x0 is oopsing
 (2.6) - FIXED!
Date: Fri, 21 Nov 2003 10:50:28 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBD7D74.8040100@starhub.net.sg>
References: <s5hn0as1hvn.wl@alsa2.suse.de> <1069291828.485.28.camel@cmn37.stanford.edu> <3FBC70F5.3060706@starhub.net.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FBC70F5.3060706@starhub.net.sg>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: R CHAN <rspchan@starhub.net.sg>
Cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The oops has been fixed by the intel8x0 patch. Thanks.


/proc/asound/card0> cat ../cards
0 [I82801DBICH4   ]: ICH - Intel 82801DB-ICH4
                      Intel 82801DB-ICH4 at 0xdffffa00, irq 10

/proc/asound/card0> cat codec97#0/ac97#0-0
0-0/0: Realtek ALC202 rev 0

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

R CHAN wrote:
> Just tried ALSA CVS and 2.6.0-test9 current bk.
> CVS snd-intel8x0 is oopsing.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 
> 00000040
>  printing eip:
> e1a3a9e6
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<e1a3a9e6>]    Not tainted
> EFLAGS: 00010202
> EIP is at snd_intel8x0_mixer+0x2b6/0x400 [snd_intel8x0]
> eax: 00000020   ebx: dd8ecc00   ecx: 00000008   edx: 00000080
> esi: dc13f4c0   edi: 00000001   ebp: 00000020   esp: dc137c74
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 887, threadinfo=dc136000 task=dec572e0)
> Stack: dd8ecc00 00000080 e1a3f540 00000005 df678400 dda04a00 00000000 
> dd8ecc00
>        e1a3a710 00000000 c1549400 00000000 00000000 00000000 00000000 
> 00000000
>        00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 00000000
> Call Trace:
>  [<e1a3a710>] snd_intel8x0_mixer_free_ac97+0x0/0x20 [snd_intel8x0]
>  [<e1a3adc7>] snd_intel8x0_ich_chip_init+0x1d7/0x300 [snd_intel8x0]
>  [<e1a39290>] snd_intel8x0_codec_write+0x0/0xd0 [snd_intel8x0]
>  [<e1a39360>] snd_intel8x0_codec_read+0x0/0x110 [snd_intel8x0]
>  [<e1a3a700>] snd_intel8x0_mixer_free_ac97_bus+0x0/0x10 [snd_intel8x0]
>  [<e1a3bfea>] snd_intel8x0_probe+0x10a/0x280 [snd_intel8x0]
>  [<c016c531>] dput+0x31/0x220
>  [<c0202822>] pci_device_probe_static+0x52/0x70
>  [<c020287c>] __pci_device_probe+0x3c/0x50
>  [<c02028bc>] pci_device_probe+0x2c/0x50
>  [<c02428df>] bus_match+0x3f/0x70
>  [<c0242a0c>] driver_attach+0x5c/0xa0
>  [<c0242cd3>] bus_add_driver+0x93/0xb0
>  [<c024310f>] driver_register+0x2f/0x40
>  [<c0202aac>] pci_register_driver+0x5c/0x90
>  [<e195c013>] alsa_card_intel8x0_init+0x13/0x8e [snd_intel8x0]
>  [<c0135a09>] sys_init_module+0x119/0x230
>  [<c010b3d9>] sysenter_past_esp+0x52/0x71
> 
> Code: 0f b7 40 20 0f b6 84 83 c8 02 00 00 c0 e0 06 08 c1 eb cb 80
> 
> Anything else you need to know?
> 
> 
> Fernando Pablo Lopez-Lezcano wrote:
> 
>>> as you might have already seen on the web news page, we released
>>> 1.0.0pre1 tarball.  This is intended for the wide tests before the
>>> official 1.0.0 release.  We planned to release 1.0.0 (hopefully) in
>>> this month, so please everyone test this version and give bug reports
>>> now.
>>
>>
>>
>> Looks like somehow hdspmix and hdspconf did not make it to the
>> alsa-tools tarball (but they are there in CVS)....
>> -- Fernando
>>
>>
>>
>>
>> -------------------------------------------------------
>> This SF.net email is sponsored by: SF.net Giveback Program.
>> Does SourceForge.net help you be more productive?  Does it
>> help you create better code?  SHARE THE LOVE, and help us help
>> YOU!  Click Here: http://sourceforge.net/donate/
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
