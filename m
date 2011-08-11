From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: DAPM: Allow multiple mixer
 sources to be routed via the same switch
Date: Thu, 11 Aug 2011 18:31:42 +0900
Message-ID: <20110811093140.GB18454@opensource.wolfsonmicro.com>
References: <1312948364-2587-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 35BD0243A3
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 11:31:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1312948364-2587-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 10, 2011 at 05:52:41AM +0200, Lars-Peter Clausen wrote:
> Currently it is only possible to route one source per switch into a mixer.
> This patch modifies the code, so that it is possible to route multiple sources
> into a mixer via the same switch. One use-case for this is routing a stereo
> channel pair into a mono-mixer via the same switch.

I'd have thought the dapm_is_shared_control() stuff should handle this?
