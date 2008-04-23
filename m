From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: Add drivers for the Texas
	Instruments OMAP	processors
Date: Wed, 23 Apr 2008 10:20:23 +0100
Message-ID: <20080423092023.GA9374@rakim.wolfsonmicro.main>
References: <1208870079-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hskxe9dvs.wl%tiwai@suse.de>
	<20080422144331.GB5242@rakim.wolfsonmicro.main>
	<s5hlk369bvu.wl%tiwai@suse.de>
	<20080423085731.f0f9c05f.jarkko.nikula@nokia.com>
	<s5habjldjkp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F5FF2445C
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 11:20:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5habjldjkp.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 23, 2008 at 11:08:54AM +0200, Takashi Iwai wrote:

> So, at the next time, if you have something you want to merge, please
> check the current ALSA tree status.  If the patch isn't there, submit
> the patch soon.  The merge to the subsystem tree is easy as long as no

He's actually done all that - the patch has been posted on alsa-devel a
few times and has been sitting in ASoC for almost a month waiting for
the ARM bits it needs to be merged.

> big API changes happens.  Tossing to the upstream is another issue,
> though.

For stuff that doesn't touch any core code (especially things like this
which will only be selectable on one platform) it shouldn't be too much
of an issue, I'd expect - there's not much risk of breaking
anything else.
