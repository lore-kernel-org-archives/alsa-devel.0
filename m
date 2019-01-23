From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 4/8] ASoC: wcd9335: add basic controls
Date: Wed, 23 Jan 2019 10:11:31 +0000
Message-ID: <6a3664d2-9b10-d6e6-9df5-ed50364812f4@linaro.org>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
 <20190110150616.2332-5-srinivas.kandagatla@linaro.org>
 <20190122185253.GG7579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122185253.GG7579@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 22/01/2019 18:52, Mark Brown wrote:
> On Thu, Jan 10, 2019 at 03:06:12PM +0000, Srinivas Kandagatla wrote:
> 
>> +static const char * const wcd9335_ear_pa_gain_text[] = {
>> +	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
>> +	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
>> +};
> 
> Gains should be controlled with Volume controls, not enums.  Provide
> information on the levels via TLV.
I agree, I will fix this as well in next version!
> 
>> +static const char * const rx_hph_mode_mux_text[] = {
>> +	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
>> +};
> 
> Is there a strong reason not to use more human readable strings here?
> 
No, I can rename them to below if it helps reader.

"Class-H Hi-Fi", "Class-H Low Power",   "Class-AB", "Class-H Hi-Fi Low 
Power".

Thanks,
srini
