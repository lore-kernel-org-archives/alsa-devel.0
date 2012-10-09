From: gsantosh@codeaurora.org
Subject: Re: customized IOCTL in pcm platform driver.
Date: Tue, 9 Oct 2012 00:30:40 -0700 (PDT)
Message-ID: <9c99072a34e9cd171404e40d6e543d13.squirrel@www.codeaurora.org>
References: <d0ef8dd36b2e37d9f0f0886758cb5963.squirrel@www.codeaurora.org>
 <s5hipak6td2.wl%tiwai@suse.de>
 <4d3d244e3c337274675747eee0404a78.squirrel@www.codeaurora.org>
 <s5hfw5o6ss5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 by alsa0.perex.cz (Postfix) with ESMTP id D7A3226526D
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 09:30:56 +0200 (CEST)
In-Reply-To: <s5hfw5o6ss5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org

> At Mon, 8 Oct 2012 23:44:40 -0700 (PDT),
> gsantosh@codeaurora.org wrote:
>>
>> > At Mon, 8 Oct 2012 23:30:09 -0700 (PDT),
>> > gsantosh@codeaurora.org wrote:
>> >>
>> >> Hi All,
>> >>
>> >> will ALSA framework provide any customized IOCTL functionality in PCM
>> >> platform driver.
>> >
>> > No.
>> >
>> >> in my  system there is a requirement to get some information from DSP
>> to
>> >> user space and I am thinking to add IOCTL's, is there any method to
>> >> accommodate or how we can address this issue?
>> >
>> > You can use hwdep device for any extra methods.
>>
>> We need to tie this ioctl with the on going DSP session which will be
>> difficult When used with hwdep interface.
>
> Hm, how can it be difficult?  More specific description is needed to
> answer more.

to communicate with DSP we open up a session and populate that information
in the substream, for this use case during the playback session user space
has to talk to DSP to get some information like time stamp also the time
stamp statistics, to talk to DSP I need to get hold of the proper
substream so that the communication with particular session is possible.

I see adding one IOCTL in the platform driver will solve my issue, but not
finding any way to integrate this in the current framework,

if we use the hwdep, not sure how can I get hold of the substream handle
so I can talk to particular session in DSP.

DSP can support multiple sessions playback even in this case we need to
talk to DSP but the DSP session information will be the part of substream,
I need to get hold of proper substream handle to talk to particular DSP
session.

let me know can we handle this?

>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
