From: Alex Fedora <alexander.fedora@gmail.com>
Subject: Re: PROBLEM: [Lenovo ThinkPad X61s] Speaker volume
 mutes itself in random intervals after upgrading from 3.11 to 3.15.
Date: Tue, 03 Jun 2014 00:41:48 -0700
Message-ID: <538D7C3C.3040301@gmail.com>
References: <538ACE22.9020306@gmail.com>	<s5h8upflouw.wl%tiwai@suse.de>	<538C3BF4.2000706@gmail.com>	<s5h1tv7lliv.wl%tiwai@suse.de>	<538C489C.1030508@gmail.com>
 <s5hvbsjjz2w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A8B2655C5
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 09:41:57 +0200 (CEST)
Received: by mail-pb0-f50.google.com with SMTP id ma3so5204294pbc.9
 for <alsa-devel@alsa-project.org>; Tue, 03 Jun 2014 00:41:56 -0700 (PDT)
In-Reply-To: <s5hvbsjjz2w.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/02/2014 05:05 AM, Takashi Iwai wrote:
> At Mon, 02 Jun 2014 02:49:16 -0700,
> Alex Fedora wrote:
>> On 06/02/2014 02:15 AM, Takashi Iwai wrote:
>>> At Mon, 02 Jun 2014 01:55:16 -0700,
>>> Alex Fedora wrote:
>>>> On 06/02/2014 01:03 AM, Takashi Iwai wrote:
>>>>> At Sat, 31 May 2014 23:54:26 -0700,
>>>>> Alex Fedora wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Please see problem description below. I've captured alsa info output for
>>>>>> the latest kernel. Kernel just before the regression. And info from the
>>>>>> kernel with the offending commit. But I had to calculate diff from first
>>>>>> one to fit to 100K limit. If you want, I can send all 3 files as an
>>>>>> attachments. Also the latest version of the kernel was took from
>>>>>> http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/current/linux-image-3.15.0-999-generic_3.15.0-999.201405310205_amd64.deb
>>>>>> .
>>>>>>
>>>>>> Thank you,
>>>>>> Alex
>>>>>>
>>>>>> [1.] One line summary of the problem: [Lenovo ThinkPad X61s] Speaker
>>>>>> volume mutes itself in random intervals after upgrade to latest kernel
>>>>>> [2.] Full description of the problem/report:
>>>>>>
>>>>>> Speaker mutes itself in random intervals. Headphones are working fine at
>>>>>> that moment. I can see what volume of the Speaker drops to 0% and then
>>>>>> back to 100% using alsamixer. It seems like Internal Mic Boost also
>>>>>> jumps from 100% to 0% and back. It is regression from
>>>>>> 5ccc618fee67f0f0b2122dd4b32a02fd2b6a1569 (ALSA: hda - Remove static
>>>>>> quirks for AD1884/1984 & variants). I've tested previous commit
>>>>>> aa95d61b43e0fcb0b2ce68e5efa37174fd9e5cd3 (ALSA: hda - Remove static
>>>>>> quirks for AD1882) and audio works as expected.
>>>>>>
>>>>>> New kernel shows two controls "Headphone Playback Volume" and "Speaker
>>>>>> Playback Volume". But old one shows single control "PCM Playback
>>>>>> Volume". "Speaker Playback Volume" is the one which gets muted randomly.
>>>>> Are you using PulseAudio?  If yes, does the problem happen without PA?
>>>>> This kind of random mute/unmute tends to be an issue of bogus
>>>>> headphone or mic jack detection.
>>>>>
>>>>>
>>>>> Takashi
>>>>>
>>>> Hi Takashi,
>>>>
>>>> Yes, I'm using  PulseAudio. I've removed it and issue gone away. It
>>>> returned back after reinstalling it. This is still driver bug, right?
>>> Yes.  So PA seems confused by some bogus information by the driver.
>>>
>>> Try to run "alsactl monitor 0", maybe better without PA at first.
>>> Do you see occasional events about the jack detection even if you
>>> don't plug/unplug?  And, try it also with PA.
>>>
>>>
>>> Takashi
>>>
>> Yes, I can see a lot of events even if I don't plug/unplug anything.
>> Even more if I'm using PA.
>>
>> No pulseaudio:
>>
>> card 0, #22 (0,0,0,Mic Jack,0) VALUE
>> card 0, #23 (0,0,0,Headphone Jack,0) VALUE
>> card 0, #23 (0,0,0,Headphone Jack,0) VALUE
> Thanks.  These are definitely bogus events.  No wonder that PA gets
> screwed up.
>
> Could you try the patch below?
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
> index 06275f8807a8..fa626648d746 100644
> --- a/sound/pci/hda/patch_analog.c
> +++ b/sound/pci/hda/patch_analog.c
> @@ -191,7 +191,6 @@ static int ad198x_parse_auto_config(struct hda_codec *codec, bool indep_hp)
>   	int err;
>   
>   	codec->spdif_status_reset = 1;
> -	codec->no_trigger_sense = 1;
>   	codec->no_sticky_stream = 1;
>   
>   	spec->gen.indep_hp = indep_hp;
> @@ -377,6 +376,8 @@ static int patch_ad1986a(struct hda_codec *codec)
>   	/* AD1986A has the inverted EAPD implementation */
>   	codec->inv_eapd = 1;
>   
> +	codec->no_trigger_sense = 1;
> +
>   	spec->gen.mixer_nid = 0x07;
>   	spec->gen.beep_nid = 0x19;
>   	set_beep_amp(spec, 0x18, 0, HDA_OUTPUT);
> @@ -500,6 +501,8 @@ static int patch_ad1983(struct hda_codec *codec)
>   		return err;
>   	spec = codec->spec;
>   
> +	codec->no_trigger_sense = 1;
> +
>   	spec->gen.mixer_nid = 0x0e;
>   	spec->gen.beep_nid = 0x10;
>   	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
> @@ -588,6 +591,8 @@ static int patch_ad1981(struct hda_codec *codec)
>   		return -ENOMEM;
>   	spec = codec->spec;
>   
> +	codec->no_trigger_sense = 1;
> +
>   	spec->gen.mixer_nid = 0x0e;
>   	spec->gen.beep_nid = 0x10;
>   	set_beep_amp(spec, 0x0d, 0, HDA_OUTPUT);
> @@ -913,6 +918,8 @@ static int patch_ad1988(struct hda_codec *codec)
>   		return err;
>   	spec = codec->spec;
>   
> +	codec->no_trigger_sense = 1;
> +
>   	spec->gen.mixer_nid = 0x20;
>   	spec->gen.mixer_merge_nid = 0x21;
>   	spec->gen.beep_nid = 0x10;
> @@ -1140,6 +1147,8 @@ static int patch_ad1882(struct hda_codec *codec)
>   		return err;
>   	spec = codec->spec;
>   
> +	codec->no_trigger_sense = 1;
> +
>   	spec->gen.mixer_nid = 0x20;
>   	spec->gen.mixer_merge_nid = 0x21;
>   	spec->gen.beep_nid = 0x10;
> .
>

I've applied the patch and rebuild the kernel. But it didn't solve the 
problem. I have applied the patch to kernel 3.13.11.2. Does it matter? 
Should I try to download latest kernel and try to apply patch to it?

Here is the output of the monitor with PA enabled:

card 0, #22 (0,0,0,Mic Jack,0) VALUE
card 0, #23 (0,0,0,Headphone Jack,0) VALUE
card 0, #4 (2,0,0,Speaker Playback Switch,0) VALUE
card 0, #3 (2,0,0,Speaker Playback Volume,0) VALUE
card 0, #22 (0,0,0,Mic Jack,0) VALUE
card 0, #22 (0,0,0,Mic Jack,0) VALUE
card 0, #22 (0,0,0,Mic Jack,0) VALUE
card 0, #23 (0,0,0,Headphone Jack,0) VALUE
card 0, #4 (2,0,0,Speaker Playback Switch,0) VALUE
card 0, #3 (2,0,0,Speaker Playback Volume,0) VALUE
card 0, #22 (0,0,0,Mic Jack,0) VALUE
card 0, #23 (0,0,0,Headphone Jack,0) VALUE
card 0, #4 (2,0,0,Speaker Playback Switch,0) VALUE
card 0, #3 (2,0,0,Speaker Playback Volume,0) VALUE
card 0, #13 (2,0,0,Capture Volume,0) VALUE
card 0, #23 (0,0,0,Headphone Jack,0) VALUE
card 0, #22 (0,0,0,Mic Jack,0) VALUE
card 0, #4 (2,0,0,Speaker Playback Switch,0) VALUE
card 0, #3 (2,0,0,Speaker Playback Volume,0) VALUE
card 0, #13 (2,0,0,Capture Volume,0) VALUE

Thank you,
Alex
