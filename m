From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] ASoC: tegra: Make 'ahub_auxdata' static
Date: Mon, 21 Jan 2013 10:16:30 -0700
Message-ID: <50FD77EE.8030800@wwwdotorg.org>
References: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
 <1358760566-3803-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id A9ABE26163F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 18:16:33 +0100 (CET)
In-Reply-To: <1358760566-3803-4-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, swarren@nvidia.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 01/21/2013 02:29 AM, Sachin Kamat wrote:
> Fixes the following sparse warning:
> sound/soc/tegra/tegra30_ahub.c:302:23: warning:
> symbol 'ahub_auxdata' was not declared. Should it be static?

> diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c

> -struct of_dev_auxdata ahub_auxdata[] = {
> +static struct of_dev_auxdata ahub_auxdata[] = {

This array is being removed from the driver for 3.9 in a patch being
taken through the Tegra tree. As such, please drop this one patch.

The rest look fine to me, so the series,
Reviewed-by: Stephen Warren <swarren@nvidia.com>
