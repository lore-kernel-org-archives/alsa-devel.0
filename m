From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC 0/4] ALSA controls management using
 index/device/sub-devices fields
Date: Wed, 9 Nov 2016 15:38:47 +0100
Message-ID: <cb9cf7f0-ae86-307b-c4d6-b4d3120d4e88@st.com>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
 <c28a3623-3cf1-5fc1-1ba8-e6785fb967ca@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 45651266802
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 15:38:51 +0100 (CET)
In-Reply-To: <c28a3623-3cf1-5fc1-1ba8-e6785fb967ca@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 11/09/2016 01:33 PM, Takashi Sakamoto wrote:
> Hi,
> 
> On Nov 8 2016 17:11, Arnaud Pouliquen wrote:
>> 3) Patches proposed:
>> Based on these observations, here are some patches that i tested in my
>> environment. There are complementary,  and could answer to some
>> limitations mentioned above.
>>
>> 3-1) Alsa-utils patch
>>
>> - iecset: allow to select control with device and sub-device numbers
>>   This patch allows to access to 2 iec controls differentiated by
>>   device/sub-devices numbers
>> => For me, this patch is mandatory to be able to address the ASoC IEC
>>    controls, in case of no fix is implemented to allows index field
>>    update in ASoC.
>>
>> 3-2) Alsa driver patches
>>   - ASoC: core: allow PCM control binding to PCM device
>>   	Add relationship between DAIs PCM controls and PCM device.
>>
>>   - ALSA: control: increment index field for duplicated control.
>>    	Generic implementation of the patch proposed in HDA driver
>>         (http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add)
>>
>>   - ASoC: sti: use bind_pcm_ctl
>>   	implementation of bind_pcm_ctl for sti driver.
> 
> In my view, this patchset includes two attempts:
> 1.to add a framework into ALSA SoC part to relate some control element 
> sets to PCM devices
> 2.to allow drivers in ALSA SoC part to add some control element sets 
> from the same codes according to entries of dtb
> 
> To achieve above 2nd attempt, it changes ALSA control core to accept 
> several control element sets with the same name by assigning proper 
> indexes to the sets.
> 
> Well, since your former messages, you continue using the word, 'general' 
> or 'generic'. If it were somewhat general, it should satisfy 
> requirements in whole this subsystem. Actually, there's none of such 
> requirements outside of ALSA SoC part. For the drivers outside of ALSA 
> SoC part, design of target sound card is fixed in advance, therefore 
> programmers can assign control element sets to PCM devices in usual 
> ways. At least, current infrastructure in ALSA control core can satisfy 
> the programmers.
> 
> Therefore, I think that your attempts includes over-generalization. In 
> theory, it can bring over-specification easily and it causes code 
> complication or unmaintained codes.

I based my RFC on the fact that i was facing same kind of problem than
HDA driver (last time i mention it). In this context, i don't think that
it was senseless to have a global approach.
If not the good approach, let's refocus on ASoC, that's fine by me.
> 
> 
> Focusing on ALSA SoC part, there's a requirement to register control 
> element sets from the same code, in fact. So I wonder why you don't 
> start your explanation in an aspect of it. In short, I can't understand 
> the reason that you adhere to such an inappropriate generalization for 
> this subsystem.
> 
> In this patchset, you adhere to usage of 'index' field. But there's 
> another way; assigning different identification information to the 
> control element sets. Let us to start discussion from this point? At 
> least, Iwai-san said, former driver for Intel High Definition Audio is 
> necessarily not a good example for a model to c
> onsider about this issue and the usage of 'index' is not 
> well-generalized[1].
> 
> Finally, it's better to clear main points of your issue, for practical 
> and meaningful discussion for better approaches, before starting this 
> discussion, I think. At least, there's over-generalization, 
> misunderstandings of design and interfaces, driver-specific historical 
> reasons and so on.
> 
> 
> [1] [alsa-devel] [RFC 0/4] ALSA controls management using 
> index/device/sub-devices fields
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/114430.html
> 
So I propose to continue discussion on a simple and concrete use case:
The 'IEC958 Playback Default' control.

In my ASoC driver i have one HDMI and one SPDIF outputs.
so I have 2'IEC958 Playback Default' PCM controls.
=> Each control can be set independently.

Regarding control identification field (struct snd_ctl_elem_i):
 .numid;  => set by ALSA framework
 .iface;  => must be SNDRV_CTL_ELEM_IFACE_PCM
 .device; => must be linked to PCM device , but not possible for
             ASoC DAI...
 .subdevice => not used in ASoC implementation
 .name      => 'IEC958 Playback Default'
 .index     => not used in ASoC, forced to 0 by snd_soc_cnew

Other solution: use control "prefix"? not possible as control has a
pre-defined name.

=> Only solution to differentiate the control: "device" field.
   (that seems coherent as it a PCM device).

Issues:
     - use "device" in ASOC DAI driver means that driver needs to
       define a "virtual" PCM device value, not the PCM device.
	=> this break the rule that mention that PCM control should be
        linked to a PCM device.
       Furthermore, this "virtual" value has to be aligned with the one
       defined in alsa-lib conf file(s).
     - iecset uses only index to differentiate IEC controls. But in
       ASoC implementation this is not possible as index is forced to 0.

Regards
Arnaud
