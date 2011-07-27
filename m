From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Rename Tegra support to Tegra20?
Date: Wed, 27 Jul 2011 12:47:30 +0100
Message-ID: <20110727114730.GD300@sirena.org.uk>
References: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF989@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4882324380
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 13:47:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF989@HQMAIL01.nvidia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2011 at 03:38:25PM -0700, Stephen Warren wrote:

> * The new drivers I've written use "tegra30" in Kconfig variable names,
> filenames, symbol names, etc. Do you think it's a good idea to rename the
> existing Tegra20 driver to basically s/tegra/tegra20/ everywhere so
> everything is versioned, or do you think that's just unnecessary churn?
> (My motivation is kinda like the device tree compatible properties always
> being versioned)

I guess.  I'd not bother moving the directory, but renaming the files
should be fine.

> * I assume there's little point my posting Tegra30 ASoC drivers for
> inclusion in mainline, since there's no Tegra30 CPU support at all there
> yet?

I don't see a problem with submitting them now.
