From: Daniel Mack <zonque@gmail.com>
Subject: Re: am335x: mcasp in DIT mode
Date: Mon, 04 Mar 2013 09:03:54 +0100
Message-ID: <5134556A.4060709@gmail.com>
References: <CAGm1_kt83A2i-ew_gUaySRZpMeuQPEpTvEH_xX9BvfpUKob_Ug@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3B63C@DBDE01.ent.ti.com>
 <51345389.2030502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f177.google.com (mail-we0-f177.google.com
 [74.125.82.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F38E264F2B
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 09:03:53 +0100 (CET)
Received: by mail-we0-f177.google.com with SMTP id d7so4209146wer.8
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 00:03:52 -0800 (PST)
In-Reply-To: <51345389.2030502@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Porter, Matt" <mporter@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Fernandes,
 Joel A" <joelagnel@ti.com>, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: alsa-devel@alsa-project.org

On 04.03.2013 08:55, Daniel Mack wrote:
> Hi Vaibhav,
> Hi Yegor,
> 
> On 04.03.2013 07:22, Bedia, Vaibhav wrote:
>> On Fri, Mar 01, 2013 at 16:23:53, Yegor Yefremov wrote:
>>> I've solved the problem with DIT/SPDIF mode (see the issue description
>>> here: http://e2e.ti.com/support/arm/sitara_arm/f/791/p/247447/870030.aspx).
>>>
>>> In davinci_mcasp_hw_params() the DIT or I2S params will be set in the
>>> beginning. DIT mode configures the DAVINCI_MCASP_TXMASK_REG and
>>> DAVINCI_MCASP_TXFMT_REG.
>>>
>>> And here comes the problem:
>>>
>>> at the end of davinci_mcasp_hw_params() the
>>> davinci_config_channel_size() will touch the same registers again and
>>> thus overwrite the settings necessary for DIT. After I commented this
>>> routine I got the sound over S/PDIF and sii9022a HDMI transmitter and
>>> I could see the proper bits appearing on my oscilloscope.
>>>
>>> What were the best way to solve this problem?
>>>
>>> 1. execute  davinci_config_channel_size() only if not in DIT mode?
>>> 2. for DIT only change the DAVINCI_MCASP_TXMASK_REG according to channel width?
>>> 3. execute
>>>
>>> if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
>>>                 davinci_hw_dit_param(dev);
>>> else
>>>                 davinci_hw_param(dev, substream->stream);
>>>
>>> after davinci_config_channel_size()
>>>
>>
>> AFAIK DIT mode was working on Davinci platforms some time back. Since AM335x
>> has the same hardware block I was surprised to see this bug report. Not having
>> a setup handy to test out DIT related changes, I looked at the commits on the
>> mcasp file to figure out what happened. I suspect one of the recent patches which
>> added 24bit support inadvertently broke the DIT support. Would it be possible
>> for you to do a git-bisect to find out what change it was? It would be good
>> to reference that change in the final patch.
> 
> I agree, but I also believe it's not easy to do, given the number of
> different trees you need for AM33xx support in general.

Just to be clear: I was referring to the number of commits in different
areas that you needed by the time these mcasp patches were merged. I
think they make it tricky to bisect back from the current state now. But
maybe Yegor's setup looks differently, who knows.



Thanks,
Daniel
