From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC merge
Date: Tue, 20 Nov 2007 16:56:55 +0000
Message-ID: <20071120165654.GC1744@sirena.org.uk>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910711200659o84d6eebud65150e542b938ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3490624A61
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 17:56:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9e4733910711200659o84d6eebud65150e542b938ba@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: tiwai@suse.de, liam.girdwood@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 09:59:15AM -0500, Jon Smirl wrote:

> In asoc v2 soc-core is changed from being a platform driver into
> subsys_initcall(asoc_bus_init); Is this change going in anytime soon?
> subsys call is the right way, the alsa core is not a platform device.
> This will bring asoc into alignment with i2c which already uses
> subsys_initcall.

I can't give any actual hard timescales for anything but this merge is
a first step on the way to doing that.  My plan was to try to get the
pending ASoC v1 changes merged into mainline so that there is only one
place to keep track of when merging into ASoC v2 development.
