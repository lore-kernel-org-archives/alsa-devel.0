From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and
 disable TIE/RIE in trigger()
Date: Tue, 29 Oct 2013 13:00:10 +0000
Message-ID: <50y5h8hi19x5t2r9jhjrk097.1383051600782@email.android.com>
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org> <20131029115711.GA9605@MrMyself>
 <526FA78D.2090601@tabi.org>
 <20131029121330.GB9605@MrMyself>,<526FACC1.7010909@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 67C11261B03
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 14:00:23 +0100 (CET)
In-Reply-To: <526FACC1.7010909@tabi.org>
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
To: Timur Tabi <timur@tabi.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

I mean there is a possibility.

 I'm sorry if my patch is kinda annoying and it really bother you, sir. I also want to make things better.

If you really don't like it, we can drop it. It's all your call.

And thank you for reviewing.

Sent by Android device.

Timur Tabi <timur@tabi.org> wrote:


Nicolin Chen wrote:
> The DMA request might be remaining high if not disabling it.

Might?  Are you just guessing?

> This would
> cause SDMA re-check this request, while it has no BD existing. For the
> other interrupts, if you don't like it, I can drop it. Just modification
> to the driver might not be less complicated.

I'm only talking about this particular patch.
