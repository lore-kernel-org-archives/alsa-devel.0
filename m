From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to
 volatile register list
Date: Fri, 29 Apr 2016 00:41:05 -0300
Message-ID: <CAOMZO5DK2nd+VfkSAgbgByPU+vhY2DG0dsZT_mKtEX+4b+p0Fw@mail.gmail.com>
References: <1461609378-467-1-git-send-email-caleb@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA7A265132
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 05:41:06 +0200 (CEST)
Received: by mail-ig0-f170.google.com with SMTP id m9so9940784ige.1
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 20:41:06 -0700 (PDT)
In-Reply-To: <1461609378-467-1-git-send-email-caleb@crome.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 25, 2016 at 3:36 PM, Caleb Crome <caleb@crome.org> wrote:
> The CCSR_SSI_SOR is a register that clears the TX and/or the RX fifo
> on the i.MX SSI port.  The fsl_ssi_trigger writes this register in
> order to clear the fifo at trigger time.
>
> However, since the CCSR_SSI_SOR register is not in the volatile list,
> the caching mechanism prevented the register write in the trigger
> function.  This caused the fifo to not be cleared (because the value
> was unchanged from the last time the register was written), and thus
> causes the channels in both TDM or simple I2S mode to slip and be in
> the wrong time slots on SSI restart.
>
> This has gone unnoticed for so long because with simple stereo mode,
> the consequence is that left and right are swapped, which isn't that
> noticeable.  However, it's catestrophic in some systems that
> require the channels to be in the right slots.
>
> Signed-off-by: Caleb Crome <caleb@crome.org>
> Suggested-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
