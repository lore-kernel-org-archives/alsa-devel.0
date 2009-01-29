From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can DMA address, periods, buffer size,
 etc change after hw_params is called?
Date: Thu, 29 Jan 2009 09:58:10 +0100
Message-ID: <49816FA2.3030108@ladisch.de>
References: <20090129081825.241be9e4@hcegtvedt>	<498164BC.6080907@ladisch.de>
	<20090129094332.2728c908@hcegtvedt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id E6DEF103854
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 09:58:13 +0100 (CET)
In-Reply-To: <20090129094332.2728c908@hcegtvedt>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hans-Christian Egtvedt wrote:
> Is there a chance that the following might happen:
>  - stop trigger,
>  - hw_free
>  - hw_params
>  - prepare
>  - start trigger
> 
> I.e. without calling close and open?

Yes.

It is also possible that the same happens without hw_free, i.e.,
hw_params has to initialize _or_ to change the parameters.

> Clemens Ladisch <clemens@ladisch.de> wrote:
> > The DMA address is selected by the driver in the hw_params callback,
> > but most drivers let the framework handle this by calling
> > snd_pcm_lib_malloc_pages().
> 
> Yes, this is what I do today. I am considering if I should release the
> DMA stuff in hw_free and then in the prepare callback check if it needs
> to be prepared again (since it was released in hw_free).

The framework guarantees that prepare is called only when the hardware
parameters are set.


Best regards,
Clemens
