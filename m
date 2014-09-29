From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/3] ASoC: ssm2602: do not hardcode type to SSM2602
Date: Mon, 29 Sep 2014 21:51:05 +0200
Message-ID: <5429B829.3020900@metafoo.de>
References: <1412019553-19342-1-git-send-email-stefan.kristiansson@saunalahti.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412019553-19342-1-git-send-email-stefan.kristiansson@saunalahti.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/29/2014 09:39 PM, Stefan Kristiansson wrote:
> The correct type (SSM2602/SSM2603/SSM2604) is passed down
> from the ssm2602_spi_probe()/ssm2602_spi_probe() functions,
> so use that instead of hardcoding it to SSM2602 in
> ssm2602_probe().
>
> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

Fixes: c924dc68f737 ("ASoC: ssm2602: Split SPI and I2C code into different \
	modules")
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
