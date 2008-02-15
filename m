From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Fri, 15 Feb 2008 18:56:00 +0100
Message-ID: <47B5D230.4050402@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	<476A2BCC.4060109@gmail.com>	<s5h1w9h4g5d.wl%tiwai@suse.de>	<47727C6C.6080401@gmail.com>	<1198815321.3732.229.camel@razman.gruemaster.com>	<47B06DEF.4070609@gmail.com>	<s5htzkfv5jp.wl%tiwai@suse.de>	<47B0D319.2000702@gmail.com>
	<s5hd4r2v5g1.wl%tiwai@suse.de> <47B23AB8.6000301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F76A243BD
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 18:56:07 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so1641234uge.50
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 09:56:06 -0800 (PST)
In-Reply-To: <47B23AB8.6000301@gmail.com>
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

Daniele (Mastro) ha scritto:
> Takashi Iwai ha scritto:
>> Basically run alsa-info.sh on your problematic configuration you
>> wanted to use.  So, don't pass model option unless you did so in the
>> earlier versions and it ran well.  If you have another better-working
>> configuration, take alsa-info.sh snapshot as well for comparison.
> 
> http://pastebin.ca/901893
> 
> this is with "default" configuration... and it's the best one...
> has this the things you need?
> 

with "default" configuration i mean model=auto
and.. i forgot to raise capture volume:

if i raise the second capture volume (capture 1) i got playback sound 
(even if i disable it) and record is a noisy sound...
if you want i can upload it somewhere

i've retoken the alsa-info
http://pastebin.ca/905273


i've noticed that now on aplay -L i have

default:CARD=Intel
     HDA Intel, ALC268 Analog
     Default Audio Device
front:CARD=Intel,DEV=0
     HDA Intel, ALC268 Analog
     Front speakers
surround40:CARD=Intel,DEV=0
     HDA Intel, ALC268 Analog
     4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
     HDA Intel, ALC268 Analog
     4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
     HDA Intel, ALC268 Analog
     5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
     HDA Intel, ALC268 Analog
     5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
     HDA Intel, ALC268 Analog
     7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
null
     Discard all samples (playback) or generate zero samples (capture)


but if i try to test surround with:
speaker-test -c6 -Dplug:surround51 -t wav -l1

i get:

speaker-test 1.0.15

Playback device is plug:surround51
Stream parameters are 48000Hz, S16_LE, 6 channels
WAV file(s)
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy
[....]

i don't know how to test the digital output/input

and i've no "mix, mux or aux" on capture device list (only mic, front 
mic and line)

-- 
Daniele
