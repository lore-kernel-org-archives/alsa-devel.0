From: Caleb Crome <caleb@crome.org>
Subject: Re: Imx6 i2s master driver without i2c
Date: Wed, 11 May 2016 10:34:53 -0700
Message-ID: <CAG5mAdw8oWy38SBzYTKi9DeCS5UzcMNjY5VsFCARp6yDb76cFg@mail.gmail.com>
References: <CABPh3UNhKMGUoiDvHn9paXVNvtpwzbzkbCwBhtSCm72jxkh3CA@mail.gmail.com>
 <CABPh3UMMvVKvHL0g52NqP-E8dpxoZHfwgR_t1WY08OFMSYt9tg@mail.gmail.com>
 <CABPh3UMJ4gOtNN3FJg0fF7Mm+Lpw0=jXGk_+ejsHaGLG9UvWAQ@mail.gmail.com>
 <CABPh3UNi79pMZPgJBisaq9Qo847MV-6riCEQ=Akt_RoLdqeVpw@mail.gmail.com>
 <CABPh3UPLR20WbV0NuYLA4RZ7XB-0+RdFrB-SpDLa0T+wOxqQ+g@mail.gmail.com>
 <CAG5mAdzJyTdsBTnz8FZ8Ay278j1bYJHHqkOTGY+_Ck9sSPhQoQ@mail.gmail.com>
 <CABPh3UN1ZoGAVF1y_5vi_DbkARfopbe5tc5SSy0HQbiYe8MERA@mail.gmail.com>
 <CAG5mAdw1erm=4RjMfP-hf1Vkw73KCWSaLbU3DtditMfsFQNRdQ@mail.gmail.com>
 <CABPh3UN2157eMxwr6i8-vPfdyr3L0DOrpVt7ChTUrPTCbCzCBA@mail.gmail.com>
 <CABPh3UNk9xa=K7QiVV3pZba7o287AyOrjufUGd1QWUxnHNHLOg@mail.gmail.com>
 <CAG5mAdyCAgtFBCbAyLVtqtLgOtCgkB9=yV+YEY8a3oeL2yJDHA@mail.gmail.com>
 <CABPh3UPzP1iFYsy_Ni1fcfimnoVDUWfdn8ht5On_mx0xN1w8Mg@mail.gmail.com>
 <CAG5mAdyceKw_H7zNfx-KTSUUMc81UiLu3feLBcB+vjjjpuhetQ@mail.gmail.com>
 <CABPh3UNPDS+4H60eeL79etF70O0-Xp2T_oNBkYL2m4g6jpeSWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A30B2607C8
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 19:35:13 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id w198so8290148oiw.2
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 10:35:13 -0700 (PDT)
In-Reply-To: <CABPh3UNPDS+4H60eeL79etF70O0-Xp2T_oNBkYL2m4g6jpeSWA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nick83ola <nick83ola@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 10, 2016 at 11:25 PM, nick83ola <nick83ola@gmail.com> wrote:
> What I don't understand is the sequence of init.
> of the driver.
> I think that I need to :
> init dma to transfer from ssi1 (what file???)
> init ssi1 with a clock and a mode (i2s master) (i think fsl_ssi or imx-ssi
> file?? )
> init audmux to put ssi1 (port 1) to port 4 (is a clock needed?) (imx-audmux
> module??)
> init iomux to put port4 output on output pin (I need to set pin direction
> also or is automatic???) (only in dts? what function set that?)
>
> and where those init are? and what file/function does the actual memory
> transfer?
> and ... last how I can check separately all those things??
> I can init ssi for example without audio as a "serial port" and test it???
> or I can Init the output port as gpio and set pins to test if its
> initializated??

In pricipal, but you don't want to mess with the structure that's in place.

>
> How I can read the cpu register back from linux to check that are correctly
> initializated (for example I can read iomux registers????)

Yes, use printk from fsl_ssi.c
For example:

   u32 stcr_val;
   regmap_read(regs, CCSR_SSI_STCR, &stcr_val);
   printk(KERN_INFO "This is the STCR register: 0x%08x\n", strc_val);

There is also a regmap entry in /sys that has your ssi values there,
which can be great for reading all the register values at once.
However, these are really only useful when the port is open.
Generally, I want to see the values are they are written into the
registers so I can see exampley what's going on..

> The documentation/tutorial on alsa driver are very scarse, and freescale
> community is not of help
>
> Thanks for your help
>
> Nicola
>

Yeah, it's all a bit complicated, and I don't understand most of it.
But, the good news is that you shouldn't really have to deal with much
of it.  The SSI is already connected to the DMA and the DMA is
connected to user space, so that's not something you need to worry
about.
The things you need to make sure of is that the pins & audmux & SSI
are configured properly via the device tree, and you shouldn't really
need to do much more than that.

It sounds like you're not getting your TX clock into master mode,
right?  It should start generating a master clock when you start
recording and playing back from your sound card.

For example, looking at the IMX6DQRM.pdf (section 61.8.1.4 among
others), you'll want SSI.TXDIR set to 1 (generate bit clock) and TFDIR
set to 1 (generated frame sync).

The way these bits are set is a bit round-about.  But here goes:

For master mode, (for simple-audio-card anyway), in your DTB you set:

   simple-audio-card,frame-master = <&sound2_ssi>;
   simple-audio-card,bitclock-master = <&sound2_ssi>;

(see here https://github.com/ccrome/linux-caleb-dev/blob/b9bf92b9d9f2121bab38d5e927faa4bc2f80c18c/arch/arm/boot/dts/imx6qdl-wandboard.dtsi).

This tells the simple-audio-card driver (here:
http://lxr.free-electrons.com/source/sound/soc/generic/simple-card.c#L278)
to set the DAI format so that the SSI is master.  This will in turn
call fsl_set_dai_fmt here:
http://lxr.free-electrons.com/source/sound/soc/fsl/fsl_ssi.c#L1044,
which should set the TDDIR and TXDIR bits appropriately.

So, I'd put prink's in fsl_ssi_set_dai_fmt and to see what's actually
getting set, just to check.

Are you successfully getting it set to master mode?

Are you getting a clock?  This is trickier for me since I totally
don't understand how the clock tree stuff works.  But, if you use SSI3
instead of SSI1, my config should work.  Is there any reason you're
using the other SSI?

For me, once I got the audmux directions right, the bits started
flying out of the port (but only when the alsa device is open).

-Caleb
