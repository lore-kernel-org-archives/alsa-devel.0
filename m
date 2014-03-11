From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: cs42888: Add codec driver support
Date: Tue, 11 Mar 2014 16:55:58 +0100
Message-ID: <531F320E.70605@metafoo.de>
References: <1394536791-8381-1-git-send-email-Guangyu.Chen@freescale.com> <alpine.DEB.2.02.1403111026280.3558@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1403111026280.3558@heelrod>
Sender: linux-doc-owner@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Nicolin Chen <Guangyu.Chen@freescale.com>, broonie@kernel.org, Paul.Handrigan@cirrus.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, lgirdwood@gmail.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/11/2014 04:41 PM, Brian Austin wrote:
>
> On Tue, 11 Mar 2014, Nicolin Chen wrote:
>
>> This patch adds support for the Cirrus Logic CS42888 Audio CODEC that
>> has four 24-bit A/D and eight 24-bit D/A converters.
>>
>> [ CS42888 supports both I2C and SPI control ports. As initial patch,
>>  this patch only adds the support for I2C. ]
>>
>> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
>> ---
> So WRT the CS42888, this is one device in a series of 2 devices that are
> register compatible with the only difference being that the CS42488 has 2
> extra ADC's. Same die and same DeviceID.
>
> Would it make more sense to submit the driver with the extra ADC's to make
> it feature complete for both devices? Wouldn't be odd to have 2 drivers that
> do the same for 98% of the code.

This should be in one driver. But support for the second device can always 
be added in a follow up patch.

- Lars

