From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] bebob: Use ARRAY_SIZE() instead of
 sizeof() for return condition
Date: Mon, 02 Jun 2014 00:04:49 +0900
Message-ID: <538B4111.9040408@sakamocchi.jp>
References: <1401518032-7223-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hppiuv1ud.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BA4D26530C
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 17:05:00 +0200 (CEST)
In-Reply-To: <s5hppiuv1ud.wl%tiwai@suse.de>
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

(May 31 2014 16:34), Takashi Iwai wrote:
> At Sat, 31 May 2014 15:33:52 +0900,
> Takashi Sakamoto wrote:
>>
>> The parser for stream format information should return when detecting wrong
>> value for sampling rate. But it doesn't.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> This was already fixed by Dan's patch.

Oops. Exactly. I've posted the same content as Dan posted...
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/077254.html

But 'master' branch includes Dan's patch, on the other hand 'for-next'
branch doesn't. I think we're confused with much patches for firewire
stack...
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
