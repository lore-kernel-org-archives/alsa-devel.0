From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
 checking for each DAIs separately
Date: Tue, 30 Aug 2011 02:54:27 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77222AE40@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
	<CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by alsa0.perex.cz (Postfix) with ESMTP id 074AA2437B
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 04:55:52 +0200 (CEST)
In-Reply-To: <CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Tuesday, August 30, 2011 4:35 AM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; lars@metafoo.de; s.hauer@pengutronix.de;
> broonie@opensource.wolfsonmicro.com; w.sang@pengutronix.de; lrg@ti.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [alsa-devel] [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
> checking for each DAIs separately
> 
> On Mon, Aug 29, 2011 at 4:15 AM, Dong Aisheng <b29396@freescale.com>
> wrote:
> > The orginal code does not cover the case that one DAI such as codec
> > may be shared between other two DAIs(CPU).
> 
> Can you give me an example of how this can occur?
> 

Pls check the following case used in mx28evk.
static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
        {
                .name           = "HiFi Tx",
                .stream_name    = "HiFi Playback",
                .codec_dai_name = "sgtl5000",
                .codec_name     = "sgtl5000.0-000a",
                .cpu_dai_name   = "mxs-saif.0",
                .platform_name  = "mxs-pcm-audio.0",
                .ops            = &mxs_sgtl5000_hifi_ops,
        }, {
                .name           = "HiFi Rx",
                .stream_name    = "HiFi Capture",
                .codec_dai_name = "sgtl5000",
                .codec_name     = "sgtl5000.0-000a",
                .cpu_dai_name   = "mxs-saif.1",
                .platform_name  = "mxs-pcm-audio.1",
                .ops            = &mxs_sgtl5000_hifi_ops,
        },
};
You can also refer to:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/129789/focus=129839

Regards
Dong Aisheng
