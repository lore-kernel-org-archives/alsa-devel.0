From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Mon, 27 Jun 2011 14:42:08 +0200
Message-ID: <4E087AA0.1090100@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org>	<s5h39j0zpnc.wl%tiwai@suse.de>	<4E036C8F.3080709@gmail.com>	<s5hvcvvzkzq.wl%tiwai@suse.de>	<s5hk4cbzj6s.wl%tiwai@suse.de>	<4E047441.4010003@gmail.com>	<s5hpqm2v0zq.wl%tiwai@suse.de>	<4E05C1B1.50302@gmail.com>	<4E05C704.4080806@gmail.com>	<4E05CE02.1070801@gmail.com>	<s5hei2fvmgw.wl%tiwai@suse.de>	<4E082166.5060902@gmail.com>	<s5hpqlz3a3b.wl%tiwai@suse.de>
	<s5hhb7b315l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id A51862442F
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 14:42:12 +0200 (CEST)
Received: by fxh2 with SMTP id 2so1475096fxh.9
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 05:42:11 -0700 (PDT)
In-Reply-To: <s5hhb7b315l.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27/06/2011 14:32, Takashi Iwai wrote:
> At Mon, 27 Jun 2011 11:19:36 +0200,
> Takashi Iwai wrote:
>>
>> At Mon, 27 Jun 2011 08:21:26 +0200,
>> Julian Sikorski wrote:
>>>
>>> W dniu 27.06.2011 08:04, Takashi Iwai pisze:
>>>> At Sat, 25 Jun 2011 14:01:06 +0200,
>>>> Julian Sikorski wrote:
>>>>>
>>>>> W dniu 25.06.2011 13:31, Julian Sikorski pisze:
>>>>>> W dniu 25.06.2011 13:08, Julian Sikorski pisze:
>>>>>>> W dniu 25.06.2011 09:11, Takashi Iwai pisze:
>>>>>>>> At Fri, 24 Jun 2011 13:25:53 +0200,
>>>>>>>> Julian Sikorski wrote:
>>>>>>>>>
>>>>>>>>> On 24/06/2011 11:12, Takashi Iwai wrote:
>>>>>>>>>> At Fri, 24 Jun 2011 10:34:01 +0200,
>>>>>>>>>> Takashi Iwai wrote:
>>>>>>>>>>>
>>>>>>>>>>> At Thu, 23 Jun 2011 18:40:47 +0200,
>>>>>>>>>>> Julian Sikorski wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 23/06/2011 14:41, Takashi Iwai wrote:
>>>>>>>>>>>>> At Thu, 23 Jun 2011 08:36:55 +0200,
>>>>>>>>>>>>> Julian Sikorski wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I am coming here from pulseaudio-general mailing list [1]. I recently
>>>>>>>>>>>>>> got myself a Clevo P150HM laptop. It has 2.1 speakers, a built-in
>>>>>>>>>>>>>> microphone and the following connectors:
>>>>>>>>>>>>>> - headphone out
>>>>>>>>>>>>>> - microphone in; can be switched to center/lfe out
>>>>>>>>>>>>>> - spdif out; can be switched to rear speaker out
>>>>>>>>>>>>>> - line in; can be switched to side speaker out
>>>>>>>>>>>>>> Alsa does not seem to reflect that the device is capable of 5.1 and 7.1
>>>>>>>>>>>>>> sound, and there are two configs showing up in pavucontrol (analog
>>>>>>>>>>>>>> output and analog headphones) which seem to be the same. I have uploaded
>>>>>>>>>>>>>> the output of alsa-info.sh [2]. Please let me know if more information
>>>>>>>>>>>>>> is needed.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The current parser doesn't allow the multi-io pins when the primary
>>>>>>>>>>>>> output is no line-out.  The patch below should fix (change) the
>>>>>>>>>>>>> behavior.  It'll count HP out, too.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Takashi
>>>>>>>>>>>>>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>>>>>>>>>>>>> index fe56b2b..b0cf726 100644
>>>>>>>>>>>>> --- a/sound/pci/hda/patch_realtek.c
>>>>>>>>>>>>> +++ b/sound/pci/hda/patch_realtek.c
>>>>>>>>>>>>> @@ -18992,6 +18992,7 @@ static int alc662_auto_fill_dac_nids(struct hda_codec *codec,
>>>>>>>>>>>>>     	hda_nid_t dac;
>>>>>>>>>>>>>
>>>>>>>>>>>>>     	spec->multiout.dac_nids = spec->private_dac_nids;
>>>>>>>>>>>>> +	spec->multiout.num_dacs = 0;
>>>>>>>>>>>>>     	for (i = 0; i<    cfg->line_outs; i++) {
>>>>>>>>>>>>>     		dac = alc_auto_look_for_dac(codec, cfg->line_out_pins[i]);
>>>>>>>>>>>>>     		if (!dac)
>>>>>>>>>>>>> @@ -19326,8 +19327,20 @@ static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
>>>>>>>>>>>>>     	unsigned int location, defcfg;
>>>>>>>>>>>>>     	int num_pins;
>>>>>>>>>>>>>
>>>>>>>>>>>>> +	if (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT&&    cfg->hp_outs == 1) {
>>>>>>>>>>>>> +		/* use HP as primary out */
>>>>>>>>>>>>> +		cfg->speaker_outs = cfg->line_outs;
>>>>>>>>>>>>> +		memcpy(cfg->speaker_pins, cfg->line_out_pins,
>>>>>>>>>>>>> +		       sizeof(cfg->speaker_pins));
>>>>>>>>>>>>> +		cfg->line_outs = cfg->hp_outs;
>>>>>>>>>>>>> +		memcpy(cfg->line_out_pins, cfg->hp_pins, sizeof(cfg->hp_pins));
>>>>>>>>>>>>> +		cfg->hp_outs = 0;
>>>>>>>>>>>>> +		memset(cfg->hp_pins, 0, sizeof(cfg->hp_pins));
>>>>>>>>>>>>> +		cfg->line_out_type = AUTO_PIN_HP_OUT;
>>>>>>>>>>>>> +		alc662_auto_fill_dac_nids(codec, cfg);
>>>>>>>>>>>>> +	}
>>>>>>>>>>>>>     	if (cfg->line_outs != 1 ||
>>>>>>>>>>>>> -	    cfg->line_out_type != AUTO_PIN_LINE_OUT)
>>>>>>>>>>>>> +	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
>>>>>>>>>>>>>     		return 0;
>>>>>>>>>>>>>
>>>>>>>>>>>>>     	defcfg = snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0]);
>>>>>>>>>>>>> @@ -19348,6 +19361,8 @@ static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
>>>>>>>>>>>>>     		spec->multi_ios = num_pins;
>>>>>>>>>>>>>     		spec->ext_channel_count = 2;
>>>>>>>>>>>>>     		spec->multiout.num_dacs = num_pins + 1;
>>>>>>>>>>>>> +		/* for avoiding multi HP mixers */
>>>>>>>>>>>>> +		cfg->line_out_type = AUTO_PIN_LINE_OUT;
>>>>>>>>>>>>>     	}
>>>>>>>>>>>>>     	return 0;
>>>>>>>>>>>>>     }
>>>>>>>>>>>> Would you like me to test this patch? If so, what should I apply it to
>>>>>>>>>>>> and how should I proceed?
>>>>>>>>>>>
>>>>>>>>>>> Yes, the test would be appreciated, of course.
>>>>>>>>>>> Apply it to the latest 3.0-rc kernel and test.
>>>>>>>>>>
>>>>>>>>>> Also, the additional patch below will give "Headphone" mixer control
>>>>>>>>>> back while new "Surround", "Center" and "LFE" will appear.
>>>>>>>>>>
>>>>>>>>>> Note that you'll need to change "Channel Mode" mixer control to "6ch"
>>>>>>>>>> for using the surround outputs even with these patches.  As default,
>>>>>>>>>> it's set as "2ch".
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Takashi
>>>>>>>>>>
>>>>>>>>> I will definitely try to give this a shot, but the outcome might be
>>>>>>>>> dependent on the fact whether Fedora 15 will want to work with 3.0-rc
>>>>>>>>> kernel.
>>>>>>>>
>>>>>>>> You can build the kernel by yourself at any time...
>>>>>>>>
>>>>>>>>> How about 8-channel sound btw? Under Windows the device claims to be
>>>>>>>>> capable of it.
>>>>>>>>
>>>>>>>> Do you have 4 jacks?  Otherwise it's nonsense.
>>>>>>>>
>>>>>>>>
>>>>>>>> Takashi
>>>>>>> OK, I was able to successfully apply the patch and build the kernel. I
>>>>>>> tested it using:
>>>>>>> $ pasuspender bash
>>>>>>> $ speaker-test -Dplug:surround51 -c6
>>>>>>> Once I set sound to 6-channel using alsamixer -c0, I was able to hear
>>>>>>> the sound for all 6 channels. Setting it to 4 channels took away LFE and
>>>>>>> center. Pulseaudio outputs are still a little messy, but this is out of
>>>>>>> ALSA scope, I think.
>>>>>>>
>>>>>>> Julian
>>>>>> It seems I spoke a bit too soon. The superfluous controls are still a
>>>>>> problem. Speaker and Headphone controls seem to be overlapping (new
>>>>>> output on amixer -c0 attached). They both control the headphones when
>>>>>> they are plugged in and internal speakers when not.
>>>>>>
>>>>>> Julian
>>>>>>
>>>>> Sorry for this email bombardment, but I just booted back to stock F15
>>>>> kernel (2.6.38.8-32.fc15.x86_64) and noticed that speaker and headphone
>>>>> controls actually do what they advertise. Still, it is impossible to
>>>>> make the sound go through the speakers when headphones are plugged in (I
>>>>> tried pavucontrol for this).
>>>>
>>>> The auto-mute feature can be controlled "Auto-Mute Mode" mixer enum.
>>>> Set to "Disabled" will turn off the auto-mute in the driver side.
>>>> However...
>>>
>>> You are right - when auto-mute is disabled sound goes via both speakers
>>> and headphones when they are plugged. I did not know the function of
>>> auto-mute.
>>> However, the "Speaker" and "Headphone" controls still do influence both
>>> outputs, and "Speaker" can only be muted - there is no volume control
>>> available. So, in my opinion, they should either be merged altogether,
>>> or switched back to the way they work in 2.6.38.8-32.fc15.x86_64, that
>>> is setting the volume of speakers and headphones independently.
>>
>> Give alsa-info.sh outputs on your machine with the latest status for
>> further analysis.
>
> I think this issue was fixed now in topic/hda branch in sound git tree:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>
> Give it a try.  You can pull the branch into the latest Linus git tree
> for merging into the latest 3.0-rc.
>
>
> Takashi
Do you mean this specific commit:
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=3af9ee6b83c4c3f2577719e31e7d2af1ce996557 
?
The thing is that I only know how to build a kernel using Fedora RPM and 
I have never built it purely from source. As a result, I can easily test 
patches but testing whole trees might be tricky. If it is a problem, I 
can try to seek help how to create RPM out of your tree. I'll try to 
test it one way or the other once I get back home in the evening (I'm in 
CEST time zone).
Thank you for all the input so far.

Julian
