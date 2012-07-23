From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 19:51:52 +0530
Message-ID: <CAJe_ZhcWhzUr-q8Z=0r=KSXG07RzuZTsr9VAm0ZPqRwDff8Uig@mail.gmail.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <20120723101851.GG4435@opensource.wolfsonmicro.com>
 <1343039946.1726.4830.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ABA2265CD1
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 16:21:51 +0200 (CEST)
Received: by vcbf11 with SMTP id f11so4678118vcb.38
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 07:21:53 -0700 (PDT)
In-Reply-To: <1343039946.1726.4830.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 23 July 2012 16:09, Vinod Koul <vinod.koul@linux.intel.com> wrote:

> Take the case of a DSP which employs DMA on input and output (of the
> DSP)
> At start, DSP would buffer some data, assuming a period. And assume app
> has filed one period only. So at start as we buffered a period, ALSA
> threw up wrong xrun, as it wasn't aware that this buffer is not yet
> rendered.
>
I thought the data was supposed to leave the ring-buffer only _after_
the TRIGGER_START call ?
