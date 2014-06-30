From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/5] ASoC: omap-pcm: Include omap-pcm.h
Date: Mon, 30 Jun 2014 18:48:33 +0200
Message-ID: <53B194E1.1080209@metafoo.de>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
 <1403163631-26215-4-git-send-email-lars@metafoo.de>
 <20140621200002.GL5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 974052655C4
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 18:48:32 +0200 (CEST)
In-Reply-To: <20140621200002.GL5099@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 06/21/2014 10:00 PM, Mark Brown wrote:
> On Thu, Jun 19, 2014 at 09:40:29AM +0200, Lars-Peter Clausen wrote:
>> omap_pcm_platform_register() is declared in omap-pcm.h and defined in
>> omap-pcm.c. To make sure that the function signature matches for both omap-pcm.c
>> should include omap-pcm.h
>
> Applied, thanks.

This patch somehow did not make it, the patch is not in asoc/next, nor is 
there a asoc/topic/omap or similar. Shall I resend?

Thanks,
- Lars
