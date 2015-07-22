From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 26/37] ALSA: firewire-tascam: add
 MMAP	support to show status and control message
Date: Wed, 22 Jul 2015 23:53:37 +0900
Message-ID: <55AFAE71.7070809@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
 <1436623968-10780-27-git-send-email-o-takashi@sakamocchi.jp>
 <s5hzj2qj4b7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 795E9260713
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 16:53:41 +0200 (CEST)
In-Reply-To: <s5hzj2qj4b7.wl-tiwai@suse.de>
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
Cc: Yoshifuji Hideaki <yoshfuji@linux-ipv6.org>, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jul 20 2015 23:23, Takashi Iwai wrote:
> On Sat, 11 Jul 2015 16:12:37 +0200,
> Takashi Sakamoto wrote:
>>
>> TASCAM FireWire series transfers status and control messages in
>> isochronous packets. One packet includes one message, and the
>> message is periodic every 64 packets. As a result, the messages
>> construct image with 64 quadlets. For example:
>>
>> 00 00000000, 32 00000000
>> 01 00000000, 33 00000000
>> 02 00000000, 34 00000000
>> 03 00020000, 35 00000000
>> 04 00000000, 36 25ea0000
>> 05 ffff0000, 37 27dfff00
>> 06 ffffffff, 38 1d9d0000
>> 07 ffffffff, 39 00000000
>> 08 ffffffff, 40 25ea0000
>> 09 ffffffff, 41 27dfff00
>> 10 00000000, 42 00000000
>> 11 00000000, 43 00000000
>> 12 00000000, 44 00000000
>> 13 00000000, 45 00000000
>> 14 00000000, 46 00000000
>> 15 00010000, 47 00000000
>> 16 00012e00, 48 00000000
>> 17 00010400, 49 00000000
>> 18 00011e00, 50 00000000
>> 19 00011200, 51 00000000
>> 20 00014900, 52 01010101
>> 21 00011e00, 53 00000000
>> 22 00010c00, 54 25ea0000
>> 23 00013000, 55 27dfff00
>> 24 00000000, 56 00000000
>> 25 00000000, 57 00000000
>> 26 00000000, 58 00000000
>> 27 00000000, 59 00000001
>> 28 00000000, 60 00000000
>> 29 00000000, 61 00000000
>> 30 00000000, 62 00000000
>> 31 00000000, 63 00000000
>>
>> Quadlet 00-15 show control messages. Quadlet 16-23 show analog input
>> level. Quadlet 24-31 shows digital ADAT input level. Quadlet 32-33
>> shows digital S/PDIF input level. Quadlet 34-35 is unknown. Quadlet
>> 36-43 shows analog output level. The other quadlets are unknown.
>>
>> This image is updated every 1 msec or less, depending on current
>> sampling transfer frequency.
>>
>> This commit adds MMAP support to show this image via hwdep interface.
>> An userspace application can map a page frame to its virtual address
>> space with read-only flag. This driver write every control and status
>> messages into the page frame, and the userspace application can parse
>> them.
>>
>> The control messages are both of edge-triggered/level-trigerred,
>> according to physical implementation. For example, the control message
>> corresponding to toggle switch acts as edge-trigger, while the control
>> message corresponding to level fader acts as level-trigger. These control
>> messages are updated every 1 msec or less, alghough the scheduling
>> granuality in Linux operating system is not always so small. This may
>> cause the userspace parser misses some messages when many tasks are
>> running without voluntary programs.
>>
>> Typically, such messages should be converted to MIDI control change
>> messages for userspace applications. Thus, this driver should have
>> a converter with appropriate MIDI map. Currently I have no good idea
>> for the map and it is not implemented yet. Developers helps are
>> required.
>>
>> Cc: Yoshifuji Hideaki <yoshfuji@linux-ipv6.org>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Using mmap for accessing this kind of message isn't good for various
> reasons.  First off, it's volatile, and your implementation keeps only
> a single record, thus it will be overridden at each input.
> 
> Second, the access is racy.
> 
> Third, the mmap implementation can be complex if a cache coherency
> plays a role.  It's easy on x86, but for others...

Indeed. Now I investigate about the converter between the bitmap and
MIDI messages.

But anyway, input/output level should be exposed to userspace because it
doesn't matter to miss reading the information sometimes.

> And the rest... there must be something else I overlooked obviously
> (I don't count a bug here, e.g. the lack of offset value check in vm
>  fault handler :)


Thanks

Takashi Sakamoto
