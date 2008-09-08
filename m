From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 7/8] ASoC: Add SPI support for WM8731
Date: Mon, 8 Sep 2008 21:51:06 +0100
Message-ID: <20080908205105.GA32649@sirena.org.uk>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200809041148.29439.gineera@aspect135.co.uk>
	<20080908135201.GA11376@rakim.wolfsonmicro.main>
	<200809082127.13653.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D5B602435D
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 22:51:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809082127.13653.gineera@aspect135.co.uk>
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
Cc: Cliff Cai <cliff.cai@analog.com>, ALSA devel <alsa-devel@alsa-project.org>, Bryan Wu <cooloney@kernel.org>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 08, 2008 at 09:27:13PM +0100, Alan Horstmann wrote:

> Attached and here inline is the small change we applied to ensure the byte 
> order is correct in the _spi_write function.  Note we observed the spi bus 

I take it you're happy to give this your Signed-off-by?

> With just this one change we have been successful in running the codec over 
> spi.  At present we do have an issue with dapm during capture -nothing is 
> being turned on!  Any pointers would be appreciated.

If you define DEBUG when building soc-dapm.c (a define at the top of the
source file will do the trick) then it will be very verbose about the
decisions it's making - that will normally point out the problem.
Probably either one of the input controls is not configured to make a
path from the input pins to the ADC or the input has been mistakenly
marked as disabled.

Otherwise if you post the machine driver and the kernel output with
DEBUG enabled someone might be able to spot something.
