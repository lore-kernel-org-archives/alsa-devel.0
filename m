From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/4 v5] ALSA: dice: improve card
	registration processing
Date: Wed, 6 Jan 2016 19:50:01 +0900
Message-ID: <568CF159.80202@sakamocchi.jp>
References: <1451537894-28366-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hlh83rrok.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 7464F260417
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 11:50:07 +0100 (CET)
In-Reply-To: <s5hlh83rrok.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 06 2016 18:19, Takashi Iwai wrote:
> On Thu, 31 Dec 2015 05:58:10 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This patchset updates my previous one:
>> [alsa-devel] [PATCH 0/5 v4] ALSA: dice: improve card registration processing
>> a
>>
>> Changes:
>>  * Merge patch 02 and 03 in v4.
>>  * Allocate sound card instance in sound card registration work, independently
>>    of dice instance, allocated in .probe callback and set as driver_data of
>>    device structure.
>>  * Use __be32 type for __be32 data.
>>
>> In this version, sound card instance is not allocated in .probe callback. In
>> the callback, dice instance is allocated independently of the card instance.
>> Thus, in .probe callback, this driver reserve no slot of sound card. The
>> allocation of sound card instance is performed in a scheduled work. When
>> processing in the work fails, the work can be re-scheduled again according to
>> bus reset.
> 
> Applied now all four patches.  Thanks.

OK. Thanks.

How about the rest of my work for ALSA Dice driver to Linux 4.5?

[alsa-devel] [RFC][PATCH 00/10 v2] ALSA: dice: stabiliza packet streaming
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/101897.html

It takes almost one month since I posted the RFCv2. We already had a
discussion about the patchset in RFCv1 and in my opinion there's no
thorough disagreement. If possible, I'd like to merge it in the merge
window for Linux 4.5. If we go for it, I'll post them in this night.


Have a nice year.

> Takashi
> 
>>
>> Takashi Sakamoto (4):
>>   ALSA: dice: split subaddress check from category check
>>   ALSA: dice: postpone card registration
>>   ALSA: dice: purge transaction initialization at timeout of Dice
>>     notification
>>   ALSA: dice: expand timeout to wait for Dice notification
>>
>>  sound/firewire/dice/dice-transaction.c | 123 +++++++++++-------
>>  sound/firewire/dice/dice.c             | 227 +++++++++++++++++----------------
>>  sound/firewire/dice/dice.h             |   3 +
>>  3 files changed, 202 insertions(+), 151 deletions(-)
>>
>> -- 
>> 2.5.0
>>
