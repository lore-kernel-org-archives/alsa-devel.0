From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH 7/8] ASoC: Add SPI support for WM8731
Date: Thu, 4 Sep 2008 11:48:29 +0100
Message-ID: <200809041148.29439.gineera@aspect135.co.uk>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200809031701.46791.gineera@aspect135.co.uk>
	<386072610809031846j18a1534s937a143f66203782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-4.talktalk.net [62.24.128.234])
	by alsa0.perex.cz (Postfix) with ESMTP id A400724367
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 12:42:32 +0200 (CEST)
In-Reply-To: <386072610809031846j18a1534s937a143f66203782@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 04 September 2008 02:46, you wrote:
> On Thu, Sep 4, 2008 at 12:01 AM, Alan Horstmann <gineera@aspect135.co.uk> 
wrote:
> > On Monday 01 September 2008 18:47, Mark Brown wrote:
> >> [Modified to allow runtime selection between I2C and SPI and to select
> >> SPI_MASTER for all codecs build so this is included. -- broonie]
> > What architecture has this SPI code been tested on?  Specifically, what
> > endianess?
>
> We tested on Blackfin machine and it's little-endian.
>
> -Bryan

Thanks, Mark, Bryan.  We are trying this on AT91.  What we see is the 2 bytes 
of the SPI message swapped on the bus (data then address) and I am suspicious 
of this _spi_write function.  As I am in unfamiliar territory, please be 
patient if I am mistaken.  Analysis below...

> >> +static int wm8731_spi_write(struct spi_device *spi, const char *data,
> >> int len) +{
> >> +     struct spi_transfer t;
> >> +     struct spi_message m;
> >> +     u16 msg[2];
> >> +
> >> +     if (len <= 0)
> >> +             return 0;
> >> +
> >> +     msg[0] = (data[0] << 8) + data[1];
> >> +
> >> +     spi_message_init(&m);
> >> +     memset(&t, 0, (sizeof t));
> >> +
> >> +     t.tx_buf = &msg[0];
> >> +     t.len = len;
> >> +
> >> +     spi_message_add_tail(&t, &m);
> >> +     spi_sync(spi, &m);
> >> +
> >> +     return len;
> >> +}

I assume that spi_transfer sends bytes in order, from the tx_buf position, and 
it seems clear that data[0] is the high byte that should go first.  As msg[2] 
is u16 (why?), I would have thought that the byte at &msg[0] would be the low 
byte on LE, high byte on BE so it would only be correct on BE.

Changing the code to use 
	u8 msg[2];
and simply, but explicitly
	msg[0] = data[0];
	msg[1] = data[1];

fixes the problem here.

Comments?

Alan
