From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: [ASoC] Mic record is not working with wm9713 ASoC
	driver
Date: Wed, 9 May 2007 14:45:49 +0530
Message-ID: <8d6898730705090215s573660d8obebee755251e065@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DBB824416
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 11:15:51 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so118326wri
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 02:15:50 -0700 (PDT)
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
