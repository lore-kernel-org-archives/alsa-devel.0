From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 01/10] imx-ssi: Fix AC97 rates
Date: Wed, 13 Mar 2013 17:55:24 -0500
Message-ID: <CAOZdJXXm=jJv3zyD4j11t3BgNGyKz6V9jzShQLTk-BTiwDjvMg@mail.gmail.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
 <CAOMZO5A8F81PzCjKHrkZ_AtGMr341d6OmYHMQvdzgunmGFDVsw@mail.gmail.com>
 <20130311195108.GC18350@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130311195108.GC18350@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 11, 2013 at 2:51 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
>
> At the moment fsl-ssi and imx-ssi don't seem to have very much in
> common. However I could try to merge the imx-ssi driver code into
> fsl_ssi and make it handle imx27-ssi differently.

imx-ssi is the legacy driver that supports older, non-DT IMX platforms.
fsl-ssi is the "new" driver that supports PowerPC and IMX DT-enabled platforms.

-- 
Timur Tabi
Linux kernel developer at Freescale
