From: Raymond <rayau@netvigator.com>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]:   errors when
 installing au8820 modules
Date: Sat, 02 Jul 2005 20:53:39 +0800
Message-ID: <42C68E53.4050406@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de>	<42A5D3C8.1030903@mail.ru> <42A6E5BE.4030003@netvigator.com>	<42A73305.9000000@mail.ru> <42C1015E.9010201@netvigator.com> <42C5936C.3020305@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42C5936C.3020305@mail.ru>
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
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Igor Kovalenko wrote:
> Raymond wrote:
> 
>>Igor Kovalenko wrote:
>>
>>>Raymond wrote:
>>>
>>>>Igor Kovalenko wrote:
>>>>
>>>>
>>>>>Well, I've not stated the problem clearly enough.
>>>>>Once set, volume stays as it should. The problem is that
>>>>>PCM volume is:
>>>>>1% - at lowest audible level
>>>>>25% - at about 50% audible level
>>>>>49% - at about max audible level
>>>>>51% - at lowest audible level
>>>>>75% - at about 50% audible level
>>>>>99% - at about max audible level
>>>>>- that is what I described as low-high-low-high.
>>>>>On the other hand, Master volume behaves as expected.
>>>>
>>>>
>>>>
>>>>What is the value of comment.range of 'PCM Playback Volume' in
>>>>/etc/asound.state for your STAC9704 (au8820) ?
>>>>
>>>>
>>>>According to 9704SPEC.pdf, it should be '0-31' ( 5 bits ) for STAC9704
>>>>PCM Out volume.
>>>>
>>>
>>>
>>>        control.21 {
>>>                comment.access 'read write'
>>>                comment.type INTEGER
>>>                comment.count 2
>>>                comment.range '0 - 63'
>>>                iface MIXER
>>>                name 'PCM Playback Volume'
>>>                value.0 21
>>>                value.1 21
>>>        }
>>>
>>>Do you mean AC97 is incorrectly reporting 0...63 range?
>>>
>>>
>>
>>Try the following patch to log the read/write of ac97 and post the
>>system log using dmesg. (loading au8820 and alsactl restore)
>>
>>
>>alsa-driver-1.0.9b/alsa-kernel/pci/au88x0/au88x0_core.c
>>@@ -2520,6 +2515,7 @@
>>     vortex_t *card = (vortex_t *) codec->private_data;
>>     unsigned int lifeboat = 0;
>>
>>+    printk(KERN_INFO "ac97 write %.2x : %.4x\n",addr,data);
>>     /* wait for transactions to clear */
>>     while (!(hwread(card->mmio, VORTEX_CODEC_CTRL) & 0x100)) {
>>         udelay(100);
>>@@ -2567,6 +2563,7 @@
>>         }
>>     } while ((data & VORTEX_CODEC_ADDMASK) !=
>>          (addr << VORTEX_CODEC_ADDSHIFT));
>>+    printk(KERN_INFO "ac97 read  %.2x : %.4x\n",addr,data &
>>VORTEX_CODEC_DATMASK);
>>
>>     /* return data. */
>>     return (u16) (data & VORTEX_CODEC_DATMASK);
>>
> 
> 
> Here is the dmesg excerpt:
> 
> Vortex: shutdown...<6>done.
> ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 185
> Vortex: init.... <6>done.
> ac97 read  7c : 8384
> ac97 read  7e : 7605
> ac97 write 00 : 0000
> ac97 read  00 : 6940
> ac97 read  7c : 8384
> ac97 read  7e : 7605
> ac97 write 1c : 8a05
> ac97 read  1c : 8a05
> ac97 read  7c : 8384
> ac97 read  7e : 7605
> ac97 write 1c : 8a06
> ac97 read  1c : 8a06
> ac97 read  00 : 6940
> ac97 read  28 : 0000
> ac97 write 26 : 0000
> ac97 write 00 : 0000
> ac97 write 26 : 0000
> ac97 write 20 : 0000
> ac97 read  26 : 000f
> ac97 read  02 : 8000
> ac97 read  02 : 8000
> ac97 write 02 : 0000
> ac97 read  02 : 0000
> ac97 write 02 : 8000
> ac97 read  02 : 8000
> ac97 write 02 : 8000
> ac97 write 02 : a0a0
> ac97 read  02 : 9f9f
> ac97 write 02 : 9090
> ac97 read  02 : 9090
> ac97 read  02 : 9010
> ac97 write 02 : 9f1f
> ac97 read  06 : 9f00
> ac97 read  06 : 8000
> ac97 write 06 : 0000
> ac97 read  06 : 0000
> ac97 write 06 : 8000
> ac97 read  06 : 8000
> ac97 write 06 : 8000
> ac97 write 06 : a0a0
> ac97 read  06 : a09f
> ac97 write 06 : 9090
> ac97 read  06 : 9090
> ac97 read  06 : 8010
> ac97 write 06 : bf1f
> ac97 read  0a : 0000
> ac97 write 0a : 8000
> ac97 read  0a : 8000
> ac97 read  0a : 8000
> ac97 write 0a : 801e
> ac97 read  0c : 8008
> ac97 read  0c : 8008
> ac97 write 0c : 0008
> ac97 read  0c : 0008
> ac97 write 0c : 8008
> ac97 read  0c : 8008
> ac97 write 0c : 8008
> ac97 write 0c : a0a0
> ac97 read  0c : 8000
> ac97 write 0c : 9090
> ac97 read  0c : 8010
> ac97 write 0c : 8181
> ac97 read  0c : 8001
> ac97 read  0c : 8001
> ac97 write 0c : 801f
> ac97 read  0e : 8008
> ac97 read  0e : 8008
> ac97 write 0e : 0008
> ac97 read  0e : 0008
> ac97 write 0e : 8008
> ac97 read  0e : 8008
> ac97 write 0e : 8008
> ac97 write 0e : a0a0
> ac97 read  0e : a0a0
> ac97 read  0e : 8000
> ac97 write 0e : bf3f
> ac97 read  10 : a828
> ac97 read  10 : 8808
> ac97 write 10 : 0808
> ac97 read  10 : 0808
> ac97 write 10 : 8808
> ac97 read  10 : 8808
> ac97 write 10 : 8808
> ac97 write 10 : a0a0
> ac97 read  10 : a0a0
> ac97 read  10 : 8000
> ac97 write 10 : bf3f
> ac97 read  12 : a828
> ac97 read  12 : 8808
> ac97 write 12 : 0808
> ac97 read  12 : 0808
> ac97 write 12 : 8808
> ac97 read  12 : 8808
> ac97 write 12 : 8808
> ac97 write 12 : a0a0
> ac97 read  12 : a0a0
> ac97 read  12 : 8000
> ac97 write 12 : bf3f
> ac97 read  14 : a828
> ac97 read  14 : 8808
> ac97 write 14 : 0808
> ac97 read  14 : 0808
> ac97 write 14 : 8808
> ac97 read  14 : 8808
> ac97 write 14 : 8808
> ac97 write 14 : a0a0
> ac97 read  14 : a0a0
> ac97 read  14 : 8000
> ac97 write 14 : bf3f
> ac97 read  16 : a828
> ac97 read  16 : 8808
> ac97 write 16 : 0808
> ac97 read  16 : 0808
> ac97 write 16 : 8808
> ac97 read  16 : 8808
> ac97 write 16 : 8808
> ac97 write 16 : a0a0
> ac97 read  16 : a0a0
> ac97 read  16 : 8000
> ac97 write 16 : bf3f
> ac97 read  18 : 8808
> ac97 write 18 : 0808
> ac97 read  18 : 0808
> ac97 write 18 : 8808
> ac97 read  18 : 8808
> ac97 write 18 : 8808
> ac97 write 18 : a0a0
> ac97 read  18 : a0a0
> ac97 read  18 : 8000
> ac97 write 18 : bf3f
> ac97 read  1c : b030
> ac97 write 1c : 3030
> ac97 read  1c : 3030
> ac97 write 1c : b030
> ac97 read  1c : b030
> ac97 write 1c : b030
> ac97 write 1a : 0000
> ac97 write 1c : 0000
> ac97 read  20 : 0000
> ac97 write 20 : 8000
> ac97 read  20 : 8000
> ac97 write 20 : 0000
> ac97 read  20 : 0000
> ac97 write 20 : 2000
> ac97 read  20 : 2000
> ac97 write 20 : 0000
> ac97 read  20 : 0000
> ac97 write 20 : 0200
> ac97 read  20 : 0200
> ac97 write 20 : 0000
> ac97 read  20 : 0000
> ac97 write 20 : 0100
> ac97 read  20 : 0100
> ac97 write 20 : 0000
> ac97 read  22 : 0000
> ac97 write 22 : 0707
> ac97 read  22 : 0707
> ac97 write 22 : 0000
> ac97 read  26 : 000f
> ac97 write 26 : 800f
> ac97 read  26 : 800f
> ac97 write 26 : 000f
> ac97 read  2a : ffff
> ac97 write 2a : ffff
> ac97 write 02 : 1f1f
> ac97 write 02 : 1313
> ac97 write 12 : 3f3f
> ac97 write 12 : 3434
> ac97 write 18 : 3f3f
> ac97 write 18 : 2828
> ac97 write 20 : 0200
> ac97 write 22 : 0400
> ac97 write 22 : 0402
> ac97 write 26 : 800f
> 

Since there is no error message "vortex: ac97 codec stuck busy" or
"vortex: ac97 address never arrived" appear in your system log.

It seem to me that your problem is due to the routine
check_volume_resolution() do not take care of the difference between
STAC9704 (AC97 2.0) and AC97 2.1 Specification. ( "reserved bits are
don't care upon read back" in AC97 2.0 and "reserved bits must return 0
upon read back" in AC97 2.1)

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/ac97/ac97_codec.c?r1=1.163&r2=1.164

You will need to open another bug report with category "AC97" in ALSA
Bug Tracking System.


STAC9704 specification

1) All registers not shown and bits contain an X are resserved.
2) Any reserved bits, marked X, can be written to but are don't care
upon read back.

AC97 2.1 specification

1) Italian underline indicate optional feature registers or optional
bits within a register. Whether implemented or not, these may be written
to but must return 0 if there is no support for this feature.
2) Any reserved bits, marked X, can be written to but must return 0 on
read back.


Master Volume

ac97 read  02 : 8000
ac97 read  02 : 8000
ac97 write 02 : 0000
ac97 read  02 : 0000
ac97 write 02 : 8000
ac97 read  02 : 8000
ac97 write 02 : 8000
ac97 write 02 : a0a0
ac97 read  02 : 9f9f
ac97 write 02 : 9090
ac97 read  02 : 9090
ac97 read  02 : 9010
ac97 write 02 : 9f1f  ( 5-bits )

Master Volume Mono

ac97 read  06 : 9f00
ac97 read  06 : 8000
ac97 write 06 : 0000
ac97 read  06 : 0000
ac97 write 06 : 8000
ac97 read  06 : 8000
ac97 write 06 : 8000
ac97 write 06 : a0a0
ac97 read  06 : a09f <--- ???
ac97 write 06 : 9090
ac97 read  06 : 9090
ac97 read  06 : 8010
ac97 write 06 : bf1f ( 6-bits )

Mic Volume

ac97 read  0e : 8008
ac97 read  0e : 8008
ac97 write 0e : 0008
ac97 read  0e : 0008
ac97 write 0e : 8008
ac97 read  0e : 8008
ac97 write 0e : 8008
ac97 write 0e : a0a0
ac97 read  0e : a0a0 <--- ???
ac97 read  0e : 8000
ac97 write 0e : bf3f ( 6-bits )

CD Volume

ac97 read  12 : a828
ac97 read  12 : 8808
ac97 write 12 : 0808
ac97 read  12 : 0808
ac97 write 12 : 8808
ac97 read  12 : 8808
ac97 write 12 : 8808
ac97 write 12 : a0a0
ac97 read  12 : a0a0  <--- ???
ac97 read  12 : 8000
ac97 write 12 : bf3f ( 6-bits )

PCM Volume

ac97 read  18 : 8808
ac97 write 18 : 0808
ac97 read  18 : 0808
ac97 write 18 : 8808
ac97 read  18 : 8808
ac97 write 18 : 8808
ac97 write 18 : a0a0
ac97 read  18 : a0a0 <--- ???
ac97 read  18 : 8000
ac97 write 18 : bf3f ( 6-bits )

Record Gain

ac97 read  1c : b030 <--- ???
ac97 write 1c : 3030 <--- ???
ac97 read  1c : 3030 <--- ???
ac97 write 1c : b030 <--- ???
ac97 read  1c : b030 <--- ???
ac97 write 1c : b030 <--- ???



alsactl restore

ac97 write 02 : 1f1f
ac97 write 02 : 1313
ac97 write 12 : 3f3f  <--- ???
ac97 write 12 : 3434  <--- ???
ac97 write 18 : 3f3f  <--- ???
ac97 write 18 : 2828  <--- ???
ac97 write 20 : 0200
ac97 write 22 : 0400
ac97 write 22 : 0402
ac97 write 26 : 800f















-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
