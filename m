From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and
 disable TIE/RIE in trigger()
Date: Tue, 29 Oct 2013 07:40:33 -0500
Message-ID: <526FACC1.7010909@tabi.org>
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org> <20131029115711.GA9605@MrMyself>
 <526FA78D.2090601@tabi.org> <20131029121330.GB9605@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id B8130261ACB
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 13:40:35 +0100 (CET)
In-Reply-To: <20131029121330.GB9605@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> The DMA request might be remaining high if not disabling it.

Might?  Are you just guessing?

> This would
> cause SDMA re-check this request, while it has no BD existing. For the
> other interrupts, if you don't like it, I can drop it. Just modification
> to the driver might not be less complicated.

I'm only talking about this particular patch.
