From: Daniel Mack <zonque@gmail.com>
Subject: Re: am335x: mcasp in DIT mode
Date: Mon, 04 Mar 2013 08:55:53 +0100
Message-ID: <51345389.2030502@gmail.com>
References: <CAGm1_kt83A2i-ew_gUaySRZpMeuQPEpTvEH_xX9BvfpUKob_Ug@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3B63C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id A6B92262606
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 08:55:51 +0100 (CET)
Received: by mail-wi0-f169.google.com with SMTP id l13so1792437wie.0
 for <alsa-devel@alsa-project.org>; Sun, 03 Mar 2013 23:55:51 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3B63C@DBDE01.ent.ti.com>
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

Hi Vaibhav,
Hi Yegor,

On 04.03.2013 07:22, Bedia, Vaibhav wrote:
> On Fri, Mar 01, 2013 at 16:23:53, Yegor Yefremov wrote:
>> I've solved the problem with DIT/SPDIF mode (see the issue description
>> here: http://e2e.ti.com/support/arm/sitara_arm/f/791/p/247447/870030.aspx).
>>
>> In davinci_mcasp_hw_params() the DIT or I2S params will be set in the
>> beginning. DIT mode configures the DAVINCI_MCASP_TXMASK_REG and
>> DAVINCI_MCASP_TXFMT_REG.
>>
>> And here comes the problem:
>>
>> at the end of davinci_mcasp_hw_params() the
>> davinci_config_channel_size() will touch the same registers again and
>> thus overwrite the settings necessary for DIT. After I commented this
>> routine I got the sound over S/PDIF and sii9022a HDMI transmitter and
>> I could see the proper bits appearing on my oscilloscope.
>>
>> What were the best way to solve this problem?
>>
>> 1. execute  davinci_config_channel_size() only if not in DIT mode?
>> 2. for DIT only change the DAVINCI_MCASP_TXMASK_REG according to channel width?
>> 3. execute
>>
>> if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
>>                 davinci_hw_dit_param(dev);
>> else
>>                 davinci_hw_param(dev, substream->stream);
>>
>> after davinci_config_channel_size()
>>
> 
> AFAIK DIT mode was working on Davinci platforms some time back. Since AM335x
> has the same hardware block I was surprised to see this bug report. Not having
> a setup handy to test out DIT related changes, I looked at the commits on the
> mcasp file to figure out what happened. I suspect one of the recent patches which
> added 24bit support inadvertently broke the DIT support. Would it be possible
> for you to do a git-bisect to find out what change it was? It would be good
> to reference that change in the final patch.

I agree, but I also believe it's not easy to do, given the number of
different trees you need for AM33xx support in general.

You could revert them one-by-one, but then again, you probably need most
of them in order to make the driver work on AM33xx and in setups that
differ from what the davici driver was originally written for.

> Coming to the 3 options that you have listed I would suggest going with #1.
> DIT mode requires the configuration to be 32 bit slot with rotation set to 24
> but looks like the current implementation of davinci_config_channel_size()
> doesn't handle this scenario very well.

Hmm, if that's the case, I fail to see how the 24-bit patches you
mentioned could possibly account for that, given that they don't touch
the logical around this area. Unless I miss anything very obvious :) Can
you be a bit more specific about which of these patches you suspect?

> I think the driver needs a bit of
> rework to ensure Tx and Rx paths don't end up overwriting the configuration
> but that needs to be taken up separately.

Yegor - could you send me a patch that fixes the problem for you? I can
do regression tests on my platform.


Thanks,
Daniel
