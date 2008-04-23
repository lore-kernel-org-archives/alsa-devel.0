From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: Add drivers for the Texas
	Instruments OMAP	processors
Date: Wed, 23 Apr 2008 11:15:11 +0100
Message-ID: <20080423101511.GC9374@rakim.wolfsonmicro.main>
References: <1208870079-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hskxe9dvs.wl%tiwai@suse.de>
	<20080422144331.GB5242@rakim.wolfsonmicro.main>
	<s5hlk369bvu.wl%tiwai@suse.de>
	<20080422183842.GA7437@opensource.wolfsonmicro.com>
	<s5hk5ipdktv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58BBD24426
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 12:15:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk5ipdktv.wl%tiwai@suse.de>
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

On Wed, Apr 23, 2008 at 10:41:48AM +0200, Takashi Iwai wrote:

> Actually I have a separate branch on my git tree.  The master is for
> mm tree and for-linus is for Linus.  The appropriate patches are

what's the current status of the git trees?  There was some talk about
moving the primary revision control system for the kernel bits over to
git during the 2.6.26 cycle.

> My previous comment was about the patch that affects several subsystem
> / arch changes.  In this case, the change isn't only in the subsystem
> tree.  So, we'd need to cope with others anyway.  Keeping such a patch
> in mm tree separately is one option.

I think that just putting the patches into ALSA is a better bet - it's
more in tune with what most of the other subsystems are doing and it
avoids possible confusion about what's actually made it into -mm.
