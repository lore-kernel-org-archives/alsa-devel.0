From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: Issue in alsa when dma complete race with pcm
 release
Date: Tue, 7 Jul 2015 18:13:04 +0800
Message-ID: <20150707101302.GA22212@shlinux2>
References: <20150703082530.GA21580@shlinux2> <55966A75.90200@metafoo.de>
 <20150706090113.GA4995@shlinux2> <559A7415.8000006@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0143.outbound.protection.outlook.com [65.55.169.143])
 by alsa0.perex.cz (Postfix) with ESMTP id CD19C2618ED
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 13:21:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <559A7415.8000006@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: dmaengine <dmaengine@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 06, 2015 at 02:27:01PM +0200, Lars-Peter Clausen wrote:
> On 07/06/2015 11:01 AM, Shengjiu Wang wrote:
> >On Fri, Jul 03, 2015 at 12:56:53PM +0200, Lars-Peter Clausen wrote:
> >>On 07/03/2015 10:25 AM, Shengjiu Wang wrote:
> >>>Hi alsa-devel
> >>>
> >>>    There maybe a issue in ALSA when dma complete race with snd_pcm_release.
> >>>The pcm release and dma complete are in different thread. There is occasion
> >>>that dmaengine_pcm_dma_complete() is called too late, some memory has been
> >>>freed, the prtd is null. Then there is kernel dump.
> >>>
> >>>    Is there any solution for this issue? Thanks.
> >>
> >>We need to introduce a synchronization primitive that allows a
> >>dmaengine client to synchronize to the execution of the complete
> >>callbacks.
> >>
> >>terminate_all() unfortunately can't do this since terminate_all()
> >>might be called from within one of the complete callbacks and so
> >>would cause a deadlock if we'd wait for all complete callbacks to
> >>finish before terminate_all() returns.
> >>
> >>So what is needed is a new function called dmaengine_sync() that
> >>will wait until all scheduled complete callbacks have finished. A
> >>call to this function needs to be put in snd_dmaengine_pcm_close()
> >>before the prtd is closed.
> >>
> >>- Lars
> >
> >How to check " all scheduled complete callbacks have finished"?
> 
> That will be up to the dmaengine driver. But it basically comes down
> to two things:
> 
> 1) The driver needs to make sure that tasklet_schedule() is no
> longer called after terminate_all() has finished.
Some driver can't make sure this. The dma interrupt may come later after
terminate_all.
> 2) In the sync() callback call tasklet_kill() to make sure that it
> has finished running
> 
> >
> >One concern is if add wait in snd_dmaengine_pcm_close(), which wil cause
> >the snd_pcm_release is bound with dmaengine, when there is error in dma
> >and no callback be called. Then the snd_pcm_release will not be released.
> 
> The sync() function will only wait if there is a callback scheduled,
> if there is non scheduled it will return immediately.


Do you have other method to resolve this issue? or simple method?

Best regards
wang shengjiu
