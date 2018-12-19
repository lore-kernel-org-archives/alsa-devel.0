From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
 device
Date: Wed, 19 Dec 2018 10:54:55 -0600
Message-ID: <65b445e8-2202-0554-b920-97ce0f7833ce@linux.intel.com>
References: <3b96d716-1d9f-a569-2afa-82b386e752e4@linux.intel.com>
 <20181217181729.GB845@gerhold.net>
 <b3cf2bc5-bde3-3c3d-fd6a-ff426281563c@linux.intel.com>
 <20181217191054.GA10938@gerhold.net>
 <d5755c1c-f9d6-5bed-73ee-00a24d36fccc@linux.intel.com>
 <20181217203242.GB10938@gerhold.net> <20181217204320.GC10938@gerhold.net>
 <86b92282-5bc1-b8de-93e7-97e7ee17db4b@linux.intel.com>
 <20181219130747.GA83656@gerhold.net>
 <f3c2105e-ac56-9be3-eff7-78ef2b0560ac@linux.intel.com>
 <20181219150103.GA52375@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 891A5267ABE
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 17:54:57 +0100 (CET)
In-Reply-To: <20181219150103.GA52375@gerhold.net>
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
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>   
> -static int is_byt_cr(struct device *dev, bool *bytcr)
> +static int is_byt_cr(struct platform_device *pdev, bool *bytcr)
>   {
> +	struct device *dev = &pdev->dev;
>   	int status = 0;
>   
> +	if (platform_get_resource(pdev, IORESOURCE_IRQ, 5) == NULL) {
> +		/* This message is even shown if the device would be detected as BYT-CR below */
> +		dev_info(dev, "Falling back to Baytrail-CR platform\n");
> +		*bytcr = true;
> +		return status;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_IOSF_MBI)) {
>   		u32 bios_status;

This would be my preferred solution but if it doesn't work as Hans 
mentions it then we need to think of alternatives.

Baytrail platforms are so different (BIOS and hardware) that I don't 
think we'll manage to pull this off without quirks.
