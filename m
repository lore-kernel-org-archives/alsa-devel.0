From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: firewire-lib: remove
	rx_blocks_for_midi quirk
Date: Thu, 27 Nov 2014 21:45:00 +0900
Message-ID: <54771CCC.4090101@sakamocchi.jp>
References: <5474FA18.7000501@ladisch.de> <5475E211.3040106@sakamocchi.jp>
 <5475E5F6.2080709@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 490F9265E24
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 13:45:07 +0100 (CET)
In-Reply-To: <5475E5F6.2080709@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 26 2014 23:38, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> On Nov 26 2014 06:52, Clemens Ladisch wrote:
>>> There are several devices that expect to receive MIDI data only in the
>>> first eight data blocks of a packet.  If the driver restricts the data
>>> rate to the allowed rate (as mandated by the specification, but not yet
>>> implemented by this driver), this happens naturally.  Therefore, there
>>> is no reason to ever try to use more data packets with any device.
>>>
>>> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
>>> ---
>>>  sound/firewire/amdtp.c                      |   10 +++++++---
>>>  sound/firewire/amdtp.h                      |    3 ---
>>>  sound/firewire/bebob/bebob_stream.c         |    7 -------
>>>  sound/firewire/fireworks/fireworks_stream.c |    5 -----
>>>  4 files changed, 7 insertions(+), 18 deletions(-)
>>
>> Can I ask your opinion about applying this patch to devices with
>> non-blocking mode? At least, your comment of this patch is for blocking
>> mode (the fixed number of data blocks in a packet).
> 
> This patch does not assume that there is a fixed number of data blocks.
> 
> It does not matter whether a stream is (non-)blocking: eight data blocks
> per packet (i.e., one MIDI byte per MPX-MIDI data channel per packet) is
> always enough for MIDI.  Even at 32 kHz, there are about 4000 packets
> per seconds in blocking mode.  In non-blocking mode, the packets are
> smaller (so not ecery MPX-MIDI data channels gets sent in every packet),
> but there are exactly 8000 packets per second, so the overall number of
> samples (= data blocks) does not change.

I was suspicious of unfairless for 8 MPX-MIDI data streams to transfer
MIDI messages in non-blocking mode, because .the MPX-MIDI data stream in
the first data block is different per packet.

But this is not matter. At 32.0/44.1/48.0, the number of data blocks in
a packet is lesser than 8 therefore all of MPX-MIDI data stream has the
same chances to transfer MIDI messages. At 88.2 kHz or higher, the
number of data blocks in a packet is bigger than 8 but8 MPX-MIDI data
streams has a chance per packet. As a result, All of MPX-MIDI data
stream has the same opportunity to transfer MIDI messages.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I tested these two patch with below devices. All of them can transmit
MIDI messages correctly at any sampling transfer tates.

M-Audio: FIreWire 1814 (snd-bebob)
M-Audio: FireWire 410 (snd-bebob)
M-Audio: FireWire AudioPhile (snd-bebob)
M-Audio: Ozonic (snd-bebob)
Yamaha: GO44 (snd-bebob)
Yamaha: GO46 (snd-bebob)
Echo Audio: AudioFire4 (snd-fireworks)
Echo Audio: AudioFirePre8 (snd-fireworks)
TC Electronic: Impact Twin (snd-dice)

These two patches solves one of issues which I wrote in my report.
9.5 A lack of throttles for MIDI messages in outgoing stream
https://github.com/takaswie/alsa-firewire-report


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
