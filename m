From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: [ASoC] Mic record is not working with wm9713 ASoC
	driver
Date: Wed, 9 May 2007 13:02:35 +0530
Message-ID: <8d6898730705090032k375babefl973819bd3d9d85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id D90B42440D
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 09:32:39 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so26360anc
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 00:32:38 -0700 (PDT)
Content-Disposition: inline
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

I am trying to record mic with AsoC wm9713 driver. My Mic is connected "Mic 1".

My settings

'Mic A Source' -> "Mic 1"
'Mic Boost (+20dB)' [on]
'Capture' [on]
'Left Capture Source' "Mic 1"
'Right Capture Source' "Mic 1"


i am issuing following command to record
"arecord -M -f S16_LE sound.wav"

But what i found is driver is not enabling "Mic bias" and "Mic A PGA"

this dump of /sys/devices/platform/soc-audio/dapm_widget while
"arecord" is running is given below


Mic Bias: Off
Mic B Pre Amp: Off
Mic A Pre Amp: On
Mic B PGA: Off
Mic A PGA: Off
Mono In: Off
Right Line In: Off
Left Line In: Off
Mono Out: Off
Out 4: Off
Out 3: Off
Right Speaker: Off
Left Speaker: Off
Right Headphone: Off
Left Headphone: Off
Right ADC: On
Left ADC: On
Aux DAC: Off
Voice DAC: Off
Capture Mixer: Off
HP Mixer: Off
AC97 Mixer: Off
Right DAC: Off
Left DAC: Off
Speaker Mixer: Off
Mono Mixer: Off
Right HP Mixer: Off
Left HP Mixer: Off
PM State: D0

In idea why this is happening?
what is going wrong with my settings?

Nobin Mathew
