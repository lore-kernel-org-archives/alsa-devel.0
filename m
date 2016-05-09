From: nick83ola <nick83ola@gmail.com>
Subject: Re: Imx6 i2s master driver without i2c
Date: Mon, 9 May 2016 13:17:48 +0200
Message-ID: <CABPh3UN1ZoGAVF1y_5vi_DbkARfopbe5tc5SSy0HQbiYe8MERA@mail.gmail.com>
References: <CABPh3UNhKMGUoiDvHn9paXVNvtpwzbzkbCwBhtSCm72jxkh3CA@mail.gmail.com>
 <CABPh3UMMvVKvHL0g52NqP-E8dpxoZHfwgR_t1WY08OFMSYt9tg@mail.gmail.com>
 <CABPh3UMJ4gOtNN3FJg0fF7Mm+Lpw0=jXGk_+ejsHaGLG9UvWAQ@mail.gmail.com>
 <CABPh3UNi79pMZPgJBisaq9Qo847MV-6riCEQ=Akt_RoLdqeVpw@mail.gmail.com>
 <CABPh3UPLR20WbV0NuYLA4RZ7XB-0+RdFrB-SpDLa0T+wOxqQ+g@mail.gmail.com>
 <CAG5mAdzJyTdsBTnz8FZ8Ay278j1bYJHHqkOTGY+_Ck9sSPhQoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DEC2C2606F5
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 13:18:07 +0200 (CEST)
Received: by mail-lf0-f65.google.com with SMTP id u64so20760710lff.2
 for <alsa-devel@alsa-project.org>; Mon, 09 May 2016 04:18:07 -0700 (PDT)
In-Reply-To: <CAG5mAdzJyTdsBTnz8FZ8Ay278j1bYJHHqkOTGY+_Ck9sSPhQoQ@mail.gmail.com>
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
Cc: support@engicam.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, arnaud.mouiche@invoxia.com
List-Id: alsa-devel@alsa-project.org

Dear Alsa, Caleb and Arnaud

I need to output an i2s master stream from my IMX6 solo board

my board have this configuration for sound: (it have an sgtl5000 codec not
on module, but on dev board)

==========================================================================
sound {
        compatible = "fsl,imx6q-icore-sgtl5000",
                 "fsl,imx-audio-sgtl5000";
        model = "imx6q-icore-sgtl5000";
        ssi-controller = <&ssi1>;
        audio-codec = <&codec>;
        audio-routing =
           "MIC_IN", "Mic Jack",
            "Mic Jack", "Mic Bias",
            "Headphone Jack", "HP_OUT";
        mux-int-port = <2>;
        mux-ext-port = <4>;
    };
&ssi1 {
    fsl,mode = "i2s-master";
    status = "okay";
};

&audmux {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_audmux_4>;
    status = "okay";
};

&iomuxc {
    audmux {
        pinctrl_audmux_4: audmux-4 {
            fsl,pins = <
                MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
                MX6QDL_PAD_DISP0_DAT21__AUD4_TXD 0x110b0
                MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS  0x130b0
                MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
            >;
       };
  };
==========================================================================

I need to output i2s on the same port as sgtl5000, bit in master mode
i've patched sound/soc/soc-utils.c to add support for dts as per arnaud
patch

==========================================================================
#ifdef CONFIG_OF
static const struct of_device_id soc_dummy_ids[] = {
    { .compatible = "linux,snd-soc-dummy", },
    { }
};
MODULE_DEVICE_TABLE(of, soc_dummy_ids);
#endif
...
.of_match_table = of_match_ptr(soc_dummy_ids),
==========================================================================

--> (it is necessary?????? or can I use simple audio card??????


-> i've put this in my dts file

==========================================================================
&audmux {
    ssi3 {
        fsl,audmux-port = <6>;
        fsl,port-config = <
             0x00000000
             IMX_AUDMUX_V2_PDCR_RXDSEL(4)
         >;
     };

     port5 {
         fsl,audmux-port = <4>;
         fsl,port-config = <
             (IMX_AUDMUX_V2_PTCR_TFSDIR |
             IMX_AUDMUX_V2_PTCR_TFSEL(6) |
             IMX_AUDMUX_V2_PTCR_TCLKDIR |
             IMX_AUDMUX_V2_PTCR_TCSEL(6))
             IMX_AUDMUX_V2_PDCR_RXDSEL(6)
         >;
     };
};

&ssi1 {
     status = "disabled";
};

&ssi2 {
     status = "disabled";
};

&ssi3 {
     status = "okay";
     #sound-dai-cells = <0>;
     // select the a clock parent suitable for 48000 Hz sampling rate
     assigned-clocks = <&clks IMX6QDL_CLK_SSI3_SEL>, <&clks
IMX6QDL_CLK_SSI3>;
     assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
     assigned-clock-rates = <0>, <49152000>;
};

/ {
    model = "Engicam i.CoreM6 DualLite/Solo starterkit";
    compatible = "fsl,imx6-icore", "fsl,imx6dl";

    sound{
     status = "disabled";
    };

    sound-itel {
        compatible = "simple-audio-card";
        simple-audio-card,name = "test";
        simple-audio-card,format="dsp_a";
        simple-audio-card,frame-master = <&sound2_ssi>;
        simple-audio-card,bitclock-master = <&sound2_ssi>;
        sound2_ssi: simple-audio-card,cpu {
            sound-dai = <&ssi3>;
            system-clock-frequency = <1536000>;
            dai-tdm-slot-num = <2>;
            dai-tdm-slot-width = <16>;
        };
    };
};
==========================================================================


here's my log

/sound-itel/simple-audio-card,cpu: arguments longer than property
asoc-simple-card sound-itel.31: parse error -22
asoc-simple-card: probe of sound-itel.31 failed with error -22












2016-05-06 17:38 GMT+02:00 Caleb Crome <caleb@crome.org>:

> Hi there,
>    Arnaud had a neat patch here that lets you set up a dummy sound
> card from the DTS.
>
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100896.html
>
> With that patch, you can set up your DTS to simply start streaming, no
> codec or anything required, which should work for a codec with no I2C.
>
>
> Hope that helps,
>   -Caleb
>
>
> On Thu, May 5, 2016 at 12:56 PM, nick83ola <nick83ola@gmail.com> wrote:
> > Hello Alsa dev!
> >
> > Anyone have an example of an i2s only driver for imx6 solo? I need a
> driver
> > without i2c....
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 

P.S. Le informazioni trasmesse attraverso la presente comunicazione sono di
esclusiva
spettanza dell'effettivo destinatario. Nel caso in cui le stesse
raggiungessero, per
qualunque motivo, soggetti non interessati, questi ultimi vorranno darne
immediata
notizia al mittente. In ogni caso, eventuali soggetti diversi dai legittimi
destinatari
della presente comunicazione e dei dati contenuti negli allegati, possono
essere
sanzionati ai sensi del T.U. sul trattamento dei dati personali d.lgs.
196/2003, sia ai
sensi dell'art. 616 del Codice Penale che disciplina la violazione del
segreto sulla
corrispondenza.
