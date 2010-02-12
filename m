From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fix compile breakage if
 CONFIG_SH_DMA_API=y && CONFIG_SND_SIU_MIGOR!=n
Date: Fri, 12 Feb 2010 10:22:02 +0000
Message-ID: <20100212102202.GA16988@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.64.1002111809250.4484@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 985E324451
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 11:22:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1002111809250.4484@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 11, 2010 at 06:11:10PM +0100, Guennadi Liakhovetski wrote:
> Audio on Migo-R cannot work if CONFIG_SH_DMA_API=y, but compilation should not
> break anyway.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
