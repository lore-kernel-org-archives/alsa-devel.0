From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: Fix build dependency for
	SND_SOC_JZ4740_CODEC
Date: Tue, 6 Dec 2011 11:01:56 +0000
Message-ID: <20111206110156.GI28840@opensource.wolfsonmicro.com>
References: <1323157131.22557.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF73F2413A
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 12:01:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323157131.22557.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 06, 2011 at 03:38:51PM +0800, Axel Lin wrote:
> Currently SND_SOC_JZ4740_CODEC depends on SOC_JZ4740 but SOC_JZ4740 is not
> defined in any Kconfig. Thus the codec driver will not be built when select
> "Build all ASoC CODEC drivers". 

Applied, thanks.
