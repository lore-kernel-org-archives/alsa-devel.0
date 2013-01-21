From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 4/5] ASoC: tegra: Use NULL instead of 0 for
 pointers
Date: Mon, 21 Jan 2013 10:15:10 -0700
Message-ID: <50FD779E.5010800@wwwdotorg.org>
References: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
 <1358760566-3803-5-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id E76F126163F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 18:15:15 +0100 (CET)
In-Reply-To: <1358760566-3803-5-git-send-email-sachin.kamat@linaro.org>
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
> Fixes the following sparse warnings:
> sound/soc/tegra/tegra30_ahub.c:583:16: warning:
> Using plain integer as NULL pointer
> sound/soc/tegra/tegra30_ahub.c:600:16: warning:
> Using plain integer as NULL pointer

Out of curiosity, which compiler is this with; I've never seen this warning.
