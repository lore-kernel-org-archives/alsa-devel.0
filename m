From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 3/6] soundwire: core: define SDW_MAX_PORT
Date: Fri, 7 Jun 2019 07:31:59 -0500
Message-ID: <a4b527af-c999-829d-c4a0-41f0a6775b65@linux.intel.com>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607085643.932-4-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, vkoul@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/7/19 3:56 AM, Srinivas Kandagatla wrote:
> This patch adds SDW_MAX_PORT so that other driver can use it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   include/linux/soundwire/sdw.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index aac68e879fae..80ca997e4e5d 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -36,6 +36,7 @@ struct sdw_slave;
>   #define SDW_FRAME_CTRL_BITS		48
>   #define SDW_MAX_DEVICES			11
>   
> +#define SDW_MAX_PORTS	14

That's an ambiguous definition.
You can have 16 ports per the SoundWire spec, but DP0 is reserved for 
control and DP15 is an alias for all ports (same idea as device 15 for 
broadcast operations but limited to a single device), which leaves 14 
ports for audio usages.

In the MIPI specs, specifically the DisCo part, the difference is called 
about with the the DP0 and DPn notations, so this could be SDW_MAX_DPn. 
Alternatively you could use SDW_MAX_AUDIO_PORTS which is more 
self-explanatory and does not require in-depth familiarity with the spec.

>   #define SDW_VALID_PORT_RANGE(n)		((n) <= 14 && (n) >= 1)
>   
>   #define SDW_DAI_ID_RANGE_START		100
> 
