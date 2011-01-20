From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Platform data fixes for
 ASoC driver updates
Date: Thu, 20 Jan 2011 22:15:12 +0000
Message-ID: <1295561712.2870.24.camel@odin>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-4-git-send-email-swarren@nvidia.com>
	<20110120212259.GA21324@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FB63103A8D
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 23:15:16 +0100 (CET)
Received: by wyi11 with SMTP id 11so1111254wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 14:15:16 -0800 (PST)
In-Reply-To: <20110120212259.GA21324@opensource.wolfsonmicro.com>
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

On Thu, 2011-01-20 at 21:22 +0000, Mark Brown wrote:
> On Thu, Jan 20, 2011 at 01:52:10PM -0700, Stephen Warren wrote:
> > The WM8903 driver now needs platform data in order to correctly expose its
> > GPIOs through gpiolib.
> 
> This isn't really a fix - it's enabling a new feature that wasn't
> previously supported, describing it as a fix is misleading as that'd
> suggest it should be applied to the release branch as a bugfix which
> would cause build issues.
> 
> I'm happy with this version of the series, I guess Liam will be too.
> Ideally someone from the Tegra side should sign off on the arch/arm
> side - that'll need to go through the same tree as the ASoC side for
> build dependencies.

I'm happy with this too.

Acked-by: Liam girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
