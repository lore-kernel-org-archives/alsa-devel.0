From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH 4/5] ALSA: hda - Use acpi_dev_present
Date: Tue, 24 Nov 2015 09:51:13 +0800
Message-ID: <5653C291.9090607@canonical.com>
References: <cover.1448282995.git.lukas@wunner.de>
 <515643b09b28cd6b4445a1ff194bf62b0d02989c.1448282995.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <515643b09b28cd6b4445a1ff194bf62b0d02989c.1448282995.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org, devel@acpica.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/23/2015 10:34 PM, Lukas Wunner wrote:
> Use shiny new acpi_dev_present and remove all the boilerplate to search
> for a particular ACPI device. No functional change.
>
> Cc: Hui Wang <hui.wang@canonical.com>
The [PATCH 4/5] looks fine to me.

Acked-by: Hui Wang <hui.wang@canonical.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   sound/pci/hda/thinkpad_helper.c | 17 ++---------------
>   1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
> index 0a4ad5f..59ab6ce 100644
> --- a/sound/pci/hda/thinkpad_helper.c
> +++ b/sound/pci/hda/thinkpad_helper.c
> @@ -10,23 +10,10 @@
>   static int (*led_set_func)(int, bool);
>   static void (*old_vmaster_hook)(void *, int);
>   
> -static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *context,
> -				 void **rv)
> -{
> -	bool *found = context;
> -	*found = true;
> -	return AE_OK;
> -}
> -
>   static bool is_thinkpad(struct hda_codec *codec)
>   {
> -	bool found = false;
> -	if (codec->core.subsystem_id >> 16 != 0x17aa)
> -		return false;
> -	if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb, &found, NULL)) && found)
> -		return true;
> -	found = false;
> -	return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb, &found, NULL)) && found;
> +	return (codec->core.subsystem_id >> 16 == 0x17aa) &&
> +	       (acpi_dev_present("LEN0068") || acpi_dev_present("IBM0068"));
>   }
>   
>   static void update_tpacpi_mute_led(void *private_data, int enabled)

