From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH alsa-lib v2] Sync enum snd_hwdep_iface_t
	with include/asound/asound.h
Date: Tue, 19 Aug 2014 07:53:34 +0900
Message-ID: <53F283EE.9060800@sakamocchi.jp>
References: <1408264747-26357-1-git-send-email-o-takashi@sakamocchi.jp>
 <1408355117-9654-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hha1a5ani.wl-tiwai@suse.de> <53F1E908.7060504@sakamocchi.jp>
 <s5h8umm53uq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id F115C265353
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 00:53:39 +0200 (CEST)
In-Reply-To: <s5h8umm53uq.wl-tiwai@suse.de>
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

On Aug 18 2014 22:23, Takashi Iwai wrote:
>> I have a plan to work for OXFW driver in the rest of this year. My
>> patches includes SNDRV_HWDEP_IFACE_FW_OXFW for the same purpose the
>> other firewire drivers have.
>>
>> I should add it to alsa-lib but I have no confidence for the timing.
>> Which is better, the same time to post the driver or the time Linux
>> kernel is released with the driver?
> 
> At best, merge both kernel and user-space stuff at the same time.
> So, please send both kernel and alsa-lib patches.  The merge to Linus
> shall be postponed until the following merge window, of course, but it
> shouldn't matter much.

OK, I see.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
