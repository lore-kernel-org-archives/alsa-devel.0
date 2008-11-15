From: "Andrei Tanas" <andrei@tanas.ca>
Subject: Re: Fwd: Undelivered Mail Returned to Sender
Date: Sat, 15 Nov 2008 17:22:43 -0500
Message-ID: <002f01c94770$adeba2a0$09c2e7e0$@ca>
References: <6d799ca1be9af898f664f82ade06d669@localhost>
	<20081115002724.GA5073@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id CC7A7103817
	for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2008 23:22:34 +0100 (CET)
In-Reply-To: <20081115002724.GA5073@mail.ustc.edu.cn>
Content-Language: en-ca
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Fengguang Wu' <fengguang.wu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> >> And here's "cat /proc/asound/card0/codec#0"
>> > 
>> > This is the regular codec.
>> > Are there /proc/asound/card0/codec#{1,2,3}?
>> 
>> There was only one.
>> 
>> > The HDMI codec would look like this one:
>> > % cat /proc/asound/card0/codec\#3

>>  
>> 
>> I saw nothing like that.

>> Does your main board have an external physical HDMI interface?
>> If true, then there is an ALSA bug.

Yes, there's physical HDMI port on the card, which, according to the
documentation, supports both video and audio.
However, there's also "SPDIF OUT Mode Setting" in the BIOS allowing to
choose between "HDMI Output" or "SPDIF Output", suggesting that only one can
be used at a time. The description is not terribly clear though.

>> Will it help to enable SND_VERBOSE_PRINTK and SND_DEBUG?

> Sure it could help, and be sure to use the latest sound-2.6 git tree :-)

Ok, I've done this.
Here's "aplay -l"

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC1200 Analog [ALC1200 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC1200 Digital [ALC1200 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


And here's "dmesg"

[    8.513848] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) ->
IRQ 22
[    8.514001] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    8.514005] ALSA sound/pci/hda/hda_intel.c:2187: chipset global
capabilities = 0x4401
[    8.543345] ALSA sound/pci/hda/hda_intel.c:779: codec_mask = 0x3
[    8.543487] ALSA sound/pci/hda/hda_intel.c:1206: hda_intel: codec #0
probed OK
[    8.545462] ALSA sound/pci/hda/hda_codec.c:2587: hda_codec: model
'6stack-dig' is selected

[    8.574845] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Headphone Playback Volume, skipped
[    8.574947] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Speaker Playback Volume, skipped
[    8.575043] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave Mono
Playback Volume, skipped
[    8.575135] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Line-Out Playback Volume, skipped
[    8.575231] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave PCM
Playback Volume, skipped
[    8.575337] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Speaker Playback Switch, skipped
[    8.575435] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave Mono
Playback Switch, skipped

[  105.312682] ALSA sound/pci/hda/hda_codec.c:853: hda_codec_cleanup_stream:
NID=0x6
[  106.707933] ALSA sound/pci/hda/hda_intel.c:1464: azx_pcm_prepare:
bufsize=0x10000, format=0x11
[  106.707951] ALSA sound/pci/hda/hda_codec.c:841: hda_codec_setup_stream:
NID=0x6, stream=0x5, channel=0, format=0x11
..........
[  110.479724] ALSA sound/pci/hda/hda_intel.c:1464: azx_pcm_prepare:
bufsize=0x10000, format=0x11
[  110.479740] ALSA sound/pci/hda/hda_codec.c:841: hda_codec_setup_stream:
NID=0x6, stream=0x5, channel=0, format=0x11
[  200.715073] ALSA sound/pci/hda/hda_codec.c:853: hda_codec_cleanup_stream:
NID=0x6
