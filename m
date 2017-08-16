From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: IEC61937 passthrough with BYT/CHT HdmiLpeAudio
Date: Wed, 16 Aug 2017 10:15:09 -0500
Message-ID: <346c68cd-d922-e773-3047-0a36b084e7f0@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 26073266B1C
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 17:15:14 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

While I was looking at IEC61937, I ran a quick test on my BYT and CHT 
boxes, and as I suspected IEC61937 works fine since your modifications 
to add s16_le support. I can get AC3 to my HDMI receiver without 
problems just by using the hw:0,<1,2,3> device, depending on which port 
is used.

e.g. aplay  -Dhw:0,2 -c2 -r48000 -fs16le ac3_surround_test.spdif

To make things more usable for applications, and maybe support receivers 
who actually care about the AES0 non-audio bit or reduce the initial 
lock time, it'd be nice to support the traditional command line, e.g.

aplay -D'hdmi:CARD=0,DEV=<0,1,2>,AES0=0x6' -c2 -r48000 -fs16_le 
ac3_surround_test.spdif

However we seem to have a mix of alsa-lib configuration issues and maybe 
a miss at the driver level

I added the missing devices in HdmiLpeAudio.conf with the patch below, 
which helps select the right output, but somehow the AES0 non-audio bit 
doesn't seem to be set.

[plb@ZOTAC PASSTHROUGH]$ amixer -Dhw:0 cget numid=12
numid=12,iface=PCM,name='IEC958 Playback Default',device=2
   ; type=IEC958,access=rw------,values=1
   : values=[AES0=0x00 AES1=0x00 AES2=0x00 AES3=0x00]
[plb@ZOTAC PASSTHROUGH]$ aplay -D'hdmi:CARD=0,DEV=2,AES0=0x6' -c2 
-r48000 -fs16_le ac3_surround_test.spdif
Playing raw data 'ac3_surround_test.spdif' : Signed 16 bit Little 
Endian, Rate 48000 Hz, Stereo
^CAborted by signal Interrupt...
[plb@ZOTAC PASSTHROUGH]$ amixer -Dhw:0 cget 
numid=12numid=12,iface=PCM,name='IEC958 Playback Default',device=2
   ; type=IEC958,access=rw------,values=1
   : values=[AES0=0x00 AES1=0x00 AES2=0x00 AES3=0x00]

Could it be that we are missing the 'index' which is used in the HDaudio 
case to access the 'IEC958 Playback Default' controls?

Thanks

-Pierre

diff HdmiLpeAudio.conf /usr/share/alsa/cards/HdmiLpeAudio.conf
59,135d58
<                 device 0
<                 lock true
<                 preserve true
<                 value [ $AES0 $AES1 $AES2 $AES3 ]
<             }
<         ]
<     }
< }
<
< HdmiLpeAudio.pcm.hdmi.1 {
<     @args [ CARD AES0 AES1 AES2 AES3 ]
<     @args.CARD {
<         type string
<     }
<     @args.AES0 {
<         type integer
<     }
<     @args.AES1 {
<         type integer
<     }
<     @args.AES2 {
<         type integer
<     }
<     @args.AES3 {
<         type integer
<     }
<     type hooks
<     slave.pcm {
<         type hw
<         card $CARD
<         device 1
<     }
<     hooks.0 {
<         type ctl_elems
<         hook_args [
<             {
<                 interface PCM
<                 name "IEC958 Playback Default"
<                 device 1
<                 lock true
<                 preserve true
<                 value [ $AES0 $AES1 $AES2 $AES3 ]
<             }
<         ]
<     }
< }
<
< HdmiLpeAudio.pcm.hdmi.2 {
<     @args [ CARD AES0 AES1 AES2 AES3 ]
<     @args.CARD {
<         type string
<     }
<     @args.AES0 {
<         type integer
<     }
<     @args.AES1 {
<         type integer
<     }
<     @args.AES2 {
<         type integer
<     }
<     @args.AES3 {
<         type integer
<     }
<     type hooks
<     slave.pcm {
<         type hw
<         card $CARD
<         device 2
<     }
<     hooks.0 {
<         type ctl_elems
<         hook_args [
<             {
<                 interface PCM
<                 name "IEC958 Playback Default"
<                 device 2
