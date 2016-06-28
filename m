From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_ssi: Fix number of words per
 frame for I2S-slave mode
Date: Tue, 28 Jun 2016 11:20:54 -0700
Message-ID: <20160628182053.GA21603@Asurada-Nvidia>
References: <1466830762-31646-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
 [209.85.220.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 962D92657BE
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 20:20:59 +0200 (CEST)
Received: by mail-pa0-f67.google.com with SMTP id us13so2257390pab.1
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 11:20:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466830762-31646-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 25, 2016 at 07:59:22AM +0300, Alexander Shiyan wrote:
> The i.MX51 datasheet says:
> Chapter 56.1.2.4 I2S Mode
> ...
> When I2S modes are entered (I2S master (01) or I2S slave (10)),
> the following settings are recommended:
> ...
> - TX Frame Rate should be 2 i.e. (STCCR[12:8] = 1)
> - RX Frame Rate should be 2 i.e. (SRCCR[12:8] = 1)
> 
> Chapter 56.3.3.12 SSI Transmit and Receive Clock Control Registers (STCCR & SRCCR)
> ...
> Bits 12-8 DC4-DC0
> Frame Rate Divider Control. These bits are used to control the divide ratio
> for the programmable frame rate dividers. The divide ratio works on the word
> clock. In Normal mode, this ratio determines the word transfer rate.
> In Network mode, this ratio sets the number of words per frame. The divide
> ratio ranges from 1 to 32 in Normal mode and from 2 to 32 in Network mode.
> In Normal mode, a divide ratio of 1 (DC=00000) provides continuous periodic
> data word transfer. A bit-length frame sync must be used in this case.
> 
> Function fsl_ssi_hw_params() setup Normal mode for MONO output,
> so with DC=0, SSI enters to continuous periodic data word transfer.
> To fix this, setup DC for any I2S mode.

The change looks fine and didn't show any problem when I tested it.
But I am wondering what's the failed user case here so we need this
patch to fix? (The mono playback works without this patch as well.)

Thanks
Nicolin
