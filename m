From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: spdif-dit: Add missing MODULE_*
Date: Fri, 20 May 2011 09:47:38 +0100
Message-ID: <4DD62AAA.90409@ti.com>
References: <1305848686-436-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id E4BA8103A94
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 10:47:43 +0200 (CEST)
In-Reply-To: <1305848686-436-1-git-send-email-swarren@nvidia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 20/05/11 00:44, Stephen Warren wrote:
> MODULE_ALIAS is required so that the module will auto-load based on a
> platform_device registration in the board file.
> 
> While we're at it, add some other MODULE_*.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
