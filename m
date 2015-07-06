From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Issue in alsa when dma complete race with pcm
	release
Date: Mon, 06 Jul 2015 14:27:01 +0200
Message-ID: <559A7415.8000006@metafoo.de>
References: <20150703082530.GA21580@shlinux2> <55966A75.90200@metafoo.de>
 <20150706090113.GA4995@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 072242605C3
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 14:27:03 +0200 (CEST)
In-Reply-To: <20150706090113.GA4995@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/06/2015 11:01 AM, Shengjiu Wang wrote:
> On Fri, Jul 03, 2015 at 12:56:53PM +0200, Lars-Peter Clausen wrote:
>> On 07/03/2015 10:25 AM, Shengjiu Wang wrote:
>>> Hi alsa-devel
>>>
>>>     There maybe a issue in ALSA when dma complete race with snd_pcm_release.
>>> The pcm release and dma complete are in different thread. There is occasion
>>> that dmaengine_pcm_dma_complete() is called too late, some memory has been
>>> freed, the prtd is null. Then there is kernel dump.
>>>
>>>     Is there any solution for this issue? Thanks.
>>
>> We need to introduce a synchronization primitive that allows a
>> dmaengine client to synchronize to the execution of the complete
>> callbacks.
>>
>> terminate_all() unfortunately can't do this since terminate_all()
>> might be called from within one of the complete callbacks and so
>> would cause a deadlock if we'd wait for all complete callbacks to
>> finish before terminate_all() returns.
>>
>> So what is needed is a new function called dmaengine_sync() that
>> will wait until all scheduled complete callbacks have finished. A
>> call to this function needs to be put in snd_dmaengine_pcm_close()
>> before the prtd is closed.
>>
>> - Lars
>
> How to check " all scheduled complete callbacks have finished"?

That will be up to the dmaengine driver. But it basically comes down to two 
things:

1) The driver needs to make sure that tasklet_schedule() is no longer called 
after terminate_all() has finished.
2) In the sync() callback call tasklet_kill() to make sure that it has 
finished running

>
> One concern is if add wait in snd_dmaengine_pcm_close(), which wil cause
> the snd_pcm_release is bound with dmaengine, when there is error in dma
> and no callback be called. Then the snd_pcm_release will not be released.

The sync() function will only wait if there is a callback scheduled, if 
there is non scheduled it will return immediately.
