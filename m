From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 21/30] ALSA: oxfw: Change the way to name
	card
Date: Wed, 03 Dec 2014 23:19:53 +0900
Message-ID: <547F1C09.5010103@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
 <1417190379-4172-22-git-send-email-o-takashi@sakamocchi.jp>
 <s5hbnnpbxxs.wl-tiwai@suse.de> <547A9E1B.7060004@sakamocchi.jp>
 <s5h4mthay31.wl-tiwai@suse.de> <547BA5F2.4040401@sakamocchi.jp>
 <s5hzjb792z3.wl-tiwai@suse.de> <547C4F53.1030306@ladisch.de>
 <547C83BB.3040602@sakamocchi.jp> <s5h8uirv1jn.wl-tiwai@suse.de>
 <547D5975.6010008@sakamocchi.jp> <s5hr3wi8sfk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 9866526045C
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 15:19:58 +0100 (CET)
In-Reply-To: <s5hr3wi8sfk.wl-tiwai@suse.de>
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
Cc: ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Sorry to be late.

On Dec 2 2014 15:41, Takashi Iwai wrote:
>>> You see now that you're breaking user's setup, don't you?
>>> This is another reason why you shouldn't change the short name
>>> string.
>>
>> In this case, it depends on the estimated number of actual users for 
>> this device.
> 
> No.  The number doesn't matter unless it's proved to be really no
> regression.
> 
>> At least, snd-firewire-speakers cannot handle this device 
>> correctly, while there're no bug reports, for 4 years. I think this is 
>> an evidence of few users.
> 
> Did you get reports that the name hw:Speaker is bad, too?
> If not, why do you insist to "fix" this at all?  It's just because you
> feel so -- which is no objective measurement, either.

Not. Just depending on my feeling.

>> ...although havind said so, it's not my favorite to spend more time to 
>> such a small things, instead of more important things. I'll keep the 
>> naming rule what it was in next patchset.
> 
> There is no more important things than fixing a regression.
> 
> Just fix it for the next patchset, or patches won't be accepted.
> That's so simple.
> 
> I'm giving a strong word here because you might miss the point: in
> such a rewrite, the primary item you have to care is to avoid
> regressions.  Supporting other devices, the cleanness of the code, or
> even the correctness of the code, is hence in the second place.

I'm sure.

This weekend, I'll post the next patchset. I hope it's the last one for
OXFW 970/971.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
