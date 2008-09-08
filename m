From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: Add SPI support for WM8731
Date: Mon, 8 Sep 2008 14:52:01 +0100
Message-ID: <20080908135201.GA11376@rakim.wolfsonmicro.main>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200809031701.46791.gineera@aspect135.co.uk>
	<386072610809031846j18a1534s937a143f66203782@mail.gmail.com>
	<200809041148.29439.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F08D024365
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 15:52:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809041148.29439.gineera@aspect135.co.uk>
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
Cc: Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>, ALSA devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 04, 2008 at 11:48:29AM +0100, Alan Horstmann wrote:

> I assume that spi_transfer sends bytes in order, from the tx_buf position, and 
> it seems clear that data[0] is the high byte that should go first.  As msg[2] 
> is u16 (why?), I would have thought that the byte at &msg[0] would be the low 
> byte on LE, high byte on BE so it would only be correct on BE.

Your analysis makes sense to me.

> Changing the code to use 

...

> fixes the problem here.

Could you supply a patch, please?
