From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/7] Tegra ALSA/ASoC driver
Date: Mon, 10 Jan 2011 18:35:58 +0000
Message-ID: <20110110183558.GF6541@sirena.org.uk>
References: <1294450353-25076-1-git-send-email-swarren@wwwdotorg.org>
	<1294464977-25814-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B59FE2458D
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 19:36:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
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

On Fri, Jan 07, 2011 at 10:36:10PM -0700, Stephen Warren wrote:

> Stephen Warren (7):
>   ASoC: Export debugfs root dentry
>   ASoC: tegra: Add tegra-das driver
>   ASoC: tegra: Add tegra-pcm driver
>   ASoC: tegra: Add tegra-i2s driver
>   ASoC: tegra: Machine utility code
>   ASoC: tegra: Harmony machine support
>   ASoC: tegra: Kconfig and Makefile

This all looks good with the exception of the name of the debugfs root
symbol and the issues we've previously discussed which I'll work on once
I get this running on my Harmony.  Don't worry about correcting the
symbol name if Liam's OK with the rest of the series - it's easier for
me to do an incremental patch fixing it than re-review.
