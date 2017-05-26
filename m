From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ALSA: pcm: add arrangement for
	applying appl_ptr
Date: Fri, 26 May 2017 15:54:27 +0900
Message-ID: <7c1610fe-0546-73b9-f8b0-d6bd65a13b29@sakamocchi.jp>
References: <20170526003047.17721-1-o-takashi@sakamocchi.jp>
 <20170526003047.17721-3-o-takashi@sakamocchi.jp>
 <s5ha860jf2o.wl-tiwai@suse.de>
 <d4f82e6e-d402-cc5f-92ef-f37e67fc0682@sakamocchi.jp>
 <s5h8tlkjeqx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id D50F926747A
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 08:54:29 +0200 (CEST)
In-Reply-To: <s5h8tlkjeqx.wl-tiwai@suse.de>
Content-Language: en-US
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

On May 26 2017 15:47, Takashi Iwai wrote:
>>> Queued now, but will be likely declined later due to the rewrites of
>>> the code.
>>
>> Due to your recent work under reviewing?
> 
> Yes, the code might be changed heavily.
> Don't touch a too hot spot if it were only a cleanup.

I've already reviewed it but postpone my reply to this evening. (I'm in 
paid work now.)

Your patchset looks a middle of work. It includes the lack of changes 
for each drivers, thus not bisect-able. I think you will re-post the 
full series of patches several days after reviewed. Then you have chance 
to rebase it to recent HEAD of your tree, don't you?


Thanks

Takashi Sakamoto
