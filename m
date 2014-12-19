From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: iMX6 ESAI TDM with underrun and overrun support
Date: Fri, 19 Dec 2014 01:23:05 -0800
Message-ID: <20141219092304.GA8780@Asurada>
References: <20141217233623.GA3152@Asurada>
 <938681467.624323.1418893243288.JavaMail.yahoo@jws11102g.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f180.google.com (mail-yk0-f180.google.com
 [209.85.160.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 569042606A4
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 10:23:14 +0100 (CET)
Received: by mail-yk0-f180.google.com with SMTP id 9so197601ykp.39
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 01:23:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <938681467.624323.1418893243288.JavaMail.yahoo@jws11102g.mail.ir2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aurelien Bouin <a_bouin@yahoo.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 18, 2014 at 09:00:43AM +0000, Aurelien Bouin wrote:
> Yes and No.
> It supports up to 32 words (slots) per period on each transmit line, in the limit of 128 words (FIFO limitations)
> My reference is in the Reference Manual of the iMX6 "26.1.1 Features" in the ESAI chapter
> 
> FYI in the fsl_esai.c you can find how multiples lines and slots are handled : 
> -> fsl_esai_hw_params : u32 pins = DIV_ROUND_UP(channels, esai_priv->slots);
> Then it will enable the number of hardware pins used in transmit and receive mode with TFCR or RFCR :
> val = ESAI_xFCR_xWA(width) | ESAI_xFCR_xFWM(esai_priv->fifo_depth) |
> (tx ? ESAI_xFCR_TE(pins) | ESAI_xFCR_TIEN : ESAI_xFCR_RE(pins));

> I first apply the patch on my kernel I am currently using 64 channels (32 slots of 8bits width on 2 transmits pins)
> 
> But for example you can use up to 6 transmits pins with a configuration of 2 slots of 16 bits width and 12 channels ask in alsa ...

Ah, I forgot you could use several pins....

> >http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git
> I already tried the branches :
> imx_3.10.31_1.1.0_alpha
> imx_3.10.31_1.1.0_beta2
> They implemented a fsl_reset function somewhere ... but it is never called ... and the problem persist ...

I have a bit doubt whether your problem is the underrun or not. Because
I remember the work around submitter did test with underrun issue.
The reset function would be trigger by the ESAI internal ISR but be called
through the ISR from dma callback.

There's a fsl_esai_check_xrun() inside the ESAI. You can try to see if
it's really underrun happened.

And besides, which pins from IOMUX are you using for ESAI?

--Nicolin
