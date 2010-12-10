From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
Date: Fri, 10 Dec 2010 15:07:58 +0000
Message-ID: <20101210150758.GE3200@rakim.wolfsonmicro.main>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1291855051.31916.85.camel@r60e>
	<20101209105443.GA4469@rakim.wolfsonmicro.main>
	<1291897061.31916.149.camel@r60e>
	<20101209123457.GD4469@rakim.wolfsonmicro.main>
	<1291929258.16839.17.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E815024519
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 16:08:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291929258.16839.17.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 10, 2010 at 12:14:18AM +0300, Alexander wrote:

> BTW, it's how original Cirrus's sound driver had done it's work. Cirrus
> programmers had not found a way to overcome this. The datasheets for
> EP93xx series cover everything only briefly... The dumbness of EP93xx's
> DMA is also the reason why we do not have DMA in serial ports and SSP...

> The function I'm talking about is snd_ep93xx_dma2usr_ratio(), as told in
> comments "For audio playback, we convert samples of arbitrary format to
> be 32 bit for our hardware".

This doesn't really answer any of my technical questions about what's
going on here.

Please resubmit with a changelog explaining what the limitations are on
both sides (DMA seems clear but the I2S also needs to be covered) and
makes it clear why the functionality is being reduced like this.  This
will ensure that users understand why the change has been made - right
now it looks like a serious functionality regression is being
introduced so we really should make it clear why this is being done.
