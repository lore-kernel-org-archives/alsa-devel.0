From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: stream: fix out of boundary access on port
 properties
Date: Wed, 22 May 2019 11:37:01 -0500
Message-ID: <19ad7a42-9625-f547-eab3-66d3aeded6c0@linux.intel.com>
References: <20190522162443.5780-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522162443.5780-1-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 5/22/19 11:24 AM, Srinivas Kandagatla wrote:
> Assigning local iterator to array element and using it again for
> indexing would cross the array boundary.
> Fix this by directly referring array element without using the local
> variable.

The change is valid and indeed the code could never work as is. I 
vaguely recall providing this feedback as well in an earlier version.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/stream.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index d01060dbee96..544925ff0b40 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1406,9 +1406,7 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>   	}
>   
>   	for (i = 0; i < num_ports; i++) {
> -		dpn_prop = &dpn_prop[i];
> -
> -		if (dpn_prop->num == port_num)
> +		if (dpn_prop[i].num == port_num)
>   			return &dpn_prop[i];
>   	}
>   
> 
