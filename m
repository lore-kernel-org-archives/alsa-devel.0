From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: stream: fix bad unlock balance
Date: Wed, 22 May 2019 11:41:38 -0500
Message-ID: <4744834c-36b1-dd8d-45fa-76c75eb3d5cb@linux.intel.com>
References: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 5/22/19 11:25 AM, Srinivas Kandagatla wrote:
> This patch fixes below warning due to unlocking without locking.
> 
>   =====================================
>   WARNING: bad unlock balance detected!
>   5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
>   -------------------------------------
>   aplay/2954 is trying to release lock (&bus->msg_lock) at:
>   do_bank_switch+0x21c/0x480
>   but there are no more locks to release!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/stream.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 544925ff0b40..d16268f30e4f 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -814,7 +814,8 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>   			goto error;
>   		}
>   
> -		mutex_unlock(&bus->msg_lock);
> +		if (mutex_is_locked(&bus->msg_lock))
> +			utex_unlock(&bus->msg_lock);

Does this even compile? should be mutex_unlock, no?

We also may want to identify the issue in more details without pushing 
it under the rug. The locking mechanism is far from simple and it's 
likely there are a number of problems with it.

>   	}
>   
>   	return ret;
> 
