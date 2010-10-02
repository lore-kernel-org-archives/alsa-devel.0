From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: how to mandate the use of PCM plugin?
Date: Sat, 2 Oct 2010 10:11:10 +0800
Message-ID: <AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru> <i7qltg$bph$1@dough.gmane.org>
	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>
	<4CA306CB.1090305@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E7D782450F
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 04:11:11 +0200 (CEST)
Received: by eye27 with SMTP id 27so1485509eye.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 19:11:11 -0700 (PDT)
In-Reply-To: <4CA306CB.1090305@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/29 David Henningsson <david.henningsson@canonical.com>

> On 2010-09-28 06:07, Raymond Yau wrote:
> > 2010/9/28 Colin Guthrie<gmane@colin.guthr.ie>
> >
> >>
> >>
> >> And today, one of the Canonical guys published his version of a tool to
> >> help here:
> >> http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/7542
> >>
> >> Hope this helps.
> >>
> >> Col
> >>
> >>
> >>
> > why did runtest.sh use a format  FLOAT64_LE which was not supported by PA
> ?
>
> runtest.sh isn't meant to be used directly in that way, you're supposed
> to run "alsamixertest". Try "alsamixertest -r" and "alsamixertest -h" to
> get started. (Perhaps I should rename the .sh file to something else.)
>
> That said, if you find a good use case where you want to use it directly
> and need a different sample format - patches welcome (as long as they
> don't break something else).
>
>
I just try to see whether this tool can help me to calibrate the 10 band
gain/atten controls of the hardware equalizer of au8830.

Have anyone test your tool on the sound card with ac97 codec ?

It seem that the program keep complain about those controls without dB scale
(e.g. AC97 3D Control - depth and rear depth , .) with the emulated intel8x0
driver  and no volume control with the emulated sb16 in virtualbox

Your program seem really behave as same as pulseaudio server , set the dB
value of control but don't verify the dB value can be set by re-reading the
value since dB -> volume conversion

Even though your program start at 0dB  , ac97 volume controls are in 1.5dB
per step but your program use 2 dB step

Still finding why the program running into infinite loop and try to set dB
to -7xx dB , however amixer does output the min dB when 0%
