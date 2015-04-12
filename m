From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/2] ASoC: n810: Automatically disconnect
 non-connected pins
Date: Sun, 12 Apr 2015 11:52:05 +0300
Message-ID: <552A3235.7050403@bitmer.com>
References: <1428742078-9704-1-git-send-email-lars@metafoo.de>
 <1428742078-9704-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A5836260504
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 10:52:13 +0200 (CEST)
In-Reply-To: <1428742078-9704-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/11/2015 11:47 AM, Lars-Peter Clausen wrote:
> All CODEC input and output widgets are either in the DAPM routing table or
> manually marked as non-connected. This means the card is fully routed and we
> can let the core take care of disconnecting non-connected pins.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/omap/n810.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
Both,

Jarkko Nikula <jarkko.nikula@bitmer.com>
