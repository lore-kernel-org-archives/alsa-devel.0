From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
 to snd_soc_pcm_stream
Date: Sat, 20 Mar 2010 15:54:29 +0100
Message-ID: <20100320145428.GC30801@buzzloop.caiaq.de>
References: <20100318182211.GH6142@rakim.wolfsonmicro.main>
	<1268940238-6283-1-git-send-email-daniel@caiaq.de>
	<201003190856.40650.peter.ujfalusi@nokia.com>
	<20100319070852.GR30801@buzzloop.caiaq.de>
	<20100319151453.GH23306@rakim.wolfsonmicro.main>
	<20100319183958.GA30801@buzzloop.caiaq.de>
	<20100319195422.GB15902@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B3F42443E
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 15:54:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100319195422.GB15902@opensource.wolfsonmicro.com>
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

On Fri, Mar 19, 2010 at 07:54:22PM +0000, Mark Brown wrote:
> On Fri, Mar 19, 2010 at 07:39:58PM +0100, Daniel Mack wrote:
> > Thanks! I assume this is going to be taken for .34 and .35?
> 
> I've applied it for 2.6.35 only at present, I'd rather let it cook for a
> little before picking it back - like you I can only test a limited set
> of architectures.  Unfortunately it doesn't cherry pick backwards
> either, but the updates required do appear to be trivial.

Agreed. However, I believe when pushed to .34, it will get greater
exposion, and regressions would more likely be found and get fixed.
Faster than in your for-2.6.35 branch I mean.

Daniel
