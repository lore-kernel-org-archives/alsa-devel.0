From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ACPI / utils: Introduce
 acpi_dev_get_dev_name()
Date: Thu, 4 Jan 2018 11:31:11 -0600
Message-ID: <aed928f3-452c-c0b8-bd93-b9921d72df67@linux.intel.com>
References: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
 <20180104164709.64387-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 37D47267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 18:31:14 +0100 (CET)
In-Reply-To: <20180104164709.64387-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 1/4/18 10:47 AM, Andy Shevchenko wrote:
> Sometimes the user want to have device name of the match rather than
> just checking if device present or not. To make life easier for such
> users introduce acpi_dev_get_dev_name() helper based on code for
> acpi_dev_present().
> 
> To be more consistent with the purpose rename
> 
>    struct acpi_dev_present_info  -> struct acpi_dev_match_info
>    acpi_dev_present_cb()         -> acpi_dev_match_cb()
> 
> in the utils.c file.

I would have done this differently. You have two routines 
(acpi_dev_present and acpi_dev_get_dev_name) which do the same thing 
except for what they return (bool and const char *) respectively.

This could be factored with

static struct device *dev _acpi_dev_present(const char *hid, const char 
*uid, s64 hrv) {

	struct acpi_dev_present_info match = {};
	struct device *dev;

	strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
	match.uid = uid;
	match.hrv = hrv;

	dev = bus_find_device(&acpi_bus_type, NULL, &match,
		acpi_dev_present_cb);
	
	return dev;
}

bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
{
	return !!_acpi_dev_present(const char *hid, const char *uid, s64 hrv);
}

const char *acpi_dev_get_dev_name(const char *hid, const char *uid, s64 hrv)
{
	struct device *dev;

	dev = _acpi_dev_present(const char *hid, const char *uid, s64 hrv);

	return dev ? match.dev_name : NULL;
}

That said you are a much better programmer than me so the other code is 
fine with me...

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/acpi/utils.c    | 40 +++++++++++++++++++++++++++++++++-------
>   include/acpi/acpi_bus.h |  1 +
>   include/linux/acpi.h    |  6 ++++++
>   3 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 9d49a1acebe3..1da9e986d510 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -737,16 +737,17 @@ bool acpi_dev_found(const char *hid)
>   }
>   EXPORT_SYMBOL(acpi_dev_found);
>   
> -struct acpi_dev_present_info {
> +struct acpi_dev_match_info {
> +	const char *dev_name;
>   	struct acpi_device_id hid[2];
>   	const char *uid;
>   	s64 hrv;
>   };
>   
> -static int acpi_dev_present_cb(struct device *dev, void *data)
> +static int acpi_dev_match_cb(struct device *dev, void *data)
>   {
>   	struct acpi_device *adev = to_acpi_device(dev);
> -	struct acpi_dev_present_info *match = data;
> +	struct acpi_dev_match_info *match = data;
>   	unsigned long long hrv;
>   	acpi_status status;
>   
> @@ -757,6 +758,8 @@ static int acpi_dev_present_cb(struct device *dev, void *data)
>   	    strcmp(adev->pnp.unique_id, match->uid)))
>   		return 0;
>   
> +	match->dev_name = acpi_dev_name(adev);
> +
>   	if (match->hrv == -1)
>   		return 1;
>   
> @@ -789,20 +792,43 @@ static int acpi_dev_present_cb(struct device *dev, void *data)
>    */
>   bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
>   {
> -	struct acpi_dev_present_info match = {};
> +	struct acpi_dev_match_info match = {};
>   	struct device *dev;
>   
>   	strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
>   	match.uid = uid;
>   	match.hrv = hrv;
>   
> -	dev = bus_find_device(&acpi_bus_type, NULL, &match,
> -			      acpi_dev_present_cb);
> -
> +	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
>   	return !!dev;
>   }
>   EXPORT_SYMBOL(acpi_dev_present);
>   
> +/**
> + * acpi_dev_get_dev_name - Return device name of first match of ACPI device
> + * @hid: Hardware ID of the device.
> + * @uid: Unique ID of the device, pass NULL to not check _UID
> + * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
> + *
> + * Return device name if a matching device was present
> + * at the moment of invocation, or NULL otherwise.
> + *
> + * See additional information in acpi_dev_present() as well.
> + */
> +const char *acpi_dev_get_dev_name(const char *hid, const char *uid, s64 hrv)
> +{
> +	struct acpi_dev_match_info match = {};
> +	struct device *dev;
> +
> +	strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
> +	match.uid = uid;
> +	match.hrv = hrv;
> +
> +	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
> +	return dev ? match.dev_name : NULL;
> +}
> +EXPORT_SYMBOL(acpi_dev_get_dev_name);
> +
>   /*
>    * acpi_backlight= handling, this is done here rather then in video_detect.c
>    * because __setup cannot be used in modules.
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 79287629c888..8883f5ebb6ce 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -90,6 +90,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>   
>   bool acpi_dev_found(const char *hid);
>   bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
> +const char *acpi_dev_get_dev_name(const char *hid, const char *uid, s64 hrv);
>   
>   #ifdef CONFIG_ACPI
>   
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 1922063f6894..d6576eec45d1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -644,6 +644,12 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
>   	return false;
>   }
>   
> +static inline
> +const char *acpi_dev_get_dev_name(const char *hid, const char *uid, s64 hrv)
> +{
> +	return NULL;
> +}
> +
>   static inline bool is_acpi_node(struct fwnode_handle *fwnode)
>   {
>   	return false;
> 
