From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: Re: [Ekiga-devel-list] Pls don't require exclusive
 Alsa audio device access, use snd_pcm_dmix_open ()
Date: Wed, 28 Nov 2007 17:01:47 +0100
Message-ID: <474D90EB.5030400@googlemail.com>
References: <471FE2A7.9080309@googlemail.com>	<47201223.5050304@googlemail.com>	<474D2F8A.9090001@googlemail.com>	<Pine.LNX.4.61.0711281014180.8244@tm8103.perex-int.cz>
	<fijjso$aeg$1@ger.gmane.org>
Reply-To: thomas.schorpp@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id E75AD24B5F
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 17:01:51 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1274105nfd
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 08:01:49 -0800 (PST)
In-Reply-To: <fijjso$aeg$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ekiga development mailing list <ekiga-devel-list@gnome.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
> Jaroslav Kysela wrote:
>> On Wed, 28 Nov 2007, thomas schorpp wrote:
>>
>>>> +    if (_snd_pcm_dmix_open (&os_handle, real_device_name, snd_config_t* 
>>>> root, snd_config_t* sconf, stream, SND_PCM_NONBLOCK) < 0) {
>> Uff. It's really wrong. What you're trying to do? Simply use 'default' 
>> device name for snd_pcm_open() which should have defined dmix access if 
>> required. And don't forget to allow specify (force) ALSA device name to 
>> users if someone wants a special setup.

well, this is only draft code ;) ekiga uses the openh323.org ptlib alsa plugin 
and this thing blocks all other apps device access or gets blocked if another 
app like iceape is already on the device, twinkle has the same issue and this 
gets really on my nerves, cause i need to restart iceape to get the device free 
for telephony again, always :[

skype uses snd_pcm_dmix_open() (seen it in a bugtrace) and has no such problems.

i cant hardcode the devicename since it is selected and passed down by ekiga, 
the original code does:

-  if (snd_pcm_open (&os_handle, real_device_name, stream, SND_PCM_NONBLOCK) < 0) 

so i must define the dmix access in ekiga, it seems not be defined implicitely?

> 
> +1 Dmix should not be enforced... this can be handled at a lower
> level.... e.g. with dmix configured in alsa config or by using
> pulseaudio instead of dmix (my preferred solution so I can switch from
> my internal speakers to my usb headset should I plug it in mid-call).
> 
> Col.

alsa docs say dmix config files are no longer neccessary?

maybe the old (2.6.18 kernel) driver for this device has more bugs than not 
reinitializing mixer setting after acpi resume:
00:1f.5 Multimedia audio controller: Intel Corporation 82801CA/CAM AC'97 Audio Controller (rev 01)
        Subsystem: IBM ThinkPad T23 (2647-4MG) or A30/A30p (2652/2653)

snd_intel8x0           30332  1
snd_ac97_codec         83104  1 snd_intel8x0
snd_ac97_bus            2400  1 snd_ac97_codec
snd_pcm_oss            38368  0
snd_mixer_oss          15200  1 snd_pcm_oss
snd_pcm                68676  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              20996  1 snd_pcm
snd                    47012  8 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9248  1 snd
snd_page_alloc          9640  2 snd_intel8x0,snd_pcm

ii  libasound2          1.0.15-2            ALSA library

cat: /proc/asound/I82801CAICH3: Is a directory
cat: /proc/asound/card0: Is a directory
 0 [I82801CAICH3   ]: ICH - Intel 82801CA-ICH3
                      Intel 82801CA-ICH3 with CS4299 at 0x1c00, irq 5
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 33:        : timer
 0 snd_intel8x0
cat: /proc/asound/oss: Is a directory
00-01: Intel ICH - MIC ADC : Intel 82801CA-ICH3 - MIC ADC : capture 1
00-00: Intel ICH : Intel 82801CA-ICH3 : playback 1 : capture 1
cat: /proc/asound/seq: Is a directory
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-1: PCM capture 0-1-1 : SLAVE
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13:55:50 2006 UTC).

i will try the recent kernel maybe this solves things...

thx
tom
