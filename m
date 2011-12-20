From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: hda/jack - Also add jack kctls for
 Conexant codecs
Date: Tue, 20 Dec 2011 23:58:13 +0000
Message-ID: <20111220235813.GA13529@sirena.org.uk>
References: <1324390985-3496-1-git-send-email-david.henningsson@canonical.com>
	<s5hvcpbgvpm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 884592417E
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 00:58:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvcpbgvpm.wl%tiwai@suse.de>
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

On Tue, Dec 20, 2011 at 03:32:21PM +0100, Takashi Iwai wrote:
> David Henningsson wrote:

> > Also it would be nice to see this merged, soon it might be too late for 3.3?

> OK, let's merge it.  The things are still local to hda-intel, so we
> can fix pending issues and rewrite with a more generic framework later
> for unified jack-handling stuff.

I was rather expecting that the patches would be posted to the list for
review at some point (though I may have missed them as not having
generic support is really disappointing).  We should at least verify
that the userspace interface isn't going to cause problems for non-HDA
systems.
