From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: race condition between dmaengine_pcm_dma_complete
 and snd_pcm_release
Date: Thu, 08 Oct 2015 11:02:27 +0200
Message-ID: <56163123.9020106@metafoo.de>
References: <CAMDowVWrLOK1Ysmfe1zTujw0Ev5PjPei1RBH8t_Mve_fsfe2ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-060.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 392D826172C
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 11:04:03 +0200 (CEST)
In-Reply-To: <CAMDowVWrLOK1Ysmfe1zTujw0Ev5PjPei1RBH8t_Mve_fsfe2ww@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Campbell <mcampbell@izotope.com>, alsa-devel@alsa-project.org, dmaengine <dmaengine@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 10/06/2015 11:45 PM, Matt Campbell wrote:
> Hi All,
> 
> I've been trying to track down a kernel crash I've been getting when
> closing ALSA devices. There is a race condition between the bottom half
> interrupt handler for the DMA system (dmaengine_pcm_dma_complete in
> pcm_dmaengine.c) and the releasing of the sub-stream resources it receives
> as an argument (when snd_pcm_release is called). An older thread from 2013
> discussed this to a good extent so I wont go into the details here. I've
> been unable to track down either a patch to fix this or even a good
> solution that I could implement. I've spent a couple days trying to think
> of an elegant solution and come up with nothing so far. Any input would be
> appreciated.
> 
> Link to original thread:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067111.html
> 
> It's worth nothing that the original thread points out how this can arise
> on multi-core systems. In my case I'm on a single core system, but with the
> real-time patch enabled and the userspace ALSA thread running at a higher
> priority than the kernel's tasklet thread which can reproduce this almost
> 100% of the time.

Hi,

The answer is still the same. This is an inherent issue with the DMAengine
API that needs to be fixed by adding a synchronization primitive that allows
consumers to make sure that all completion tasklets have stopped running.
Unfortunately this wasn't implemented yet, but I need this in other places
outside of ASoC and it's on my TODO list and I'll hopefully get to it in the
next 2 months.

But in your case on a single CPU system it could also be an issue with the
DMA controller driver itself not properly stopping the transfer when
dma_terminate_all() is called.

- Lars
