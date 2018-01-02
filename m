From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH -next] soundwire: Fix typo in return value
 check of sdw_read()
Date: Tue, 2 Jan 2018 14:00:52 -0600
Message-ID: <a77dc39a-cc5f-f41f-d4bc-7230820a9f9b@linux.intel.com>
References: <1514866099-108711-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514866099-108711-1-git-send-email-weiyongjun1@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>, Vinod Koul <vinod.koul@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 1/1/18 10:08 PM, Wei Yongjun wrote:
> Fix the typo, 'status' should be instead of 'status2'.

well spotted, thanks!

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Fixes: b0a9c37b0178 ("soundwire: Add slave status handling")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/soundwire/bus.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 4c34519..266d2b3 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -671,8 +671,8 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
>   		status2 = sdw_read(slave, SDW_DP0_INT);
>   		if (status2 < 0) {
>   			dev_err(slave->bus->dev,
> -				"SDW_DP0_INT read failed:%d", status);
> -			return status;
> +				"SDW_DP0_INT read failed:%d", status2);
> +			return status2;
>   		}
>   		status &= status2;
>   
> @@ -741,10 +741,10 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
>   
>   		/* Read DPN interrupt again */
>   		status2 = sdw_read(slave, addr);
> -		if (status < 0) {
> +		if (status2 < 0) {
>   			dev_err(slave->bus->dev,
> -					"SDW_DPN_INT read failed:%d", status);
> -			return status;
> +					"SDW_DPN_INT read failed:%d", status2);
> +			return status2;
>   		}
>   		status &= status2;
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
