From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: M-Audio FTU issues
Date: Fri, 24 Jun 2011 09:35:03 +0200
Message-ID: <4E043E27.3060902@showlabor.de>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090001070701050902020500"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id 54D132495D
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 09:35:07 +0200 (CEST)
In-Reply-To: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090001070701050902020500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,


Am 24.06.2011 03:14, schrieb Daniel Mack:
> So, I've looked into this today and as expected, the device normally
> operates in implicit feedback mode. After installing a proprietary
> driver on Mac OS X (that regularily crashed my kernel), the analyzer
> shows that for every inbound packet, an out packet is sent back with
> the same amount of data in it. And there are no feedback endpoints.

Thank you very much!


>
> What surprises me though, is that I can't hear the clicks and pops you
> guys describe. Instead, I hear a quite annoying distortion for both
> 44100 and 48000 Hz which I can't explain either.

As Grant wrote, I only experienced something like this when I accidently 
had turned on some reverb effects in the Windows control center. But if 
it sounds as if the output was completely "chopped" then it would rather 
remind me of the days when it only worked at 48/96 kHz and I tried 
playing back at 44.1/88.2 kHz.

> I patched the driver so that it supports implicit feedback, but that
> didn't change anything in that regard.

Great, that you could already do the implicit feedback part! (BTW, don't 
hesitate to send me early experimental patches.)


> Hence my question is: How do you guys test?

I'm usually using puredata for this. I've attached the very simple pd 
file. I've always tested with JACK, never with ALSA directly. But as I 
said earlier: If I boot an old kernel with "initial support" (i.e. the 
one using just QUIRK_AUDIO_STANDARD_INTERFACE; only working at 48/96 
kHz) the clicks go away. Hence it doesn't seem related to using JACK. 
(Using my internal soundcard I don't hear clicks using pd/JACK either).

I even "ported" back the initial support to a current kernel a month or 
so ago and could reliably switch between "Clicks at all sampliing rates" 
and "No clicks at 48/96 kHz; kernel crash at 44.1/88.2 kHz".

Initially though I generated a sine in audacity, too.

>   I renderened a sine tone
> in different samplerates and bit depths to .wav files and play them
> with aplay (no pulseaudio or anything in the chain). Could you try the
> same and report what happens?

I will try this morning and report.

Kind regards,

Felix

--------------090001070701050902020500
Content-Type: text/plain;
 name="pd-sine.pd"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pd-sine.pd"

#N canvas 736 426 450 300 10;
#X obj 150 143 dac~;
#X obj 87 60 osc~ 10000;
#X connect 1 0 0 0;

--------------090001070701050902020500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090001070701050902020500--
