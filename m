From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/4] ALSA: dice: postpone card registration
Date: Fri, 25 Dec 2015 09:21:22 +0900
Message-ID: <567C8C02.7070406@sakamocchi.jp>
References: <1450911310-15507-1-git-send-email-o-takashi@sakamocchi.jp>
 <1450911310-15507-3-git-send-email-o-takashi@sakamocchi.jp>
 <20151224215147.1fae080b@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 96EED2666CE
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2015 01:21:26 +0100 (CET)
In-Reply-To: <20151224215147.1fae080b@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On De 25 2015 05:51, Stefan Richter wrote:
> On Dec 24 Takashi Sakamoto wrote:
>> --- a/sound/firewire/dice/dice.c
>> +++ b/sound/firewire/dice/dice.c
> [...]
>>  static void dice_bus_reset(struct fw_unit *unit)
>>  {
>>  	struct snd_dice *dice = dev_get_drvdata(&unit->device);
>>  
>> +	/* Postpone a workqueue for deferred registration. */
>> +	if (!dice->registered) {
>> +		schedule_registration(dice);
>> +		return;
>> +	}
>> +
>>  	/* The handler address register becomes initialized. */
>>  	snd_dice_transaction_reinit(dice);
>>  
> 
> In previous versions of the patch, you used
> 	schedule_delayed_work(&dice->dwork, delay);
> in dice_probe() and
> 	mod_delayed_work(dice->dwork.wq, &dice->dwork, delay);
> in dice_bus_reset().
> 
> Now you are using schedule_delayed_work() in both.  This means that
> dice_bus_reset() is now unable to further defer the work.  Is this
> intentional?

No intention, just my mistake. Originally, I had an intention to use
'mod_delayed_work()' here.
https://www.kernel.org/doc/htmldocs/device-drivers/API-mod-delayed-work.html

> By the way, in drivers/firewire/core-cdev.c, I used a somewhat different
> workqueue scheduling scheme.  Problem:
>   - The first 1000 ms after a bus reset are to be used for re-allocations
>     of previously allocated isochronous resources.  Attempts for new iso
>     resource allocations shall be deferred until after 1000 ms after the
>     latest bus reset.
> My solution:
>   - The work which is to perform allocations/ reallocations/ deallocations
>     is scheduled immediately.  But the worker function (iso_resource_work)
>     reschedules itself if it notices that (1.) its job is to allocate and
>     (2.) the last bus reset was less than 1 s ago.
> 
> I used the same principle in drivers/firewire/core-card.c.  Problem:
>   - If system software wants to reset the bus, it shall wait at least
>     2000 ms until after the last bus reset.  The reason is to allow for
>     various bus reset handling protocols to be performed first (e.g.
>     isochronous resource allocations, re-logins and the likes).
> My solution:
>   - br_work() reschedules itself if it detects that the last bus reset was
>     less than 2 s ago.
> 
> Admittedly there is a small remaining window after the worker looked at
> card->reset_jiffies and before it performs its real work, and another bus
> rest could happen in this window.  I suppose if I wanted to close even
> this window, I would have to couple card->reset_jiffies with a
> bus generation counter and then make the remaining work depended on this
> bus generation.
> 
> Back to your patch:  I am not sure how strictly you want to guarantee the
> delay between last reset and do_registration()'s execution.  Maybe it
> would be beneficial to put the check for card->reset_jiffies and self-
> rescheduling into do_registration(), similar to the two examples from
> firewire-core, or maybe that's not really necessary for your purposes.

On Dec 25 2015 06:04, Stefan Richter wrote:
> Or as I wrote in the other thread:
> Maybe you can live with less precision and simply use a fixed relative
> delay, disregarding card->reset_jiffies altogether.

For the case that users execute insmod/rmmod by their own. In this case,
no need to be delay for the registration work.



Thanks

Takashi Sakamoto
