From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 19/39] fireworks: Add skelton for Fireworks
	based devices
Date: Sat, 01 Mar 2014 00:05:42 +0900
Message-ID: <5310A5C6.2060602@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-20-git-send-email-o-takashi@sakamocchi.jp>
 <s5h7g8fn30m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id D30F5265166
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 16:05:47 +0100 (CET)
In-Reply-To: <s5h7g8fn30m.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Iwai-san,

(Feb 28 2014 15:51), Takashi Iwai wrote:
> Now we may handle more than 32 cards, depending on Kconfig.

I can understand I should not use 'unsigned int' for bitmap of each card 
instances because in most architecture 'unsigned int' has just 32 bit width.

 > Use bitmap instead.

But I cannot understand this sentence.

I already use this 'devices_used' for bitmap. So I guess you did mean 
alternative ways like pointer array. For example:
static struct snd_fireworks *devices_used[SNDRV_CARDS];

Can I request your explaination for this?


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
