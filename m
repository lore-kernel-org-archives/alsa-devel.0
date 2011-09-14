From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: samsung: Fix checking return value of clk_get
Date: Wed, 14 Sep 2011 10:05:55 +0800
Message-ID: <CAF+7xWkkHFA-omWg88bZgZPe_s5aUF--HBOyf8Dr_b7ML-HuFQ@mail.gmail.com>
References: <1315925062.6042.1.camel@phoenix> <20110913151420.GA23782@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110913151420.GA23782@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, Christian Pellegrin <chripell@evolware.org>, Ben Dooks <ben@simtec.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/9/13 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Tue, Sep 13, 2011 at 10:44:22PM +0800, Axel Lin wrote:
>> clk_get() returns a pointer to the struct clk or an ERR_PTR().
>
> Are you sure that the Samsung clock implementation actually does this?
>

Yes.
In arch/arm/Kconfig, all samsung platforms select CLKDEV_LOOKUP.
The implementation of clk_get() in drivers/clk/clkdev.c returns
ERR_PTR() on failure.

Regards,
Axel
