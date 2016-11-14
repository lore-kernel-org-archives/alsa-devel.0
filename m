From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC 0/4] ALSA controls management using
 index/device/sub-devices fields
Date: Mon, 14 Nov 2016 14:58:06 +0100
Message-ID: <3c7b55b7-0b7f-fd55-9c30-745822a21d33@st.com>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
 <c28a3623-3cf1-5fc1-1ba8-e6785fb967ca@sakamocchi.jp>
 <cb9cf7f0-ae86-307b-c4d6-b4d3120d4e88@st.com>
 <a92aab32-03a1-5d89-0f3b-c080cc6bb938@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 0C4292663ED
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 14:58:18 +0100 (CET)
In-Reply-To: <a92aab32-03a1-5d89-0f3b-c080cc6bb938@sakamocchi.jp>
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

hello Takashi,

On 11/12/2016 05:23 AM, Takashi Sakamoto wrote:
>> So I propose to continue discussion on a simple and concrete use case:
>> The 'IEC958 Playback Default' control.
>>
>> In my ASoC driver i have one HDMI and one SPDIF outputs.
>> so I have 2'IEC958 Playback Default' PCM controls.
>> => Each control can be set independently.
> 
> Yes. It's a demand in your issue.
> (here, I ignore a process to generalize the issue for wider range in 
> this subsystem because it's another issue.)
> 
>> Regarding control identification field (struct snd_ctl_elem_i):
>>  .numid;  => set by ALSA framework
>>  .iface;  => must be SNDRV_CTL_ELEM_IFACE_PCM
>>  .device; => must be linked to PCM device , but not possible for
>>              ASoC DAI...
>>  .subdevice => not used in ASoC implementation
>>  .name      => 'IEC958 Playback Default'
>>  .index     => not used in ASoC, forced to 0 by snd_soc_cnew
>>
>> Other solution: use control "prefix"? not possible as control has a
>> pre-defined name.
>>
>> => Only solution to differentiate the control: "device" field.
>>    (that seems coherent as it a PCM device).
> 
> This is one of solutions we can perform for this issue. As a feasibility 
> study, in the end of this message, I wrote a small program with a 
> feature of 'user-defined control element set' in ALSA control core.
> 
> I think usage of 'device' field is better than usage of prefix for 
> 'name' field. It clearly represents the relationship between control 
> element set and PCM devices. And it's just suitable for this issue.
> 
This is also my view.
Now base on your mail, that point possibility to extend name
(http://www.spinics.net/lists/alsa-devel/msg56713.html):
> I note that we can give unique names to control element set for IEC
> 60958. According to this document, Between "IEC958" and the rest, we can
> put arbitrary string.
>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/designs/control-names.rst

I missed this, Seems that name is also another solution for IEC controls.
Gstreamer and pulseaudio use PCM name to set the AES value (e.g.
'B2120.pcm.hdmi.0:CARD=0,AES0=4,AES1=130,AES2=0,AES3=2' so simple
to adapt alsa conf file with good name.
iecset could be adapted in a quite simple way using device name or an
new option ( e.g. "-e name control name extension IEC958 <name> Playback
Default")

But, perhaps better to use device... as it match with expected PCM
control rule and as it could be applied for controls
based on standard syntax: [LOCATION] SOURCE [CHANNEL] [DIRECTION] FUNCTION

>> Issues:
>>      - use "device" in ASOC DAI driver means that driver needs to
>>        define a "virtual" PCM device value, not the PCM device.
>> 	=> this break the rule that mention that PCM control should be
>>         linked to a PCM device.
> 
> Please show me where related codes and structures are. At least, I 
> cannot understand what you said because it's really abstracted.
As example, here is my current implementation (correspond to the piece
of code i would like to rework):
http://www.lingrok.org/xref/linux-linus/sound/soc/sti/sti_uniperif.c#232
- "device" field is set to the instance ID of the DAI uniperiph player.
- "index" filed is also set but overwritten by ASoC core.
In this implementation what i name "virtual device is the "device" value
uni->id
HDMI: uni->id = 0 ( PCM device associated is hw:0,0)
SPDIF: uni->id = 3 ( PCM device associated is hw:0,2)

If i don't set the device value then i can not create both controls.
A better way should be to set device to PCM device.
This was the topic of [RFC 1/4] ASoC: core: allow PCM control binding to
PCM device (http://www.spinics.net/lists/alsa-devel/msg56482.html).

> 
>>        Furthermore, this "virtual" value has to be aligned with the one
>>        defined in alsa-lib conf file(s).
> 
> Ditto.
I have not upstreamed my card conf file but an example is available at
end of my mail.
Value of the device field must be aligned with ASoC driver device values:
HDMI: STI-B2120.pcm.hdmi.0.hooks.0.device=0
SPDIF: STI-B2120.pcm.iec958.0.hooks.0.device=3

If these controls were associated to the PCM device, I should not have
to fix the value but I should be able to retrieve it.

> 
>>      - iecset uses only index to differentiate IEC controls. But in
>>        ASoC implementation this is not possible as index is forced to 0.
> 
> _Apparently_, mixer APIs in alsa-lib is not well-designed to represent 
> capacity of ALSA control core. It's not better to judge somwthing 
> according to its design.
Not sure to follow you... I can not see any issue in alsa-lib. Just a
limitation of using iecset with ASoC implementation.
> 
> Although we need to improve iecset tool, this is another issue.
> 
>From my point of view, iecset is part of the topic even if i agree that
details on potential update could/should be discuss in a separate thread.
In case, PCM control device value is not aligned with PCM device, a
workaround exists, even if it does not respect the alignment between PCM
control and PCM device...
For iecset, i have no solution except patch it, if we consider that
index field incrementation is not the good solution for PCM controls.
So for me it is important to keep it in mind in discussions.

-------------

<confdir:pcm/iec958.conf>
<confdir:pcm/hdmi.conf>

STI-B2120.pcm.iec958.common {
	@args [ CARD DEVICE CTLINDEX AES0 AES1 AES2 AES3 ]
	@args.CARD {
		type string
	}
	@args.DEVICE {
		type integer
	}
	@args.CTLINDEX {
		type integer
	}
	@args.AES0 {
		type integer
		# consumer, not-copyright, emphasis-none, mode=0
		default 0x00
	}
	@args.AES1 {
		type integer
		# original, PCM coder
		default 0x00
	}
	@args.AES2 {
		type integer
		# source and channel
		default 0x00
	}
	@args.AES3 {
		type integer
		# fs=48000Hz, clock accuracy=1000ppm
		default 0x00
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device $DEVICE
	}
	hooks.0 {
		type ctl_elems
		hook_args [
		{
			interface PCM
			name "IEC958 Playback Default"
			device 3
			lock true
			preserve true
			value [ $AES0 $AES1 $AES2 $AES3 ]
		}
		]
	}
	hint.device $DEVICE
}

STI-B2120.pcm.iec958.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD { type string }
	@args.AES0 { type integer }
	@args.AES1 { type integer }
	@args.AES2 { type integer }
	@args.AES3 { type integer }
	@func refer
	name {
		@func concat
		strings [
			"cards.STI-B2120.pcm.iec958.common:"
			"CARD=" $CARD ","
			"DEVICE=2,"
			"CTLINDEX=0,"
			"AES0=" $AES0 ","
			"AES1=" $AES1 ","
			"AES2=" $AES2 ","
			"AES3=" $AES3
		]
	}
}

STI-B2120.pcm.hdmi.common {
	@args [ CARD DEVICE CTLINDEX AES0 AES1 AES2 AES3 ]
	@args.CARD {
		type string
		default 0
	}
	@args.DEVICE {
		type integer
		default 0
	}
	@args.CTLINDEX {
		type integer
	}
	@args.AES0 {
		type integer
		# consumer, not-copyright, emphasis-none, mode=0
		default 0x00
	}
	@args.AES1 {
		type integer
		# original, PCM coder
		default 0x00
	}
	@args.AES2 {
		type integer
		# source and channel
		default 0x00
	}
	@args.AES3 {
		type integer
		# fs=48000Hz, clock accuracy=1000ppm
		default 0x00I missed this, Seems that name is also another solution
for IEC controls.

	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device $DEVICE
	}
	hooks.0 {
		type ctl_elems
		hook_args [
			{
				interface PCM
				name "IEC958 Playback Default"
				device 0
				lock true
				preserve true
				value [ $AES0 $AES1 $AES2 $AES3 ]
			}
		]
	}
	hint.device $DEVICE
}
STI-B2120.pcm.hdmi.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD { type string }
	@args.AES0 { type integer }
	@args.AES1 { type integer }
	@args.AES2 { type integer }
	@args.AES3 { type integer }
	@func refer
	name {
		@func concat
		strings [
			"cards.STI-B2120.pcm.hdmi.common:"
			"CARD=" $CARD ","
			"DEVICE=0,"
			"CTLINDEX=0,"
			"AES0=" $AES0 ","
			"AES1=" $AES1 ","
			"AES2=" $AES2 ","
			"AES3=" $AES3
		]
	}
}

Thanks and Regards
Arnaud
