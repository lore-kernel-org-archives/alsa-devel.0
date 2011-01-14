From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tegra: Remove TEGRA_I2S_AUDIO from
	Kconfig
Date: Fri, 14 Jan 2011 12:32:49 +0000
Message-ID: <20110114123249.GE20846@opensource.wolfsonmicro.com>
References: <1294957313-15834-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F9B5103BAB
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 13:32:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294957313-15834-1-git-send-email-swarren@nvidia.com>
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

On Thu, Jan 13, 2011 at 03:21:53PM -0700, Stephen Warren wrote:
> That config variable doesn't exist in the mainline kernel, and hence
> the dependency shouldn't either.
> 
> In linux-tegra-2.6.36, the dependency did exist to avoid a conflict with
> the old non-ALSA Tegra I2S driver. However, this isn't and won't be
> upstreamed.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied, thanks.
