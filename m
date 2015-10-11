From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/6 v3] ALSA: firewire-digi00x: support
	MIDI functionality
Date: Mon, 12 Oct 2015 08:26:01 +0900
Message-ID: <561AF009.3050804@sakamocchi.jp>
References: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hsi5hid4v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A47F2614A1
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 01:26:12 +0200 (CEST)
In-Reply-To: <s5hsi5hid4v.wl-tiwai@suse.de>
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
Cc: damien@zamaudio.com, robin@gareus.org, clemens@ladisch.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 12 2015 01:27, Takashi Iwai wrote:
> On Sun, 11 Oct 2015 05:30:13 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This commit updates my former post (patch 13, 15, 16):
>>
>> [alsa-devel] [PATCH 00/25 v2] ALSA: support AMDTP variants
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/096739.html
>>
>> Digi 00x driver may be newly available in Linux 4.4. This patchset adds
>> ALSA MIDI ports to support physical MIDI ports and physical controls. I
>> tested physical MIDI ports, while never tested physical controls because
>> I'm not an owner of 'console' models.
>>
>> The functionality for physical controls is written according to my
>> assumption. When I investigated Digi 002 rack, Windows driver registers
>> a certain address to the device, and adds virtual MIDI ports to the
>> system. These ports are named as 'control'. When MIDI application sends
>> MIDI messages to the port, asynchronous transactions start on IEEE 1394
>> bus. On the other hand, I have no way to confirm asynchronous transaction
>> in opposite direction because the rack model doesn't have the
>> functionality. In this time, I apply the same format of outgoing
>> asynchronous transaction to incoming asynchronous transaction.
>>
>> Takashi Sakamoto (6):
>>   firewire-digi00x: use in-kernel representation for the type of 8 bits
>>   firewire-digi00x: handle MIDI messages in isochronous packets
>>   firewire-digi00x: add support for MIDI ports corresponding to
>>     isochronous packet streaming
>>   firewire-digi00x: add support of asynchronous transaction for incoming
>>     MIDI messages from physical controls
>>   firewire-digi00x: add support of asynchronous transaction for outgoing
>>     MIDI messages to physical controls
>>   firewire-digi00x: add support for MIDI ports for physical controls
> 
> Thanks, applied all six patches now.

Thanks. Now all patches for firewire-digi00x are pushed to upstream.
It's a bit tough work to take me almost one year, so glad ;)


Thanks

Takashi Sakamoto

> Takashi
> 
>>
>>  sound/firewire/digi00x/Makefile              |   2 +-
>>  sound/firewire/digi00x/amdtp-dot.c           | 150 +++++++++++++++++++++----
>>  sound/firewire/digi00x/digi00x-midi.c        | 160 +++++++++++++++++++++++++++
>>  sound/firewire/digi00x/digi00x-stream.c      |   6 +-
>>  sound/firewire/digi00x/digi00x-transaction.c |  70 ++++++++++--
>>  sound/firewire/digi00x/digi00x.c             |   4 +
>>  sound/firewire/digi00x/digi00x.h             |  15 ++-
>>  7 files changed, 376 insertions(+), 31 deletions(-)
>>  create mode 100644 sound/firewire/digi00x/digi00x-midi.c
>>
>> -- 
>> 2.1.4
