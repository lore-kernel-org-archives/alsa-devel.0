From: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [alsa-devel] [Patch V4 00/10] ASoC: QCOM: Add support for ipq806x
 SOC
Date: Wed, 11 Feb 2015 23:20:33 -0800
Message-ID: <54DC5441.1070004@codeaurora.org>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org> <20150206223229.GG31311@finisterre.sirena.org.uk> <20150209064511.GB19870@kwestfie-linux.qualcomm.com> <20150211022634.GO2593@finisterre.sirena.org.uk> <20150212010551.GA7330@kwestfie-linux.qualcomm.com> <20150212025341.GT2593@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150212025341.GT2593-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 2/11/2015 6:53 PM, Mark Brown wrote:
> On Wed, Feb 11, 2015 at 05:05:52PM -0800, Kenneth Westfield wrote:
>
>> Replacing DSP-based drivers with LPASS-based drivers would be something that
>> should be handled by Kconfig selections.  For the DT, the DSP-related
>
> No, it shouldn't be.  We should have the ability to build a single
> kernel image which will run on many systems, including both your
> system with a DSP and other systems without.
>
Is there expectation that DTB flashed onto the system would define nodes to
bind with both LPASS-based driver and DSP-based driver? I hope not as we want
to keep LPASS-based driver & DSP-based driver mutually exclusive.

>> nodes and the LPASS-related nodes shouldn't overlap.  There should be a
>> DSP-based DT binding and a separate LPASS-based DT binding.  Tying one
>> or the other to the sound node (but not both), should work.
>
> The selection of DSP use sounds like something which isn't part of the
> description of the hardware but rather a runtime policy decision (at
> least in so far as non-DSP is ever an option).
>
Put aside IPQ8064, I would say it is actually more of build time policy
decision for QC SoCs with DSP. XPU is programmed by trust zone to allow certain
LPASS registers to be accessed by the chosen processor. If ADSP and app
processor would have to have access to audio interfaces and DMA, resources
partition(i.e # of DMAs go to ADSP while rest of DMA go to app processor is
decided after analyzing expected concurrency use case. For case of 8016, MDSP
would simply expect it has access to all audio subsystem except digital core of
CODEC.

Thanks
Patrick

-- 
Patrick Lai
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,a 
Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
