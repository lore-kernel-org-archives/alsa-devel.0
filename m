From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [PATCH] Sound: soc: samsung - Fix possible NULL
 derefrence.
Date: Mon, 30 Jan 2017 14:34:23 +0100
Message-ID: <0adef6d5-13bd-5e08-ca53-c8a5969578a2@samsung.com>
References: <CGME20170130050433epcas3p158c643fc3cba0b3b616dc24a50e11bc0@epcas3p1.samsung.com>
 <1485752659-30185-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1485752659-30185-1-git-send-email-shailendra.v@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shailendra Verma <shailendra.v@samsung.com>, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/30/2017 06:04 AM, Shailendra Verma wrote:
> of_device_get_match_data could return NULL, and so can cause
> a NULL pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  sound/soc/samsung/i2s.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 7825bff..b5acce2 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1224,8 +1224,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
>  	const struct samsung_i2s_dai_data *i2s_dai_data;
>  	int ret;
>  
> -	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
> +	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
>  		i2s_dai_data = of_device_get_match_data(&pdev->dev);
> +		if (!i2s_dai_data) {
> +			dev_err(&pdev->dev, "no device match found\n");
> +			return -ENODEV;
> +		}
> +	}

As Javier commented on similar patch for gpu/drm/exynos i2s_dai_data
can't be NULL as for DT case all struct of_device_id::data entries
are initialized in this driver and the probe callback can only be
called when device's compatible string got matched with one of entries
in the OF device id table.

>  	else
>  		i2s_dai_data = (struct samsung_i2s_dai_data *)
>  				platform_get_device_id(pdev)->driver_data;
> 

Similarly in non-dt case all struct_device_id::driver_data entries
are initialized so i2s_dai_data normally also cannot be NULL here.
If we were adding a sanity check for i2s_dai_data, it would need to
be here to cover both dt and non-dt.

I don't think this patch is necessary.  The error log above is slightly
misleading as actual device/driver matching happens already before
probe() is called.

-- 
Thanks,
Sylwester
