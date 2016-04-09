From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 2/2] sound: usb: allow clock source
	validity interrupts
Date: Sat, 9 Apr 2016 16:37:28 +0200
Message-ID: <570913A8.6090203@zonque.org>
References: <1460137922-8993-1-git-send-email-daniel@zonque.org>
 <1460137922-8993-2-git-send-email-daniel@zonque.org>
 <s5hk2k7cgfy.wl-tiwai@suse.de> <5708C88B.8080809@zonque.org>
 <s5hegafcdoz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id A5508261685
 for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2016 16:37:31 +0200 (CEST)
In-Reply-To: <s5hegafcdoz.wl-tiwai@suse.de>
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
Cc: orm.finnendahl@selma.hfmdk-frankfurt.de, alsa-devel@alsa-project.org, clemens@ladisch.de, jan.baumgart@selma.hfmdk-frankfurt.de
List-Id: alsa-devel@alsa-project.org

On 04/09/2016 11:51 AM, Takashi Iwai wrote:
> On Sat, 09 Apr 2016 11:16:59 +0200, Daniel Mack wrote:
>> On 04/09/2016 10:52 AM, Takashi Iwai wrote:

>>> Just for checking count=0 and count=1, we need no loop to count
>>> beforehand.
>>> 		if (info->control != control &&
>>> 		    (list != mixer->id_elems[unit] ||
>>> 		     list->list_next_id_elem))
>>> 			continue;
>>>
>>> But, this doesn't look better and is more harder to understand, so I'm
>>> not willing to sell it :)
>>
>> I had something like that before but opted for the more readable
>> version. But you're right. I'll add a comment and do it your way.
> 
> Oh no, sorry, I wasn't clear: I meant that my version is worse in the
> end, and I prefer your first version, just for simplicity.

Ah ok :) Well, ultimately up to you; you have both versions, and the two
patches should apply independently anyway.

Or I can resend both if you prefer that.


Thanks,
Daniel
