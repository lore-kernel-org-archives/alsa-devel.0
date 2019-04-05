From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: fix pm_runtime_get_sync return
	code checks
Date: Fri, 5 Apr 2019 10:04:38 -0500
Message-ID: <367316fa-9d92-2dfc-32c4-3e0e8c76ef43@linux.intel.com>
References: <20190405072655.25995-1-jank@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA407F8071D
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 17:04:44 +0200 (CEST)
In-Reply-To: <20190405072655.25995-1-jank@cadence.com>
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
To: Jan Kotas <jank@cadence.com>, vkoul@kernel.org, sanyog.r.kale@intel.com
Cc: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 4/5/19 2:26 AM, Jan Kotas wrote:
> When PM is disabled it returns -EACCES, which is currently
> threated as an error, and prevents accessing the slave's
> registers.
>
> This patch ignores the -EACCES return value from
> pm_runtime_get_sync() to let the SoundWire work in systems
> without runtime PM.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>   drivers/soundwire/bus.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 1cbfedfc2..6567ff439 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -328,7 +328,7 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>   		return ret;
>   
>   	ret = pm_runtime_get_sync(slave->bus->dev);
> -	if (ret < 0)
> +	if (ret < 0 && ret != -EACCES)

There was a patch submitted on 3/28 by Srinivas Kandagatla who suggested an alternate solution for exactly the same code.

+	if (pm_runtime_enabled(slave->bus->dev)) {
+		ret = pm_runtime_get_sync(slave->bus->dev);
+		if (ret < 0)
+			return ret;

I am far from an expert on pm_runtime but Srinivas' solution looks more elegant to me.
-Pierre
