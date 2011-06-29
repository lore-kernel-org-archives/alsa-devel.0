From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Wed, 29 Jun 2011 19:36:54 +0200
Message-ID: <4E0B62B6.6000007@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org>
	<s5h39j0zpnc.wl%tiwai@suse.de>	<4E036C8F.3080709@gmail.com>
	<s5hvcvvzkzq.wl%tiwai@suse.de>	<s5hk4cbzj6s.wl%tiwai@suse.de>
	<4E047441.4010003@gmail.com>	<s5hpqm2v0zq.wl%tiwai@suse.de>
	<4E05C1B1.50302@gmail.com>	<4E05C704.4080806@gmail.com>
	<4E05CE02.1070801@gmail.com>	<s5hei2fvmgw.wl%tiwai@suse.de>
	<4E082166.5060902@gmail.com>	<s5hpqlz3a3b.wl%tiwai@suse.de>
	<s5hhb7b315l.wl%tiwai@suse.de>	<4E08E33D.3060608@gmail.com>
	<s5htybaton8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090904040801010107020609"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 400281038FD
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 19:37:02 +0200 (CEST)
Received: by wwj26 with SMTP id 26so1130668wwj.20
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2011 10:37:01 -0700 (PDT)
In-Reply-To: <s5htybaton8.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------090904040801010107020609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

W dniu 28.06.2011 09:12, Takashi Iwai pisze:
> At Mon, 27 Jun 2011 22:08:29 +0200,
> Julian Sikorski wrote:
>>
>> W dniu 27.06.2011 14:32, Takashi Iwai pisze:
>>> At Mon, 27 Jun 2011 11:19:36 +0200,
>>> Takashi Iwai wrote:
>>>>
>>>> At Mon, 27 Jun 2011 08:21:26 +0200,
>>>> Julian Sikorski wrote:
>>>>>
>>>>> W dniu 27.06.2011 08:04, Takashi Iwai pisze:
>>>>>> At Sat, 25 Jun 2011 14:01:06 +0200,
>>>>>> Julian Sikorski wrote:
>>>>>>>
>>>>>>> W dniu 25.06.2011 13:31, Julian Sikorski pisze:
>>>>>>>> W dniu 25.06.2011 13:08, Julian Sikorski pisze:
>>>>>>>>> W dniu 25.06.2011 09:11, Takashi Iwai pisze:
>>>>>>>>>> At Fri, 24 Jun 2011 13:25:53 +0200,
>>>>>>>>>> Julian Sikorski wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 24/06/2011 11:12, Takashi Iwai wrote:
>>>>>>>>>>>> At Fri, 24 Jun 2011 10:34:01 +0200,
>>>>>>>>>>>> Takashi Iwai wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> At Thu, 23 Jun 2011 18:40:47 +0200,
>>>>>>>>>>>>> Julian Sikorski wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 23/06/2011 14:41, Takashi Iwai wrote:
>>>>>>>>>>>>>>> At Thu, 23 Jun 2011 08:36:55 +0200,
>>>>>>>>>>>>>>> Julian Sikorski wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I am coming here from pulseaudio-general mailing list [1]. I recently
>>>>>>>>>>>>>>>> got myself a Clevo P150HM laptop. It has 2.1 speakers, a built-in
>>>>>>>>>>>>>>>> microphone and the following connectors:
>>>>>>>>>>>>>>>> - headphone out
>>>>>>>>>>>>>>>> - microphone in; can be switched to center/lfe out
>>>>>>>>>>>>>>>> - spdif out; can be switched to rear speaker out
>>>>>>>>>>>>>>>> - line in; can be switched to side speaker out
>>>>>>>>>>>>>>>> Alsa does not seem to reflect that the device is capable of 5.1 and 7.1
>>>>>>>>>>>>>>>> sound, and there are two configs showing up in pavucontrol (analog
>>>>>>>>>>>>>>>> output and analog headphones) which seem to be the same. I have uploaded
>>>>>>>>>>>>>>>> the output of alsa-info.sh [2]. Please let me know if more information
>>>>>>>>>>>>>>>> is needed.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The current parser doesn't allow the multi-io pins when the primary
>>>>>>>>>>>>>>> output is no line-out.  The patch below should fix (change) the
>>>>>>>>>>>>>>> behavior.  It'll count HP out, too.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Takashi
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>>>>>>>>>>>>>>> index fe56b2b..b0cf726 100644
>>>>>>>>>>>>>>> --- a/sound/pci/hda/patch_realtek.c
>>>>>>>>>>>>>>> +++ b/sound/pci/hda/patch_realtek.c
>>>>>>>>>>>>>>> @@ -18992,6 +18992,7 @@ static int alc662_auto_fill_dac_nids(struct hda_codec *codec,
>>>>>>>>>>>>>>>    	hda_nid_t dac;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>    	spec->multiout.dac_nids = spec->private_dac_nids;
>>>>>>>>>>>>>>> +	spec->multiout.num_dacs = 0;
>>>>>>>>>>>>>>>    	for (i = 0; i<   cfg->line_outs; i++) {
>>>>>>>>>>>>>>>    		dac = alc_auto_look_for_dac(codec, cfg->line_out_pins[i]);
>>>>>>>>>>>>>>>    		if (!dac)
>>>>>>>>>>>>>>> @@ -19326,8 +19327,20 @@ static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
>>>>>>>>>>>>>>>    	unsigned int location, defcfg;
>>>>>>>>>>>>>>>    	int num_pins;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> +	if (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT&&   cfg->hp_outs == 1) {
>>>>>>>>>>>>>>> +		/* use HP as primary out */
>>>>>>>>>>>>>>> +		cfg->speaker_outs = cfg->line_outs;
>>>>>>>>>>>>>>> +		memcpy(cfg->speaker_pins, cfg->line_out_pins,
>>>>>>>>>>>>>>> +		       sizeof(cfg->speaker_pins));
>>>>>>>>>>>>>>> +		cfg->line_outs = cfg->hp_outs;
>>>>>>>>>>>>>>> +		memcpy(cfg->line_out_pins, cfg->hp_pins, sizeof(cfg->hp_pins));
>>>>>>>>>>>>>>> +		cfg->hp_outs = 0;
>>>>>>>>>>>>>>> +		memset(cfg->hp_pins, 0, sizeof(cfg->hp_pins));
>>>>>>>>>>>>>>> +		cfg->line_out_type = AUTO_PIN_HP_OUT;
>>>>>>>>>>>>>>> +		alc662_auto_fill_dac_nids(codec, cfg);
>>>>>>>>>>>>>>> +	}
>>>>>>>>>>>>>>>    	if (cfg->line_outs != 1 ||
>>>>>>>>>>>>>>> -	    cfg->line_out_type != AUTO_PIN_LINE_OUT)
>>>>>>>>>>>>>>> +	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
>>>>>>>>>>>>>>>    		return 0;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>    	defcfg = snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0]);
>>>>>>>>>>>>>>> @@ -19348,6 +19361,8 @@ static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
>>>>>>>>>>>>>>>    		spec->multi_ios = num_pins;
>>>>>>>>>>>>>>>    		spec->ext_channel_count = 2;
>>>>>>>>>>>>>>>    		spec->multiout.num_dacs = num_pins + 1;
>>>>>>>>>>>>>>> +		/* for avoiding multi HP mixers */
>>>>>>>>>>>>>>> +		cfg->line_out_type = AUTO_PIN_LINE_OUT;
>>>>>>>>>>>>>>>    	}
>>>>>>>>>>>>>>>    	return 0;
>>>>>>>>>>>>>>>    }
>>>>>>>>>>>>>> Would you like me to test this patch? If so, what should I apply it to
>>>>>>>>>>>>>> and how should I proceed?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes, the test would be appreciated, of course.
>>>>>>>>>>>>> Apply it to the latest 3.0-rc kernel and test.
>>>>>>>>>>>>
>>>>>>>>>>>> Also, the additional patch below will give "Headphone" mixer control
>>>>>>>>>>>> back while new "Surround", "Center" and "LFE" will appear.
>>>>>>>>>>>>
>>>>>>>>>>>> Note that you'll need to change "Channel Mode" mixer control to "6ch"
>>>>>>>>>>>> for using the surround outputs even with these patches.  As default,
>>>>>>>>>>>> it's set as "2ch".
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Takashi
>>>>>>>>>>>>
>>>>>>>>>>> I will definitely try to give this a shot, but the outcome might be 
>>>>>>>>>>> dependent on the fact whether Fedora 15 will want to work with 3.0-rc 
>>>>>>>>>>> kernel.
>>>>>>>>>>
>>>>>>>>>> You can build the kernel by yourself at any time...
>>>>>>>>>>
>>>>>>>>>>> How about 8-channel sound btw? Under Windows the device claims to be 
>>>>>>>>>>> capable of it.
>>>>>>>>>>
>>>>>>>>>> Do you have 4 jacks?  Otherwise it's nonsense.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Takashi
>>>>>>>>> OK, I was able to successfully apply the patch and build the kernel. I
>>>>>>>>> tested it using:
>>>>>>>>> $ pasuspender bash
>>>>>>>>> $ speaker-test -Dplug:surround51 -c6
>>>>>>>>> Once I set sound to 6-channel using alsamixer -c0, I was able to hear
>>>>>>>>> the sound for all 6 channels. Setting it to 4 channels took away LFE and
>>>>>>>>> center. Pulseaudio outputs are still a little messy, but this is out of
>>>>>>>>> ALSA scope, I think.
>>>>>>>>>
>>>>>>>>> Julian
>>>>>>>> It seems I spoke a bit too soon. The superfluous controls are still a
>>>>>>>> problem. Speaker and Headphone controls seem to be overlapping (new
>>>>>>>> output on amixer -c0 attached). They both control the headphones when
>>>>>>>> they are plugged in and internal speakers when not.
>>>>>>>>
>>>>>>>> Julian
>>>>>>>>
>>>>>>> Sorry for this email bombardment, but I just booted back to stock F15
>>>>>>> kernel (2.6.38.8-32.fc15.x86_64) and noticed that speaker and headphone
>>>>>>> controls actually do what they advertise. Still, it is impossible to
>>>>>>> make the sound go through the speakers when headphones are plugged in (I
>>>>>>> tried pavucontrol for this).
>>>>>>
>>>>>> The auto-mute feature can be controlled "Auto-Mute Mode" mixer enum.
>>>>>> Set to "Disabled" will turn off the auto-mute in the driver side.
>>>>>> However...
>>>>>
>>>>> You are right - when auto-mute is disabled sound goes via both speakers
>>>>> and headphones when they are plugged. I did not know the function of
>>>>> auto-mute.
>>>>> However, the "Speaker" and "Headphone" controls still do influence both
>>>>> outputs, and "Speaker" can only be muted - there is no volume control
>>>>> available. So, in my opinion, they should either be merged altogether,
>>>>> or switched back to the way they work in 2.6.38.8-32.fc15.x86_64, that
>>>>> is setting the volume of speakers and headphones independently.
>>>>
>>>> Give alsa-info.sh outputs on your machine with the latest status for
>>>> further analysis.
>>>
>>> I think this issue was fixed now in topic/hda branch in sound git tree:
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>>>
>>> Give it a try.  You can pull the branch into the latest Linus git tree
>>> for merging into the latest 3.0-rc.
>>>
>>>
>>> Takashi
>> It seems like the problem is still there. The output of alsa-info.sh is
>> available here:
>> http://www.alsa-project.org/db/?f=38e2e44ab86691006a837715601aad4311fda0d3
> 
> Double-check whether you compiled really the right stuff.
> The emulator works fine, so something wrong likely in your side.
> 
> 
> Takashi
I compiled the latest origin/master of sound-2.6 tree and the problem is
still there. Output of alsa-info.sh is attached.

Julian

--------------090904040801010107020609
Content-Type: text/plain;
 name="alsa-info.txt.uc06hJG5mu"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa-info.txt.uc06hJG5mu"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Wed Jun 29 17:30:29 UTC 2011


!!Linux Distribution
!!------------------

Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock)


!!DMI Information
!!---------------

Manufacturer:      CLEVO                            
Product Name:      P150HMx
Product Version:   Not Applicable                    


!!Kernel Information
!!------------------

Kernel release:    3.0-0.rc2.git0.1.belegdol2.fc15.x86_64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.24
Library version:    1.0.24
Utilities version:  1.0.24.1


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf6500000 irq 56
 1 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xf6080000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation Cougar Point High Definition Audio Controller (rev 05)
01:00.1 Audio device: nVidia Corporation Device 0beb (rev a1)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:1c20 (rev 05)
	Subsystem: 1558:5102
--
01:00.1 0403: 10de:0beb (rev a1)
	Subsystem: 1558:5102


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N

!!Module: snd_hda_intel
	bdl_pos_adj : 1,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC892
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0892
Subsystem Id: 0x15585102
Revision Id: 0x100302
No Modem Function Group found
Default PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC892 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=5, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=5, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=5, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x06 [Audio Output] wcaps 0x611: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="ALC892 Digital", type="SPDIF", device=1
  Converter: stream=5, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Switch", index=1, device=0
  Control: name="Capture Volume", index=1, device=0
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x90 0x90]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Switch", index=0, device=0
  Control: name="Capture Volume", index=0, device=0
  Device: name="ALC892 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x2e 0x2e]
  Converter: stream=1, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100711: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Internal Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Internal Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=In, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x11 [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x10
Node 0x12 [Pin Complex] wcaps 0x400401: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
  EAPD 0x2: EAPD
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0e
Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x03 0x03]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a11c30: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Internal Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x99a30931: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0181143f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x3, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x2: EAPD
  Pin Default 0x0121101f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400481: Stereo
  Pincap 0x00000024: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1d [Pin Complex] wcaps 0x400400: Mono
  Pincap 0x00000020: IN
  Pin Default 0x598301f0: [N/A] Line In at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1e [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=24
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Input Source", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 12
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Input Source", index=1, device=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x26 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x25 0x0b
Codec: Nvidia GPU 12 HDMI/DP
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0012
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=6, channel=0
  Digital: Enabled GenLevel
  Digital category: 0x2
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=05, enabled=1
  Connection: 1
     0x04
Codec: Nvidia GPU 12 HDMI/DP
Address: 1
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0012
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=05, enabled=1
  Connection: 1
     0x04
Codec: Nvidia GPU 12 HDMI/DP
Address: 2
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0012
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=05, enabled=1
  Connection: 1
     0x04
Codec: Nvidia GPU 12 HDMI/DP
Address: 3
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0012
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="IEC958 Playback Con Mask", index=3, device=0
  Control: name="IEC958 Playback Pro Mask", index=3, device=0
  Control: name="IEC958 Playback Default", index=3, device=0
  Control: name="IEC958 Playback Switch", index=3, device=0
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=05, enabled=1
  Connection: 1
     0x04
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  6 Jun 29 19:27 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 15 Jun 29 19:27 /dev/snd/controlC1
crw-rw----+ 1 root audio 116,  5 Jun 29 19:27 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 14 Jun 29 19:27 /dev/snd/hwC1D0
crw-rw----+ 1 root audio 116, 13 Jun 29 19:27 /dev/snd/hwC1D1
crw-rw----+ 1 root audio 116, 12 Jun 29 19:27 /dev/snd/hwC1D2
crw-rw----+ 1 root audio 116, 11 Jun 29 19:27 /dev/snd/hwC1D3
crw-rw----+ 1 root audio 116,  4 Jun 29 19:28 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Jun 29 19:29 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  2 Jun 29 19:28 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116, 10 Jun 29 19:28 /dev/snd/pcmC1D3p
crw-rw----+ 1 root audio 116,  9 Jun 29 19:27 /dev/snd/pcmC1D7p
crw-rw----+ 1 root audio 116,  8 Jun 29 19:27 /dev/snd/pcmC1D8p
crw-rw----+ 1 root audio 116,  7 Jun 29 19:27 /dev/snd/pcmC1D9p
crw-rw----+ 1 root audio 116,  1 Jun 29 19:27 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Jun 29 19:27 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x. 2 root root  80 Jun 29 19:27 .
drwxr-xr-x. 3 root root 380 Jun 29 19:27 ..
lrwxrwxrwx. 1 root root  12 Jun 29 19:27 pci-0000:00:1b.0 -> ../controlC0
lrwxrwxrwx. 1 root root  12 Jun 29 19:27 pci-0000:01:00.1 -> ../controlC1


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
			"/etc/alsa/pulse-default.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: ALC892 Digital [ALC892 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xf6500000 irq 56'
  Mixer name	: 'Realtek ALC892'
  Components	: 'HDA:10ec0892,15585102,00100302'
  Controls      : 33
  Simple ctrls  : 20
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 3 [100%] [30.00dB]
  Front Right: 3 [100%] [30.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 46 [100%] [30.00dB] [on]
  Front Right: Capture 46 [100%] [30.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 16 [35%] [0.00dB] [off]
  Front Right: Capture 16 [35%] [0.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '2ch' '4ch' '6ch'
  Item0: '2ch'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Line'
  Item0: 'Internal Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Internal Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Internal Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]

!!-------Mixer controls for card 1 [NVidia]

Card hw:1 'NVidia'/'HDA NVidia at 0xf6080000 irq 17'
  Mixer name	: 'Nvidia GPU 12 HDMI/DP'
  Components	: 'HDA:10de0012,10de0101,00100100'
  Controls      : 16
  Simple ctrls  : 4
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',3
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!-------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Channel Mode'
		value '2ch'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 '2ch'
			item.1 '4ch'
			item.2 '6ch'
		}
	}
	control.2 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.3 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.4 {
		iface MIXER
		name 'Surround Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.5 {
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.6 {
		iface MIXER
		name 'Center Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.7 {
		iface MIXER
		name 'LFE Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.8 {
		iface MIXER
		name 'Center Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'LFE Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.11 {
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.12 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.13 {
		iface MIXER
		name 'Internal Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.14 {
		iface MIXER
		name 'Internal Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.15 {
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.16 {
		iface MIXER
		name 'Line Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.17 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 3
		value.1 3
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
	control.18 {
		iface MIXER
		name 'Internal Mic Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.19 {
		iface MIXER
		name 'Auto-Mute Mode'
		value Enabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.20 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.21 {
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.22 {
		iface MIXER
		name 'Capture Volume'
		value.0 46
		value.1 46
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 46'
			dbmin -1600
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
	control.23 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 16
		value.1 16
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 46'
			dbmin -1600
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.24 {
		iface MIXER
		name 'Input Source'
		value 'Internal Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Internal Mic'
			item.2 Line
		}
	}
	control.25 {
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Internal Mic'
			item.2 Line
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.27 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.28 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.31 {
		iface MIXER
		name 'Master Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.32 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.33 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
}
state.NVidia {
	control.1 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.5 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.6 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.7 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.8 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 1
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 2
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 2
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.11 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 2
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.12 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 2
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.13 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 3
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.14 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 3
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.15 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 3
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.16 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 3
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ebtable_nat
ebtables
ipt_MASQUERADE
iptable_nat
nf_nat
xt_CHECKSUM
iptable_mangle
bridge
stp
llc
sunrpc
cpufreq_ondemand
acpi_cpufreq
freq_table
mperf
bnep
bluetooth
nf_conntrack_ipv4
nf_defrag_ipv4
ip6t_REJECT
nf_conntrack_ipv6
nf_defrag_ipv6
xt_state
nf_conntrack
ip6table_filter
ip6_tables
fuse
arc4
uvcvideo
snd_hda_codec_hdmi
videodev
media
microcode
v4l2_compat_ioctl32
snd_hda_codec_realtek
joydev
snd_hda_intel
snd_hda_codec
serio_raw
pcspkr
snd_hwdep
snd_seq
i2c_i801
snd_seq_device
i2c_core
iTCO_wdt
iTCO_vendor_support
snd_pcm
iwlagn
mac80211
snd_timer
snd
xhci_hcd
jmb38x_ms
memstick
jme
cfg80211
rfkill
mii
soundcore
snd_page_alloc
virtio_net
kvm_intel
kvm
firewire_ohci
firewire_core
crc_itu_t
sdhci_pci
sdhci
mmc_core
wmi
video


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x11 0x411111f0
0x12 0x411111f0
0x14 0x99130110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x411111f0
0x18 0x01a11c30
0x19 0x99a30931
0x1a 0x0181143f
0x1b 0x0121101f
0x1c 0x411111f0
0x1d 0x598301f0
0x1e 0x01451120
0x1f 0x411111f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC1D0/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D1/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC1D1/driver_pin_configs:

/sys/class/sound/hwC1D1/user_pin_configs:

/sys/class/sound/hwC1D1/init_verbs:

/sys/class/sound/hwC1D2/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC1D2/driver_pin_configs:

/sys/class/sound/hwC1D2/user_pin_configs:

/sys/class/sound/hwC1D2/init_verbs:

/sys/class/sound/hwC1D3/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC1D3/driver_pin_configs:

/sys/class/sound/hwC1D3/user_pin_configs:

/sys/class/sound/hwC1D3/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   19.861593] mtp-probe[622]: bus: 1, device: 3 was not an MTP device
[   19.896029] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   19.896237] snd_hda_intel 0000:00:1b.0: irq 56 for MSI/MSI-X
[   19.896377] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   19.919918] mtp-probe[647]: checking bus 2, device 3: "/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5"
[   19.960520] hda_codec: ALC892: SKU not ready 0x598301f0
[   19.960683] hda_codec: ALC892: BIOS auto-probing.
[   19.960690] ALSA sound/pci/hda/hda_codec.c:4831 autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   19.960693] ALSA sound/pci/hda/hda_codec.c:4835    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   19.960696] ALSA sound/pci/hda/hda_codec.c:4839    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   19.960698] ALSA sound/pci/hda/hda_codec.c:4840    mono: mono_out=0x0
[   19.960701] ALSA sound/pci/hda/hda_codec.c:4843    dig-out=0x1e/0x0
[   19.960703] ALSA sound/pci/hda/hda_codec.c:4844    inputs:
[   19.960706] ALSA sound/pci/hda/hda_codec.c:4848  Mic=0x18
[   19.960708] ALSA sound/pci/hda/hda_codec.c:4848  Internal Mic=0x19
[   19.960710] ALSA sound/pci/hda/hda_codec.c:4848  Line=0x1a
[   19.960712] ALSA sound/pci/hda/hda_codec.c:4850 
[   19.962063] ALSA sound/pci/hda/patch_realtek.c:1789 realtek: No valid SSID, checking pincfg 0x598301f0 for NID 0x1d
[   19.962066] ALSA sound/pci/hda/patch_realtek.c:1870 realtek: Enable default setup for auto mode as fallback
[   19.987178] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   20.035939] snd_hda_intel 0000:01:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[   20.035956] hda_intel: Disabling MSI
[   20.036245] snd_hda_intel 0000:01:00.1: setting latency timer to 64
[   20.043100] ALSA sound/pci/hda/hda_intel.c:1454 Enable delay in RIRB handling
[   20.103021] mtp-probe[647]: bus: 2, device: 3 was not an MTP device
--
[   20.277359] USB Video Class driver (v1.1.0)
[   20.295798] HDMI status: Codec=0 Pin=5 Presence_Detect=0 ELD_Valid=0
[   20.334784] HDMI status: Codec=1 Pin=5 Presence_Detect=0 ELD_Valid=0
[   20.351207] iwlagn 0000:04:00.0: loaded firmware version 17.168.5.1 build 33993
[   20.357260] Registered led device: phy0-led
[   20.374714] HDMI status: Codec=2 Pin=5 Presence_Detect=0 ELD_Valid=0
[   20.407236] microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x14
[   20.413674] HDMI status: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=0
[   20.434741] input: HDA NVidia HDMI/DP as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input13
[   20.435403] input: HDA NVidia HDMI/DP as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input14
[   20.436074] input: HDA NVidia HDMI/DP as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
[   20.436794] input: HDA NVidia HDMI/DP as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input16
[   20.438282] microcode: CPU2 sig=0x206a7, pf=0x10, revision=0x14
--
[   47.764496] DMAR:[fault reason 05] PTE Write access is not set
[   61.529629] hda-intel: Invalid position buffer, using LPIB read method instead.
[   61.715151] hda-intel: IRQ timing workaround is activated for card #1. Suggest a bigger bdl_pos_adj.
[   61.878197] hda-intel: Invalid position buffer, using LPIB read method instead.
[   72.242637] DRHD: handling fault status reg 2



--------------090904040801010107020609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090904040801010107020609--
