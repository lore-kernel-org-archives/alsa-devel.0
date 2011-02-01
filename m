From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Tegra: Harmony: Remove redundant !!
Date: Tue, 1 Feb 2011 14:14:08 +0000
Message-ID: <20110201141407.GH12743@opensource.wolfsonmicro.com>
References: <1296496817-10128-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7B6D103918
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:14:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296496817-10128-1-git-send-email-swarren@nvidia.com>
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

On Mon, Jan 31, 2011 at 11:00:17AM -0700, Stephen Warren wrote:
> gpio_set_value* should accept logic values not just 0 or 1. The WM8903 GPIO
> driver has been fixed to work this way, so remove the redundant !!
> previously required when it didn't accept values >1.

Applied thanks.
