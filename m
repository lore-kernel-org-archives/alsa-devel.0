From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Planned changes
Date: Fri, 16 May 2008 09:35:59 -0700
Message-ID: <1210955759.6610.866.camel@razman>
References: <s5hej82e2of.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id DE196249E3
	for <alsa-devel@alsa-project.org>;
	Fri, 16 May 2008 18:36:03 +0200 (CEST)
In-Reply-To: <s5hej82e2of.wl%tiwai@suse.de>
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

On the debug side, I think it would be nicer if we could just compile
with all debugging available, then specify a debug=<level> option on
module load or through /sys writes (echo 3
>/sys/module/snd_hda-intel/parameters/debug).  This way, each module can
be debugged independently without a lot of debug messages from other
modules.

As to the Kconfig option, switching to that would then require
users/developers to edit a kernel config file.  Being able to select
which module to compile is far easier for people that only care about
one or two specific cards.

Just my $.02(USD) worth.

Tobin


On Fri, 2008-05-16 at 16:36 +0200, Takashi Iwai wrote:

> Hi,
> 
> there are some patches floating around on my experimental tree, which
> I'd like to merge to the ALSA upstream.  At least, the following two
> are ready for merge:
> 
> - Use menuconfig in ALSA kconfig
> - Convert CONFIG_SND_DEBUG_DETECT to CONFIG_SND_DEBUG_VERBOSE
> 
> The first one is to change from menu to menuconfig in ALSA Kconfig
> files.  There have been some patches by others, but they haven't been
> applied because of the problem with alsa-driver build.  Now I hacked
> alsa-driver build again so that it works with menuconfig somehow.
> 
> The drawback is that it changes the configure option.  Instead of
> --with-cards and --with-card-options, now we have a single
> --with-kconfigs.  I think, however, it's rather an improvement.
> 
> The next one, renaming to CONFIG_SND_DEBUG_VERBOSE, is easy.
> The reason is that CONFIG_SND_DEBUG_DETECT and snd_printdd() are used
> almostly exclusively for verbose debug messages.  This may reduce some
> misunderstanding about this option.
> 
> The patches can be found on my experimental tree:
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build-unstable.git
> 
> If there is no objection, I'll apply the above two changes in the next
> week.
> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


"You've got to have a gimmick if your band sucks."
		-- Gary Giddens
