From: Sophie Hamilton <sophie-alsa@theblob.org>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Wed, 9 Sep 2009 13:29:02 +0100
Message-ID: <a080dbc80909090529w3e958f27g38d8238836e415e2@mail.gmail.com>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
	<s5hljkrrl3s.wl%tiwai@suse.de> <1252330155.3283.5.camel@localhost>
	<s5hbplmssrg.wl%tiwai@suse.de>
	<20090907224659.GA5917@tango.0pointer.de>
	<s5htyzej6fj.wl%tiwai@suse.de>
	<a080dbc80909080046p73207442ld8f6577ebbf37ba9@mail.gmail.com>
	<s5hws49rf58.wl%tiwai@suse.de> <s5hpra01is7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C2A02442E
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 14:29:03 +0200 (CEST)
Received: by fxm3 with SMTP id 3so3422922fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2009 05:29:03 -0700 (PDT)
In-Reply-To: <s5hpra01is7.wl%tiwai@suse.de>
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
Cc: Tony Vroon <tony@linx.net>, alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On 9/9/09, Takashi Iwai <tiwai@suse.de> wrote:
> It turned out that the hw_params determination is done rather inside
>  the alsa-lib beforehand.
>
>  Try the patch below.  This will give you larger buffer size with
>  audacious.  (And it will work without the driver changes.)
>
>  For any apps that require the old behavior, I added the check of
>  $LIBASOUND_COMPAT variable.

Since this patch is for alsa-lib and not for the kernel, this forced
me to check what version I was currently using, which turned out to be
1.0.20. (specifically, media-libs/alsa-lib-1.0.20-r1) 1.0.21 hadn't
yet been keyworded on my architecture (x86) as stable.

So for my first test, I forced 1.0.21 to install anyway, then made
sure the 2.6.30.5 kernel I was using was unpatched, then rebooted to
test whether the upgrade to 1.0.21 (unpatched) would have made any
difference anyway. It didn't; the sound was the same as it was before.

Then, I copied the alsa-lib ebuild to a local Gentoo repository and
modified it to apply your patch. (I don't know what tricks Gentoo
might have up its sleeve for components as core as this, so I didn't
feel comfortable taking the raw source. It shouldn't made a
difference, but if you'd prefer me to try, I can see what I can do. I
can't promise that any problems would be necessarily from this,
though.) I compiled and installed the new patched 1.0.21, and
rebooted.

I can confirm now that Audacious does indeed play correctly where it
didn't before. However, using mplayer with the "-ao openal" switch
still doesn't play correctly - in fact, it sounds the same as before -
so it looks like OpenAL is actually doing things slightly differently
than I thought. :/

As a final test, I removed the patch from alsa-lib and re-patched the
kernel with my patch to change the minimum period size to 64 for
cs46xx, so that I could check whether it would still work with the new
alsa-lib 1.0.21 (rather than the 1.0.20 that I was using before). It
does indeed work, in both Audacious and OpenAL.

So... I'm not sure what's up with OpenAL in this case. Is there
anything more I can do to help?

 - Sophie.
