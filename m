From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: A Restriction and rest of issues for this patchsets
Date: Sat, 26 Apr 2014 07:58:43 +0900
Message-ID: <535AE8A3.8030309@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

= A Restriction
Drivers with this patchset has a restriction comparing to windows drivers.

As long as reading manual of PreSonus/Focusrite/PrismSound, these BeBoB 
based devices may synchronize to the other BeBoB based devices on the 
same bus.

I guess this mechanism is driven by SYT in CIP packets:
  - Driver select a device as 'Sample clock source' then the other 
devices are 'Sample clock destination'.
  - Driver handle packets from 'Sample clock source' device.
  - Driver read SYT and calculate presentation timestamp for each 
devices, then transfer packets to the other devices.

If you're interested, please refer to IEC 61883-6:2005 (Edition 2.0). 
Actual examples are described in:
Annex D Transport characteristics
D.1.3 Embedded sample-clock jitter
D.1.3.2.1 Example one: simple two-node bus
D.1.3.2.2 Example two: three-node bus
D.1.3.2.3 Example: thirty-five-node system

Well, drivers with this patchset don't support this mechanism. The 
reason is bad balance between the const to implement below requirements 
and actual advantage to implement these:
  - Requirement to manage states of several devices simultaneously
  - Requirement to handle several streams from/to each device simultaneously
  - Requirement to calculate SYT with the length between host controller 
and each device

The drivers synchronized each devices independently. The drivers handle 
packets from a device and read SYT, then transfer packets with the SYT 
to the device.

= Rest of issues
Currently I focus on enabling ALSA to handle devices. So there are some 
issues which don't cause big problems.

1.Sorting packets
I know some Fireworks based devices sometimes transfer packets with 
disorder. But current implementation is a lack of sorting packets. The 
packets with disorder is detected as dicontinuity then streams are 
forced to stop and XRUN is generated. In this case, usual ALSA PCM 
applications may recover XRUN, so there may be some XRUNS to start 
straems successfully.
I need more time to investigate frequency and pattern of this issue. 
Near future I want to discuss this issue again with enough data.

2.Data rate for MIDI substream
With current implementation, the maximum data rate for MIDI substream in 
out-stream is one eighth of sampling rate. For example, at 48.0kHz, it's 
6,000 bytes. This is excess over standard MIDI data rate, 3,125 bits per 
second. So a few devices can have buffer over flow when receiving much 
MIDI messages. For example, M-Audio Firewire 1814 transmits packets with 
discontinuity in this case. I guess that Fireworks based devices and 
some BeBoB based devices ignore MIDI messages in more than 8 data blocks 
of packets and this is vendor's effort for this issue.
Drivers need a throttle for this issue but this is for future work.

3.Latency
Currently, the minumum number of frames per period is not less than 
5msec. Drivers has a flag, SNDRV_PCM_INFO_BATCH and the minimum number 
of periods in buffer is 2. As a result, its minimum latency is 10msec. 
For more severe latency, further work is needed. But I feel this is not 
so higher priority than other issues because actually devices are available.

4.A few devices are freezed when frequent establishing/breaking connections
One of testers reported this issue. 'PreSonus FP10' can be freezed when 
frequent establishing/breaking connections. This brings a disadvantage 
to PulseAudio. When PulseAudio detects the card, it starts/stops 4 
streams at least. If PulseAudio can detect devices with some hacks, it 
may take the device freezed.

5.Various results at bus reset
I confirm various results with Fireworks/BeBoB and its devices at bus 
reset during streaming, depending on cases.
Case 1. Software do bus reset
When generating bus reset with ffado-test or jujuutils, streaming 
stopped. When generating bus reset, the drivers update connections 
according to IEC 61883-1. But after a few hundred msec, the device break 
connections by itself. I don't know the reason exactly but I guess the 
synchronizing mechanism I describe have some relations.
Case 2. Connecting devices or removing devices
This case depends on which devices are connected or removed. If they're 
Fireworks/BeBoB based devices, streaming sometimes continues and 
sometimes stops. If they're not Fireworks/BeBoB based device, streaming 
continues. I don't know the reason exactly but I guess the synchronizing 
mechanism I describe have some relations.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
