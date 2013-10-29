From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and
 disable TIE/RIE in trigger()
Date: Tue, 29 Oct 2013 20:13:31 +0800
Message-ID: <20131029121330.GB9605@MrMyself>
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org> <20131029115711.GA9605@MrMyself>
 <526FA78D.2090601@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 78DB2261AA4
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 13:29:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <526FA78D.2090601@tabi.org>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 29, 2013 at 07:18:21AM -0500, Timur Tabi wrote:
> Nicolin Chen wrote:
> >Well, actually I just wanted to clear T/RDMAE to disable DMA request,
> >but it seems to be much easier to do it like this based on current
> >code and disabling unused interrupts should be better right?:)
> 
> It's not better if it complicates the code and has no real impact.
> The code has been running fine for years the way it is.  Unless you
> can show me that it actually makes a difference, I will have to NACK
> this patch.
>

The DMA request might be remaining high if not disabling it. This would
cause SDMA re-check this request, while it has no BD existing. For the
other interrupts, if you don't like it, I can drop it. Just modification
to the driver might not be less complicated.

Thank you,
Nicolin Chen
