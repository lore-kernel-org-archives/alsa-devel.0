From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: iMX6 ESAI TDM with underrun and overrun support
Date: Fri, 19 Dec 2014 12:09:28 -0800
Message-ID: <20141219200927.GA7720@Asurada>
References: <20141219092304.GA8780@Asurada>
 <808899317.634005.1418984012568.JavaMail.yahoo@jws11122.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com
 [209.85.160.169])
 by alsa0.perex.cz (Postfix) with ESMTP id C12252604EE
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 21:09:36 +0100 (CET)
Received: by mail-yk0-f169.google.com with SMTP id 79so711065ykr.28
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 12:09:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <808899317.634005.1418984012568.JavaMail.yahoo@jws11122.mail.ir2.yahoo.com>
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

On Fri, Dec 19, 2014 at 10:13:32AM +0000, Aurelien Bouin wrote:
> >I have a bit doubt whether your problem is the underrun or not. Because
> >I remember the work around submitter did test with underrun issue.
> >The reset function would be trigger by the ESAI internal ISR but be called
> >through the ISR from dma callback.
> >
> >
> >There's a fsl_esai_check_xrun() inside the ESAI. You can try to see if
> >it's really underrun happened.

> I also add a dump function that show the register at  fsl_esai_hw_params : ESAI_TCR   0x00728100
> I also add debug in the function fsl_esai_check_xrun that show the saisr register
> When underrun occured (when I see that with an oscilloscope)
> 
> There is no interrupt generated ...

So I suppose your 'no interrupt generated' also means that the
underrun flag has never been set: even if you added check debug
code into the fsl_esai_check_xrun(), it hasn't given you any
feedback.

In that case, I think the channel swap was not resulted from ESAI
hardware FIFO underrun.

> I tried to change the transmit fifo watermak(These bits configure the
> threshold at which the Transmit FIFO Empty flag will set) to set it to a
> value of 2
> Before I was using 64, since I use 64 channels in this case I get a lot of
> underrun interrupt ... and of course it is not working correctly .. Because
> the dma know to late that there is not enough data in the ESAI transmit
> FIFO...

Since you got the underrun error flag after you changed watermark,
that also proves your previous channel swap issue was not trigger
by the underrun issue.

> >And besides, which pins from IOMUX are you using for ESAI?
> I am using TX0, TX1 and RX0, RX1

No, I'm asking the full pin name of IOMUX. Where's the TX0, TX1
come from the IOMUX. You can check you schematics or the pinctrl
configuration in your dts/dtsi to see the name.

Another suggestion is for your mail client setting...please try
to set your mail client to text/plain or auto-wrapping mode. We
basically write code or mail no more than 80 characters per line.

--Nicolin
