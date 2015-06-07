From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: rx51: Automatically disconnect
	non-connected pins
Date: Sun, 07 Jun 2015 16:58:27 +0300
Message-ID: <55744E03.3000006@bitmer.com>
References: <1433427231-21756-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 46FDA260484
 for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2015 15:58:36 +0200 (CEST)
In-Reply-To: <1433427231-21756-1-git-send-email-lars@metafoo.de>
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

On 06/04/2015 05:13 PM, Lars-Peter Clausen wrote:
> According to the schematics the external speaker is differential, so the
> HPLCOM and HPRCOM pins of the CODEC should be connected to it.
> 
> Otherwise the routing looks complete, so add the missing routes and set the
> fully_routed flag of the card instead of manually marking the unused inputs
> and outputs as not connected. This makes the code a bit shorter and
> cleaner.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/omap/rx51.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
