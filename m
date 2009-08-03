From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - amixer] listen to D-Bus for volume-up,
	volume-down and mute signals.
Date: Mon, 3 Aug 2009 13:17:47 +0100
Message-ID: <20090803121747.GD5959@sirena.org.uk>
References: <1249296201-6930-1-git-send-email-stlman@poczta.fm>
	<s5hocqxcgqb.wl%tiwai@suse.de> <4A76D239.70202@poczta.fm>
	<s5hiqh5ccyr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A33224680
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 14:17:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hiqh5ccyr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, Lukasz Stelmach <stlman@poczta.fm>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 03, 2009 at 02:13:16PM +0200, Takashi Iwai wrote:
> Lukasz Stelmach wrote:

> > No worries ;) there is --with(out)--dbus option for configure to
> > disable all this code which is enough for initrd because most often
> > (AFAIK) initrd binaries are not the same that in the live system.

> Usually same binaries are used for initrd nowadays in many distros.
> So, configure option doesn't help.

> And, I really prefer this as a separate daemon, so it be as small as
> possible.  Seeing amixer as a daemon is somewhat strange...

I tend to agree, merging it into amixer seems kind of arbatrary.  Such a
daemon (and its dbus interface) may also be useful for handling things
like scenario management so I can see it growing over time.
