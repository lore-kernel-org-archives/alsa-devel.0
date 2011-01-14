From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tegra: Remove TEGRA_I2S_AUDIO from
 Kconfig
Date: Fri, 14 Jan 2011 11:04:54 +0000
Message-ID: <1295003094.3293.68.camel@odin>
References: <1294957313-15834-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AC7E103B90
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 12:04:57 +0100 (CET)
Received: by wyi11 with SMTP id 11so2684363wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 03:04:57 -0800 (PST)
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
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-13 at 15:21 -0700, Stephen Warren wrote:
> That config variable doesn't exist in the mainline kernel, and hence
> the dependency shouldn't either.
> 
> In linux-tegra-2.6.36, the dependency did exist to avoid a conflict with
> the old non-ALSA Tegra I2S driver. However, this isn't and won't be
> upstreamed.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---

Acked-by Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
