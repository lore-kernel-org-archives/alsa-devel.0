From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: Let snd_soc_limit_volume() take a
	snd_soc_card
Date: Sun, 18 Oct 2015 20:26:03 +0300
Message-ID: <5623D62B.6020504@bitmer.com>
References: <1445180673-27790-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 618B52651C7
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 19:26:08 +0200 (CEST)
In-Reply-To: <1445180673-27790-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/18/2015 06:04 PM, Lars-Peter Clausen wrote:
> snd_soc_limit_volume() operates on a card and the CODEC that is passed in
> is only used to look up the card. Let it directly take the card instead.
> This makes it possible to use it when no snd_soc_codec is available.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  include/sound/soc.h   | 2 +-
>  sound/soc/omap/rx51.c | 2 +-
>  sound/soc/soc-ops.c   | 8 ++++----

For rx51:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
