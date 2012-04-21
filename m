From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Fri, 20 Apr 2012 21:29:23 -0400
Message-ID: <4F920D73.7070309@rauros.net>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173017pub.verizon.net (vms173017pub.verizon.net
	[206.46.173.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 44139103FA5
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2012 03:30:05 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173017.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M2T00HFU2T0IKK1@vms173017.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Fri, 20 Apr 2012 20:29:25 -0500 (CDT)
In-reply-to: <4F911629.5090704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Having never done kernel module debugging I resorted to littering printk 
everywhere. Crude but effective. I'll really need to look into setting 
up kernel debug in VirtualBox...

The C400 appears to be UAC2 device.

The root cause of the failure occurs during snd_usb_mixer_controls()

Following down the rabbit hole,

parse_audio_unit() discovers a type, UAC_MIXER_UNIT and beings to parse 
pins in parse_audio_mixer_unit()

A pin is found of type "7" which since this is UAC2 device, could be 
UAC2_EFFECT_UNIT or UAC1_PROCESSING_UNIT

We arrive at the following case in check_input_term:

                 case UAC1_PROCESSING_UNIT:
                 case UAC1_EXTENSION_UNIT: {
                         struct uac_processing_unit_descriptor *d = p1;
                         if (d->bNrInPins) {
                                 id = d->baSourceID[0];
                                 break; /* continue to parse */
                         }

The break ultimately results (after find_audio_control_unit returns 
NULL) in ENODEV which bubbles all the way back out to 
snd_usb_audio_probe(), goto returns NULL, back out to usb_audio_probe() 
which finally returns -EIO.

Being a little daring I replaced the break with "return 0;" - now the 
card is detected but fails trying to probe sample rates.

I copied the FIXED_ENDPOINT quirk descriptor from the FTU and trying to 
slam in workable values(channels = 2, ifnum = 2).

Viola! The card now completes probing and shows up as a device in aplay 
-L/-l.

Except I can't get it to play anything (figure it would all be too good 
to be true)

$ speaker-test -Dfront:C400
speaker-test 1.0.25

Playback device is front:C400
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Sample format not available for playback: Invalid argument
Setting of hwparams failed: Invalid argument

$ amixer contents
numid=1,iface=MIXER,name='PCM Clock Source'
   ; type=ENUMERATED,access=rw------,values=1,items=2
   ; Item #0 'Unit 129'
   ; Item #1 'Unit 130'
   : values=0

On 04/20/2012 03:54 AM, Daniel Mack wrote:
> On 04/19/2012 10:53 AM, Clemens Ladisch wrote:
>> Chris Cavey wrote:
>>>   snd-usb-audio: probe of 1-1:1.1 failed with error -5
>>>   snd-usb-audio: probe of 1-1:1.2 failed with error -5
>>>   snd-usb-audio: probe of 1-1:1.3 failed with error -5
>> Are there no other messages immediately before this?
>>
>> Daniel, are there places where the code aborts without
>> print an error message?
> Yes, there are in fact some. -5 means -EIO, and the module probe will
> fail with this error code in case snd_usb_audio_probe() returns NULL.
> Chris, can you trace this functions in sound/usb/card.c and see where it
> bails?
>
>
>
> Daniel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
