From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: bytcht_es8316: fix
 compilation warning and quirk handling
Date: Wed, 10 Apr 2019 18:16:32 +0200
Message-ID: <fec99a28-8109-659a-a51e-f1475a015144@redhat.com>
References: <20190410160548.24317-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CC01F8068A
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 18:16:34 +0200 (CEST)
Received: by mail-wm1-f67.google.com with SMTP id q16so3270432wmj.3
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 09:16:34 -0700 (PDT)
In-Reply-To: <20190410160548.24317-1-pierre-louis.bossart@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Paul Cercueil <paul@crapouillou.net>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 10-04-19 18:05, Pierre-Louis Bossart wrote:
> Remove warning and align quirk management with other machine
> drivers. No need to be creative here.
> 
> bytcht_es8316.c:508:11: warning: cast from pointer to integer of
> different size [-Wpointer-to-int-cast]
> 
>     quirk = (int)dmi_id->driver_data;
>             ^
> Fixes: a8d218f4fe811 ('ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II')
> Cc: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

There is a good reason to use -1 for quirk-override not set.

The user may want to override the quirk variable to actual 0, on
CHT we default to:

                 /* Others default to internal-mic-in1-map, mono-speaker */
                 quirk = BYT_CHT_ES8316_INTMIC_IN1_MAP |
                         BYT_CHT_ES8316_MONO_SPEAKER;

Which is 0x20000, if the user now justs wants to clear the
BYT_CHT_ES8316_MONO_SPEAKER flag through the override, then the user
must be able to specify 0 as override.

So IMHO the proper fix here would be to just change the:

	(int)dmi_id->driver_data;

to:

	(long)dmi_id->driver_data;

And leave the rest of the code alone.

Regards,

Hans




> ---
>   sound/soc/intel/boards/bytcht_es8316.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index 38975827e276..42e9e1e50e9c 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -61,9 +61,9 @@ enum {
>   #define BYT_CHT_ES8316_MONO_SPEAKER		BIT(17)
>   #define BYT_CHT_ES8316_JD_INVERTED		BIT(18)
>   
> -static int quirk;
> +static unsigned long quirk;
>   
> -static int quirk_override = -1;
> +static int quirk_override;
>   module_param_named(quirk, quirk_override, int, 0444);
>   MODULE_PARM_DESC(quirk, "Board-specific quirk override");
>   
> @@ -505,7 +505,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   	/* Check for BYTCR or other platform and setup quirks */
>   	dmi_id = dmi_first_match(byt_cht_es8316_quirk_table);
>   	if (dmi_id) {
> -		quirk = (int)dmi_id->driver_data;
> +		quirk = (unsigned long)dmi_id->driver_data;
>   	} else if (x86_match_cpu(baytrail_cpu_ids) &&
>   	    mach->mach_params.acpi_ipc_irq_index == 0) {
>   		/* On BYTCR default to SSP0, internal-mic-in2-map, mono-spk */
> @@ -516,8 +516,9 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   		quirk = BYT_CHT_ES8316_INTMIC_IN1_MAP |
>   			BYT_CHT_ES8316_MONO_SPEAKER;
>   	}
> -	if (quirk_override != -1) {
> -		dev_info(dev, "Overriding quirk 0x%x => 0x%x\n", quirk,
> +	if (quirk_override) {
> +		dev_info(dev, "Overriding quirk 0x%x => 0x%x\n",
> +			 (unsigned int)quirk,
>   			 quirk_override);
>   		quirk = quirk_override;
>   	}
> 
