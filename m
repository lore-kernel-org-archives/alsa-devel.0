From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] ASoC: core: allow control index different
 from 0
Date: Tue, 11 Oct 2016 15:58:49 +0200
Message-ID: <19d5e5fd-9cce-989f-8c53-78137c2d37dd@st.com>
References: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
 <57F4A4B4.5070400@sakamocchi.jp>
 <20be7e11-aaf3-37ad-df0f-b191dfc563d3@st.com>
 <57F6592A.5030004@sakamocchi.jp>
 <b9f83da7-faea-ce1b-ba9c-33c61b6686f0@st.com>
 <b8205913-8357-ff8a-5f13-2787a1144471@sakamocchi.jp>
 <75636c51-baf2-8793-b39b-5961845793c1@st.com>
 <20161011083024.GD1952@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id BE2A2266B57
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2016 15:58:54 +0200 (CEST)
In-Reply-To: <20161011083024.GD1952@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kernel@stlinux.com" <kernel@stlinux.com>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vinod Koul <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org



On 10/11/2016 10:30 AM, Charles Keepax wrote:
> On Mon, Oct 10, 2016 at 11:26:00AM +0200, Arnaud Pouliquen wrote:
>>
>>
>> On 10/09/2016 05:05 AM, Takashi Sakamoto wrote:
>>> Sorry to be late. I've review your driver in for-next branch of
>>> maintainer's tree.
>>>
>>> On Oct 8 2016 01:41, Arnaud Pouliquen wrote:
>>> But I still oppose this idea. This idea allows drivers to add control
>>> element sets of different types (int/int64/bytes etc...) with the same
>>> name and different index number. This certainly brings confusions to
>>> applications.
>> Today is already possible using the device or subdevice field instead of
>> index.
>>>
>>> In a framework of ALSA SoC part, several drivers are associated to one
>>> sound card instance can add their own control element sets. There's no
>>> mechanism to prevent my concern. This idea is bad.
>> Please tell me if i misunderstand. So for you, there is no real solution
>> to do it in a generic way. Drivers has to implement it, if they want to
>> support.
>>
>> Another solution is to declare a card per instance of control.
>> This should work for my use case and for use cases with several codecs
>> that declare same controls. But this should not work for DPCM...
>> The drawback for my use case, would be that i need to declare one card
>> per PCM device.
> 
> Apologies if I am missing the mark here, I haven't been following
> this thread in great detail. But if your main concern here is
> multiple instances of the same CODEC creating the same controls
> the normal way to handle that in ASoC is using a
> snd_soc_codec_conf struct which lets you add a prefix to all the
> controls from a specific instance of a CODEC. See
> sound/soc/samsung/bells.c for an example using it.

Codec multi instance is one of the use cases. CPU_DAI multi instance is
another one (and my main concern).
But use of a prefix_name is a good point that i have not prospected yet,
thanks.
Today it is not implemented neither for CPU_DAIs nor for simple card.
But my main drawback of the prefix name, is that this breaks the naming
of generic controls like IEC. So i can't use it.

Regards
Arnaud
