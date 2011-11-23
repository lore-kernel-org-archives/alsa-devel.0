From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: cs42l51: Clear
 CS42L51_MIC_POWER_CTL_AUTO bit for MODE_SLAVE and MODE_MASTER
Date: Wed, 23 Nov 2011 11:50:19 +0000
Message-ID: <20111123115019.GN21073@opensource.wolfsonmicro.com>
References: <1322023485.6782.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47E71103AF2
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 12:50:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322023485.6782.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@freescale.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 12:44:45PM +0800, Axel Lin wrote:

> Enables the auto-detect circuitry for detecting the speed mode
> of the CODEC when operating as a slave.
> When AUTO is enabled, the MCLK/LRCK ratio must be implemented
> according to Table 3 on page 39. The
> SPEED[1:0] bits are ignored when this bit is enabled.
> Speed is determined by the MCLK/LRCK ratio.

> SPEED[1:0] bits are ignored when this bit is enabled.
> Thus we need to clear this bit for MODE_SLAVE and MODE_MASTER
> because the default of this bit is 1 (Enable).

It's not clear to me that putting the device into manual mode is the
best thing here - if the device can figure things out automatically it
seems like from a defensiveness point of view it'd be better to let it
do that.  According to the above it'll ignore the setting in the
register in slave mode so there's no harm in setting it (and it
simplifies the code) but I don't see a pressing need to actually pay
attention to it if we don't have to.
