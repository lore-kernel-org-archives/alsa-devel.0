From: Adam Rosenberg <adam@alcorn.com>
Subject: Re: Problem with underrun on new CS42448 x2 driver
Date: Thu, 26 Aug 2010 14:06:43 -0400
Message-ID: <AANLkTinY5mcCPKEJcm+Yru-+7U+nEWe+VaWL558UhhrB@mail.gmail.com>
References: <AANLkTi=3kc74QqDopiAw+u8ie2Qn47p9XQpw54b6iB4Z@mail.gmail.com>
	<20100826124757.GC5721@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 94C1E24AB5
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 20:06:48 +0200 (CEST)
Received: by vws20 with SMTP id 20so1973110vws.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 11:06:45 -0700 (PDT)
In-Reply-To: <20100826124757.GC5721@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mike Frysinger <vapier@gentoo.org>, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

Mark,

Thank you for the reply.  I emailed Barry Song on July 30th to request some
help moving to the new ASoC standards but received no response.

I began writing this driver on the Blackfin uClinux 2009 release and based
it on the AD1836 and AD1938 drivers.  I am now using the Blackfin SVN trunk
and have found that the driver model was changed to ASoC.  It is not
apparent how I would create a driver that supports two chips off of the same
SPORT using the ASoC framework.

The best I could do was use the same SPORT driver that the ASoC code uses
(bf5xx-sport.c) so that I was at least up-to-date in that area.  I had to
modify that driver so that it would support the secondary data lines of the
SPORT.  I found that the driver did not function well in 2D DMA mode so I
have to keep my period size below 64kb.  There is also a problem with
starting Rx and Tx that causes the DMA data to be placed into the SPORT
multichannel window incorrectly.  I added a function to the SPORT driver
yesterday that can work around this problem by starting both Rx and Tx as
normal then stopping the SPORT and restarting it like this:

int sport_start_both(struct sport_device *sport)
{
    sport_tx_start(sport);
    msleep(1);  // is this needed?
    sport_rx_start(sport);
    msleep(1);  // is this needed?
    sport_stop(sport);
    msleep(1);  // is this needed?
    sport_start(sport);
    return 0;
}
EXPORT_SYMBOL(sport_start_both);

This ensures that the data from the DMA buffer is properly loaded into the
SPORT multichannel window for both the Rx and Tx data lines.  If it is not
done this way it seems that one of them is always being filled incorrectly.
This may have sometime to do with the fact that I have to enable the
secondary data lines but there is no clear explanation for why that would
have an effect.

I have not entered any constraints into the driver because there really
should be no need.  The driver just copies whatever PCM data that is
provided directly to the DMA buffer.  It seems that the problem occurs
because the location to copy to is based on the pos suggested by the
callback function.  I am still finding it difficult to tell how ALSA decides
there is an underrun or overrun.  I am definitely trying to read or write
the pcm data fast enough but it seems as though I get these errors anyway.

Questions:
1.  How do I implement an ASoC-style driver that supports multiple chips
when they are connected to the same SPORT but use different SPI chip
selects?
2.  How do I define the proper buffer/period size constraints or should I
ignore the suggested position during copy operations and just keep track of
the position within the DMA buffer myself?
3.  Can you suggest a good way to debug underrun/overrun problems?

Thank you,
Adam

Adam Rosenberg
Software Engineer

Alcorn McBride Inc.
3300 South Hiawassee
Building 105
Orlando, FL 32835

(407) 296 - 5800 ext. 5490
