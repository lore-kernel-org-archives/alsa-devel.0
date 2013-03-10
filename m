From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxMC8xMF0gQVNvQzogaW14LXNzaTogQWRkIGlteDI3IGFu?=
 =?UTF-8?B?ZCBwY2ExMDAgRFQgc3VwcG9ydA==?=
Date: Sun, 10 Mar 2013 22:55:26 +0400
Message-ID: <1362941726.17062673@f71.mail.ru>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-11-git-send-email-mpa@pengutronix.de>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1362940391-8338-11-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?B?TWFya3VzIFBhcmdtYW5u?= <mpa@pengutronix.de>
Cc: =?UTF-8?B?RmFiaW8gRXN0ZXZhbQ==?= <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@opensource.wolfsonmicro.com>, =?UTF-8?B?TGlhbSBHaXJkd29vZA==?= <lgirdwood@gmail.com>, =?UTF-8?B?R3JhbnQgTGlrZWx5?= <grant.likely@secretlab.ca>, =?UTF-8?B?U2FzY2hhIEhhdWVy?= <kernel@pengutronix.de>, =?UTF-8?B?U2hhd24gR3Vv?= <shawn.guo@linaro.org>, =?UTF-8?B?VGltdXIgVGFiaQ==?= <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hello.

> Add devicetree bindings for generic imx-ssi support and specifically for
> pca100 with two custom reset functions. At the moment those functions
> are defined in mach-pca100.c. So until DT is the only method for
> booting, the ac97 reset functions have to be exported in mach-pca100.c.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
...
> +		if (of_property_read_bool(pdev->dev.of_node, "imx-ssi-net"))
> +			ssi->flags |= IMX_SSI_NET;

This line does not make sense until the patch is not applied:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/106482.html

---
