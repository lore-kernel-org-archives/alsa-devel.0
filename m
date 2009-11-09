From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH V2] ASoC - Add support for upto 16 channels
 on OMAP MCBSP
Date: Mon, 9 Nov 2009 10:14:11 +0200
Message-ID: <20091109101411.12a75af0.jhnikula@gmail.com>
References: <1257454808.3576.397.camel@odin>
	<6ed0b2680911071211g311e6399va88ff7daff7b8ed1@mail.gmail.com>
	<1257712022.15162.2.camel@vega>
	<200911090929.02019.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 2638510383F
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 09:13:19 +0100 (CET)
Received: by bwz9 with SMTP id 9so12056728bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 09 Nov 2009 00:13:18 -0800 (PST)
In-Reply-To: <200911090929.02019.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Nov 2009 09:29:01 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> I think if I set the mcbsp_data->in_freq to be:
> params_rate(params) * sample_bits * channels, and configure the mcbsp_data-
> >clk_div to be 1, might work in this case.
> 
I think it's cleanest to calculate frame size conditionally based on
SND_SOC_DAIFMT_CBS_CFS or testing !in_freq and let the frame
size to be wlen * channels in other cases.

If it's based on !in_freq, then the in_freq must be set in
omap_mcbsp_dai_set_dai_sysclk only for OMAP_MCBSP_SYSCLK_xxx cases
since this function is called also when setting CLKR and FSR sources
(no need to pass frequency).


-- 
Jarkko
