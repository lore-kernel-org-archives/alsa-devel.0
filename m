From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 2/5] ASoC: cs42xx8: Make of match table
	static
Date: Thu, 19 Jun 2014 08:50:43 -0500
Message-ID: <alpine.DEB.2.02.1406190850050.25941@heelrod>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
 <1403163631-26215-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 95D5A26568E
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 15:48:24 +0200 (CEST)
In-Reply-To: <1403163631-26215-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Jun 2014, Lars-Peter Clausen wrote:

> The cs42xx8_of_match table is not used outside of the driver, hence it can and
> should be made static.
>
> Fixes the following warning from sparse:
> 	sound/soc/codecs/cs42xx8.c:425:27: warning: symbol 'cs42xx8_of_match' was
> 	not declared. Should it be static?
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks,
