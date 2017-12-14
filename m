From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH v2 02/15] soc: qcom: add support to APR bus
 driver
Date: Thu, 14 Dec 2017 17:18:29 +0000
Message-ID: <0ba08ac5-1186-1eb0-f3c0-f6e87489035d@linaro.org>
References: <20171205221812.25641-1-srinivas.kandagatla@linaro.org>
 <20171205221812.25641-3-srinivas.kandagatla@linaro.org>
 <20171214164807.GI9788@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171214164807.GI9788@sirena.org.uk>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>, kwestfie@codeaurora.org, tiwai@suse.com, David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, Andy.Gross@linaro.org, lkasam@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org



On 14/12/17 16:48, Mark Brown wrote:
> On Tue, Dec 05, 2017 at 10:17:59PM +0000, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
>> ARP driver is made as a bus driver so that the apr devices can added removed
>> more dynamically depending on the state of the services on the dsp.
>> APR is used for communication between application processor and QDSP to
>> use services on QDSP like Audio and others.
> 
> I'm not seing any of the Qualcomm architecture maintainers in copy here
> - are they not expected to review this?  I don't know what the usual
Thanks for point this out!!

I did add arm-msm mailing list in the CC.
I think I missed Andy and Sboyd and dt-maintainers too in the list.
It's better I resend this series!!

Thanks,
srini


> practice is for Qualcomm things.  Adding Andy, Dave and Stephen to copy.
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
