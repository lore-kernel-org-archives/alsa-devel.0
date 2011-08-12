From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [uclinux-dist-devel] [PATCH 3.0]ASoC: ad193x: add
 spi_hw_read, fix sysclk and register definition
Date: Fri, 12 Aug 2011 14:33:38 +0900
Message-ID: <20110812053335.GA13521@opensource.wolfsonmicro.com>
References: <CAHG8p1B2HB61yooEsPwzw+4E60ffM2NUsb98yCsanfPnWD9vgA@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
	<20110811133432.GA6067@kroah.com> <s5hpqkc83o2.wl%tiwai@suse.de>
	<CAHG8p1D8MrLZ6rGHOoc6QiEioYD3nYJftp7AedM2ja5uuWuDRw@mail.gmail.com>
	<s5hhb5nxkmb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F35DF24634
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 07:33:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hhb5nxkmb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <greg@kroah.com>, Scott Jiang <scott.jiang.linux@gmail.com>, "Zhang,
	Sonic" <Sonic.Zhang@analog.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 12, 2011 at 07:30:04AM +0200, Takashi Iwai wrote:
> Scott Jiang wrote:

> > I have a question here that patch for 3.1 and 3.0 is different, who is
> > responsible for the back patch?

> A slight fuzz can be resolved by patch program.  I guess 3.1 patch
> is applicable to 3.0 in your case.

It's not just fuzz, between 3.0 and 3.1 the code was moved into a
completely different file.
