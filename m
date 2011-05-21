From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: spdif-dit: Add missing MODULE_*
Date: Sat, 21 May 2011 19:11:42 +0800
Message-ID: <20110521111140.GA25641@opensource.wolfsonmicro.com>
References: <1305848686-436-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 86A7E103865
	for <alsa-devel@alsa-project.org>;
	Sat, 21 May 2011 13:11:41 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 19, 2011 at 05:44:46PM -0600, Stephen Warren wrote:
> MODULE_ALIAS is required so that the module will auto-load based on a
> platform_device registration in the board file.
> 
> While we're at it, add some other MODULE_*.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
