From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [RESEND][PATCH v5 4/4] ASoC: SAMSUNG: Add
	I2S0	internal dma driver
Date: Mon, 18 Jul 2011 18:17:04 +0900
Message-ID: <026701cc452b$75f51cd0$61df5670$@com>
References: <1310533191-31645-1-git-send-email-sbkim73@samsung.com>
	<CABb+yY01c9WMfuGYpHZhAAvYiz=FH9bioQ=3Y4ioz7kz=9G3pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E6F324141
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 11:17:12 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LOI006V8V4DS3R0@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 18 Jul 2011 18:17:05 +0900 (KST)
Received: from DOSBKIM7301 ([12.23.119.77])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LOI001YBV4H9W@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 18 Jul 2011 18:17:05 +0900 (KST)
In-reply-to: <CABb+yY01c9WMfuGYpHZhAAvYiz=FH9bioQ=3Y4ioz7kz=9G3pQ@mail.gmail.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jassi Brar' <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,
On Mon, July 18, 2011 at 4:38 PM, Jassi Brar wrote: 
> On Wed, Jul 13, 2011 at 10:29 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> > I2S in Exynos4 and S5PC110(S5PV210) has a internal dma.
> > It can be used low power audio mode and 2nd channel transfer.
> > This patch can support idma.
> >
> > Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> > ---
> > V2: change idma_new by new pcm_new api
> >    add handling different idma address
> >    as jassi comments, Modify the idma driver
> >
> > V3: merge idma_reg_int and idma_addr_init
> >
> > V4: move idma setting in i2s.c to idma_hw_params in idma.c
> >    move idma_reg_addr_init calling
> >    modify idma address handling error
> >    modify module information
> >    delete useless dev_dbg
> >
> > V5: delete redundant error print and check routine
> >    modify irq handler as jassi comment
> >    fix the indent error
> >    modify period_bytes_max value to set half size of max buffer
> 
> Perhaps you forgot to mention the reason for resend ?
Sorry, I changed MAX_IDMA_BUFFER value (128KB)
Because I used wrong MAX_IDMA_BUFFER value.

Thanks 
SB Kim
