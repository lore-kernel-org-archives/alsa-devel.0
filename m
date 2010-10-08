From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Fri, 08 Oct 2010 15:05:39 +0100
Message-ID: <4CAF2533.1060102@colin.guthr.ie>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>	<4CA5A38A.7050006@ladisch.de>	<i8ce5u$fj3$1@dough.gmane.org>	<4CAD7F3D.3090205@ladisch.de>
	<4CAF1AF2.3060907@colin.guthr.ie> <4CAF1FA3.5000402@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id CF199103877
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 16:05:49 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P4Da1-00064A-Hy
	for alsa-devel@alsa-project.org; Fri, 08 Oct 2010 16:05:49 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2010 16:05:49 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2010 16:05:49 +0200
In-Reply-To: <4CAF1FA3.5000402@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Clemens Ladisch at 08/10/10 14:41 did gyre and gimble:
> Colin Guthrie wrote:
>> 'Twas brillig, and Clemens Ladisch at 07/10/10 09:05 did gyre and gimble:
>>> Please try this patch.
>>>
>>> +++ b/sound/pci/hda/patch_sigmatel.c
>>> ...
>>
>> Seemed to do something. Now, rather than printing -46.5dB then the
>> Master slider is down at 0, it prints "mute".
>>
>> Is this the extent of the fix? i.e. to correctly report that the bottom
>> value is muted?
> 
> Yes.

Cool.

>> If so, then is there a way to tell this via an API so that I can tell PA
>> to not control the slider down to it's 0 value in order to avoid the
>> auto mute?
> 
> Alsamixer uses the standard dB information that should also be used by PA.

I think something in there is busted, but it's likely at the PA end.

This is the debug from a volume that is ultimately less than the min dB
(i.e. ~50dB or there about - certainly more attenuation than -46.5dB) (I
should really make it so it prints the dB volume here too)

D: alsa-sink.c: Requested volume: 0:  13% 1:  13%
D: alsa-sink.c: Got hardware volume: 0:   0% 1:   0%
D: alsa-sink.c: Calculated software volume: 0:   0% 1:   0%
(accurate-enough=no)

And here is something for ~40dB:

D: alsa-sink.c: Requested volume: 0:  19% 1:  19%
D: alsa-sink.c: Got hardware volume: 0:  19% 1:  19%
D: alsa-sink.c: Calculated software volume: 0:  99% 1:  99%
(accurate-enough=yes)

In this case the accurate-enough checks succeed vs before when they fail.


D: alsa-mixer.c: Activating path analog-output
D: alsa-mixer.c: Path analog-output (Analog Output), direction=1,
priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
has_dB=yes, min_volume=0, max_volume=31, min_dB=-97.5, max_dB=0
D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
D: alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
I: alsa-sink.c: Hardware volume ranges from -97.50 dB to 0.00 dB.
I: alsa-sink.c: No particular base volume set, fixing to 0 dB
I: alsa-sink.c: Using hardware volume control. Hardware dB scale supported.
I: alsa-sink.c: Using hardware mute control.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Soft volume PCM
D: alsa-util.c: Control: PCM Playback Volume
D: alsa-util.c: min_dB: -51
D: alsa-util.c: max_dB: 0
D: alsa-util.c: resolution: 256
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 16384
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 15502
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 4611686018427387904
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 4611686018427387904
D: alsa-util.c: Slave: Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 16384
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 15502
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 4611686018427387904
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 4611686018427387904
D: alsa-util.c:   appl_ptr     : 0
D: alsa-util.c:   hw_ptr       : 0




I'll try and work out why PA still insists on setting Master to 0 aka
-99999.99dB :D

Many thanks for the patch.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
