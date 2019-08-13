From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: Skylake: Print constant
 literals from format specifier
Date: Tue, 13 Aug 2019 17:42:53 +0300
Message-ID: <20190813144253.GG30120@smile.fi.intel.com>
References: <20190621113116.47525-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6646EF8015B
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2019 16:42:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190621113116.47525-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 21, 2019 at 02:31:16PM +0300, Andy Shevchenko wrote:
> Instead of using two additional "%s" specifiers, put the constant string
> literals directly to the format specifier.
> 

Pierre, does it look good to you?

> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/intel/skylake/skl-sst.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
> index 13c636dece56..f3e1399450db 100644
> --- a/sound/soc/intel/skylake/skl-sst.c
> +++ b/sound/soc/intel/skylake/skl-sst.c
> @@ -421,8 +421,7 @@ static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, u8 *guid)
>  	int ret = 0;
>  	char mod_name[64]; /* guid str = 32 chars + 4 hyphens */
>  
> -	snprintf(mod_name, sizeof(mod_name), "%s%pUL%s",
> -					     "intel/dsp_fw_", guid, ".bin");
> +	snprintf(mod_name, sizeof(mod_name), "intel/dsp_fw_%pUL.bin", guid);
>  
>  	module_entry = skl_module_get_from_id(ctx, mod_id);
>  	if (module_entry == NULL) {
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko
