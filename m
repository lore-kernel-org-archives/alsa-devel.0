From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
Date: Wed, 23 May 2018 14:28:53 -0500
Message-ID: <CAL_Jsq+YF+EFfqua_GTFU=cwf8oF3HCPCR09MWOoRCJf0-zVnQ@mail.gmail.com>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org> <20180523164023.GA24671@rob-hp-laptop>
 <4b83b699-59ad-b177-f360-3e76ba847892@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4b83b699-59ad-b177-f360-3e76ba847892@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, sdharia@quicinc.com, girishm@quicinc.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Banajit Goswami <bgoswami@codeaurora.org>, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 23, 2018 at 1:11 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 23/05/18 17:40, Rob Herring wrote:
>>>
>>> +
>>> +- qcom,ngd-id
>>> +       Usage: required
>>> +       Value type: <u32>
>>> +       Definition: ngd instance id in the controller
>>
>> Why do you need this?
>>
> Please ignore my comment from previous reply.
>
> There are more than one instances of ngd in this slim controller.
> We need this to make sure we are programming the correct one.

Doesn't the parent-child relationship of devices on the bus provide
that? If you mean to provide consistent numbering to userspace, then
that's not a DT problem (nor one that Linux plans to solve).

> We also need this instance ID during powering it up using QMI.

Wouldn't that be a QMI ID?

Rob
