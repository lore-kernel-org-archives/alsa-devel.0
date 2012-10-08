From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: imx: clk: Split SSI clock into
 'ipg' and 'per'
Date: Mon, 8 Oct 2012 20:47:22 -0300
Message-ID: <CAOMZO5ACVeMwGcjSXcEqyHMc9G3KgyrL-uC=wvjmf1AQOAhgWQ@mail.gmail.com>
References: <1349725213-11354-1-git-send-email-fabio.estevam@freescale.com>
 <20121008214452.GA27665@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FAE82651DC
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 01:47:23 +0200 (CEST)
Received: by mail-oa0-f51.google.com with SMTP id n12so4317036oag.38
 for <alsa-devel@alsa-project.org>; Mon, 08 Oct 2012 16:47:22 -0700 (PDT)
In-Reply-To: <20121008214452.GA27665@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, gcembed@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Sascha,

On Mon, Oct 8, 2012 at 6:44 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> I am not sure it's good to work around that issue in the ssi driver. We
> could also just enable the clock in the clk driver as it seems to be a
> ccm related issue.

Yes, it would be better if we could fix this in clk-imx27 instead, but
I was not able to provide such fix yet.

Regards,

Fabio Estevam
