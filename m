From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 5/6] ASoC: qcom: apq8016-sbc: Add support to multi
 codec.
Date: Tue, 6 Sep 2016 13:54:57 +0100
Message-ID: <5d9e0e7a-e5cb-cf41-2523-149de7204ff8@linaro.org>
References: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473155865-13361-6-git-send-email-srinivas.kandagatla@linaro.org>
 <20160906112720.GO3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160906112720.GO3950@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 06/09/16 12:27, Mark Brown wrote:
> On Tue, Sep 06, 2016 at 10:57:44AM +0100, Srinivas Kandagatla wrote:
>> This patch adds support to multi codec, as the msm8916 codec is now
>> split into two codecs, Analog and Digital.
>
> Does this not break compatibility with existing machines (and require a
> binding documentation update)?

The bindings did not change here really, we still use "sound-dai" 
property to get handle to codec, previously the code was able to handle 
only one codec but with snd_soc_of_get_dai_link_codecs() it will now be 
able to handle multiple codecs.

Infact I have tested this series with ADV7533 audio codec(single codec) 
along with this msm8916 multi codec on this card.

I think a note in the bindings about the ability to handle multiple 
codecs be worth mentioning.

thanks,
srini
>
