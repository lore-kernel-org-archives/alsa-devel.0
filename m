From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: add ASRC support
Date: Fri, 27 Jun 2014 16:05:14 +0200
Message-ID: <53AD7A1A.2090501@metafoo.de>
References: <1403866691-5031-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-029.synserver.de (smtp-out-031.synserver.de
 [212.40.185.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 021A926530C
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 16:05:22 +0200 (CEST)
In-Reply-To: <1403866691-5031-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 06/27/2014 12:58 PM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>
> This patch add ASRC support for rt5640 series codecs.
>
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> ---
>   sound/soc/codecs/rt5640.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++-
>   sound/soc/codecs/rt5640.h |  2 ++
>   2 files changed, 80 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> index 6bc6efd..3245ec4 100644
> --- a/sound/soc/codecs/rt5640.c
> +++ b/sound/soc/codecs/rt5640.c
> @@ -341,6 +341,43 @@ static bool rt5640_readable_register(struct device *dev, unsigned int reg)
>   	}
>   }
>
> +static const char * const rt5640_asrc_mode[] = {
> +	"disable", "enable"
> +};
> +
> +static const SOC_ENUM_SINGLE_DECL(rt5640_asrc_enum, SND_SOC_NOPM,
> +				0, rt5640_asrc_mode);

I wonder if that shouldn't be something that is automatically 
enabled/disabled based on the samplerates involved. Also for enable/disable 
controls use a switch control rather than a enum.

- Lars
