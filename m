From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
 to snd_soc_pcm_stream
Date: Fri, 19 Mar 2010 11:14:27 +0200
Message-ID: <20100319111427.4222b968.jhnikula@gmail.com>
References: <20100318182211.GH6142@rakim.wolfsonmicro.main>
	<1268940238-6283-1-git-send-email-daniel@caiaq.de>
	<201003190856.40650.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id AB382103889
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 10:12:38 +0100 (CET)
Received: by ewy23 with SMTP id 23so1607423ewy.4
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 02:12:38 -0700 (PDT)
In-Reply-To: <201003190856.40650.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Michael Hirsch <m.hirsch@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Mar 2010 08:56:40 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> At least the OMAP code should not be affected by the bug, that you have with the 
> pxa-ssp. I think the bug could be also fixed within the pxa code, since the 
> whole thing goes down to inconsistent memory management within the pxa code.
> 
> Having said that, I do think having separate dma_data for each streams is a 
> really good idea.
> One thing that I can think of in OMAP case, where this could fix a nasty race 
> condition is (have never seen it, but it is in theory possible):
> Also in duplex case, when the second hw_param gets called after the first 
> omap_mcbsp_hw_params, and before the omap_pcm_hw_params for the first stream.
> The second omap_mcbsp_hw_params will override the dma_data, thus we would set 
> bogus parameters for the first stream.
> 
There shouldn't be this kind of race in OMAP since the soc_pcm_hw_params
protects the hw_params calls with a mutex and the omap_pcm_hw_params
takes a copy from parameters passed from DAI driver's hw_params.

But yes, I agree that the stream specific dma_data is good idea.

> For the omap-mcbsp.c and omap-pcm.c changes:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
