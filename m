From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] ASoC: core: allow control index different
	from 0
Date: Mon, 10 Oct 2016 16:38:18 +0200
Message-ID: <810077fe-c979-5dc1-7f95-f76b7c756175@st.com>
References: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
 <57F4A4B4.5070400@sakamocchi.jp>
 <20be7e11-aaf3-37ad-df0f-b191dfc563d3@st.com>
 <57F6592A.5030004@sakamocchi.jp>
 <b9f83da7-faea-ce1b-ba9c-33c61b6686f0@st.com>
 <b8205913-8357-ff8a-5f13-2787a1144471@sakamocchi.jp>
 <75636c51-baf2-8793-b39b-5961845793c1@st.com>
 <cf680add-b2a8-49bc-7324-31b00f92e2ec@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 42B86265B3E
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2016 16:38:22 +0200 (CEST)
In-Reply-To: <cf680add-b2a8-49bc-7324-31b00f92e2ec@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Moise GERGAUD <moise.gergaud@st.com>, "broonie@kernel.org" <broonie@kernel.org>, "kernel@stlinux.com" <kernel@stlinux.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org




>>> But I still oppose this idea. This idea allows drivers to add control
>>> element sets of different types (int/int64/bytes etc...) with the same
>>> name and different index number. This certainly brings confusions to
>>> applications.
>> Today is already possible using the device or subdevice field instead of
>> index.
> 
> Please explain about the reason or show references to the reason that
> usage of iface/card/device/subdevice combination is not convenient to
> your issue. To me, this solves the issue (second issue in your previous
> message) because at least, from user land, applications can identify a
> control element corresponding to each PCM subdevice.
> 
> In other words, in your taste, why this is not a generic way for
> something you face (this is not cleared yet to me).

iface/card/device/subdevice can be used when control is linked to a PCM
device.
Main difference for ASoC drivers is that controls associated to CPU_DAIs
and CODEC_DAIs are not linked to PCM device.
That's why i had mentioned in a previous mail a patch that proposed to
link DAI to PCM (it just a first version for concept).
[PATCH v4 1/6] ASoC: core: add snd_soc_add_dai_pcm_controls helper:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105501.html

This could link control to PCM device for CPU and CODEC DAI in ASoC
implementation. But issue still there for DPCM implementation where
back-end is not linked to the PCM device, or for CODECS without DAI
interface, as mentioned in feedbacks:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105570.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105660.html

Also we can imagine 2 instances of the same codec (for instance HDMI1
and HDMI2 output for TV and AVR). They can export twice the same
controls. In this case issue can also exists for none PCM controls (such
as MIXER controls).

The last point is the iecset application. It uses card/index and not
iface/card/device/subdevice. But this also makes sense if iec control
is not linked to PCM device.

>> Another solution is to declare a card per instance of control.
>> This should work for my use case and for use cases with several codecs
>> that declare same controls.> But this should not work for DPCM...
>> The drawback for my use case, would be that i need to declare one card
>> per PCM device.
> 
> In my understanding, this idea is not good for simple-card
> implementation in ALSA SoC part, too. The idea needs more complicated
> driver to have several instances of sound card.
Simple card can be instantiate in DT to create several sound cards.
But look like more a backup that a main solution, from my point of view.

Regards
Arnaud
