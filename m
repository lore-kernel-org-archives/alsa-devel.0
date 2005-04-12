From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Tue, 12 Apr 2005 22:14:06 +0800
Message-ID: <425BD7AE.20104@netvigator.com>
References: <424A5D7D.2070400@netvigator.com> <Pine.HPX.4.33n.0503301007400.20197-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0503301007400.20197-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


How do I find out where the problem is (segment fault when loading 
soundfont) ?


Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
00000000
*pde = 00000000
Oops: 0000
snd-pcm-oss snd-mixer-oss snd-seq-midi snd-au8830-synth
snd-seq-midi-emul snd-hwdep snd-seq-virmidi snd-seq-midi-event snd-seq
snd-intel8x0 snd-au8830 snd-uti
CPU:    0
EIP:    0060:[<00000000>]    Tainted: P
EFLAGS: 00010202

EIP is at [unresolved] (2.4.22-1.2199.nptl)
eax: da711280   ebx: d34c9a00   ecx: df450800   edx: 00008f88
esi: 00011f10   edi: dc96defc   ebp: d34c9b00   esp: dc96dec4
ds: 0068   es: 0068   ss: 0068
Process asfxload (pid: 7569, stackpage=dc96d000)
Stack: e1f1df3a da711280 d34c9a00 db4d6b80 084b5f80 00011f10 00000000
00000000
        00008f68 00006190 00008f60 00008f88 00000000 00000000 084b5f60
ffffffea
        dc96df34 00000000 e1f1d22c df450800 084b5f60 00011f30 00000011
00000000
Call Trace:   [<e1f1df3a>] load_data [snd-au8830-synth] 0x16a (0xdc96dec4)
[<e1f1d22c>] snd_soundfont_load [snd-au8830-synth] 0x14c (0xdc96df0c)
[<e1f20886>] snd_vortex_hwdep_load_patch [snd-au8830-synth] 0x96
(0xdc96df44)
[<e1f20960>] snd_vortex_hwdep_ioctl [snd-au8830-synth] 0x0 (0xdc96df6c)
[<e1f17755>] snd_hwdep_ioctl [snd-hwdep] 0x65 (0xdc96df78)
[<c0153719>] sys_ioctl [kernel] 0xc9 (0xdc96df94)
[<c010dad4>] syscall_trace [kernel] 0x54 (0xdc96dfac)
[<c01097b3>] tracesys [kernel] 0x1f (0xdc96dfc0)


Code:  Bad EIP value.




Manuel Jander wrote:
> Raymond wrote:
>
>>http://www.alsa-project.org/~frank/alsa-sequencer/node12.html
>>
>>The midi port only need to support 16 voices, the 16 sample rate
>>convertors are just enough to produce 16 voices using the mono sound
>>samples in the soundfonts au30gm.arl
>
>
> Yes, but the ADB engine is intended for normal wave playback. The WT
> engine is more suited  for Wavetable stuff. It also has some envelope
> filters and such for effects. With only 16  voices, you will run out of
> them pretty fast (overlapping notes).
>
Only enough for solo of single instrument and no reverb/chrous effect
when using ADB.

Some of the "pitch-shift" rates of the sample seem to be outside the
5000Hz-48000Hz range of hw:0,0

How can I play the soundfont sample loaded in memory through hw:0,0 in
snd-au8830-synth and bypass the 5000Hz-48000Hz range ?

>
>
>>The current alsa driver do not even use the timer VORTEX_SMP_TIME or
>>timer interrupt VORTEX_SMP_TIMER
>>
>>3) Is there any way to find out the resolution of the timer ?
>
>
> Yes. Measuring it :)
>

The clock VORTEX_SMP_TIME seem to tick at 12.288Mhz (256 * 48000Hz)
which is one-quarter of the 49.152Mhz oscillator on all the vortex
sound cards.

Is there any way to disable the loading of the ALSA and au88x0 during
boot if some fatal bug occur when testing the timer interrupt
VORTEX_SMP_TIMER ?























-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
