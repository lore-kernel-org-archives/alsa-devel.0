From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/4] soundwire: cdns: fix check for number
	of messages
Date: Thu, 28 Mar 2019 10:03:56 -0400
Message-ID: <797b8525-dbcd-e52b-7b36-b80427a80186@linux.intel.com>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1581F8963C
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 15:04:00 +0100 (CET)
In-Reply-To: <20190328134134.22479-3-srinivas.kandagatla@linaro.org>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/28/19 9:41 AM, Srinivas Kandagatla wrote:
> Looks like there is a typo while checking number of messages, which
> should be checked in defer pointer rather than message length.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/cadence_master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index cb6a331f448a..d41adbc57918 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -434,7 +434,7 @@ cdns_xfer_msg_defer(struct sdw_bus *bus,
>   	int cmd = 0, ret;
>   
>   	/* for defer only 1 message is supported */
> -	if (msg->len > 1)

I am not sure this is a typo.

IRRC the hardware only defer e.g. a single write that can perform bank 
switches and writes at specific times indicated with an SSP. What's more 
is that the defer structure is actually modified below this code (not 
shown in the diff) to set defer>length = msg->len, so testing before the 
value is set looks more suspicious than the current code.

Vinod, does this ring a bell?


> +	if (defer->length > 1)
>   		return -ENOTSUPP;
>   
>   	ret = cdns_prep_msg(cdns, msg, &cmd);
> 
