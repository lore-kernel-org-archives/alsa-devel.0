From: Eran Guendelman <erang@stanford.edu>
Subject: Re: Got microphone working with SigmaTel STAC 9221 A1
 on a	Dell XPS M1210
Date: Sat, 16 Jun 2007 19:25:46 -0700
Message-ID: <46749BAA.6030900@stanford.edu>
References: <466B39A7.3000905@stanford.edu>	<s5hy7ipux89.wl%tiwai@suse.de>	<466F9373.5050106@stanford.edu>
	<s5hwsy8tb9i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from agp.stanford.edu (agp.Stanford.EDU [171.67.73.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 35E9A2435B
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jun 2007 04:25:24 +0200 (CEST)
In-Reply-To: <s5hwsy8tb9i.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 12 Jun 2007 23:49:23 -0700,
> Eran Guendelman wrote:
>>> So, we need to add a new model.  Could you give the output of "lspci
>>> -nv", too?  We need PCI SSID to identify the device.  Then I can write
>>> a patch to try.
>> 00:1b.0 Class 0403: 8086:27d8 (rev 01)
>>          Subsystem: 1028:01d7
>>          Flags: bus master, fast devsel, latency 0, IRQ 233
>>          Memory at efffc000 (64-bit, non-prefetchable) [size=16K]
>>          Capabilities: [50] Power Management version 2
>>          Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ 
>> Queue=0/0 Enable-
>>          Capabilities: [70] Express Unknown type IRQ 0
>>          Capabilities: [100] Virtual Channel
>>          Capabilities: [130] Unknown (5)
> 
> OK, looks fine.  Did you try my patch?

Sorry for the delayed reply...
Yup, just tried it out and it works.  Thanks.


>>>> - Does the snd_hda_intel driver currently (or will it eventually) 
>>>> support dynamic switching so I can switch from the Mic In to Line In or 
>>>> to Rear Speakers Out, etc, just like in the Windows driver?
>>> Hm?  It should have already the switches, "Line In As Output" and "Mic
>>> As Output"...
>> I did see those when I tried the 3stack mode, but in my current fix 
>> (modifying "ref" with my pin configs) I don't get such options in the 
>> mixer.  Any idea what I would need to do to get it to add these switches 
>> to the mixer?  This is the output from "amixer controls"
>>
>> numid=8,iface=MIXER,name='Master Playback Switch'
>> numid=7,iface=MIXER,name='Master Playback Volume'
>> numid=13,iface=MIXER,name='PCM Playback Volume'
>> numid=6,iface=MIXER,name='Front Playback Switch'
>> numid=5,iface=MIXER,name='Front Playback Volume'
>> numid=3,iface=MIXER,name='Capture Switch'
>> numid=2,iface=MIXER,name='Capture Volume'
>> numid=9,iface=MIXER,name='IEC958 Playback Con Mask'
>> numid=10,iface=MIXER,name='IEC958 Playback Pro Mask'
>> numid=11,iface=MIXER,name='IEC958 Playback Default'
>> numid=12,iface=MIXER,name='IEC958 Playback Switch'
>> numid=14,iface=MIXER,name='Digital Capture Volume'
>> numid=1,iface=MIXER,name='Input Source'
>> numid=4,iface=MIXER,name='Mux Capture Volume'
> 
> Could you show the kernel message regarding pin detections (appearing
> only when debug options is set)?
> The mic/line-in output switches appear only when
> 	- line_outs are less than 3 (usually 1)
> 	- line and mic (not fmic or fline) inputs are found
> 

Well, maybe the problem is that it detects an fmic and not a mic.  This 
is because all I did was take the pin configs from the Windows INI 
(which originally made 0x0c be a Line In at Ext Front), and changed it 
from a Line In to a Mic, making it a Mic at Ext Front...  I'm assuming 
this makes it an fmic instead of a mic...  I don't really understand 
what the big diff between front and non-front is, but the jacks on the 
laptop are certainly on the front of the laptop if it's at all related 
to that...

Actually, even if I made it a non-front mic, it will fail to find a Line 
In anyway because I've effectively replaced it by a Mic, no?  So the 
test for having mic/line-in output switches will fail...

Anyway, here's the debug output when loading the driver:

ALSA /home/erang/install/alsa-driver-1.0.14/pci/hda/hda_codec.c:1810: 
hda_codec: model 'dell' is selected
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 0a pin config 0221121e
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 0b pin config 408103ff
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 0c pin config 02a1123e
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 0d pin config 90100310
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 0e pin config 408003f1
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 0f pin config 0221122f
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 10 pin config 03451340
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 11 pin config 40c003f2
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 15 pin config 50a003f3
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:843: 
hda_codec: pin nid 1b pin config 405003f4
ALSA /home/erang/install/alsa-driver-1.0.14/pci/hda/hda_codec.c:2339: 
autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA /home/erang/install/alsa-driver-1.0.14/pci/hda/hda_codec.c:2343: 
  speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/erang/install/alsa-driver-1.0.14/pci/hda/hda_codec.c:2347: 
  hp_outs=2 (0xa/0xf/0x0/0x0/0x0)
ALSA /home/erang/install/alsa-driver-1.0.14/pci/hda/hda_codec.c:2355: 
  inputs: mic=0x0, fmic=0xc, line=0x0, fline=0x0, cd=0x0, aux=0x0
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1153: 
stac92xx_add_dyn_out_pins: total dac count=4
ALSA 
/home/erang/install/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1264: 
dac_nids=1 (0x2/0x0/0x0/0x0/0x0)
