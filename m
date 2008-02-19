From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Tue, 19 Feb 2008 16:55:02 +0100
Message-ID: <47BAFBD6.8050903@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	<476A2BCC.4060109@gmail.com>	<s5h1w9h4g5d.wl%tiwai@suse.de>	<47727C6C.6080401@gmail.com>	<1198815321.3732.229.camel@razman.gruemaster.com>	<47B06DEF.4070609@gmail.com>	<s5htzkfv5jp.wl%tiwai@suse.de>	<47B0D319.2000702@gmail.com>	<s5hd4r2v5g1.wl%tiwai@suse.de>	<47B23AB8.6000301@gmail.com>	<47B5D230.4050402@gmail.com>	<47B9C909.9010100@gmail.com>	<s5h3arpujri.wl%tiwai@suse.de>	<47BAE549.2080009@gmail.com>	<s5hzltxt3oy.wl%tiwai@suse.de>	<47BAEFB6.8040209@gmail.com>
	<s5hprutt22f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C0E910392C
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 16:55:10 +0100 (CET)
Received: by mu-out-0910.google.com with SMTP id i10so2075854mue.3
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 07:55:09 -0800 (PST)
In-Reply-To: <s5hprutt22f.wl%tiwai@suse.de>
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

Takashi Iwai ha scritto:
> The mixer setting?  You should set "Digital Capture Volume" 50%,
> corresponding to 0dB.  The capture volume doesn't have to be too
> high, too.

oh..
i had to play a bit with alsamixer but finally i got a good result...

my setting:
- front mic boost = 50 (option: 0, 50, 100)
- Capture enabled = 65
- Capture 1 disabled (see below)
- Digital = 68
- Input Source = Front mic
- Input Source 1 = Front mic (playback - see below)


i've discovered some oddity:

- i have 2 capture device.... (capture and capure 1)
- the first one is *really* a capture device and work only if i select 
"front mic", not "mic"
- the second one is the mic playback device... and again it work only if 
i use "front mic"

should it work this way?

> The vref level could be a different one depending on the mic device
> you are using.  But VREF80 is OK in most cases.

i don't know what "VREF80" but now capturing with mic work...

now remaining problems:
- midi hardware (my card should have it): i've loaded snd-seq-midi 
module and i've an alsa hardware device but i can't play midi files 
(they play but i hear nothing...). i've created another alsa-info log 
taken with the snd-seq-midi loaded http://pastebin.ca/909849
- no "mux","mix", or "aux" record source to directly record from desktop
- surround still doesn't work
i should have surround
$ aplay -L
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

but trying
speaker-test -c5 -Dplug:surround41

or any of that other devices produce this error:
Playback device is plug:surround41
Stream parameters are 48000Hz, S16_LE, 5 channels
Using 16 octaves of pink noise
Playback open error: -16,Device or resource busy

the last error repeat itself until i stop it (CTRL+C)
and i hear nothing


are some of this fixable? and can i help in some way fixing them?
thanks again... A LOT!

-- 
Daniele
