From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [Patch v6 4/4] ASoC: at91sam9g20ek-wm8731: convert to dt support
Date: Tue, 27 Nov 2012 10:54:03 +0800
Message-ID: <50B42B4B.90407@atmel.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com> <1352887751-21848-5-git-send-email-voice.shen@atmel.com> <201211262123.42812.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <201211262123.42812.arnd@arndb.de>
Sender: linux-sound-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, broonie@opensource.wolfsonmicro.com, plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Arnd,

On 11/27/2012 5:23, Arnd Bergmann wrote:
> On Wednesday 14 November 2012, Bo Shen wrote:
>> +
>> +                       ssc0: ssc@fffbc000 {
>> +                               status = "okay";
>> +                               pinctrl-0 = <&pinctrl_ssc0_tx>;
>> +                       };
>>                  };
>>
>
> This gives me a build error in linux-next with at91sam9g20_defconfig:
>
> ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"

Yes, this is because there is a cross merge patch at: 
https://patchwork.kernel.org/patch/1776941/ acked by Mark Brown, however 
it does not merged.

Best Regards,
Bo Shen
