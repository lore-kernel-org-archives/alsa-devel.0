From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 5/6] fireworks: Remove meaningless
	mutex_unlock()
Date: Wed, 04 Jun 2014 21:54:15 +0900
Message-ID: <538F16F7.4080702@sakamocchi.jp>
References: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
 <1401863137-15103-6-git-send-email-o-takashi@sakamocchi.jp>
 <s5h8upc3l0h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id ED2B2262634
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 14:54:27 +0200 (CEST)
In-Reply-To: <s5h8upc3l0h.wl%tiwai@suse.de>
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

(Jun 4 2014 21:41), Takashi Iwai wrote:
> At Wed,  4 Jun 2014 15:25:36 +0900,
> Takashi Sakamoto wrote:
>>
>> Currently mutex_unlock() is called in module's cleanup function. But after
>> cleaned up, this mutex is automatically released. So this function call
>> is meaningless.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> It must be meant as mutex_destroy()?
> I applied it with the typo fixes.  Thanks.

Exactly. Thanks for your correction.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
