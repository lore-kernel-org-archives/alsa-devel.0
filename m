From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
 to snd_soc_pcm_stream
Date: Fri, 19 Mar 2010 19:39:58 +0100
Message-ID: <20100319183958.GA30801@buzzloop.caiaq.de>
References: <20100318182211.GH6142@rakim.wolfsonmicro.main>
	<1268940238-6283-1-git-send-email-daniel@caiaq.de>
	<201003190856.40650.peter.ujfalusi@nokia.com>
	<20100319070852.GR30801@buzzloop.caiaq.de>
	<20100319151453.GH23306@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E3271038AB
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 19:40:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100319151453.GH23306@rakim.wolfsonmicro.main>
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
Cc: Sven Neumann <s.neumann@raumfeld.com>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Michael Hirsch <m.hirsch@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 19, 2010 at 03:14:53PM +0000, Mark Brown wrote:
> I agree with both of you, we can always tidy the code up later but cross
> platform changes need some sync.  I've applied the patch, thanks once
> again for analysing this and to everyone else for their review.

Thanks! I assume this is going to be taken for .34 and .35?
And how is backporting done - I think we should probably also get this
into .33 and .32?

Daniel
