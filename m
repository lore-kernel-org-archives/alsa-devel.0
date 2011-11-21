From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove redundant regcache_sync call
 in cs42l73_resume
Date: Mon, 21 Nov 2011 17:06:36 +0000
Message-ID: <20111121170635.GC20478@opensource.wolfsonmicro.com>
References: <1321681534.4414.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 86841103904
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 18:06:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321681534.4414.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 19, 2011 at 01:45:34PM +0800, Axel Lin wrote:
> It's done in cs42l73_set_bias_level when the dapm.bias_level is switching
> from SND_SOC_BIAS_OFF to SND_SOC_BIAS_STANDBY.

Applied, thanks.
