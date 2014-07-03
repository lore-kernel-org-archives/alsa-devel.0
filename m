From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau1701: fix adau1701_reg_read()
Date: Thu, 03 Jul 2014 19:21:58 +0200
Message-ID: <53B59136.4020008@metafoo.de>
References: <1404399096-4056-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-170.synserver.de (smtp-out-170.synserver.de
 [212.40.185.170])
 by alsa0.perex.cz (Postfix) with ESMTP id F1AD2261A2C
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 19:21:58 +0200 (CEST)
In-Reply-To: <1404399096-4056-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/03/2014 04:51 PM, Daniel Mack wrote:
> Fix a long standing bug in the read register routing of adau1701.
> The bytes arrive in the buffer in big-endian, so the result has to be
> shifted before and-ing the bytes in the loop.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   sound/soc/codecs/adau1701.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index defb277..15feb12 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -240,8 +240,10 @@ static int adau1701_reg_read(void *context, unsigned int reg,
>
>   	*value = 0;
>
> -	for (i = 0; i < size; i++)
> -		*value |= recv_buf[i] << (i * 8);
> +	for (i = 0; i < size; i++) {
> +		*value <<= 8;
> +		*value |= recv_buf[i];
> +	}
>
>   	return 0;
>   }
>
