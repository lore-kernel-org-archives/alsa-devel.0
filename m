From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: tegra_alc5632: Remove unused
	mach-types.h include
Date: Tue, 16 Jul 2013 09:34:20 -0600
Message-ID: <51E567FC.9050804@wwwdotorg.org>
References: <1373972129-13767-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D5AD626500B
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 17:34:24 +0200 (CEST)
In-Reply-To: <1373972129-13767-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 07/16/2013 04:55 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>

Acked-by: Stephen Warren <swarren@nvidia.com>

Don't you see similar issues with:

sound/soc/tegra/trimslice.c:27:#include <asm/mach-types.h>
sound/soc/tegra/tegra_wm8753.c:31:#include <asm/mach-types.h>
sound/soc/tegra/tegra_alc5632.c:16:#include <asm/mach-types.h>
