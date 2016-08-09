From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/39] ALSA: seq: optimize system_info
 function to new design
Date: Tue, 9 Aug 2016 22:01:01 +0900
Message-ID: <3edd4cd7-a813-28ba-fd7d-c9b7af1a2a5c@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470563355-18368-12-git-send-email-o-takashi@sakamocchi.jp>
 <s5hwpjroi5k.wl-tiwai@suse.de>
 <3165103a-b4b0-94a6-6fb5-4d7b00dc1ae1@sakamocchi.jp>
 <s5heg5znvtf.wl-tiwai@suse.de>
 <08b81c00-5e46-b202-b533-c403beaf5638@sakamocchi.jp>
 <s5hlh062kr0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 75901268155
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 15:01:04 +0200 (CEST)
In-Reply-To: <s5hlh062kr0.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Aug 9 2016 21:24, Takashi Iwai wrote:
>> You completely puzzled me. Finally, what you'd like me to do?????
> 
> You've cut into too small patches.  Damn too small.
> 
> Of course, too small is much better than too big.  That's why I wrote
> "it's OK".  But it's also a bad taste, after all -- it annoys readers,
> since they need to look over the same boring changes again and again.
> 
> For avoiding annoyance, such tasks would be better to be grouped in a
> certain level, so that readers can take a glance over wider ranges, as
> long as all the changes are the more or less same procedure.

And bisect operations have a practical effect.

Hm, OK. I see. Depending on the purpose of patches, I'm likely to create
large patches.

Honestly, I have a long concern about the granularity of the size of
each patch. For example, change log of the latest alsa-lib in
alsa-project.org is quite bad and I was a bit disappointed.


Regards

Takashi Sakamoto
