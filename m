From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] ASoC: rt5640: Power down LDO while
	suspended
Date: Wed, 16 Oct 2013 11:47:34 -0600
Message-ID: <525ED136.9040605@wwwdotorg.org>
References: <1381941215-29031-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 2608F26522D
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 19:47:39 +0200 (CEST)
In-Reply-To: <1381941215-29031-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 10/16/2013 10:33 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> If we have control over the LDO then disable it during suspend; the device
> is already being put into reset so will be non-functional over suspend
> anyway and this will save a small amount of power.

The series,
Tested-by: Stephen Warren <swarren@nvidia.com>

On Tegra Beaver and Dalmore boards. As you may have noticed, Tegra audio
doesn't work after resume at the moment, but that's true irrespective of
these patches, and I believe is a problem without our DMA or I2S
drivers, and nothing to do with the CODEC. The CODEC certainly still
responds to I2C accesses (e.g. triggered by alsamixer) after this patch,
and wouldn't if the LDO1_EN GPIO wasn't correctly set.
