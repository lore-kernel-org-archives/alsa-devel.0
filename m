From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: Replace snd_soc_acpi_check_hid with
 acpi_dev_present
Date: Mon, 13 Nov 2017 13:43:57 -0600
Message-ID: <20618d9a-4bd3-1653-b749-6db0c2162ac3@linux.intel.com>
References: <0100015fa737dec2-4d7283d5-bba0-4270-9f92-8f258d2835dd-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0100015fa737dec2-4d7283d5-bba0-4270-9f92-8f258d2835dd-000000@email.amazonses.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Cline <jeremy@jcline.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org



On 11/10/2017 12:36 PM, Jeremy Cline wrote:
> Replace snd_soc_acpi_check_hid() with the generic acpi_dev_present()
> and remove the now unused snd_soc_acpi_check_hid function. This should
> have no functional change.

The code looks ok, but I'd like to first add the fix for the quirk 
handling regression which appeared in 4.13 and is still there in 4.14. 
Current fix is at https://bugzilla.kernel.org/attachment.cgi?id=258581

Can we wait a couple of days on this one to avoid mixing bug fixes and 
renames? this would also make the stable branch fix easier to handle.

>
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> ---
> Changes in v3:
>    - Remove the unnecessary "== true" and "!= true"
>
>   include/sound/soc-acpi.h |  3 ---
>   sound/soc/soc-acpi.c     | 32 ++------------------------------
>   2 files changed, 2 insertions(+), 33 deletions(-)
>
> diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
> index a7d8d335b043..057805489af3 100644
> --- a/include/sound/soc-acpi.h
> +++ b/include/sound/soc-acpi.h
> @@ -49,9 +49,6 @@ snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>   struct snd_soc_acpi_mach *
>   snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines);
>   
> -/* acpi check hid */
> -bool snd_soc_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
> -
>   /**
>    * snd_soc_acpi_mach: ACPI-based machine descriptor. Most of the fields are
>    * related to the hardware, except for the firmware and topology file names.
> diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
> index f21df28bc28e..3543a7749490 100644
> --- a/sound/soc/soc-acpi.c
> +++ b/sound/soc/soc-acpi.c
> @@ -49,41 +49,13 @@ const char *snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
>   }
>   EXPORT_SYMBOL_GPL(snd_soc_acpi_find_name_from_hid);
>   
> -static acpi_status snd_soc_acpi_mach_match(acpi_handle handle, u32 level,
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
> -	status = acpi_get_devices(hid, snd_soc_acpi_mach_match, &found, NULL);
> -
> -	if (ACPI_FAILURE(status))
> -		return false;
> -
> -	return found;
> -}
> -EXPORT_SYMBOL_GPL(snd_soc_acpi_check_hid);
> -
>   struct snd_soc_acpi_mach *
>   snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>   {
>   	struct snd_soc_acpi_mach *mach;
>   
>   	for (mach = machines; mach->id[0]; mach++) {
> -		if (snd_soc_acpi_check_hid(mach->id) == true) {
> +		if (acpi_dev_present(mach->id, NULL, -1)) {
>   			if (mach->machine_quirk == NULL)
>   				return mach;
>   
> @@ -163,7 +135,7 @@ struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>   		return mach;
>   
>   	for (i = 0; i < codec_list->num_codecs; i++) {
> -		if (snd_soc_acpi_check_hid(codec_list->codecs[i]) != true)
> +		if (!acpi_dev_present(codec_list->codecs[i], NULL, -1))
>   			return NULL;
>   	}
>   
