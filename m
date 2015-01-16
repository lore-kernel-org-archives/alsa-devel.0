From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: firewire-lib:
	remove	rx_blocks_for_midi quirk
Date: Fri, 16 Jan 2015 22:18:15 +0100
Message-ID: <54B98017.2090000@ladisch.de>
References: <5474FA18.7000501@ladisch.de> <5475E211.3040106@sakamocchi.jp>
 <5475E5F6.2080709@ladisch.de> <54771CCC.4090101@sakamocchi.jp>
 <548456CD.1070701@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4CC1A2656EB
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 22:19:05 +0100 (CET)
In-Reply-To: <548456CD.1070701@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Iwai-san,
>
> On Nov 27 2014 21:45, Takashi Sakamoto wrote:
>> On Nov 26 2014 23:38, Clemens Ladisch wrote:
>>> Takashi Sakamoto wrote:
>>>> On Nov 26 2014 06:52, Clemens Ladisch wrote:
>>>>> There are several devices that expect to receive MIDI data only in the
>>>>> first eight data blocks of a packet.  If the driver restricts the data
>>>>> rate to the allowed rate (as mandated by the specification, but not yet
>>>>> implemented by this driver), this happens naturally.  Therefore, there
>>>>> is no reason to ever try to use more data packets with any device.
>>>>>
>>>>> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
>>>>> ---
>>>>>  sound/firewire/amdtp.c                      |   10 +++++++---
>>>>>  sound/firewire/amdtp.h                      |    3 ---
>>>>>  sound/firewire/bebob/bebob_stream.c         |    7 -------
>>>>>  sound/firewire/fireworks/fireworks_stream.c |    5 -----
>>>>>  4 files changed, 7 insertions(+), 18 deletions(-)
>>
>> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>
> I think these two patches are deserved to merge. Could you apply these
> two patches to linux-next?
>
> Regards
>
> Takashi Sakamoto
> o-takashi@sakamocchi.jp

Ping?
