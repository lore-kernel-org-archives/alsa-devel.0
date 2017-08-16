From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: IEC61937 passthrough with BYT/CHT HdmiLpeAudio
Date: Wed, 16 Aug 2017 11:09:49 -0500
Message-ID: <3da22d38-989f-477f-1d2b-4d16cd91240a@linux.intel.com>
References: <346c68cd-d922-e773-3047-0a36b084e7f0@linux.intel.com>
 <s5hwp63bjc8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 38CBB266B1C
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 18:09:50 +0200 (CEST)
In-Reply-To: <s5hwp63bjc8.wl-tiwai@suse.de>
Content-Language: en-US
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



On 08/16/2017 10:52 AM, Takashi Iwai wrote:
> On Wed, 16 Aug 2017 17:15:09 +0200,
> Pierre-Louis Bossart wrote:
>> Hi Takashi,
>>
>> While I was looking at IEC61937, I ran a quick test on my BYT and CHT
>> boxes, and as I suspected IEC61937 works fine since your modifications
>> to add s16_le support. I can get AC3 to my HDMI receiver without
>> problems just by using the hw:0,<1,2,3> device, depending on which
>> port is used.
>>
>> e.g. aplay  -Dhw:0,2 -c2 -r48000 -fs16le ac3_surround_test.spdif
>>
>> To make things more usable for applications, and maybe support
>> receivers who actually care about the AES0 non-audio bit or reduce the
>> initial lock time, it'd be nice to support the traditional command
>> line, e.g.
>>
>> aplay -D'hdmi:CARD=0,DEV=<0,1,2>,AES0=0x6' -c2 -r48000 -fs16_le
>> ac3_surround_test.spdif
>>
>> However we seem to have a mix of alsa-lib configuration issues and
>> maybe a miss at the driver level
> Yeah, alsa-lib config is still not updated to follow the recent
> changes in kernel side.  It needs multiple HDMI entries.
>
>
>> I added the missing devices in HdmiLpeAudio.conf with the patch below,
>> which helps select the right output, but somehow the AES0 non-audio
>> bit doesn't seem to be set.
>>
>> [plb@ZOTAC PASSTHROUGH]$ amixer -Dhw:0 cget numid=12
>> numid=12,iface=PCM,name='IEC958 Playback Default',device=2
>>    ; type=IEC958,access=rw------,values=1
>>    : values=[AES0=0x00 AES1=0x00 AES2=0x00 AES3=0x00]
>> [plb@ZOTAC PASSTHROUGH]$ aplay -D'hdmi:CARD=0,DEV=2,AES0=0x6' -c2
>> -r48000 -fs16_le ac3_surround_test.spdif
>> Playing raw data 'ac3_surround_test.spdif' : Signed 16 bit Little
>> Endian, Rate 48000 Hz, Stereo
>> ^CAborted by signal Interrupt...
>> [plb@ZOTAC PASSTHROUGH]$ amixer -Dhw:0 cget
>> numid=12numid=12,iface=PCM,name='IEC958 Playback Default',device=2
>>    ; type=IEC958,access=rw------,values=1
>>    : values=[AES0=0x00 AES1=0x00 AES2=0x00 AES3=0x00]
> Did you check the value during the playback?
> Since you set "preserve" in HDMI config, the old value gets restored
> at closing the PCM.
yes, that was the issue, thanks. I'll send a patch just now, it works fine
>
>
> thanks,
>
> Takashi
>
>
>> Could it be that we are missing the 'index' which is used in the
>> HDaudio case to access the 'IEC958 Playback Default' controls?
>>
>> Thanks
>>
>> -Pierre
>>
>> diff HdmiLpeAudio.conf /usr/share/alsa/cards/HdmiLpeAudio.conf
>> 59,135d58
>> <                 device 0
>> <                 lock true
>> <                 preserve true
>> <                 value [ $AES0 $AES1 $AES2 $AES3 ]
>> <             }
>> <         ]
>> <     }
>> < }
>> <
>> < HdmiLpeAudio.pcm.hdmi.1 {
>> <     @args [ CARD AES0 AES1 AES2 AES3 ]
>> <     @args.CARD {
>> <         type string
>> <     }
>> <     @args.AES0 {
>> <         type integer
>> <     }
>> <     @args.AES1 {
>> <         type integer
>> <     }
>> <     @args.AES2 {
>> <         type integer
>> <     }
>> <     @args.AES3 {
>> <         type integer
>> <     }
>> <     type hooks
>> <     slave.pcm {
>> <         type hw
>> <         card $CARD
>> <         device 1
>> <     }
>> <     hooks.0 {
>> <         type ctl_elems
>> <         hook_args [
>> <             {
>> <                 interface PCM
>> <                 name "IEC958 Playback Default"
>> <                 device 1
>> <                 lock true
>> <                 preserve true
>> <                 value [ $AES0 $AES1 $AES2 $AES3 ]
>> <             }
>> <         ]
>> <     }
>> < }
>> <
>> < HdmiLpeAudio.pcm.hdmi.2 {
>> <     @args [ CARD AES0 AES1 AES2 AES3 ]
>> <     @args.CARD {
>> <         type string
>> <     }
>> <     @args.AES0 {
>> <         type integer
>> <     }
>> <     @args.AES1 {
>> <         type integer
>> <     }
>> <     @args.AES2 {
>> <         type integer
>> <     }
>> <     @args.AES3 {
>> <         type integer
>> <     }
>> <     type hooks
>> <     slave.pcm {
>> <         type hw
>> <         card $CARD
>> <         device 2
>> <     }
>> <     hooks.0 {
>> <         type ctl_elems
>> <         hook_args [
>> <             {
>> <                 interface PCM
>> <                 name "IEC958 Playback Default"
>> <                 device 2
>>
