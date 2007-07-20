From: Matthias Dahl <ml_alsa@mortal-soul.de>
Subject: Re:
	=?iso-8859-1?q?snd-hda-intel=2C_=09AD_1988b=3A_SPDIF?=
	=?iso-8859-1?q?_output_not_working_correctly=2C_=09volume_low_for_?=
	=?iso-8859-1?q?analog_output?=
Date: Fri, 20 Jul 2007 08:29:02 +0200
Message-ID: <200707200829.03682.ml_alsa@mortal-soul.de>
References: <200707170832.01976.ml_alsa@mortal-soul.de>
	<200707171822.58228.ml_alsa@mortal-soul.de>
	<s5hwswwqz8k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd15922.kasserver.com (dd15922.kasserver.com [85.13.137.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 83FD31037EC
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 08:28:54 +0200 (CEST)
In-Reply-To: <s5hwswwqz8k.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 19 July 2007 15:50:19 Takashi Iwai wrote:

> So, the primary problem is rather the 6stack-dig preset doesn't match
> with your device.  The SPDIF problem seems independent, though, but
> we'd better to fix the stuff first.
>
> With auto model, do you get louder output from the analog out?

Just tested it and as far as I can tell, only spdif seems a lot louder, analog 
output is equal to 6stack-dig.

Reminds me what also a bit strange: the PCM mixer control only appears after I 
have played back something.

On detail: - unload alsa, rm asound.state, load alsa, alsamixer (no pcm vol)
           - play back something, alsamixer (pcm volume is there)

>From there on, it'll always be visible, even after restarts. I also do not 
have any channel configuration control (2/4/6 channels). It's just not there. 
No matter if I use auto or 6stack-dig.

> The first thing to do is to check which pin widget corresponds to the
> real I/O jacks.  It's a guess work and trial-and-error.

Sounds a lot like digging into patch_analog.c (a long change/recompile/test 
cycle) or is there a way to figure this stuff out during runtime...? Could 
you please elobrate on what I should do? Thanks.

Best regards,
Matthias Dahl
