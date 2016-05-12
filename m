From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt298: fix null deref on acpi
	driver data
Date: Thu, 12 May 2016 05:59:19 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701154FF5@RTITMBSV03.realtek.com.tw>
References: <1463026130-18651-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 55BF8265068
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 08:01:14 +0200 (CEST)
In-Reply-To: <1463026130-18651-1-git-send-email-vinod.koul@intel.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "patches.audio@intel.com" <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul@intel.com]
> Sent: Thursday, May 12, 2016 12:09 PM
> To: alsa-devel@alsa-project.org
> Cc: broonie@kernel.org; liam.r.girdwood@linux.intel.com;
> patches.audio@intel.com; Bard Liao; Vinod Koul; Senthilnathan Veppur
> Subject: [PATCH 1/2] ASoC: rt298: fix null deref on acpi driver data
> 
> ACPI driver data can be NULL so we need to check that before
> dereference the driver data.
> 
> Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Acked-by: Bard Liao <bardliao@realtek.com>

> ---
>  sound/soc/codecs/rt298.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c index
> 68cf8d5a174f..45dc5fa24961 100644
> --- a/sound/soc/codecs/rt298.c
> +++ b/sound/soc/codecs/rt298.c
> @@ -1179,7 +1179,7 @@ static int rt298_i2c_probe(struct i2c_client
> *i2c,
> 
>  	/* enable jack combo mode on supported devices */
>  	acpiid = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (acpiid) {
> +	if (acpiid && acpiid->driver_data) {
>  		rt298->pdata = *(struct rt298_platform_data *)
>  				acpiid->driver_data;
>  	}
> --
> 1.9.1
