From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] ASoC: core: allow control index different
	from 0
Date: Fri, 7 Oct 2016 18:41:53 +0200
Message-ID: <b9f83da7-faea-ce1b-ba9c-33c61b6686f0@st.com>
References: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
 <57F4A4B4.5070400@sakamocchi.jp>
 <20be7e11-aaf3-37ad-df0f-b191dfc563d3@st.com>
 <57F6592A.5030004@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D84D7266DFD
 for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2016 18:41:57 +0200 (CEST)
In-Reply-To: <57F6592A.5030004@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "kernel@stlinux.com" <kernel@stlinux.com>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org



On 10/06/2016 04:01 PM, Takashi Sakamoto wrote:
> On Oct 5 2016 17:41, Arnaud Pouliquen wrote:
>> Thanks for the explanation. Here is my use case:
>> I have a card with 3 output devices:
>>  hw:0,0 HDMI
>> 	associated controls:
>> 		numid=1,iface=PCM,name='ELD'
>> 		numid=2,iface=PCM,name='IEC958 Playback Default'
>> 		numid=3,iface=PCM,name='Freq.Adjustment'
>>  hw:0,1 DAC
>> 	associated controls:
>> 		numid=4,iface=PCM,name=' Freq Adjustment'
>>  hw:0,2 SPDIF
>> 	associated controls:
>> 		numid=5,iface=PCM,name='IEC958 Playback Default'
>> 		numid=6,iface=PCM,name='Freq Adjustment'
>>
>> My concern is to differentiate the controls associated to the outputs.
>> Seems that it could be done using device field, but iecset is based on
>> index (or i missed something?).
>> Adding an option in iecset to address control by device could solve the
>> issue... but it is to good way to handle the use case?
>>
>> Complementary solution would be that control device field corresponds to
>> PCM device, to allow to address PCM device with args (for instance AESx
>> params for iec)
>>
>> This is linked to the management of DAI PCM controls that has already
>> been discussed in thread associated to this patch:
>> http://www.spinics.net/lists/alsa-devel/msg47611.html.
>> I can rework my patch (suppress iec generic control, to simplify it)
>> but this only treat DAI controls not BE and "dai less" codecs.
> 
> Hm. In configuration space (namespace) of alsa-lib, the 'hw:0,1' PCM
> node is a short representation of 'pcm.hw:0,1,0'; each member expresses:
>  - pcm: interface
>  - hw:  plugin name
>  - 0:   card number
>  - 1:   device number
>  - 0:   subdevice number
> 
> Next, when identifying a control element, 'struct snd_ctl_elem_id' is
> used in ALSA control core. Layout of the structure is in <sound/asound.h>:
> 
> struct snd_ctl_elem_id {
>   unsigned int numid;
>   snd_ctl_elem_iface_t iface;
>   unsigned int device;
>   unsigned int subdevice;
>   unsigned char name[44];
>   unsigned int index;
> };
> 
> Under the above design, when using a proper combination of
> iface/card/device/subdevice, we can represent the relationship between a
> control element and a PCM node.
> 
> But in a case of control elements for IEC 60958 type, we need to read
> this patch, commit ea9b43addc4d ("ALSA: hda - Fix broken workaround for
> HDMI/SPDIF conflicts").
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add
> 
> In this commit for former Intel HDA driver, two issues were addressed:
>  - multiple codecs gives functionalities of digital interface such as HDMI.
>  - bug of mixer interface in alsa-lib
not aware about alsa-lib issue... Have you an URI that details the issue?
> 
> Due to the issues, 'index' field is used, instead of the design I described.
> 
> Although, the requirement for HDA codecs (verb parser) and your
> requirement is different. I think it better for you to follow the above
> design, then fix the bug of mixer interface in alsa-lib. At least, via
> the other ctl-related APIs such as ctl/hctl, the control element can be
> selected and processed in user land.

First, sorry i think my mail is not Cristal clear

Let clarify the my devs:

1) My original implementation is here :
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/soc/sti/sti_uniperif.c?h=sound-4.9-rc1#n232
this does not work due to index that is overwritten
 Notice that my issue is not limited to iec958 control, but controls in
generals

2) In parallel, I proposed generic code to implement:
 IEC control + possibility to attach DAI ctrl to PCM
device:http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105502.html

Right now, I propose to focus on point 1) that integrates constraints
for DAIs and forget the patch-set that includes IEC generic control (if
you interested in this code, i can rework it in a second step)

STI DAI driver uses DAI control interface. Index is forced to 0 but as
device is also set, no error on ctrl registration.
Handle index based on HDA codec implementation means I need to bypass
DAI ctrl helpers... Should be nice to have a more generic way,
as several implementations can face the same issue.

Perhaps this could be handled in a generic way in control.c?
Today if control is identical, snd_ctl_add returns an error.
Instead an auto-incrementation mechanism could be implemented to
increase index.

> 
>> This is linked to the management of DAI PCM controls that has already
>> been discussed in thread associated to this patch:
>> http://www.spinics.net/lists/alsa-devel/msg47611.html.
>> I can rework my patch (suppress iec generic control, to simplify it)
>> but this only treat DAI controls not BE and "dai less" codecs.
> 
> I can't follow all of messages in the related threads, but:
> 
> [alsa-devel] [PATCH v3 1/4] ALSA: pcm: add IEC958 channel status control
> helper
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105152.html
> 
> Takashi Iwai wrote:
>> Hmm, this doesn't always work.  It will create the substream_count
>> ctls starting from the pcm dev# as index.  What if there are 2 PCM
>> devices where both contain 4 substreams?
> 
> struct snd_ctl_elem_id.subdevice can represent the index of PCM
> substream because current PCM core expresses the substreams as the
> subdevices.
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/pcm.c?h=sound-4.9-rc1#n144
> 
> [alsa-devel] [PATCH v3 1/4] ALSA: pcm: add IEC958 channel status control
> helper
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105158.html
> 
> Takashi Iwai wrote:
>> This pretty much depends on the hardware design.  If each substream is
>> really individual, you'd need to give the control for each substream.
> 
> I'll assist his advice for your issue.
For IEC generic ctrl, hope that this point has be integrated in V4:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105505.html
index is no more overwritten by snd_pcm_create_iec958_ctl and subdevice
is added in function params

Thanks and Regards
Arnaud
