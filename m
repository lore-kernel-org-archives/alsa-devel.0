From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Wed, 17 Feb 2010 16:37:21 +0900
Message-ID: <4B7B9CB1.8080204@samsung.com>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com>
	<1b68c6791002162324kbeb220dm23031e3115e617ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 68B54103853
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 08:37:25 +0100 (CET)
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KXZ00MMA6I9HZ@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 17 Feb 2010 16:37:21 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KXZ00K8B6I8LB@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 17 Feb 2010 16:37:20 +0900 (KST)
In-reply-to: <1b68c6791002162324kbeb220dm23031e3115e617ca@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On 2/17/2010 4:24 PM, jassi brar wrote:
> On Wed, Feb 17, 2010 at 3:58 PM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
>> Additionally, i have one more question.
>>
>> At the ASoC, is there a situation to share the dai(cpu or codec)?
> Currently, ASOC doesn't allow sharing cpu or codec dai.
> 
>> If the dai is shared, i just think the ASoC core cannot support it.
> Correct.
> 
>> There is the case at the S5PC1XX, it supports the hardware mixing by
>> using two tx fifo. First Jassi implemented codes using each other cpu
>> dai as Jassi says at the above for the hardware mixing, but it should
>> share codec_dai and need some modification of ASoC core.
>> (I can see codes at the below url
>> http://git.kernel.org/?p=linux/kernel/git/kki_ap/linux-2.6-samsung.git)
>> Jassi, how do you think about this?
> Though outside this topic, please see latest code from samsung GIT.
> I already share wm8580 dai with I2S primary_fifo dai as well
> as secondary_fifo dai. I implemented temporary workaround to share
> dais(luckily codec_dai wasn't used in a way to make it impossible,
> though cpu_dai still can't be shared).
> Also, there is some reason I didn't point to our repository:- the code is
> not meant for mainline. It's just a 'workaround' for urgent requirement.
> 

I think even if it is workaround, the codes orient should go to the 
right side. Anyway, i just wonder about sharing the dai and supporting 
it at the ASoC.
