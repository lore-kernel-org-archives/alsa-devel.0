From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: integration into ASoC
Date: Mon, 10 Mar 2014 18:23:10 +0100
Message-ID: <531DF4FE.2020405@metafoo.de>
References: <20140307165335.GT607@lukather> <5319FE01.3070909@metafoo.de>
 <20140310095039.GC2815@lukather> <531D90C1.8000800@metafoo.de>
 <20140310164307.GH2815@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-237.synserver.de
 [212.40.185.237])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E9BE265166
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 18:22:32 +0100 (CET)
In-Reply-To: <20140310164307.GH2815@lukather>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zhuzhenhua@allwinnertech.com, Mark Brown <broonie@kernel.org>, kevin.z.m.zh@gmail.com, sunny@allwinnertech.com, shuge@allwinnertech.com
List-Id: alsa-devel@alsa-project.org

On 03/10/2014 05:43 PM, Maxime Ripard wrote:
>>>
>>>> Right now ASoC expects you to specify a DAI link for a PCM
>>>> device. The DAI link connects the DAIs of two components typically
>>>> the SoC side and a external CODEC. In your case you do not have the
>>>> external CODEC. You can solve this by using a dummy CODEC or
>>>> splitting things up and register both the CODEC and the CPU DAI from
>>>> the same driver.
>>>
>>> That would probably be the best solution, yes.
>>>
>>>> But I'm currently working on a patchset that will eventually allow
>>>> these kind of devices to be supported more naturally. It will allow
>>>> to register them as one component that won't need the CODEC
>>>> component to work.
>>>
>>> Great! Do you have a branch with that work somewhere?
>>
>> Not yet. But I hope to get there in the next weeks.
>
> Could you put me in Cc whenever you post them for feedback/testing?

Sure. I just had a quick peek at the datasheet and I think you should be 
able to get away with implementing this as a CODEC driver for now and use 
the dummy-dai for the CPU side in you DAI link.

- Lars
