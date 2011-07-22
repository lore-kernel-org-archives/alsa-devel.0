From: David Henderson <dhenderson@digital-pipe.com>
Subject: Re: additional problem
Date: Fri, 22 Jul 2011 14:23:07 -0400
Message-ID: <4E29C00B.5020900@digital-pipe.com>
References: <4E0B2F67.3070304@digital-pipe.com>	<4E0C68ED.1070506@digital-pipe.com>	<s5hiprmijtw.wl%tiwai@suse.de>	<4E1B07FD.9030702@digital-pipe.com>	<s5h1uxwkhcx.wl%tiwai@suse.de>	<4E1B1127.4080800@digital-pipe.com>	<s5htyasj1gi.wl%tiwai@suse.de>	<4E1B12FF.4080307@digital-pipe.com>	<s5hr55wj17k.wl%tiwai@suse.de>	<4E1B15EE.8080304@digital-pipe.com>	<s5hoc10izl3.wl%tiwai@suse.de>	<4E1C469B.4050400@digital-pipe.com>	<s5hd3hfiqvc.wl%tiwai@suse.de>	<4E1C4C8A.50703@digital-pipe.com>	<4E1D9A4F.503@digital-pipe.com>	<s5h39ianuh1.wl%tiwai@suse.de>	<4E1DAADB.202@digital-pipe.com>
	<s5hvcv6meua.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080601040409070804060100"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C35EB1037E3
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jul 2011 20:25:42 +0200 (CEST)
Received: by yib2 with SMTP id 2so1450847yib.38
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2011 11:25:41 -0700 (PDT)
In-Reply-To: <s5hvcv6meua.wl%tiwai@suse.de>
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
--------------080601040409070804060100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/13/2011 10:31 AM, Takashi Iwai wrote:
> At Wed, 13 Jul 2011 10:25:31 -0400,
> David Henderson wrote:
>> On 07/13/2011 10:08 AM, Takashi Iwai wrote:
>>> At Wed, 13 Jul 2011 09:14:55 -0400,
>>> David Henderson wrote:
>>>>> Thanks again for the help Takashi.  Ok, I've created the
>>>>> /etc/asound.conf file with the appropriate group and now I'm trying to
>>>>> run the aplay binary and I'm not getting any error messages, but I'm
>>>>> also not hearing any sounds from the speakers.
>>>>>
>>>>> # aplay freq10-30000-10s.wav
>>>>> Playing WAVE 'freq10-30000-10s.wav' : Signed 16 bit Little Endian,
>>>>> Rate 44100 Hz, Mono
>>>>>
>>>>> # speaker-test -w ./freq10-30000-10s.wav
>>>>>
>>>>> speaker-test 1.0.23
>>>>>
>>>>> Playback device is default
>>>>> Stream parameters are 48000Hz, S16_LE, 1 channels
>>>>> Using 16 octaves of pink noise
>>>>> Rate set to 48000Hz (requested 48000Hz)
>>>>> Buffer size range from 2048 to 8192
>>>>> Period size range from 1024 to 1024
>>>>> Using max buffer size 8192
>>>>> Periods = 4
>>>>> was set period_size = 1024
>>>>> was set buffer_size = 8192
>>>>>    0 - Front Left
>>>>> Time per period = 2.835792
>>>>>    0 - Front Left
>>>>> Time per period = 2.986653
>>>>>    0 - Front Left
>>>>> Time per period = 2.986654
>>>>>    0 - Front Left
>>>>> ...snip...
>>>>>
>>>>> I've made sure nothing is muted with the audio hardware by using
>>>>> alsamixer and changed the permissions on the files within the /etc/snd
>>>>> directory.  Any other thoughts?
>>>>>
>>>>> Dave
>>>> bump for help
>>> You didn't give any useful information about the hardware itself, so
>>> no one can answer.  Did it ever sound correctly with any other distro
>>> at all?
>>>
>>> Please don't mix up the custom-build problem and the driver problem.
>>> The problem with silent output is more likely a driver issue (or a
>>> configuration issue).
>>>
>>>
>>> Takashi
>> The hardware is an integrated HDA Intel audio sound card.  The
>> /proc/asound/pcm file has this listed:
>>
>> 00-00: STAC92xx Analog : STAC92xx Analog : playback 1 : capture 2
>> 00-01: STAC92xx Digital : STAC92xx Digital : playback 1
>> 00-03: INTEL HDMI 0 : INTEL HDMI 0 : playback 1
> That's not enough.  Which kernel / ALSA version, which model option?
> Could you alsa-info.sh output (run with --no-upload option)?
> This will give most of needed information.
>
>> Yes, this audio works just fine within Kubuntu.
> Do both run the same kernel version?
>
> At next, try to run "alsactl -f somefile store" on both systems, and
> compare the files.  You may see some difference in mixer setup.
>
>
> Takashi

I've searched the local fs for the alsa-info.sh script as well as 
looking through the package contents on debian.org without any results.  
Where would I get this script from?  The kernel running on the custom 
distro is 2.6.33.3 with an alsa version of 1.0.23.  Also, I didn't 
compile or install the alsa-driver package, but it appears that the 
drivers are getting loaded for the hardware under the custom distro.

Per the instructions above, I have performed the alsactl command on the 
working system (Kubuntu) and the custom distro.  There are differences 
in the files which I've attached to this message.  Something else I 
noticed while in the alsamixer for both systems is that there are 
additional settings on the Kubuntu system as shown below.

Custom Distro:
Master, Headphone, Front, Front Mic Jack, Surround, Center, LFE, Side, 
Mic jack Mode, S/PDIF, S/PDIF Default, S/PDIF Playback, S/PDIF Playback, 
S/PDIF 1, Swap Center

Kubuntu:
Master, Headphone, PCM, Front, Front Mic Jack, Surround, Center, LFE, 
Side, Mic jack Mode, S/PDIF, S/PDIF Default, S/PDIF Playback, S/PDIF 
Playback, S/PDIF 1, Beep, Swap Center


Any ideas or other information required to help resolve this problem?

Thanks,
Dave



--------------080601040409070804060100
Content-Type: text/plain;
 name="custom_sound.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="custom_sound.txt"

state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 64
		value.1 64
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 64
		value.1 64
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 64
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value true
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 64
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value true
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Swap Center/LFE Playback Switch'
		value true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Side Playback Volume'
		value.0 64
		value.1 64
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Side Playback Switch'
		value.0 true
		value.1 true
	}
	control.12 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Mic In'
		comment.item.1 'Line In'
		iface MIXER
		name 'Mic Jack Mode'
		value 'Mic In'
	}
	control.13 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Mic In'
		comment.item.1 'Line In'
		iface MIXER
		name 'Front Mic Jack Mode'
		value 'Mic In'
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 64
		value.1 64
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mic Capture Volume'
		value.0 0
		value.1 0
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Front Mic Capture Volume'
		value.0 0
		value.1 0
	}
	control.22 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.23 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.24 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Digital Playback'
		comment.item.1 'Analog Mux 1'
		comment.item.2 'Analog Mux 2'
		comment.item.3 Off
		iface MIXER
		name 'IEC958 Playback Source'
		value 'Digital Playback'
	}
	control.25 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Digital Playback'
		comment.item.1 'Analog Mux 1'
		comment.item.2 'Analog Mux 2'
		comment.item.3 Off
		iface MIXER
		name 'IEC958 Playback Source'
		index 1
		value 'Digital Playback'
	}
	control.26 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.27 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.28 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 64
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.33 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.34 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.35 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		index 1
		value true
	}
}

--------------080601040409070804060100
Content-Type: text/plain;
 name="kubuntu_sound.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kubuntu_sound.txt"

state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 52
		value.1 52
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 64
		value.1 64
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 false
		value.1 false
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 64
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value false
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 64
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value false
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Swap Center/LFE Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Side Playback Volume'
		value.0 64
		value.1 64
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Side Playback Switch'
		value.0 false
		value.1 false
	}
	control.12 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Mic In'
		comment.item.1 'Line In'
		iface MIXER
		name 'Mic Jack Mode'
		value 'Mic In'
	}
	control.13 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Mic In'
		comment.item.1 'Line In'
		iface MIXER
		name 'Front Mic Jack Mode'
		value 'Mic In'
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Beep Playback Switch'
		value true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		comment.dbmin -1800
		comment.dbmax 0
		iface MIXER
		name 'Beep Playback Volume'
		value 1
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 64
		value.1 64
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
	}
	control.22 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mic Capture Volume'
		value.0 0
		value.1 0
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Front Mic Capture Volume'
		value.0 0
		value.1 0
	}
	control.24 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.25 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.26 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Digital Playback'
		comment.item.1 'Analog Mux 1'
		comment.item.2 'Analog Mux 2'
		comment.item.3 Off
		iface MIXER
		name 'IEC958 Playback Source'
		value 'Digital Playback'
	}
	control.27 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Digital Playback'
		comment.item.1 'Analog Mux 1'
		comment.item.2 'Analog Mux 2'
		comment.item.3 Off
		iface MIXER
		name 'IEC958 Playback Source'
		index 1
		value 'Digital Playback'
	}
	control.28 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.29 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.30 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.33 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 52
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.35 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.36 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.37 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.38 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		index 1
		value true
	}
	control.39 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
	}
}

--------------080601040409070804060100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080601040409070804060100--
