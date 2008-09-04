From: Mark Lokowich <lokowich@acdstar.com>
Subject: Re: DaVinci ASoC DMA stalls
Date: Thu, 04 Sep 2008 17:23:57 -0500
Message-ID: <48C05FFD.4030009@acdstar.com>
References: <48BFE50E.3000802@acdstar.com> <48C015B2.2070401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g2host.com (mailfront2.g2host.com [208.42.176.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 3337F243B5
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 00:24:28 +0200 (CEST)
In-Reply-To: <48C015B2.2070401@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Caglar Akyuz <caglarakyuz@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

I did have to add a getposition accessor to the DaVinci DMA module, 
which is used by the pcm_pointer function.  Other than that, I believe 
the ASoC should build.  My test is simply to run aplay or speaker-test, 
then quit and run it again.  The first run is audible, the second and 
subsequent runs are not audible until I provide a manual DMA event trigger.

Mark

Caglar Akyuz wrote:
> Mark Lokowich wrote:
>
>   
>> I've been using the DaVinci ASoC for a few months and have recently
>> upgraded to the 2.6.26 based DaVinci git kernel.  Now my audio DMA
>> stalls more readily after stopping an active stream.  I can manually
>> trigger the event by poking the ESR to reactivate the stalled stream,
>> suggesting the problem is in the ASP-to-DMA XEVT interface.  This
>> problem is less prevalent in the 2.6.25 based kernel.  Any help?
>>
>>     
>
>
> I don't know if this helps but, I am using ASoC code on my DaVinci board
> with latest git kernel(2.6.27) and I have no visible issues with the ASoC
> code. However, there may be some code-coverage issue with my usage so if you
> have any test method to verify that I really don't have your problem I'll
> be happy to perform some tests.
>
> My real concern is that this code has never been built without any problems here.
> First there was a separate asoc branch in davinci tree which failed to built.
> I tried with 2.6.25 and there was again build issues. Finally I wasn't able to
> build ASoC code with 2.6.27 so I tried to patch it. I think some part of it 
> relies on some dma code which is not present in davinci tree.[1] I don't know
> if everybody else is patching kernel source to build asoc support, maybe I'm
> doing something wrong. I'm not sure, just FYI.
>
> Regards,
> Caglar
>
> [1] http://linux.omap.com/pipermail/davinci-linux-open-source/2008-March/005920.html
>
>
>   
