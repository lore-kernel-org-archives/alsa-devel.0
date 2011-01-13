From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tegra: Add DAPM widgets/routes for
	Harmony
Date: Thu, 13 Jan 2011 22:38:35 +0000
Message-ID: <20110113223834.GA13717@opensource.wolfsonmicro.com>
References: <1294957328-15869-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 11D8C103B6A
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 23:38:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294957328-15869-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 13, 2011 at 03:22:08PM -0700, Stephen Warren wrote:

> Question: Harmony has a mono mic attached to the left input channel.
> However, the I2S controller only supports stereo. Is it possible to
> duplicate the mic input to both channels in ALSA? I know the WM8903
> can do it via the WM8903_AUDIO_INTERFACE_0 register, but I'm not
> sure how to request that in ALSA-speak. It looks like this same setup
> applies to many other platforms, but I couldn't see how the issue was
> solved, if at all.

It needs implementing it in the CODEC driver, it's not currently
supported as the feature is very rarely used.  I'll add it to the list
to look at, like I say I'm holding off until the merge window closes so
that the clock changes (and hopefully SD card support) get a chance to
merge into the tree and allow things to work out of the box as far as
possible.
