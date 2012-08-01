From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Revert "ASoC: core: Try to use regmap if
 the driver doesn't set up any I/O"
Date: Wed, 1 Aug 2012 18:59:55 +0100
Message-ID: <20120801175953.GA4483@opensource.wolfsonmicro.com>
References: <1343829022-23259-1-git-send-email-peter.ujfalusi@ti.com>
 <20120801152248.GZ11892@opensource.wolfsonmicro.com>
 <s5hzk6ed1zr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C5785265D65
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 20:06:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzk6ed1zr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 01, 2012 at 06:13:28PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > No, this isn't constructive - it just shoves things onto the drivers
> > that are relying on the implicit functionality.  Why not just change the
> > criteria we use to check, for example looking for the ops instead?

> Well, the NULL check of dev_get_regmap() looks necessary, but I find
> it was done in a wrong place in Peter's first patch, too.
> It could be rather in the caller side, e.g.

Yes, this is exactly the sort of change I'm talking about above.  We
need to take a better decision about deciding to use regmap for the
device I/O, this seems like a useful input.  Checking for ops should be
even better, though - one could potentially use regmap but want to wrap
it for some reason (can't think of one right now though).

What I *don't* think is a good idea is trying to bodge this in the I/O
code.
