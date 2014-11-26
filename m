From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: firewire-lib:
	remove	rx_blocks_for_midi quirk
Date: Wed, 26 Nov 2014 15:38:46 +0100
Message-ID: <5475E5F6.2080709@ladisch.de>
References: <5474FA18.7000501@ladisch.de> <5475E211.3040106@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id ABDAA264F0A
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 15:38:57 +0100 (CET)
In-Reply-To: <5475E211.3040106@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Nov 26 2014 06:52, Clemens Ladisch wrote:
>> There are several devices that expect to receive MIDI data only in the
>> first eight data blocks of a packet.  If the driver restricts the data
>> rate to the allowed rate (as mandated by the specification, but not yet
>> implemented by this driver), this happens naturally.  Therefore, there
>> is no reason to ever try to use more data packets with any device.
>>
>> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
>> ---
>>  sound/firewire/amdtp.c                      |   10 +++++++---
>>  sound/firewire/amdtp.h                      |    3 ---
>>  sound/firewire/bebob/bebob_stream.c         |    7 -------
>>  sound/firewire/fireworks/fireworks_stream.c |    5 -----
>>  4 files changed, 7 insertions(+), 18 deletions(-)
>
> Can I ask your opinion about applying this patch to devices with
> non-blocking mode? At least, your comment of this patch is for blocking
> mode (the fixed number of data blocks in a packet).

This patch does not assume that there is a fixed number of data blocks.

It does not matter whether a stream is (non-)blocking: eight data blocks
per packet (i.e., one MIDI byte per MPX-MIDI data channel per packet) is
always enough for MIDI.  Even at 32 kHz, there are about 4000 packets
per seconds in blocking mode.  In non-blocking mode, the packets are
smaller (so not ecery MPX-MIDI data channels gets sent in every packet),
but there are exactly 8000 packets per second, so the overall number of
samples (= data blocks) does not change.


Regards,
Clemens
