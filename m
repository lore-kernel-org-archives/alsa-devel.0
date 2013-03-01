From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: am335x: mcasp in DIT mode
Date: Fri, 1 Mar 2013 11:53:53 +0100
Message-ID: <CAGm1_kt83A2i-ew_gUaySRZpMeuQPEpTvEH_xX9BvfpUKob_Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C9F93265DF0
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 11:54:13 +0100 (CET)
Received: by mail-bk0-f44.google.com with SMTP id j4so1295679bkw.31
 for <alsa-devel@alsa-project.org>; Fri, 01 Mar 2013 02:54:13 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Porter, Matt" <mporter@ti.com>, joelagnel <joelagnel@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

I've solved the problem with DIT/SPDIF mode (see the issue description
here: http://e2e.ti.com/support/arm/sitara_arm/f/791/p/247447/870030.aspx).

In davinci_mcasp_hw_params() the DIT or I2S params will be set in the
beginning. DIT mode configures the DAVINCI_MCASP_TXMASK_REG and
DAVINCI_MCASP_TXFMT_REG.

And here comes the problem:

at the end of davinci_mcasp_hw_params() the
davinci_config_channel_size() will touch the same registers again and
thus overwrite the settings necessary for DIT. After I commented this
routine I got the sound over S/PDIF and sii9022a HDMI transmitter and
I could see the proper bits appearing on my oscilloscope.

What were the best way to solve this problem?

1. execute  davinci_config_channel_size() only if not in DIT mode?
2. for DIT only change the DAVINCI_MCASP_TXMASK_REG according to channel width?
3. execute

if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
                davinci_hw_dit_param(dev);
else
                davinci_hw_param(dev, substream->stream);

after davinci_config_channel_size()

Yegor
