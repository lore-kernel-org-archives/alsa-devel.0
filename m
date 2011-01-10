From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/7] Tegra ALSA/ASoC driver
Date: Mon, 10 Jan 2011 21:47:30 +0000
Message-ID: <1294696050.3416.236.camel@odin>
References: <1294450353-25076-1-git-send-email-swarren@wwwdotorg.org>
	<1294464977-25814-1-git-send-email-swarren@nvidia.com>
	<20110110183558.GF6541@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4A05824632
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 22:48:04 +0100 (CET)
Received: by ewy19 with SMTP id 19so8333121ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 13:48:03 -0800 (PST)
In-Reply-To: <20110110183558.GF6541@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-10 at 18:35 +0000, Mark Brown wrote:
> On Fri, Jan 07, 2011 at 10:36:10PM -0700, Stephen Warren wrote:
> 
> > Stephen Warren (7):
> >   ASoC: Export debugfs root dentry
> >   ASoC: tegra: Add tegra-das driver
> >   ASoC: tegra: Add tegra-pcm driver
> >   ASoC: tegra: Add tegra-i2s driver
> >   ASoC: tegra: Machine utility code
> >   ASoC: tegra: Harmony machine support
> >   ASoC: tegra: Kconfig and Makefile
> 
> This all looks good with the exception of the name of the debugfs root
> symbol and the issues we've previously discussed which I'll work on once
> I get this running on my Harmony.  Don't worry about correcting the
> symbol name if Liam's OK with the rest of the series - it's easier for
> me to do an incremental patch fixing it than re-review.

I've had a quick look and all is fine.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
