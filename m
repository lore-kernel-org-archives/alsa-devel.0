From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] alsa-lib: if card driver name is empty
 string, use card name instead
Date: Tue, 20 Sep 2011 11:51:57 +0100
Message-ID: <20110920105156.GF2387@opensource.wolfsonmicro.com>
References: <1316538944-31853-1-git-send-email-scott.jiang.linux@gmail.com>
	<s5haa9zspcb.wl%tiwai@suse.de>
	<20110920101434.GD2387@opensource.wolfsonmicro.com>
	<s5hy5xj1p16.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AABBC1038AE
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 12:51:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy5xj1p16.wl%tiwai@suse.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2011 at 12:33:41PM +0200, Takashi Iwai wrote:

> Well, you can follow a short history from the commit: the commit above
> was really a fix to get back to the old good behavior.  Until 3.0,
> ASoC had no way to set card->driver field.  The method to set

No - older versions of ASoC always automatically generated a driver
name (badly but that's a separate story).  I guess that got broken with
multi-component but didn't bother checking.

> But, this was no good move, too.  The card->driver field is to be a
> concise string without special letters while card->name contains more
> flexible string.  So, I changed the way back to the state before 3.0
> there, the commit 873bd4.

Which unfortunately restored the original problem which was being fixed
by Jarkko.

> Of course, it'd be nice to implement a logic in ASoC core to
> automatically generate some valid driver-name string.  But, the driver
> name string is at most 15 letters, and card->name is an arbitrary
> string, so you'd need to do it a bit carefully.

I think the card name is fine, people don't tend to write anything
terribly long there and very little actually cares about the driver name
- alsa-lib's config loading thing is the only thing I'm aware of (and
that's not being terribly useful really, one driver can easily support
multiple cards).  If it's a problem people can always explicitly set
something.
