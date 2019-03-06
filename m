From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Wed, 6 Mar 2019 16:53:47 +0100
Message-ID: <02af2c16-b5c2-d717-4997-1dbeac6edc39@perex.cz>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D106F896CE
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2019 16:53:51 +0100 (CET)
In-Reply-To: <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sven Van Asbroeck <thesven73@gmail.com>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 05. 03. 19 v 15:23 Sven Van Asbroeck napsal(a):
> Hi Takashi,
> 
> On Mon, Mar 4, 2019 at 11:42 PM Takashi Sakamoto
> <o-takashi@sakamocchi.jp> wrote:
>>
>> Anyway, when posting to change UAPI of Linux sound subsystem, it's
>> better to describe the reason fot new stuffs; what they're designed for,
>> and the reason to require them. Wnen posting in a result of series of
>> discussion done previously, it's better to add any reference to it.
> 
> My apologies for not linking in previous discussions, I'll certainly make
> sure to link in the future.
> 
> The original problem was that the fsl_ssi did not appear to work with the
> tda998x hdmi codec. This codec seems to be 'unique' in the sense that it
> needs to know the number of clocks per frame on the wire, i.e. the bclk_ratio,
> which no-one in alsa is providing or using at the moment.
> 
> I first made the error of conflating the physical width and the bclk_ratio,
> and posted this patch - Russell King quickly pointed out my error:
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/145916.html
> 
> This then led to the following discussions:
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/thread.html#145985
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/thread.html#145947
> 
> Most of the discussion is about a mechanism to convey bclk_ratio from
> the frame master
> to the tda998x. We don't yet seem to have a consensus on how to do this best.
> 
> My rfc patch was only intended to provoke discussion, and to allow
> people to experiment
> with a flawed solution that would allow the alsa core to negotiate
> bclk_ratio between
> components. The uapi change is a serious flaw. bclk_ratio negotiation should be
> invisible to userspace. But I cannot see a way to accomplish this.

I think that this might be resolved using double constraint rules in the
affected driver:

    snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
                        bclk_format_constraint, substream,
                                  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
    snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
                        bclk_channels_constraint, substream,
                                  SNDRV_PCM_HW_PARAM_FORMAT, -1);

And refine the format bitmask / channel interval according your bclk
constraint. The physical sample width can be obtained in both
bclk_format_constraint / bclk_channels_constraint function so all input
values are known. The final bclk value can be obtained like in your
proposed code:

    params_channels(params) * params_width(params)

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
