From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH v3 1/1] ASoC: mxs-saif: add record function
Date: Thu, 8 Sep 2011 22:29:12 +0100
Message-ID: <CABS+qY12ChK=aA-eOERH5ATWKcQdp3wE48SsBNcpe0nDzXWOMw@mail.gmail.com>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AD03103A7D
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 23:29:20 +0200 (CEST)
Received: by qyk2 with SMTP id 2so738992qyk.15
	for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2011 14:29:12 -0700 (PDT)
In-Reply-To: <1315399910-6525-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 7 September 2011 13:51, Dong Aisheng <b29396@freescale.com> wrote:

> 1. add different clkmux mode handling
> SAIF can use two instances to implement full duplex (playback &
> recording) and record saif may work on EXTMASTER mode which is
> using other saif's BITCLK&LRCLK.
>
> The clkmux mode could be set in pdata->init() in mach-specific code.
> For generic saif driver, it only needs to know who is his master
> and the master id is also provided in mach-specific code.
>
> 2. support playback and capture simutaneously however the sample
> rates can not be different due to hw limitation.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
>
> ---
> Changes since v2:
>  * remove mach-specific code(clkmux in DIGCTL) out of saif driver
>  For supporting EXTMASTER mode, SAIF only nees to know who's
>  its master and the master id is provided by mach layer according
>  to different clkmux setting.
>  So we need to add a pdata->get_master_id();
>
> Changes since v1:
>  * calc the delay based on the rate
>  * change the saif.h #ifndef micro to match the directory
> ---
>  include/sound/saif.h     |   16 +++++
>  sound/soc/mxs/mxs-saif.c |  145
> +++++++++++++++++++++++++++++++++++++++++-----
>  sound/soc/mxs/mxs-saif.h |    4 +
>  3 files changed, 151 insertions(+), 14 deletions(-)
>
>
Acked-by Liam Girdwood <lrg@ti.com>
