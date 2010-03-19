From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
 to snd_soc_pcm_stream
Date: Fri, 19 Mar 2010 08:50:23 +0000
Message-ID: <1268988623.3757.4.camel@odin>
References: <20100318182211.GH6142@rakim.wolfsonmicro.main>
	<1268940238-6283-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id B48E41037EE
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 09:50:43 +0100 (CET)
Received: by bwz20 with SMTP id 20so3568281bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 01:50:42 -0700 (PDT)
In-Reply-To: <1268940238-6283-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Michael Hirsch <m.hirsch@raumfeld.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-18 at 20:23 +0100, Daniel Mack wrote:
> This fixes a memory corruption when ASoC devices are used in
> full-duplex mode. Specifically for pxa-ssp code, where this pointer
> is dynamically allocated for each direction and destroyed upon each
> stream start.
> 
> All other platforms are fixed blindly, I couldn't even compile-test
> them. Sorry for any breakage I may have caused.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Sven Neumann <s.neumann@raumfeld.com>
> Cc: Michael Hirsch <m.hirsch@raumfeld.com>
> Reported-by: Sven Neumann <s.neumann@raumfeld.com>
> Reported-by: Michael Hirsch <m.hirsch@raumfeld.com>
> ---
> 
> I indeed missed quite a few platforms, you were right.
> Hope I got them all now. Better check again - thanks!
> 

All the platforms here look fine. 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
