From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: sigmadsp: Fix missleading return
	value
Date: Wed, 10 Feb 2016 15:55:57 +0100
Message-ID: <56BB4F7D.5010102@metafoo.de>
References: <1455115890-23127-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-039.synserver.de (unknown [212.40.180.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FB65260673
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2016 15:55:59 +0100 (CET)
In-Reply-To: <1455115890-23127-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pascal.huerst@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/10/2016 03:51 PM, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
> 
> Forwarding the return value of i2c_master_send, leads to errors
> later on, since i2c_master_send returns the number of bytes
> transmittet. Check for ret < 0 instead and return 0 otherwise.
> 
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>

Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Please resend to the ASoC maintainers otherwise it wont get picked up.

> ---
>  sound/soc/codecs/sigmadsp-i2c.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/sigmadsp-i2c.c b/sound/soc/codecs/sigmadsp-i2c.c
> index 21ca3a5..d374c18 100644
> --- a/sound/soc/codecs/sigmadsp-i2c.c
> +++ b/sound/soc/codecs/sigmadsp-i2c.c
> @@ -31,7 +31,10 @@ static int sigmadsp_write_i2c(void *control_data,
>  
>  	kfree(buf);
>  
> -	return ret;
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
>  }
>  
>  static int sigmadsp_read_i2c(void *control_data,
> 
