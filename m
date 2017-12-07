From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 02/15] soc: qcom: add support to APR bus driver
Date: Thu, 7 Dec 2017 10:33:25 +0000
Message-ID: <c6723fbe-1c15-80a6-b40d-09eb80882795@linaro.org>
References: <20171205221812.25641-1-srinivas.kandagatla@linaro.org>
 <20171205221812.25641-3-srinivas.kandagatla@linaro.org>
 <CAOFm3uE=xoiyWE7d6bw=CeGzxcT1NMxnZ0zX_z-wPOVPTGL7zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOFm3uE=xoiyWE7d6bw=CeGzxcT1NMxnZ0zX_z-wPOVPTGL7zw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Mark <broonie@kernel.org>, bgoswami@codeaurora.org, ALSA <alsa-devel@alsa-project.org>, tiwai@suse.com, plai@codeaurora.org, kwestfie@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, lkasam@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org



On 07/12/17 09:53, Philippe Ombredanne wrote:
> Srinivas,
> 
> On Tue, Dec 5, 2017 at 11:17 PM,  <srinivas.kandagatla@linaro.org> wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
>> ARP driver is made as a bus driver so that the apr devices can added removed
>> more dynamically depending on the state of the services on the dsp.
>> APR is used for communication between application processor and QDSP to
>> use services on QDSP like Audio and others.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> []
>> --- /dev/null
>> +++ b/drivers/soc/qcom/apr.c
>> @@ -0,0 +1,395 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> +* Copyright (c) 2011-2016, The Linux Foundation
>> +* Copyright (c) 2017, Linaro Limited
>> +*/
> 
> Accept my apologies as I am nitpicking there, but I think that Linus's
> preferred style for the SPDX id line is the C++  style //.
> 
Thanks for review, I just realized this, I will fix this in next version.


> And while you are at it since these is only license and copyrights you
> could go with this all the way, as in this:
> 
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2011-2016, The Linux Foundation
>> +// Copyright (c) 2017, Linaro Limited
Yep, thanks,

srini
> 
> You can check the doc patches posted by Thomas (tglx) and earlier
> comments from Linus wrt comment style and his good rationale for
> these.
> 
