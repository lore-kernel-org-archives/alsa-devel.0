From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
 to snd_soc_pcm_stream
Date: Thu, 18 Mar 2010 19:11:09 +0100
Message-ID: <20100318181109.GB30807@buzzloop.caiaq.de>
References: <1268933737.3773.36.camel@odin>
	<1268935739-2931-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 49285103874
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 19:11:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268935739-2931-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Michael Hirsch <m.hirsch@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 07:08:59PM +0100, Daniel Mack wrote:
> This fixes a memory corruption when using ASoC devices are used in
> full-duplex mode. Specifically for pxa-ssp code, where this pointer

Sorry - in case the patch is ok, could you please fix up my grammar bug?

Thanks,
Daniel
