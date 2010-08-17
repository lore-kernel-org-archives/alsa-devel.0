From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Multi-component: JZ4740: QI_LB60
	board fixes
Date: Tue, 17 Aug 2010 11:12:05 +0100
Message-ID: <20100817101205.GA21985@rakim.wolfsonmicro.main>
References: <1281887327-9104-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CCBA024456
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 12:12:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281887327-9104-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 15, 2010 at 05:48:47PM +0200, Lars-Peter Clausen wrote:
> This patch contains two small fixes for the sound board driver for the qi_lb60
> introduced by the multi-component patches:
> * Remove unnecessary includes: Those includes where only used to get the
>   definitions for the DAI devices and are thus not needed anymore.
> * Fix a typo.
> 
> Signed-off-By: Lars-Peter Clausen <lars@metafoo.de>

Applied, thanks.
