From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: fix PXA SSP port resume
Date: Tue, 2 Feb 2010 11:41:04 +0000
Message-ID: <20100202114103.GJ6566@rakim.wolfsonmicro.main>
References: <1265107888.4194.59.camel@odin>
	<1265107527-15524-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4AEAF103830
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 12:41:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1265107527-15524-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 02, 2010 at 06:45:27PM +0800, Daniel Mack wrote:
> Unconditionally save the register states when suspending and restore
> them again at resume time. Register contents were not preserved over
> suspend, and hence the driver takes false assumptions about them.
> 
> The clock must be enabled to access the register block.

Applied, thanks.
