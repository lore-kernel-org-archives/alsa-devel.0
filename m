From: Caleb Crome <caleb@crome.org>
Subject: Re: Imx6 i2s master driver without i2c
Date: Mon, 9 May 2016 10:21:23 -0700
Message-ID: <CAG5mAdw1erm=4RjMfP-hf1Vkw73KCWSaLbU3DtditMfsFQNRdQ@mail.gmail.com>
References: <CABPh3UNhKMGUoiDvHn9paXVNvtpwzbzkbCwBhtSCm72jxkh3CA@mail.gmail.com>
 <CABPh3UMMvVKvHL0g52NqP-E8dpxoZHfwgR_t1WY08OFMSYt9tg@mail.gmail.com>
 <CABPh3UMJ4gOtNN3FJg0fF7Mm+Lpw0=jXGk_+ejsHaGLG9UvWAQ@mail.gmail.com>
 <CABPh3UNi79pMZPgJBisaq9Qo847MV-6riCEQ=Akt_RoLdqeVpw@mail.gmail.com>
 <CABPh3UPLR20WbV0NuYLA4RZ7XB-0+RdFrB-SpDLa0T+wOxqQ+g@mail.gmail.com>
 <CAG5mAdzJyTdsBTnz8FZ8Ay278j1bYJHHqkOTGY+_Ck9sSPhQoQ@mail.gmail.com>
 <CABPh3UN1ZoGAVF1y_5vi_DbkARfopbe5tc5SSy0HQbiYe8MERA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com
 [209.85.214.178])
 by alsa0.perex.cz (Postfix) with ESMTP id A9E6D2654D4
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 19:21:44 +0200 (CEST)
Received: by mail-ob0-f178.google.com with SMTP id aq1so80982071obc.3
 for <alsa-devel@alsa-project.org>; Mon, 09 May 2016 10:21:44 -0700 (PDT)
In-Reply-To: <CABPh3UN1ZoGAVF1y_5vi_DbkARfopbe5tc5SSy0HQbiYe8MERA@mail.gmail.com>
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
Cc: support@engicam.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 9, 2016 at 4:17 AM, nick83ola <nick83ola@gmail.com> wrote:
> Dear Alsa, Caleb and Arnaud
>
> I need to output an i2s master stream from my IMX6 solo board
>
> my board have this configuration for sound: (it have an sgtl5000 codec not
> on module, but on dev board)
>
> ==========================================================================
> sound {
>         compatible = "fsl,imx6q-icore-sgtl5000",
>                  "fsl,imx-audio-sgtl5000";
>         model = "imx6q-icore-sgtl5000";
>         ssi-controller = <&ssi1>;
>         audio-codec = <&codec>;
>         audio-routing =
>            "MIC_IN", "Mic Jack",
>             "Mic Jack", "Mic Bias",
>             "Headphone Jack", "HP_OUT";
>         mux-int-port = <2>;
>         mux-ext-port = <4>;
>     };
> &ssi1 {
>     fsl,mode = "i2s-master";
>     status = "okay";
> };
>
> &audmux {
>     pinctrl-names = "default";
>     pinctrl-0 = <&pinctrl_audmux_4>;
>     status = "okay";
> };
>
> &iomuxc {
>     audmux {
>         pinctrl_audmux_4: audmux-4 {
>             fsl,pins = <
>                 MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
>                 MX6QDL_PAD_DISP0_DAT21__AUD4_TXD 0x110b0
>                 MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS  0x130b0
>                 MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
>             >;
>        };
>   };
> ==========================================================================
>
> I need to output i2s on the same port as sgtl5000, bit in master mode
> i've patched sound/soc/soc-utils.c to add support for dts as per arnaud
> patch
>
> ==========================================================================
> #ifdef CONFIG_OF
> static const struct of_device_id soc_dummy_ids[] = {
>     { .compatible = "linux,snd-soc-dummy", },
>     { }
> };
> MODULE_DEVICE_TABLE(of, soc_dummy_ids);
> #endif
> ...
> .of_match_table = of_match_ptr(soc_dummy_ids),
> ==========================================================================
>
> --> (it is necessary?????? or can I use simple audio card??????
>
>
> -> i've put this in my dts file
>
> ==========================================================================
> &audmux {
>     ssi3 {
>         fsl,audmux-port = <6>;
>         fsl,port-config = <
>              0x00000000
>              IMX_AUDMUX_V2_PDCR_RXDSEL(4)
>          >;
>      };
>
>      port5 {
>          fsl,audmux-port = <4>;
>          fsl,port-config = <
>              (IMX_AUDMUX_V2_PTCR_TFSDIR |
>              IMX_AUDMUX_V2_PTCR_TFSEL(6) |
>              IMX_AUDMUX_V2_PTCR_TCLKDIR |
>              IMX_AUDMUX_V2_PTCR_TCSEL(6))
>              IMX_AUDMUX_V2_PDCR_RXDSEL(6)
>          >;
>      };
> };
>
> &ssi1 {
>      status = "disabled";
> };
>
> &ssi2 {
>      status = "disabled";
> };
>
> &ssi3 {
>      status = "okay";
>      #sound-dai-cells = <0>;
>      // select the a clock parent suitable for 48000 Hz sampling rate
>      assigned-clocks = <&clks IMX6QDL_CLK_SSI3_SEL>, <&clks
> IMX6QDL_CLK_SSI3>;
>      assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
>      assigned-clock-rates = <0>, <49152000>;
> };
>
> / {
>     model = "Engicam i.CoreM6 DualLite/Solo starterkit";
>     compatible = "fsl,imx6-icore", "fsl,imx6dl";
>
>     sound{
>      status = "disabled";
>     };
>
>     sound-itel {
>         compatible = "simple-audio-card";
>         simple-audio-card,name = "test";
>         simple-audio-card,format="dsp_a";
>         simple-audio-card,frame-master = <&sound2_ssi>;
>         simple-audio-card,bitclock-master = <&sound2_ssi>;
>         sound2_ssi: simple-audio-card,cpu {
>             sound-dai = <&ssi3>;
>             system-clock-frequency = <1536000>;
>             dai-tdm-slot-num = <2>;
>             dai-tdm-slot-width = <16>;
>         };
>     };
> };
> ==========================================================================
>
>
> here's my log
>
> /sound-itel/simple-audio-card,cpu: arguments longer than property
> asoc-simple-card sound-itel.31: parse error -22
> asoc-simple-card: probe of sound-itel.31 failed with error -22
>
>
>


Hi Nikola,
   Here is my working setup for a wandboard with no i2c codecs.

https://github.com/ccrome/linux-caleb-dev/blob/v4.5-caleb-wandboard/arch/arm/boot/dts/imx6qdl-wandboard.dtsi

You need to be sure to set up the audmux right.    I'm not sure with
that old kernel if everything with audmux works right or not -- I
haven't tested it.

That should get you pretty close to what you need for your board I suspect.

That branch (v4.5-caleb-wandboard) will build and run the SSI3 port on
AUD5 port, with the mx6 in master mode.  And, with all arnaud's
patches (included already in that repo), it will actually be robust.

-caleb






>
>
>
>
>
>
>
>
>
> 2016-05-06 17:38 GMT+02:00 Caleb Crome <caleb@crome.org>:
>>
>> Hi there,
>>    Arnaud had a neat patch here that lets you set up a dummy sound
>> card from the DTS.
>>
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100896.html
>>
>> With that patch, you can set up your DTS to simply start streaming, no
>> codec or anything required, which should work for a codec with no I2C.
>>
>>
>> Hope that helps,
>>   -Caleb
>>
>>
>> On Thu, May 5, 2016 at 12:56 PM, nick83ola <nick83ola@gmail.com> wrote:
>> > Hello Alsa dev!
>> >
>> > Anyone have an example of an i2s only driver for imx6 solo? I need a
>> > driver
>> > without i2c....
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>
>
> --
>
> P.S. Le informazioni trasmesse attraverso la presente comunicazione sono di
> esclusiva
> spettanza dell'effettivo destinatario. Nel caso in cui le stesse
> raggiungessero, per
> qualunque motivo, soggetti non interessati, questi ultimi vorranno darne
> immediata
> notizia al mittente. In ogni caso, eventuali soggetti diversi dai legittimi
> destinatari
> della presente comunicazione e dei dati contenuti negli allegati, possono
> essere
> sanzionati ai sensi del T.U. sul trattamento dei dati personali d.lgs.
> 196/2003, sia ai
> sensi dell'art. 616 del Codice Penale che disciplina la violazione del
> segreto sulla
> corrispondenza.
