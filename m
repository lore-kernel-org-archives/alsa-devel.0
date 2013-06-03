From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: mxs: mxs-saif: Fix the
 playback/record capabilities
Date: Mon, 03 Jun 2013 17:07:57 +0200
Message-ID: <51ACB14D.2050205@metafoo.de>
References: <1370191092-1773-1-git-send-email-festevam@gmail.com>
 <51ABA36D.8020802@metafoo.de> <20130603092028.GD31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-047.synserver.de
 [212.40.185.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 1087C261ADA
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 17:08:06 +0200 (CEST)
In-Reply-To: <20130603092028.GD31367@sirena.org.uk>
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
Cc: marex@denx.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/03/2013 11:20 AM, Mark Brown wrote:
> On Sun, Jun 02, 2013 at 09:56:29PM +0200, Lars-Peter Clausen wrote:
> 
>> Not sure if this is the right approach, there is no limitation on either
>> saif0 or saif1 that it can only be used for capture or playback. Some
>> systems may use saif1 as playback and saif0 as capture, or both as playback
>> and so on...
> 
> Is there a limitation on the CODEC side or does the CODEC side have a
> single bidirectional interface?

I think the sgtl5000 has a single bidirectional DAI, but I'd assume that it
is not the only CODEC to be ever used with the mxs-saif. In my opinion a
better solution is to add support for being able to specify if a
snd_soc_dai_link is used playback, capture or both.

- Lars
