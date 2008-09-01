From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASOC: WM8731 codec: add SPI support	as
	well as I2C
Date: Mon, 1 Sep 2008 15:02:27 +0100
Message-ID: <20080901140227.GA17103@rakim.wolfsonmicro.main>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<1219829968-6431-4-git-send-email-cooloney@kernel.org>
	<200809011452.08070.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C67AD24412
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 16:02:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809011452.08070.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: liam.girdwood@wolfsonmicro.com, Bryan Wu <cooloney@kernel.org>, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 01, 2008 at 02:52:08PM +0100, Alan Horstmann wrote:

> in order to force use of SPI when (CONFIG_SND_SOC_WM8731_SPI) and (CONFIG_I2C) 
> are both defined.  Or have we misunderstood the intention?  This is in 2 
> other places also in the patch.

I've reworked the patch to allow a single kernel image to support both
I2C and SPI which sidesteps this problem.  I'll post this later today.
