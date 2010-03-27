From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [for 2.6.34][PATCH] ALSA: pcm_lib - fix xrun
	functionality
Date: Sat, 27 Mar 2010 20:48:37 +0100
Message-ID: <20100327194837.GB2103@elf.ucw.cz>
References: <1269612445-14245-1-git-send-email-jhnikula@gmail.com>
	<s5hvdcjnokb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (ksp.mff.cuni.cz [195.113.26.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FFEC243EF
	for <alsa-devel@alsa-project.org>; Sat, 27 Mar 2010 20:48:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvdcjnokb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri 2010-03-26 15:29:56, Takashi Iwai wrote:
> At Fri, 26 Mar 2010 16:07:25 +0200,
> Jarkko Nikula wrote:
> > 
> > The commit 4d96eb255c53ab5e39b37fd4d484ea3dc39ab456 broke the interrupt
> > time xrun functionality (stream stop etc.) if the CONFIG_SND_PCM_XRUN_DEBUG
> > is not set. This is because the xrun() is null defined without it.
> > 
> > Fix this by letting the function xrun() to be always defined as it was
> > before.
> 
> Thanks, that's likely the problem Pavel has seen, but never reproduced
> on Jaroslav or my machine.

Yes, I hand-applied the patch, and problem went away. Thanks!

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
