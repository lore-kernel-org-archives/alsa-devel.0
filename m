From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC v1 7/9] ASoC: msm8x16: Add sound mixer controls.
Date: Wed, 17 Feb 2016 10:58:02 +0000
Message-ID: <56C4523A.7040003@linaro.org>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1455644008-1917-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160216202113.GH7544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160216202113.GH7544@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Thanks for your comments on the patch series.

On 16/02/16 20:21, Mark Brown wrote:
> On Tue, Feb 16, 2016 at 05:33:28PM +0000, Srinivas Kandagatla wrote:
>
>> +static const char * const msm8x16_wcd_spk_boost_ctrl_text[] = {
>> +		"DISABLE", "ENABLE"};
>
> On/off switches should be presented to usersrpace as on/off switches
> with "Switch" at the end of their name not as SHOUTING enums.  The
> indentation and brace placement are also weird here.
>
> I'm going to stop reviewing at this point.  It really feels like this
> code could benefit from taking a look at some modern CODEC drivers and
> following the ways they do things, there appear to be a lot of these
> issues throughout the series.

I totally agree with you on this and all the comments in the patchset, 
TBH this driver was forward ported from msm-3.10 Andriod kernel, My Idea 
was to retain most of code bits from that driver but it looks its a very 
bad Idea to start with.

I will relook into the modern codec drivers and rewrite the driver to be 
inline with them.

Thanks,
srini

>
