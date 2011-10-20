From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Set sgtl5000->ldo in ldo_regulator_register
Date: Thu, 20 Oct 2011 17:53:38 +0100
Message-ID: <CABS+qY1efSEF1dyqnmcQxg+Y7BmUpynZH2NoUY6Jn4TgF0P-9A@mail.gmail.com>
References: <1319106779.8866.1.camel@phoenix>
	<20111020104943.GA2379@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111020104943.GA2379@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Zeng Zhaoming <zhaoming.zeng@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Dong Aisheng <B29396@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 20 October 2011 11:49, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Oct 20, 2011 at 06:32:59PM +0800, Axel Lin wrote:
>> Otherwise calling ldo_regulator_remove() does not unregister regulator
>> and free memories.
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
>
> BTW I think it is better to CC "Dong Aisheng <B29396@freescale.com>"
> instead of Zeng Zhaoming; he was lately working with sgtl5000.
>
Acked-by: Liam Girdwood <lrg@ti.com>
