From: Fabio Estevam <festevam@gmail.com>
Subject: Re: mx6: Audio does not work on linux-next 20140107
Date: Wed, 8 Jan 2014 08:01:56 -0200
Message-ID: <CAOMZO5C0_aEzSB+fJuyfxCisojUewS9i33kA4-rVB2-NHaFOgw@mail.gmail.com>
References: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
 <52CBEDFA.10603@metafoo.de>
 <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
 <20140107122813.GA6750@MrMyself>
 <CAOMZO5AC5n-intSnUdnBJyYVO2O2BfPYMj_SwNP6jXD5qxVp9g@mail.gmail.com>
 <CAOMZO5DD-SXe9GKdvTEPccJe5rhR4zVNQF=Of1iUsbqrBtAXPg@mail.gmail.com>
 <20140108050431.GD6750@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f173.google.com (mail-ve0-f173.google.com
 [209.85.128.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 323A42619F2
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 11:01:57 +0100 (CET)
Received: by mail-ve0-f173.google.com with SMTP id oz11so1076814veb.32
 for <alsa-devel@alsa-project.org>; Wed, 08 Jan 2014 02:01:56 -0800 (PST)
In-Reply-To: <20140108050431.GD6750@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Wed, Jan 8, 2014 at 3:04 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:

> I think it is impossible to run SDMA without firmware, which stores all
> the scripts we need, including Audio's one. Although the upstream kernel
> doesn't have firmware, the reason why you were able to run audio playback
> is because you have the firmware in your rootfs. So since the driver's
> upgraded, it's plausible for us to upgrade the firmware as well. But I

No, this is not correct.

Please see this commit from Sascha:

commit dcfec3c09890120d86d4e86887074c
76763075ca
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue Aug 20 10:04:32 2013 +0200

    dma: imx-sdma: Add ROM script addresses to driver

    This adds the ROM script addresses for i.MX25, i.MX5x and i.MX6 to the
    SDMA driver needed for the driver to work without additional firmware.

    The ROM script addresses are SoC specific and in some cases even tapeout
    specific. This patch adds the ROM script addresses only for SoCs which
    do not have a tapeout specific SDMA ROM, because currently it's unclear
    how this case should be handled.

    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
    Acked-by: Shawn Guo <shawn.guo@linaro.org>
    Signed-off-by: Vinod Koul <vinod.koul@intel.com>

It allows audio to be played without any additional SDMA firmware.

Please try running 3.13-rc7 without the SDMA firmware and linux-next
without firmware and you will get the difference: 3.13-rc7 will play
the audio just fine, but linux-next will crash the system.

Regards,

Fabio Estevam
