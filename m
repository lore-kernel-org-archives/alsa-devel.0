From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: soc-core: Increment codec and
 platform driver refcounts before probing
Date: Fri, 28 Jan 2011 12:58:22 +0000
Message-ID: <20110128125822.GD10350@opensource.wolfsonmicro.com>
References: <1296138262-28113-1-git-send-email-jhnikula@gmail.com>
	<1296138262-28113-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C41892455B
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 13:58:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296138262-28113-3-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 27, 2011 at 04:24:22PM +0200, Jarkko Nikula wrote:
> Commit f6c2ed5 "ASoC: Fix the device references to codec and platform drivers"
> moved codec and platform driver refcount increments from soc_bind_dai_link
> to more appropriate places.
> 
> Adjust a little them so that refcounts are incremented before executing the
> driver probe functions.

Applied, thanks.
