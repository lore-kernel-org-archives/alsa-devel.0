From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tegra: s/IS_ERR_OR_NULL/IS_ERR/ for
	clk_get_sys
Date: Thu, 13 Jan 2011 13:58:36 +0000
Message-ID: <20110113135836.GE11840@opensource.wolfsonmicro.com>
References: <1294775333-8372-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E251103873
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:58:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294775333-8372-1-git-send-email-swarren@nvidia.com>
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

On Tue, Jan 11, 2011 at 12:48:53PM -0700, Stephen Warren wrote:
> A recent discussion on linux-arm-kernel noted that the value returned by
> clk_get_sys is an opaque token, and not strictly a pointer; it is
> meaningful only to the clock API, clients should not dereference the value,
> and the clock API must accept any non-IS_ERR value it returned.

Applied, thanks.
