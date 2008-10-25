From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver, possible fix
Date: Sat, 25 Oct 2008 23:57:53 +0200
Message-ID: <5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>
References: <4900A4FA.7020300@jasonline.co.uk>
	<4900DBBD.2020806@jasonline.co.uk> <s5hljwee68t.wl%tiwai@suse.de>
	<49017FBF.4030005@jasonline.co.uk> <s5hfxmm47kb.wl%tiwai@suse.de>
	<20081025130652.GA27621@rzle423.uni-duisburg.de>
	<s5hej24psn6.wl%tiwai@suse.de>
	<20081025194255.GA27872@rzle423.uni-duisburg.de>
	<s5hod18fntg.wl%tiwai@suse.de> <49038448.3090704@jasonline.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 351E324420
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 23:58:12 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so1313249rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2008 14:57:53 -0700 (PDT)
In-Reply-To: <49038448.3090704@jasonline.co.uk>
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
To: Jason Harvey <softdevice@jasonline.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Latest unstable (25Oct 19:57) works from command line with mplayer,
> without the proc oss fix.
>
Confirmed.
The stuttering got better, but is still present.

Xine works flawless.

> aplay still works but only with dmix.
>
Samplingrate 11025Hz and 8000Hz do not play a clear sinus, sounds a
bit scratchy..
All other common samplingrates work flawless. Could someone confirm that?
http://tmp.olausson.de/30days/0_16_s_8000.wav
http://tmp.olausson.de/30days/0_16_s_11025.wav
http://tmp.olausson.de/30days/0_16_s_96000.wav

Just using "aplay file.wav"

More noticable ist it when using mplayer. Crackles a lot with 8000Hz and 11025Hz
"mplayer file.wav"

mmh, xine crackles too. Please someone confirm, otherwise the files may be bad.

> Now also almost working in gnome with pulse, sound is recognisable but
> with lots of interference/corruption.
>
No pulseaudio on my machine. Sry.

> Machine did not crash at any point!
>
Just observed a X crash when using smplayer to play a avi. When I
closed smplayer while the movie was playing X crashed. (But could be
unrelated to audio, I could not reproduce it)

But no crash or freez so far.

> This was running on 2.6.26... is this a problem? SUPPORTED_KERNELS says
> 2.6.25 or earlier?
>
I am using vanilla 2.6.27.3

Thanks for you awesome work!

By the way, what's next on your plan when stereo output and recording
is working flawless?


kind regards
Bjoern
