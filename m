From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH] ALSA: firewire-lib: support Linux
 tracing to dump a part of packet data
Date: Wed, 30 Mar 2016 09:47:06 +0900
Message-ID: <56FB220A.4010102@sakamocchi.jp>
References: <1459081086-6145-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hpoud2xvj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A3543266A1B
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 02:47:10 +0200 (CEST)
In-Reply-To: <s5hpoud2xvj.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 29 2016 22:54, Takashi Iwai wrote:
> On Sun, 27 Mar 2016 14:18:06 +0200,
> Takashi Sakamoto wrote:
>>
>> When audio and music units have some quirks in their sequence of packet,
>> it's really hard for non-owners to identify the quirks. To handle the
>> quirks, developers need a dump for sequence of packets at least, however
>> it's difficult to users who have no knowledge and equipment for this
>> purpose.
>>
>> This commit adds tracepoints for this situation. When users encounter
>> the issue, they can dump a part of packet data via Linux tracing framework
>> as long as using drivers in ALSA firewire stack.
>>
>> This commit adds 'snd-firewire-lib' subsystem with 'in_packet' and
>> 'out_packet' events. In the events, the content of CIP headers, the number
>> of included quadlets and the index of packet managed by this module are
>> recorded per packet.
>>
>> This is a sample:
>>
>> $ trace-cmd record -e snd_firewire_lib:out_packet -e snd_firewire_lib:in_packet
>> /sys/kernel/tracing/events/snd_firewire_lib/out_packet/filter
>> /sys/kernel/tracing/events/snd_firewire_lib/in_packet/filter
>> Hit Ctrl^C to stop recording
>> ^C
>> $ trace-cmd report trace.dat
>> ...
>> <idle>-0  [002] 40398.221702: out_packet: 00070008 9001427a: 058: 31
>> <idle>-0  [002] 40398.221703: in_packet:  01020010 9001ffff: 002: 15
>> <idle>-0  [002] 40398.221703: out_packet: 00070010 9001ffff: 002: 32
>> <idle>-0  [002] 40398.223679: in_packet:  010b0010 900157e4: 090: 16
>> <idle>-0  [002] 40398.223681: out_packet: 00070010 900157e4: 058: 33
>> <idle>-0  [002] 40398.223681: in_packet:  010b0018 9001714f: 090: 17
>> ...
>>
>> One line represent one packet. The legend for the last four fields is:
>>   - The first quadlet of CIP header
>>   - The second quadlet of CIP header
>>   - The number of included quadlets
>>   - The index of packet inner buffer maintained by this module
>>
>> Currently, when detecting packet discontinuity, this module stops packet
>> streaming. This is reasonable to packet streaming implementation. However,
>> to identify the quirks, packet streaming should continue to dump enough
>> sequence of packet. This commit adds a condition statement and a marker
>> for this purpose.
>
> The packet tracing is nice, and I don't see any reason against it.
> But changing the driver behavior depending on the trace state is
> unusual, rather a thing to be avoided in general.

See already-identified quirks:
  - 13f3a46d2a6c('ALSA: oxfw: add Mackie Onyx Satellite quirk to inform 
wrong value in 'dbs' field in tx CIP header')
  - 18f5ed365d3f('ALSA: fireworks/firewire-lib: add support for recent 
firmware quirk')
  - c4d860a0d256('ALSA: bebob: loosen up severity of checking continuity 
for BeBoB v3 quirk')
  - 9d59124cacf5('ALSA: bebob/firewire-lib: Add a quirk of wrong dbc in 
empty packet for M-Audio special Firewire series')
  - d9cd0065c8a4('ALSA: fireworks/firewire-lib: Add a quirk for fixed 
interval of reported dbc')
  - c8bdf49b9935('ALSA: fireworks/firewire-lib: Add a quirk for the 
meaning of dbc')

To investigate quirks similar to these, the sequence of packet 
before/after detecting discontinuity helps us. It's a reason to change 
the behaviour against the general issue.


Regards

Takashi Sakamoto
