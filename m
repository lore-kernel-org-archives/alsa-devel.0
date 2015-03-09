From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH_V2] ASoC: jz4740: Add jz4780 support
Date: Mon, 09 Mar 2015 12:54:50 +0100
Message-ID: <54FD8A0A.4080909@metafoo.de>
References: <1425900224-52026-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425900224-52026-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/09/2015 12:23 PM, Zubair Lutfullah Kakakhel wrote:
[...]
> @@ -460,6 +499,9 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
>
>   	platform_set_drvdata(pdev, i2s);
>
> +	if (i2s->version >= JZ_I2S_JZ4780)
> +		jz4740_i2s_dai.symmetric_rates = 0;

We shouldn't modify driver global structs from a device instance. Just add a 
second copy of jz4740_i2s_dai for the jz4780 without the bit set.

- Lars
