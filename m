From: Sophie Hamilton <sophie-alsa@theblob.org>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Tue, 8 Sep 2009 00:10:19 +0100
Message-ID: <a080dbc80909071610p647a8267r7ce792a98b20874a@mail.gmail.com>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
	<s5hljkrrl3s.wl%tiwai@suse.de> <1252330155.3283.5.camel@localhost>
	<s5hbplmssrg.wl%tiwai@suse.de>
	<20090907224659.GA5917@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id E7BB5245E7
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 01:10:19 +0200 (CEST)
Received: by fxm3 with SMTP id 3so2327299fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2009 16:10:19 -0700 (PDT)
In-Reply-To: <20090907224659.GA5917@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Tony Vroon <tony@linx.net>, Sophie Hamilton <sophie-alsa@theblob.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/7/09, Lennart Poettering <mznyfn@0pointer.de> wrote:
>  For a short while we used to call
>  snd_pcm_hw_params_set_buffer_size_near() first, then
>  snd_pcm_hw_params_set_periods_near() and then snd_pcm_hw_params().
>
>  This turned out to cause a couple of issues with some drivers (i think
>  CS46xx is one of them, ice1712 another, I lack the hw in question, so
>  i never tried to track this down further). Basically on those drivers
>  both _set_buffer_size_near() and _set_periods_near() would fail with
>  EINVAL for some reason and then causing snd_pcm_hw_params() to return
>  ENOENT. Removing the two calls and calling snd_pcm_hw_params() would
>  however work. Changing the order of the first two calls, i.e. doing
>  first _set_periods_near() and then _set_buffer_size_near() would make
>  both calls succeed and the snd_pcm_hw_params(), too.

I don't know if this is relevant, but in the course of tracking down
the bug which led to me creating the patch for the cs46xx driver, I
downloaded the latest alsa-utils to play with the aplay source. It
turned out that I could comment out either the period-setting block
(which called either _set_period_time_near or _set_period_size_near)
*or* the buffer-setting block (which called either
_set_buffer_time_near or _set_buffer_size_near) without experiencing
any ill effects on sound. It was only when I commented out both blocks
that I experienced issues with the sound.

This may be obvious to people here, but being new to ALSA programming
(this is literally my first excursion into it), it strikes me that
this could be significant. Does it help you at all?

 - Sophie.
