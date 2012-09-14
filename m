From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: Avoid recalculating the bitmask for
	SOC_ENUM controls
Date: Fri, 14 Sep 2012 15:10:56 +0300
Message-ID: <50531ED0.3090005@ti.com>
References: <1347623847-25287-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog128.obsmtp.com (na3sys009aog128.obsmtp.com
 [74.125.149.141])
 by alsa0.perex.cz (Postfix) with ESMTP id CF3E3264ED0
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 14:10:15 +0200 (CEST)
Received: by oagl20 with SMTP id l20so2771109oag.38
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 05:10:14 -0700 (PDT)
In-Reply-To: <1347623847-25287-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/14/2012 02:57 PM, Lars-Peter Clausen wrote:
> For ENUM controls the bitmask is calculated based on the number of items.
> Currently this is done each time the control is accessed. And while the
> performance impact of this should be negligible we can easily do better. The
> roundup_pow_of_two macro performs the same calculation which is currently done
> manually, but it is also possible to use this macro with compile time constants
> and so it can be used to initialize static data. So we can use it to initialize
> the mask field of a ENUM control during its declaration.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  include/sound/soc.h        |    4 +++-
>  sound/soc/codecs/twl4030.c |    8 +++-----
>  sound/soc/soc-core.c       |   16 ++++++----------
>  sound/soc/soc-dapm.c       |   22 ++++++++--------------
>  4 files changed, 20 insertions(+), 30 deletions(-)

Looks good, for the twl4030 part:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
