From: Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Mon, 27 Jul 2015 08:48:52 +0200
Message-ID: <CALUcmUn31z0g5R9s8rDbJCzHtvL9nqFeFWaHSG=DBBXTo3YkRg@mail.gmail.com>
References: <CALUcmU=aB1oXFA7E3A2uPiu_3+--9OqkQPvo3hq0JCtNcPY5UA@mail.gmail.com>
 <CAN8cciZZ+akLsv=oz3SN0YD-mHhUJ+WZujQmTsEbw_PMgiVYYw@mail.gmail.com>
 <CALUcmUkeDRgu0+kzCVp_RP1ZBkFRQbifU456HNY7vf9H_SHhuQ@mail.gmail.com>
 <CAN8cciYgkzGxdUwi0DbifZRsGDvwPwuVMvaKVJ-k-kWAdzwQMw@mail.gmail.com>
 <CALUcmUmR3XCaQFjEbPtsPYS6QcRdkWFdtry+x3uWP7qLE07ePg@mail.gmail.com>
 <CAN8cciZ6GAWoad8OMzJOFzUwAQkjJAUS86NV3EbJNpvC3WhPow@mail.gmail.com>
 <CALUcmUk6niiT2aU2e4FcPDk_rxOf54F-g10ePCjgTQg38zuP6g@mail.gmail.com>
 <CAN8cciajhQsvasRPJuBGp9Hsj5vaiaczczDPAz5dR03UAad2Sg@mail.gmail.com>
 <CALUcmU=vP4B=agrO6XDhsPiPOTCnqudtNsT0W49YheHn9ypzDg@mail.gmail.com>
 <CAN8cciZG+ZmSzVh4v2giQh4vnJ1a7dbYvY6zcfeuQy0ephWUww@mail.gmail.com>
 <CALUcmUmdhehmMZZykw0SLsKRbswOq=mti6hfgGZrTryDtKc7MA@mail.gmail.com>
 <CAN8cciaGZkrHOsD7KDX7sfXTRdJEVwwGLi-G+XcwHUxeGsAVDw@mail.gmail.com>
 <CALUcmU=fh2O+8COLPv1GXneomk2=XS_ES+LDK8yoqaEWXDrszQ@mail.gmail.com>
 <CAN8ccibYUjoDUe+UhNesjEpD1t2rRg8TUbmtr-3kZuMGDXMoMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 573DB260647
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 08:49:13 +0200 (CEST)
Received: by obre1 with SMTP id e1so52922021obr.1
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2015 23:49:12 -0700 (PDT)
In-Reply-To: <CAN8ccibYUjoDUe+UhNesjEpD1t2rRg8TUbmtr-3kZuMGDXMoMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: =?UTF-8?B?xYF1a2FzeiBX?= <lukasz.wojnilowicz@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, patrakov@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I shall file a bug against Pulseaudio with the subject.

Pulseaudio enables Surround 4.0, while chmap reports no RL and RR.

While waiting for the Pulseaudio result, do you think it is a good idea to
send your Alsa patches upstream, so at least some of the functionality
start working soon?
If so, do you guess this patch will be available in v4.2 or v4.3?

On 27 July 2015 at 04:11, Raymond Yau <superquad.vortex2@gmail.com> wrote:

>
>
> 2015-07-26 19:55 GMT+08:00 Arthur Borsboom <arthurborsboom@gmail.com>:
>
>> Hi Raymond,
>>
>> I have to apologize.
>>
>> When you said Pulseaudio might have a bug, I rechecked my steps and I
>> believe I had only applied half of your patches.
>> I have applied all the patches this time, against the 4.2.0-rc3 kernel
>> and posted the requested info again.
>>
>> alsa-info:
>> http://www.alsa-project.org/db/?f=ab56d544c53402fc7fdb96956299753de2708a6f
>>
>
>
> 	control.23 {
> 		iface CARD
> 		name 'External Subwoofer Jack'
> 		value true
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
>
> As "External Subwoofer Jack" can report the presence of the external Sonice Master Subwoofer
>
> You need David to answer whether pulseaudio can auto mute since there is NO "Headphone Jack" kctl for model=dell-headset-multi
>
>
>
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/hda-emu.git/tree/codecs/canonical?id=HEAD
>
> There is no "Headphone Jack" kctl for those alc3661-dell which use
> dell-headset-multi,
>
> 	control.19 {
> 		iface CARD
> 		name 'Headphone Mic Jack'
> 		value false
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.20 {
> 		iface CARD
> 		name 'Headset Mic Phantom Jack'
> 		value true
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.21 {
> 		iface CARD
> 		name 'Internal Mic Phantom Jack'
> 		value true
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
> 	control.22 {
> 		iface CARD
> 		name 'Speaker Front Phantom Jack'
> 		value true
> 		comment {
> 			access read
> 			type BOOLEAN
> 			count 1
> 		}
> 	}
>
>
>
>> chmap-result (stable, does not change after plugging or unplugging jacks):
>>
>> Type = FIXED, Channels = 2
>>   FL FR
>> Type = FIXED, Channels = 4
>>   FL FR NA LFE
>>
>> [Pavucontrol] -> [Configuration] -> [Built-in Audio] gives
>>
>> Analog Stereo Duplex
>> Analog Stereo Output
>> Analog Surround 2.1 Output + Analog Stereo Input
>> Analog Surround 2.1 Output
>> Analog Surround 4.0 Output + Analog Stereo Input
>> Analog Surround 4.0 Output
>> Analog Stereo Input
>> Off
>>
>> Pulseaudio verbose log: http://pastebin.com/MwC3KQS5
>>
>
> Pulseaudio expect "Headphone Jack" but it is not available in
> dell-headset-multi
>
>
> (   0.088|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
> output:analog-surround-21
> (   0.088|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on
> Analog Surround 2.1 (analog-surround-21)
> (   0.088|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:1 with
> SND_PCM_NO_AUTO_FORMAT ...
> (   0.088|   0.000) D: [pulseaudio] alsa-util.c: Managed to open
> surround21:1
> (   0.088|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is
> 11888 ms
> (   0.106|   0.017) D: [pulseaudio] alsa-util.c: Set buffer size first (to
> 4408 samples), period size second (to 1102 samples).
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
> output:analog-surround-21 supported.
> (   0.106|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL
> surround21:1
> (   0.106|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer
> surround21:1: No such file or directory
> (   0.106|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to
> mixer 'hw:1'
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Removing path
> 'analog-output' as it is a subset of 'analog-output-speaker'.
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths
> (after tidying):
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xc8a0b0,
> direction=1
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Path
> analog-output-speaker (Speakers), direction=1, priority=100, probed=yes,
> supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0,
> max_volume=87, min_dB=-181.5, max_dB=0
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master,
> direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
> required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
> n_channels=1, override_map=yes
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone,
> direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0,
> required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
> override_map=no
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Element Speaker,
> direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
> required=0, required_any=4, required_absent=0, mask=0x3600000000f66,
> n_channels=2, override_map=yes
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Element Bass Speaker,
> direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
> required=0, required_any=4, required_absent=0, mask=0x80, n_channels=2,
> override_map=yes
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM,
> direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0,
> required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
> n_channels=2, override_map=yes
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone,
> alsa_name='Headphone Jack', detection unavailable
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Dock Headphone,
> alsa_name='Dock Headphone Jack', detection unavailable
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Headphone,
> alsa_name='Front Headphone Jack', detection unavailable
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out,
> alsa_name='Line Out Jack', detection unavailable
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front,
> alsa_name='Line Out Front Jack', detection unavailable
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Speaker Phantom,
> alsa_name='Speaker Phantom Jack', detection unavailable
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Speaker Front
> Phantom, alsa_name='Speaker Front Phantom Jack', detection possible
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
> output:analog-surround-21+input:analog-mono - will not be able to open
> input:analog-mono
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
> output:analog-surround-21+input:analog-stereo
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording
> on Analog Stereo (analog-stereo)
> (   0.106|   0.000) D: [pulseaudio] alsa-util.c: Trying front:1 with
> SND_PCM_NO_AUTO_FORMAT ...
> (   0.106|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:1
> (   0.106|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is
> 23777 ms
> (   0.106|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to
> 4408 samples), period size second (to 1102 samples).
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
> output:analog-surround-21+input:analog-stereo supported.
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
> output:analog-surround-21+input:iec958-stereo - will not be able to open
> input:iec958-stereo
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
> output:analog-surround-40
> (   0.106|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on
> Analog Surround 4.0 (analog-surround-40)
> (   0.106|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:1 with
> SND_PCM_NO_AUTO_FORMAT ...
> (   0.106|   0.000) D: [pulseaudio] alsa-util.c: Managed to open
> surround40:1
> (   0.107|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is
> 11888 ms
> (   0.107|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to
> 4408 samples), period size second (to 1102 samples).
> (   0.107|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
> output:analog-surround-40 supported.
>
> it is pulseaudio bug to support surround40 since your laptop does not have
> "RL and RR" chmap
>
>
>>
>>
>


-- 
Arthur Borsboom
Lieven de Keystraat 77
3067 KG, Rotterdam
The Netherlands
Mob: +31629089953
Email: arthurborsboom@gmail.com
Skype: Arthur Borsboom, The Hague, The Netherlands

[image: View Arthur's LinkedIn profile]
<http://uk.linkedin.com/in/arthurborsboom>
