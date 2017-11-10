From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: common: Replace sst_acpi_check_hid with
 acpi_dev_present
Date: Fri, 10 Nov 2017 12:33:38 +0100
Message-ID: <2c94120e-74b3-052f-a86f-fa3a95af9095@redhat.com>
References: <0100015fa29c1e78-d78dbbd4-d14a-4ec1-9f8a-69addb10921b-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0100015fa29c1e78-d78dbbd4-d14a-4ec1-9f8a-69addb10921b-000000@email.amazonses.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Cline <jeremy@jcline.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 09-11-17 22:07, Jeremy Cline wrote:
> Replace the sst_acpi_check_hid helper function added in
> commit 915ae2b9f0fe ("ASoC: Intel: Create a helper to search for
> matching machine") with the generic acpi_dev_present helper function
> and remove the now unused sst_acpi_check_hid function. This should have
> no functional change.
> 
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

I've just successfully tested this on an Assu T100HA:

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   sound/soc/intel/common/sst-acpi.h       |  3 ---
>   sound/soc/intel/common/sst-match-acpi.c | 32 ++------------------------------
>   2 files changed, 2 insertions(+), 33 deletions(-)
> 
> diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
> index afe9b87b8bd5..d7facac83b7e 100644
> --- a/sound/soc/intel/common/sst-acpi.h
> +++ b/sound/soc/intel/common/sst-acpi.h
> @@ -43,9 +43,6 @@ static inline bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>   /* acpi match */
>   struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines);
>   
> -/* acpi check hid */
> -bool sst_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
> -
>   /* Descriptor for SST ASoC machine driver */
>   struct sst_acpi_mach {
>   	/* ACPI ID for the matching machine driver. Audio codec for instance */
> diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
> index 56d26f36a3cb..f8e1b92de79a 100644
> --- a/sound/soc/intel/common/sst-match-acpi.c
> +++ b/sound/soc/intel/common/sst-match-acpi.c
> @@ -49,40 +49,12 @@ const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
>   }
>   EXPORT_SYMBOL_GPL(sst_acpi_find_name_from_hid);
>   
> -static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
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
> -bool sst_acpi_check_hid(const u8 hid[ACPI_ID_LEN])
> -{
> -	acpi_status status;
> -	bool found = false;
> -
> -	status = acpi_get_devices(hid, sst_acpi_mach_match, &found, NULL);
> -
> -	if (ACPI_FAILURE(status))
> -		return false;
> -
> -	return found;
> -}
> -EXPORT_SYMBOL_GPL(sst_acpi_check_hid);
> -
>   struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
>   {
>   	struct sst_acpi_mach *mach;
>   
>   	for (mach = machines; mach->id[0]; mach++) {
> -		if (sst_acpi_check_hid(mach->id) == true) {
> +		if (acpi_dev_present(mach->id, NULL, -1) == true) {
>   			if (mach->machine_quirk == NULL)
>   				return mach;
>   
> @@ -161,7 +133,7 @@ struct sst_acpi_mach *sst_acpi_codec_list(void *arg)
>   		return mach;
>   
>   	for (i = 0; i < codec_list->num_codecs; i++) {
> -		if (sst_acpi_check_hid(codec_list->codecs[i]) != true)
> +		if (acpi_dev_present(codec_list->codecs[i], NULL, -1) != true)
>   			return NULL;
>   	}
>   
> 
