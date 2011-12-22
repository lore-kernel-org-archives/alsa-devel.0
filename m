From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: hda/jack - Also add jack kctls
	for	Conexant codecs
Date: Thu, 22 Dec 2011 01:08:09 +0000
Message-ID: <20111222010808.GC27144@opensource.wolfsonmicro.com>
References: <1324390985-3496-1-git-send-email-david.henningsson@canonical.com>
	<s5hvcpbgvpm.wl%tiwai@suse.de>
	<20111220235813.GA13529@sirena.org.uk>
	<s5hr4zydm0m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19C72103C16
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 02:08:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr4zydm0m.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 21, 2011 at 03:42:17PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > I was rather expecting that the patches would be posted to the list for
> > review at some point (though I may have missed them as not having
> > generic support is really disappointing).

> Err, sorry, I thought I have posted some in RFC, but wasn't there.
> The essential patch for the common helper is attached below.

Thanks.  It'll be tomorrow at the earliest before I can read it properly.

> >  We should at least verify
> > that the userspace interface isn't going to cause problems for non-HDA
> > systems.

> Well, the kctl-jack part itself can't break anything right now since
> it's used only in HD-audio.  If others will use, this will be a pure
> addition, so it won't break except for possibly different ctl numids.

I'm more worried about the userspace interface than the in kernel one,
we can rewrite the kernel if it sucks but we're stuck with userspace.

> The question toward the integration with the input-jack stuff is still
> open.  In the HD-audio case, input-jack functions are merged into the
> kctl-jack helpers.  But for others, it doesn't have to be so.

I really don't see any reason why you'd want to have to worry about the
specific mechanisms in drivers (and there's also the extcon/switch stuff
that's looking likely to hit soon).  Indeed the extcon stuff might make
this needless anyway.

> One remaining obstacle for this integration is that the input-jack
> provides multiple key bits per jack entry while this doesn't exist in
> the kctl notification.  With kctl, the notifier says just that the 
> value was changed.  Then the user-space can query the current value
> (not necessarily a boolean but can be an integer or else), but the
> value isn't passed in the notification itself.  So, it's a different
> design. 

The detail in the notification seems completely trivial to deal with -
the input layer also provides similar readback support, it just happens
to have a more verbose report (and it needs the cache for readback
anyway as it also uses it to eliminate noop reports).
