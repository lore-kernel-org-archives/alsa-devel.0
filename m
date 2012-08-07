From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 08:45:27 -0300
Message-ID: <CAOMZO5A4dmM7u98378famhRFnvXkwwgE3y+FPj1d_Ma=2jPoJw@mail.gmail.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <20120807062623.GD1451@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA7F265204
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 13:15:42 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so6718042obb.38
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 04:45:27 -0700 (PDT)
In-Reply-To: <20120807062623.GD1451@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel@pengutronix.de, gcembed@gmail.com
List-Id: alsa-devel@alsa-project.org

Sascha,

On Tue, Aug 7, 2012 at 3:26 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> AFAIK only stereo works with the mc13783.

Ok, could you please let me know what do you think about my patch? It
does the same thing as in fsl_ssi.c by setting channels_min to 2 and I
am interested to know if this is an acceptable change.

Thanks,

Fabio Estevam
