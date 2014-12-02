From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 21/30] ALSA: oxfw: Change the way to name
	card
Date: Tue, 02 Dec 2014 15:17:25 +0900
Message-ID: <547D5975.6010008@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
 <1417190379-4172-22-git-send-email-o-takashi@sakamocchi.jp>
 <s5hbnnpbxxs.wl-tiwai@suse.de> <547A9E1B.7060004@sakamocchi.jp>
 <s5h4mthay31.wl-tiwai@suse.de> <547BA5F2.4040401@sakamocchi.jp>
 <s5hzjb792z3.wl-tiwai@suse.de> <547C4F53.1030306@ladisch.de>
 <547C83BB.3040602@sakamocchi.jp> <s5h8uirv1jn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 284C5260439
 for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2014 07:17:28 +0100 (CET)
In-Reply-To: <s5h8uirv1jn.wl-tiwai@suse.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Dec 2 2014 00:21, Takashi Iwai wrote:
>>> As for the shortname, it is not an internal identifier but typically
>>> displayed to identify the device for the user.  Something like
>>> "FWSpeakers" might be recognizable, but I'd prefer the old "FireWire
>>> Speakers".
>>
>> In this case (the old name), 'Speakers' is an identical name such as
>> 'hw:Speakers'. IMHO, this is a bit strange because it's usual, not
>> identical.
>
> You see now that you're breaking user's setup, don't you?
> This is another reason why you shouldn't change the short name
> string.

In this case, it depends on the estimated number of actual users for 
this device. At least, snd-firewire-speakers cannot handle this device 
correctly, while there're no bug reports, for 4 years. I think this is 
an evidence of few users.

...although havind said so, it's not my favorite to spend more time to 
such a small things, instead of more important things. I'll keep the 
naming rule what it was in next patchset.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
