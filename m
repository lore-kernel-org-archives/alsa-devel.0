From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt286: Set cbj_en for ACPI devices
Date: Wed, 10 Sep 2014 08:32:59 +0200
Message-ID: <540FF09B.4080608@metafoo.de>
References: <1410313233-585-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-053.synserver.de (smtp-out-057.synserver.de
 [212.40.185.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B006261A60
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 08:32:54 +0200 (CEST)
In-Reply-To: <1410313233-585-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 09/10/2014 03:40 AM, bardliao@realtek.com wrote:
[...]
> +	/* enable jack combo mode on supported devices */
> +	acpiid = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (acpiid) {
> +		for (mach = rt286_jack_combo; mach->acpi_id; mach++) {
> +			if (!strcmp(mach->acpi_id, acpiid->id))
> +				rt286->pdata.cbj_en =
> +					rt286_jack_combo->jack_combo;
> +
> +		}
> +	}

Don't invent your own mechanism for this. Use the driver_data field from the 
acpi_device_id table.

> +
>   	regmap_write(rt286->regmap, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
>
>   	for (i = 0; i < RT286_POWER_REG_LEN; i++)
>
