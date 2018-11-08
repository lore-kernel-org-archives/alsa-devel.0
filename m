From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: GitHub - alsa-project - repositories
Date: Thu, 8 Nov 2018 23:20:41 +0900
Message-ID: <fea4f32f-625c-7e2e-3911-667221a43877@sakamocchi.jp>
References: <031c30f1-36b6-4cd9-3f67-3e8de8c77a3e@perex.cz>
 <fe3a3e44-f712-fac0-a76b-c91b5a1a222e@sakamocchi.jp>
 <970ae06c-be01-8cef-930e-a7c0bccfa31b@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 28D10267AB4
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2018 15:20:46 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id p16-v6so9611652plr.8
 for <alsa-devel@alsa-project.org>; Thu, 08 Nov 2018 06:20:46 -0800 (PST)
In-Reply-To: <970ae06c-be01-8cef-930e-a7c0bccfa31b@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

Thanks for your reply.

On 2018/11/06 18:20, Jaroslav Kysela wrote:
>> I have two concerns.
>>
>> 1. For Ubuntu 14.04 LTS (trusty), End-of-life (EOL) is scheduled April
>> 2019. A few months remained but it's better to use recent LTSs such as
>> 18.04 (bionic) to reduce future maintenance cost. (I guess packages
>> except on 'main' pocket are not already maintained for security
>> updates.)
> 
> I think that we have limited choices:
> 
> https://docs.travis-ci.com/user/reference/overview/

Oh, indeed. It's reasonable currently, but I continue to take care of
travis-ci action against the EOF.

>> 2. Message for PR
>> In my opinion, notification to alsa-devel list is an alternative of
>> cover-letters in the past. But in this time it doesn't includes change
>> summary, like:
>>
>> ```
>> Takashi Sakamoto (3):
>>     aplay: delete paragraph for obsoleted '--sleep-min' ('-s') option from
>>       aplay manual
>>     aplay: add a paragraph for '--samples' ('-s') option to aplay manual
>>     aplay: improve available conditions for '--samples' and '--duration'
>>       options
>>
>>    aplay/aplay.1 | 10 +++++++---
>>    1 file changed, 7 insertions(+), 3 deletions(-)
>> ```
>>
>> If it's difficult to include the change summary automatically into the
>> notification, it's worth to discuss that PR senders should include it
>> handy to PR message.
> 
> Actually, I can work directly only with the information from the webhooks:
> 
> https://developer.github.com/v3/activity/events/types/#pullrequestevent
> 
> The webhook code used on my server is in python, so we can probably
> fetch the patch from github and generate the diffstat from it.
Sounds good, but I don't mind to postpone the idea because this is not
so critical issue. Readers of posted issue can see diffstat in
github.com.


Well, I have another concern when having conversation with Daniel
Baluta[1]. He post his 'Reviewed-by' tag to the github issue. In this
case, how can we apply the tag to commit history? I don't know exactly
services in github.com have good solution for this issue, or not...

[1] https://github.com/alsa-project/alsa-utils/pull/1#issuecomment-436164565


Thanks

Takashi Sakamoto
