From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH] ASoC: core: Invoke pcm_new() for all
 DAI-link
Date: Wed, 21 Nov 2018 13:08:12 +0530
Message-ID: <71f9a436-aa73-29df-9dbe-849f95a8ccb1@codeaurora.org>
References: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
 <s5htvl0exil.wl-tiwai@suse.de>
 <48c78f67-8178-2d07-e35d-2e4eca51ccbc@codeaurora.org>
 <791d4587-4db3-3ffa-331a-f79d0993ca8c@st.com>
 <3616f01f-6a00-6eb1-0bdd-f161b7ce15e6@codeaurora.org>
 <4f22e4e5-84f0-1560-1ba7-5e77d44fd312@st.com>
 <20181107161437.GC6809@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 40303267936
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 08:38:22 +0100 (CET)
In-Reply-To: <20181107161437.GC6809@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, olivier.moysan@st.com, vinod.koul@linaro.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, ajitp@codeaurora.org
List-Id: alsa-devel@alsa-project.org


On 11/7/2018 9:44 PM, Mark Brown wrote:
> On Tue, Nov 06, 2018 at 04:41:23PM +0100, Arnaud Pouliquen wrote:
>
>> I would say force device to 0 if no_pcm (need probably to create the
>> control in hdmi_of_xlate_dai_id instead of hdmi_codec_pcm_new).
>> But keep in mind that solution has to work in case of multi HDMI codec
>> instances, perhaps using prefix...
>> Anyway, i'm not a DPCM expert so perhaps more elegant solutions exist.
> Liam, any thoughts on how to handle this?  I've still not really worked
> with DPCM systems!
>
Liam/Mark, Do you have any suggestion on this?

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
Thanks,
Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.
