From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH alsa-lib v2] Sync enum snd_hwdep_iface_t
	with include/asound/asound.h
Date: Mon, 18 Aug 2014 20:52:40 +0900
Message-ID: <53F1E908.7060504@sakamocchi.jp>
References: <1408264747-26357-1-git-send-email-o-takashi@sakamocchi.jp>
 <1408355117-9654-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hha1a5ani.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B9B02654E0
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 13:52:46 +0200 (CEST)
In-Reply-To: <s5hha1a5ani.wl-tiwai@suse.de>
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

On Aug 18 2014 19:56, Takashi Iwai wrote:
> At Mon, 18 Aug 2014 18:45:17 +0900,
> Takashi Sakamoto wrote:
>>
>> Some members in this enumerated type has not updated for 9 years, although
>> kernel-drivers added them during this period. This commit adds them following
>> to a commit 87df9f3 'sync include/asound/asound.h with 3.17-rc1 kernel'.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Applied, thanks.

Thank you.

I have a plan to work for OXFW driver in the rest of this year. My
patches includes SNDRV_HWDEP_IFACE_FW_OXFW for the same purpose the
other firewire drivers have.

I should add it to alsa-lib but I have no confidence for the timing.
Which is better, the same time to post the driver or the time Linux
kernel is released with the driver?


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
