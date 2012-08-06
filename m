From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Mon, 6 Aug 2012 23:33:18 +0000
Message-ID: <CAOZdJXUmgD+GjuvdLMVErYRs7tsGXOxWROi6YGDvf0yHSOBA_w@mail.gmail.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A77D265DD5
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 01:03:36 +0200 (CEST)
In-Reply-To: <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
Content-Language: en-US
Content-ID: <27CC0D038393A14C8658A193B91DF7B3@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "gcembed@gmail.com" <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 6, 2012 at 2:58 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Do you know if mono playback used to work previously in imx-ssi?

I doubt it.  I don't think the I2S standard allows for mono playback,
so the SSI would need to send the same sample twice, and I don't see
any support for that feature in the RM.

When I wrote fsl_ssi, I couldn't find any way to get mono playback to work.

BTW, I can't find the original patch in my inbox or the mailing list
archives.  When was it sent?

-- 
Timur Tabi
Linux kernel developer at Freescale
