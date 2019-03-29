From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/4] soundwire: add module_sdw_driver
	helper macro
Date: Fri, 29 Mar 2019 11:08:43 +0530
Message-ID: <20190329053843.GI5348@vkoul-mobl>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E8A7F80766
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 06:38:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190328134134.22479-2-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 28-03-19, 13:41, Srinivas Kandagatla wrote:
> This Helper macro is for Soundwire drivers which do not do anything special in

s/Soundwire/SoundWire

Most of the 'documentation' uses SoundWire as that is spec name, unless
you are referring to subsystem in which case all will be lowercase :)

> module init/exit. This eliminates a lot of boilerplate. Each module may only
> use this macro once, and calling it replaces module_init() and module_exit()
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  include/linux/soundwire/sdw_type.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
> index 9fd553e553e9..e14843ed13a5 100644
> --- a/include/linux/soundwire/sdw_type.h
> +++ b/include/linux/soundwire/sdw_type.h
> @@ -16,4 +16,15 @@ void sdw_unregister_driver(struct sdw_driver *drv);
>  
>  int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
>  
> +/**
> + * module_sdw_driver() - Helper macro for registering a Soundwire driver
> + * @__sdw_driver: soundwire slave driver struct
> + *
> + * Helper macro for Soundwire drivers which do not do anything special in
> + * module init/exit. This eliminates a lot of boilerplate. Each module may only
> + * use this macro once, and calling it replaces module_init() and module_exit()
> + */
> +#define module_sdw_driver(__sdw_driver) \
> +	module_driver(__sdw_driver, sdw_register_driver, \
> +			sdw_unregister_driver)
>  #endif /* __SOUNDWIRE_TYPES_H */
> -- 
> 2.21.0

-- 
~Vinod
