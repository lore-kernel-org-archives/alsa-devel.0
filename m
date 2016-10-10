From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: core: allow control index different
	from 0
Date: Mon, 10 Oct 2016 22:03:35 +0900
Message-ID: <cf680add-b2a8-49bc-7324-31b00f92e2ec@sakamocchi.jp>
References: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
 <57F4A4B4.5070400@sakamocchi.jp>
 <20be7e11-aaf3-37ad-df0f-b191dfc563d3@st.com>
 <57F6592A.5030004@sakamocchi.jp>
 <b9f83da7-faea-ce1b-ba9c-33c61b6686f0@st.com>
 <b8205913-8357-ff8a-5f13-2787a1144471@sakamocchi.jp>
 <75636c51-baf2-8793-b39b-5961845793c1@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id E0C0E265B3E
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2016 15:03:41 +0200 (CEST)
In-Reply-To: <75636c51-baf2-8793-b39b-5961845793c1@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "kernel@stlinux.com" <kernel@stlinux.com>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

On Oct 10 2016 18:26, Arnaud Pouliquen wrote:
> Sorry if my approach to treat the topic is not good. My Aim is to find a
> way to support multi instances of an alsa control.
> As I suppose that i'm not alone to have this kind of problematic. I am
> trying to look for a generic way to do it.
> 
>>
>> On Oct 8 2016 01:41, Arnaud Pouliquen wrote:
>>> Perhaps this could be handled in a generic way in control.c?
>>> Today if control is identical, snd_ctl_add returns an error.
>>> Instead an auto-incrementation mechanism could be implemented to
>>> increase index.
>>
>> Just for ALSA SoC part, something like below (not tested). This never
>> work well because 0 is still assigned to the index field later.
> Index is forced to 0 in snd_soc_cnew. Not updated after, please find
> comment in line in your patch.

I should write that '0 is assigned to the index field later than
calculated index number is assigned'.

>> But I still oppose this idea. This idea allows drivers to add control
>> element sets of different types (int/int64/bytes etc...) with the same
>> name and different index number. This certainly brings confusions to
>> applications.
> Today is already possible using the device or subdevice field instead of
> index.

Please explain about the reason or show references to the reason that
usage of iface/card/device/subdevice combination is not convenient to
your issue. To me, this solves the issue (second issue in your previous
message) because at least, from user land, applications can identify a
control element corresponding to each PCM subdevice.

In other words, in your taste, why this is not a generic way for
something you face (this is not cleared yet to me).

>> In a framework of ALSA SoC part, several drivers are associated to one
>> sound card instance can add their own control element sets. There's no
>> mechanism to prevent my concern. This idea is bad.
> Please tell me if i misunderstand. So for you, there is no real solution
> to do it in a generic way. Drivers has to implement it, if they want to
> support.

Over-generalizing, you did.

In my insistent, the usage of index field for this purpose is not just
better. I've never said that no real solutions we have.

> Another solution is to declare a card per instance of control.
> This should work for my use case and for use cases with several codecs
> that declare same controls.> But this should not work for DPCM...
> The drawback for my use case, would be that i need to declare one card
> per PCM device.

In my understanding, this idea is not good for simple-card
implementation in ALSA SoC part, too. The idea needs more complicated
driver to have several instances of sound card.


Regards

Takashi Sakamoto
