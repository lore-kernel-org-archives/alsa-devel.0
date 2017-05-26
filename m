From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ALSA: pcm: add arrangement for
	applying appl_ptr
Date: Fri, 26 May 2017 17:46:07 +0900
Message-ID: <6d53114b-11a3-2cab-a0d0-9f7de9ca1be9@sakamocchi.jp>
References: <20170526003047.17721-1-o-takashi@sakamocchi.jp>
 <20170526003047.17721-3-o-takashi@sakamocchi.jp>
 <s5ha860jf2o.wl-tiwai@suse.de>
 <d4f82e6e-d402-cc5f-92ef-f37e67fc0682@sakamocchi.jp>
 <s5h8tlkjeqx.wl-tiwai@suse.de>
 <7c1610fe-0546-73b9-f8b0-d6bd65a13b29@sakamocchi.jp>
 <s5h60gojdod.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D6E93266B88
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 10:46:10 +0200 (CEST)
In-Reply-To: <s5h60gojdod.wl-tiwai@suse.de>
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

On May 26 2017 16:10, Takashi Iwai wrote:
> On Fri, 26 May 2017 08:54:27 +0200,
> Takashi Sakamoto wrote:
>>
>> On May 26 2017 15:47, Takashi Iwai wrote:
>>>>> Queued now, but will be likely declined later due to the rewrites of
>>>>> the code.
>>>>
>>>> Due to your recent work under reviewing?
>>>
>>> Yes, the code might be changed heavily.
>>> Don't touch a too hot spot if it were only a cleanup.
>>
>> I've already reviewed it but postpone my reply to this evening. (I'm
>> in paid work now.)
>>
>> Your patchset looks a middle of work. It includes the lack of changes
>> for each drivers, thus not bisect-able.
> 
> Yes, it was mentioned so in the cover letter.
> 
>> I think you will re-post the
>> full series of patches several days after reviewed. Then you have
>> chance to rebase it to recent HEAD of your tree, don't you?
> 
> My patches are already ready.  I didn't post the full set just because
> it's too much.  The patch "snippet" was shown as a demonstration.

Yes, like I did in my previous patchset.

> And, why do you think there is only one patchset?
> Usually I write several different implementations and choose the best one
> for submission.  That is, I already have a few other patchsets in my local
> tree based on the current code base.  And even further works on PCM
> code are pending.

I can easily imagine how you progress the work, because I have some 
topic branch in my local repository as well, for PCM core. They're also 
ready, like yours. However, I accept changes of HEAD of remote branch. 
HEAD tends to move regardless of my work. When posting my patchset, I 
always work to rebase to the HEAD. This often brings me a bit work, and 
next week I'll surely do it, but it's natural to me.

Here, I don't necessarily request you to merge them promptly. I'm just 
interested in your current situation, in short, the reason to postpone 
this patch. In my eyes, this patch surely brings conflict to your future 
patchset, but it has a small changes and the occurred conflict can be 
fixed quickly. I understand that you'd like to save the time for it.

> So which is easier to rebase and handle?  Which one has more
> significant changes?  A single trivial cleanup patch, or the whole
> several sets of patchsets?  The answer is clear to my eyes.

Hm.

It depends on the shape of patchset, regardless of the importance, in my 
humble opinion.

When it includes large changes, it takes longer time to review. When a 
patchset is splitted into small parts and posted sequentially with each 
of topics, reviewer finishes his or her work within shorter time 
relatively. I'll post my comments to your recent work later, but here 
your patchset looks to include refactoring, integration and more. It 
seems takes more time to merge into HEAD and I cannot post the series of 
my works (they depends each other) even if my patches are enough small. 
That's my concern here.


Regards

Takashi Sakamoto
