From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/3] ASoC: Replace snd_soc_acpi_check_hid
 with acpi_dev_present
Date: Thu, 04 Jan 2018 15:09:59 +0200
Message-ID: <1515071399.7000.670.camel@linux.intel.com>
References: <20180103170242.5363-1-pierre-louis.bossart@linux.intel.com>
 <20180103170242.5363-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 358CF267873
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 14:23:01 +0100 (CET)
In-Reply-To: <20180103170242.5363-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, jeremy@jcline.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-01-03 at 11:02 -0600, Pierre-Louis Bossart wrote:
> From: Jeremy Cline <jeremy@jcline.org>
> 
> Replace snd_soc_acpi_check_hid() with the generic acpi_dev_present()
> and remove the now unused snd_soc_acpi_check_hid function. This should
> 
> have no functional change.

Nice catch!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.
> com>
> ---
>  include/sound/soc-acpi.h |  3 ---
>  sound/soc/soc-acpi.c     | 32 ++------------------------------
>  2 files changed, 2 insertions(+), 33 deletions(-)
> 
> diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
> index a93436089bf5..d1aaf876cd26 100644
> --- a/include/sound/soc-acpi.h
> +++ b/include/sound/soc-acpi.h
> @@ -50,9 +50,6 @@ snd_soc_acpi_find_package_from_hid(const u8
> hid[ACPI_ID_LEN],
>  struct snd_soc_acpi_mach *
>  snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines);
>  
> -/* acpi check hid */
> -bool snd_soc_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
> -
>  /**
>   * snd_soc_acpi_mach: ACPI-based machine descriptor. Most of the
> fields are
>   * related to the hardware, except for the firmware and topology file
> names.
> diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
> index e103f3571b55..06d2aaccdb32 100644
> --- a/sound/soc/soc-acpi.c
> +++ b/sound/soc/soc-acpi.c
> @@ -49,41 +49,13 @@ const char *snd_soc_acpi_find_name_from_hid(const
> u8 hid[ACPI_ID_LEN])
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_acpi_find_name_from_hid);
>  
> -static acpi_status snd_soc_acpi_mach_match(acpi_handle handle, u32
> level,
> -				       void *context, void **ret)
> -{
> -	unsigned long long sta;
> -	acpi_status status;
> -
> -	*(bool *)context = true;
> -	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
> -	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
> -		*(bool *)context = false;
> -
> -	return AE_OK;
> -}
> -
> -bool snd_soc_acpi_check_hid(const u8 hid[ACPI_ID_LEN])
> -{
> -	acpi_status status;
> -	bool found = false;
> -
> -	status = acpi_get_devices(hid, snd_soc_acpi_mach_match,
> &found, NULL);
> -
> -	if (ACPI_FAILURE(status))
> -		return false;
> -
> -	return found;
> -}
> -EXPORT_SYMBOL_GPL(snd_soc_acpi_check_hid);
> -
>  struct snd_soc_acpi_mach *
>  snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>  {
>  	struct snd_soc_acpi_mach *mach;
>  
>  	for (mach = machines; mach->id[0]; mach++) {
> -		if (snd_soc_acpi_check_hid(mach->id) == true) {
> +		if (acpi_dev_present(mach->id, NULL, -1)) {
>  			if (mach->machine_quirk(mach) != NULL)
>  				mach = mach->machine_quirk(mach);
>  			return mach;
> @@ -161,7 +133,7 @@ struct snd_soc_acpi_mach
> *snd_soc_acpi_codec_list(void *arg)
>  		return mach;
>  
>  	for (i = 0; i < codec_list->num_codecs; i++) {
> -		if (snd_soc_acpi_check_hid(codec_list->codecs[i]) !=
> true)
> +		if (!acpi_dev_present(codec_list->codecs[i], NULL,
> -1))
>  			return NULL;
>  	}
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
