From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/4] ASoC: omap: Replace instances of
 rtd->codec->card with rtd->card
Date: Tue, 20 May 2014 07:40:39 +0300
Message-ID: <20140520044039.GA28674@bitmer.com>
References: <1400492508-2732-1-git-send-email-lars@metafoo.de>
 <1400492508-2732-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CDC3261684
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 06:40:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1400492508-2732-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 19, 2014 at 11:41:46AM +0200, Lars-Peter Clausen wrote:
> No need to go via the CODEC to get a pointer to the card. This will help to
> eventually remove the card field from the snd_soc_codec struct.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/omap/omap-abe-twl6040.c | 5 ++---
>  sound/soc/omap/omap-twl4030.c     | 5 ++---
>  sound/soc/omap/rx51.c             | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
