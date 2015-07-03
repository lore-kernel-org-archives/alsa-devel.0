From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Issue in alsa when dma complete race with pcm
	release
Date: Fri, 03 Jul 2015 12:56:53 +0200
Message-ID: <55966A75.90200@metafoo.de>
References: <20150703082530.GA21580@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-007.synserver.de (smtp-out-022.synserver.de
 [212.40.185.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 65598260484
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 12:56:55 +0200 (CEST)
In-Reply-To: <20150703082530.GA21580@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org
Cc: dmaengine <dmaengine@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 07/03/2015 10:25 AM, Shengjiu Wang wrote:
> Hi alsa-devel
>
>     There maybe a issue in ALSA when dma complete race with snd_pcm_release.
> The pcm release and dma complete are in different thread. There is occasion
> that dmaengine_pcm_dma_complete() is called too late, some memory has been
> freed, the prtd is null. Then there is kernel dump.
>
>     Is there any solution for this issue? Thanks.

We need to introduce a synchronization primitive that allows a dmaengine 
client to synchronize to the execution of the complete callbacks.

terminate_all() unfortunately can't do this since terminate_all() might be 
called from within one of the complete callbacks and so would cause a 
deadlock if we'd wait for all complete callbacks to finish before 
terminate_all() returns.

So what is needed is a new function called dmaengine_sync() that will wait 
until all scheduled complete callbacks have finished. A call to this 
function needs to be put in snd_dmaengine_pcm_close() before the prtd is closed.

- Lars
