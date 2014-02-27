From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
Date: Thu, 27 Feb 2014 10:06:33 -0600
Message-ID: <530F6289.7030805@tabi.org>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
 <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
 <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140227152332.GA30791@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id ED38126589A
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 17:06:36 +0100 (CET)
In-Reply-To: <20140227152332.GA30791@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, Mark Brown <broonie@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 02/27/2014 09:23 AM, Markus Pargmann wrote:
>>> > >+static const struct regmap_config fsl_ssi_regconfig = {
>>> > >+	.max_register = CCSR_SSI_SACCDIS,
>>> > >+	.reg_bits = 32,
>>> > >+	.val_bits = 32,
>>> > >+	.reg_stride = 4,
>>> > >+#ifdef PPC
>>> > >+	.val_format_endian = REGMAP_ENDIAN_BIG,
>>> > >+#endif
>> >
>> >Is this really needed for your PPC platforms?
> I don't know if this is necessary. I don't have any PPC hardware where I
> could test this driver. This is just a guess how regmap for this driver
> and PPC should look like based on the previous code. So it would be
> great if anyone could test this regmap config on PPC.

I will *try* to test this out.
