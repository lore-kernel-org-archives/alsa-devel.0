From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 06/10] ASoC: wcd9335: add basic controls
Date: Wed, 1 Aug 2018 09:57:12 +0100
Message-ID: <bbee4cb6-286d-c774-9b44-267d0af25af3@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-7-srinivas.kandagatla@linaro.org>
 <20180731171654.GL5719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731171654.GL5719@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review.

On 31/07/18 18:16, Mark Brown wrote:
> On Fri, Jul 27, 2018 at 01:18:02PM +0100, Srinivas Kandagatla wrote:
> 
>> +static const char * const wcd9335_ear_pa_gain_text[] = {
>> +	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
>> +	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
>> +};
> 
> This is fairly clearly a volume control so shouldn't be an enum.  I
> don't think we have a standard control that enables you to skip values
> in a regular volume control (we do for enums which you should've used
> rather than having the undefined entry) so you'd have to have custom get
> and put operators but that's better than abusing an enum.
I agree, this can be a TLV, I will fix any such instances in next version.
> 
>> +static const char * const rx_hph_mode_mux_text[] = {
>> +	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
>> +};
> 
> Use a SOC_VALUE_ENUM to hide the invalid option from users.
Yep.
> 
>> +	wcd->comp_enabled[comp] = value;
>> +	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
>> +		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;
> 
> Just write normal if statements unless there's a reason not to, it's
> easier to read.
Will do that in next version.

thanks,
srini
> 
