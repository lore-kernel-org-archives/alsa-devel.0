From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH RFT] ASoC: cs4271: Split SPI and I2C code
 into different modules
Date: Mon, 6 Oct 2014 10:24:08 -0500
Message-ID: <alpine.DEB.2.10.1410061023060.3364@heelrod>
References: <1412608187.4950.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0137.outbound.protection.outlook.com [157.56.111.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 48CB22604A7
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 17:23:45 +0200 (CEST)
In-Reply-To: <1412608187.4950.5.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alexander Sverdlin <subaparts@yandex.ru>
List-Id: alsa-devel@alsa-project.org


On Mon, 6 Oct 2014, Axel Lin wrote:

> Currently the cs4271 driver depends on SND_SOC_I2C_AND_SPI.
> So the driver cannot be built as built-in if CONFIG_I2C=m.
> Split SPI and I2C code into different modules to avoid this issue.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Looks good to me. Thanks Axel!

Acked-by: Brian Austin <brian.austin@cirrus.com>
