From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/7] WM8580 updates
Date: Mon, 16 Aug 2010 15:49:55 +0100
Message-ID: <20100816144954.GD3276@rakim.wolfsonmicro.main>
References: <20100813193305.GB3778@sirena.org.uk>
	<AANLkTinjBpbdJNVyszADoLzkYA_r7jmbaHJC8gNLVGCH@mail.gmail.com>
	<AANLkTikh_WFPc-M6pFaC-n91aCzQPvH9YaTnwjwOg6ap@mail.gmail.com>
	<20100815111043.GB25723@opensource.wolfsonmicro.com>
	<AANLkTik-vDfN39HT-yiO1hgp7rzhgk_=gw-=MiuE+3w=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4C61243F0
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 16:49:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTik-vDfN39HT-yiO1hgp7rzhgk_=gw-=MiuE+3w=@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 16, 2010 at 06:44:28PM +0900, Seungwhan Youn wrote:
> On Sun, Aug 15, 2010 at 8:10 PM, Mark Brown

>  - CPU board Rev. 1.0
>  - Base board Rev. 1.0 (2008.07.23)

> Board switch settings

>  - Base board
>     - CFG1 - 0000 (all off)
>     - CFG2 - 1000 (only 1 pin is on, others off)

Hrm, I have CFG2 all on.  Why would I want a mixed configuration?

>     - CFG5 - set I2SMULTI_CDCLK (pin 1-2 connected)

I have pins 2 and 3 connected (which was the board default as shipped)
but this does sound like it might be relevant.  Unfortunately I don't
have a schematic for the R1.0 base board so I can't comment on this
configuration.  If you could supply me with an updated schematic that'd
be great.

> [root@Samsung ~]# arecord -Dhw:0,1 -d5 -fS16_LE -r48000 -c2 >

-f dat might be easier here FWIW.  Once the S3C CPU has started
reporting errors it tends not to recover terribly well so any further
tests you've done without a reboot are a bit suspect.
