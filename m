From: nick83ola <nick83ola@gmail.com>
Subject: Re: Imx6 i2s master driver without i2c
Date: Tue, 10 May 2016 17:28:07 +0200
Message-ID: <CABPh3UNk9xa=K7QiVV3pZba7o287AyOrjufUGd1QWUxnHNHLOg@mail.gmail.com>
References: <CABPh3UNhKMGUoiDvHn9paXVNvtpwzbzkbCwBhtSCm72jxkh3CA@mail.gmail.com>
 <CABPh3UMMvVKvHL0g52NqP-E8dpxoZHfwgR_t1WY08OFMSYt9tg@mail.gmail.com>
 <CABPh3UMJ4gOtNN3FJg0fF7Mm+Lpw0=jXGk_+ejsHaGLG9UvWAQ@mail.gmail.com>
 <CABPh3UNi79pMZPgJBisaq9Qo847MV-6riCEQ=Akt_RoLdqeVpw@mail.gmail.com>
 <CABPh3UPLR20WbV0NuYLA4RZ7XB-0+RdFrB-SpDLa0T+wOxqQ+g@mail.gmail.com>
 <CAG5mAdzJyTdsBTnz8FZ8Ay278j1bYJHHqkOTGY+_Ck9sSPhQoQ@mail.gmail.com>
 <CABPh3UN1ZoGAVF1y_5vi_DbkARfopbe5tc5SSy0HQbiYe8MERA@mail.gmail.com>
 <CAG5mAdw1erm=4RjMfP-hf1Vkw73KCWSaLbU3DtditMfsFQNRdQ@mail.gmail.com>
 <CABPh3UN2157eMxwr6i8-vPfdyr3L0DOrpVt7ChTUrPTCbCzCBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F736261600
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 17:28:27 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id m101so1643192lfi.1
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 08:28:27 -0700 (PDT)
In-Reply-To: <CABPh3UN2157eMxwr6i8-vPfdyr3L0DOrpVt7ChTUrPTCbCzCBA@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

enabling kernel debug on all modules it says:

sound/soc/fsl/imx-pcm-fiq.c:226 [imx_pcm_fiq]snd_imx_pcm_mmap =_ "%s: ret:
%d %p 0x%08x 0x%08x\012"
sound/soc/fsl/fsl_ssi.c:1289 [snd_soc_fsl_ssi]fsl_ssi_imx_probe =_ "could
not get baud clock: %ld\012"
sound/soc/fsl/imx-audmux.c:333 [snd_soc_imx_audmux]imx_audmux_probe =p
"cannot get clock: %ld\012"
sound/soc/generic/simple-card.c:180
[snd_soc_simple_card]asoc_simple_card_parse_of =p "card-name : %s\012"
sound/soc/generic/simple-card.c:181
[snd_soc_simple_card]asoc_simple_card_parse_of =p "platform : %04x\012"
sound/soc/generic/simple-card.c:185
[snd_soc_simple_card]asoc_simple_card_parse_of =p "cpu : %s / %04x / %d\012"
sound/soc/generic/simple-card.c:189
[snd_soc_simple_card]asoc_simple_card_parse_of =p "codec : %s / %04x /
%d\012"
sound/soc/generic/simple-card.c:33
[snd_soc_simple_card]__asoc_simple_card_dai_init =p "ASoC: set_fmt is not
supported\012"

2016-05-10 16:57 GMT+02:00 nick83ola <nick83ola@gmail.com>:

> Hello Caleb
> thanks for your help
>
> Here's my current dts
> I want to use ssi1 on port 4
> I added #sound-dai-cells = <0>; on ssi1 because simple card complaijning
> about it (what is that?? I could not find documentation about it)
>
> Now the driver says:
>  asoc-simple-card sound.26: snd-soc-dummy-dai <-> 2028000.ssi mapping ok
>
> and
>
> > aplay -l
>
> **** List of PLAYBACK Hardware Devices ****
> card 0: D2028000ssisnds [2028000.ssi-snd-soc-dummy-dai], device 0:
> 2028000.ssi-snd-soc-dummy-dai snd-soc-dummy-dai-0 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>
> > aplay -L
>
> null
>     Discard all samples (playback) or generate zero samples (capture)
> sysdefault:CARD=D2028000ssisnds
>     2028000.ssi-snd-soc-dummy-dai,
>     Default Audio Device
>
> but if I try to play a file it hangs and nothing escape
>
> How I can debug the various modules? ssi, dma, ???
>
> how I can print debug messages?? (i cannot see the various dev_dbg no
> matter what I try...)
>
>
> ==================================================================
> /dts-v1/;
>
> #include <dt-bindings/gpio/gpio.h>
> #include <dt-bindings/sound/fsl-imx-audmux.h>
>
> #include "imx6dl.dtsi"
> #include "imx6qdl-icore.dtsi"
>
> #define SSI_TEST_MASTER
> /*
>  * port 4 is datasheet port 5 (aud5)
>  * port 6 is datasheet port 7 (ssi3)
>  */
> #define AUDMUX_EXT_PORT 3
> #define AUDMUX_INT_PORT 0
> #define AUDMUX_INT_PORT_NAME port4
>
> &audmux {
> /*    pinctrl-names = "default";
>     pinctrl-0 = <&pinctrl_audmux_4>;*/
>     status = "okay";
> };
>
> &ssi1 {
>     #sound-dai-cells = <0>;
>     pinctrl-names = "default";
>     pinctrl-0 = <&pinctrl_audmux_4>;
>
>     // select the a clock parent suitable for 48000 Hz sampling rate
>     assigned-clocks = <&clks IMX6QDL_CLK_SSI1_SEL>, <&clks
> IMX6QDL_CLK_SSI1>;
>     assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
>     assigned-clock-rates = <0>, <49152000>;
>     fsl,mode = "i2s-master";
>     status = "okay";
> };
>
> &audmux {
>     status = "okay";
>
>     ssi1 {
>         fsl,audmux-port = <AUDMUX_INT_PORT>;
>         fsl,port-config = <
> #ifdef SSI_TEST_MASTER
>             IMX_AUDMUX_V2_PTCR_SYN
> #else
>             (IMX_AUDMUX_V2_PTCR_TFSDIR |
>             IMX_AUDMUX_V2_PTCR_TFSEL(AUDMUX_EXT_PORT) |
>             IMX_AUDMUX_V2_PTCR_TCLKDIR |
>             IMX_AUDMUX_V2_PTCR_TCSEL(AUDMUX_EXT_PORT) |
>             IMX_AUDMUX_V2_PTCR_SYN
>             )
> #endif
>             IMX_AUDMUX_V2_PDCR_RXDSEL(AUDMUX_EXT_PORT)
>         >;
>     };
>
>     AUDMUX_INT_PORT_NAME {
>         fsl,audmux-port = <AUDMUX_EXT_PORT>;
>         fsl,port-config = <
> #ifdef SSI_TEST_MASTER
>             (IMX_AUDMUX_V2_PTCR_TFSDIR |
>             IMX_AUDMUX_V2_PTCR_TFSEL(AUDMUX_INT_PORT) |
>             IMX_AUDMUX_V2_PTCR_TCLKDIR |
>             IMX_AUDMUX_V2_PTCR_TCSEL(AUDMUX_INT_PORT) |
>             IMX_AUDMUX_V2_PTCR_SYN
>             )
> #else
>             IMX_AUDMUX_V2_PTCR_SYN
> #endif
>             IMX_AUDMUX_V2_PDCR_RXDSEL(AUDMUX_INT_PORT)
>         >;
>     };
> };
>
>
> / {
>     model = "Engicam i.CoreM6 DualLite/Solo starterkit";
>     compatible = "fsl,imx6-icore", "fsl,imx6dl";
>
>     codec_test: codec_test {
>         compatible = "linux,snd-soc-dummy";
>         #sound-dai-cells = <0>;
>     };
>
>     sound {
>         compatible = "simple-audio-card";
>         simple-audio-card,name = "test";
>         simple-audio-card,format="dsp_a";
>         simple-audio-card,frame-master = <&sound2_ssi>;
>         simple-audio-card,bitclock-master = <&sound2_ssi>;
>
>         sound2_ssi: simple-audio-card,cpu {
>             sound-dai = <&ssi1>;
>             system-clock-frequency = <1536000>;
>             dai-tdm-slot-num = <2>;
>             dai-tdm-slot-width = <16>;
>         };
>
>         sound2codec: simple-audio-card,codec {
>             sound-dai = <&codec_test>;
>         };
>     };
>
> };
>
> &iomuxc {
>     audmux {
>         pinctrl_audmux_1: audmux-1 {
>             fsl,pins = <
>                 MX6QDL_PAD_SD2_DAT0__AUD4_RXD  0x130b0
>                 MX6QDL_PAD_SD2_DAT3__AUD4_TXC  0x130b0
>                 MX6QDL_PAD_SD2_DAT2__AUD4_TXD  0x110b0
>                 MX6QDL_PAD_SD2_DAT1__AUD4_TXFS 0x130b0
>             >;
>         };
>
>         pinctrl_audmux_2: audmux-2 {
>             fsl,pins = <
>                 MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x130b0
>                 MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x130b0
>                 MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x110b0
>                 MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x130b0
>             >;
>         };
>
>         pinctrl_audmux_3: audmux-3 {
>             fsl,pins = <
>                 MX6QDL_PAD_DISP0_DAT16__AUD5_TXC  0x130b0
>                 MX6QDL_PAD_DISP0_DAT18__AUD5_TXFS 0x130b0
>                 MX6QDL_PAD_DISP0_DAT19__AUD5_RXD  0x130b0
>             >;
>         };
>
>         pinctrl_audmux_4: audmux-4 {
>             fsl,pins = <
>                 MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
>                 MX6QDL_PAD_DISP0_DAT21__AUD4_TXD 0x110b0
>                 MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS  0x130b0
>                 MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
>             >;
>         };
>     };
> };
>
>
>
> 2016-05-09 19:21 GMT+02:00 Caleb Crome <caleb@crome.org>:
>
>> On Mon, May 9, 2016 at 4:17 AM, nick83ola <nick83ola@gmail.com> wrote:
>> > Dear Alsa, Caleb and Arnaud
>> >
>> > I need to output an i2s master stream from my IMX6 solo board
>> >
>> > my board have this configuration for sound: (it have an sgtl5000 codec
>> not
>> > on module, but on dev board)
>> >
>> >
>> ==========================================================================
>> > sound {
>> >         compatible = "fsl,imx6q-icore-sgtl5000",
>> >                  "fsl,imx-audio-sgtl5000";
>> >         model = "imx6q-icore-sgtl5000";
>> >         ssi-controller = <&ssi1>;
>> >         audio-codec = <&codec>;
>> >         audio-routing =
>> >            "MIC_IN", "Mic Jack",
>> >             "Mic Jack", "Mic Bias",
>> >             "Headphone Jack", "HP_OUT";
>> >         mux-int-port = <2>;
>> >         mux-ext-port = <4>;
>> >     };
>> > &ssi1 {
>> >     fsl,mode = "i2s-master";
>> >     status = "okay";
>> > };
>> >
>> > &audmux {
>> >     pinctrl-names = "default";
>> >     pinctrl-0 = <&pinctrl_audmux_4>;
>> >     status = "okay";
>> > };
>> >
>> > &iomuxc {
>> >     audmux {
>> >         pinctrl_audmux_4: audmux-4 {
>> >             fsl,pins = <
>> >                 MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
>> >                 MX6QDL_PAD_DISP0_DAT21__AUD4_TXD 0x110b0
>> >                 MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS  0x130b0
>> >                 MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
>> >             >;
>> >        };
>> >   };
>> >
>> ==========================================================================
>> >
>> > I need to output i2s on the same port as sgtl5000, bit in master mode
>> > i've patched sound/soc/soc-utils.c to add support for dts as per arnaud
>> > patch
>> >
>> >
>> ==========================================================================
>> > #ifdef CONFIG_OF
>> > static const struct of_device_id soc_dummy_ids[] = {
>> >     { .compatible = "linux,snd-soc-dummy", },
>> >     { }
>> > };
>> > MODULE_DEVICE_TABLE(of, soc_dummy_ids);
>> > #endif
>> > ...
>> > .of_match_table = of_match_ptr(soc_dummy_ids),
>> >
>> ==========================================================================
>> >
>> > --> (it is necessary?????? or can I use simple audio card??????
>> >
>> >
>> > -> i've put this in my dts file
>> >
>> >
>> ==========================================================================
>> > &audmux {
>> >     ssi3 {
>> >         fsl,audmux-port = <6>;
>> >         fsl,port-config = <
>> >              0x00000000
>> >              IMX_AUDMUX_V2_PDCR_RXDSEL(4)
>> >          >;
>> >      };
>> >
>> >      port5 {
>> >          fsl,audmux-port = <4>;
>> >          fsl,port-config = <
>> >              (IMX_AUDMUX_V2_PTCR_TFSDIR |
>> >              IMX_AUDMUX_V2_PTCR_TFSEL(6) |
>> >              IMX_AUDMUX_V2_PTCR_TCLKDIR |
>> >              IMX_AUDMUX_V2_PTCR_TCSEL(6))
>> >              IMX_AUDMUX_V2_PDCR_RXDSEL(6)
>> >          >;
>> >      };
>> > };
>> >
>> > &ssi1 {
>> >      status = "disabled";
>> > };
>> >
>> > &ssi2 {
>> >      status = "disabled";
>> > };
>> >
>> > &ssi3 {
>> >      status = "okay";
>> >      #sound-dai-cells = <0>;
>> >      // select the a clock parent suitable for 48000 Hz sampling rate
>> >      assigned-clocks = <&clks IMX6QDL_CLK_SSI3_SEL>, <&clks
>> > IMX6QDL_CLK_SSI3>;
>> >      assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
>> >      assigned-clock-rates = <0>, <49152000>;
>> > };
>> >
>> > / {
>> >     model = "Engicam i.CoreM6 DualLite/Solo starterkit";
>> >     compatible = "fsl,imx6-icore", "fsl,imx6dl";
>> >
>> >     sound{
>> >      status = "disabled";
>> >     };
>> >
>> >     sound-itel {
>> >         compatible = "simple-audio-card";
>> >         simple-audio-card,name = "test";
>> >         simple-audio-card,format="dsp_a";
>> >         simple-audio-card,frame-master = <&sound2_ssi>;
>> >         simple-audio-card,bitclock-master = <&sound2_ssi>;
>> >         sound2_ssi: simple-audio-card,cpu {
>> >             sound-dai = <&ssi3>;
>> >             system-clock-frequency = <1536000>;
>> >             dai-tdm-slot-num = <2>;
>> >             dai-tdm-slot-width = <16>;
>> >         };
>> >     };
>> > };
>> >
>> ==========================================================================
>> >
>> >
>> > here's my log
>> >
>> > /sound-itel/simple-audio-card,cpu: arguments longer than property
>> > asoc-simple-card sound-itel.31: parse error -22
>> > asoc-simple-card: probe of sound-itel.31 failed with error -22
>> >
>> >
>> >
>>
>>
>> Hi Nikola,
>>    Here is my working setup for a wandboard with no i2c codecs.
>>
>>
>> https://github.com/ccrome/linux-caleb-dev/blob/v4.5-caleb-wandboard/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
>>
>> You need to be sure to set up the audmux right.    I'm not sure with
>> that old kernel if everything with audmux works right or not -- I
>> haven't tested it.
>>
>> That should get you pretty close to what you need for your board I
>> suspect.
>>
>> That branch (v4.5-caleb-wandboard) will build and run the SSI3 port on
>> AUD5 port, with the mx6 in master mode.  And, with all arnaud's
>> patches (included already in that repo), it will actually be robust.
>>
>> -caleb
>>
>>
>>
>>
>>
>>
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>> > 2016-05-06 17:38 GMT+02:00 Caleb Crome <caleb@crome.org>:
>> >>
>> >> Hi there,
>> >>    Arnaud had a neat patch here that lets you set up a dummy sound
>> >> card from the DTS.
>> >>
>> >>
>> >>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100896.html
>> >>
>> >> With that patch, you can set up your DTS to simply start streaming, no
>> >> codec or anything required, which should work for a codec with no I2C.
>> >>
>> >>
>> >> Hope that helps,
>> >>   -Caleb
>> >>
>> >>
>> >> On Thu, May 5, 2016 at 12:56 PM, nick83ola <nick83ola@gmail.com>
>> wrote:
>> >> > Hello Alsa dev!
>> >> >
>> >> > Anyone have an example of an i2s only driver for imx6 solo? I need a
>> >> > driver
>> >> > without i2c....
>> >> > _______________________________________________
>> >> > Alsa-devel mailing list
>> >> > Alsa-devel@alsa-project.org
>> >> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >
>> >
>> >
>> >
>> > --
>> >
>> > P.S. Le informazioni trasmesse attraverso la presente comunicazione
>> sono di
>> > esclusiva
>> > spettanza dell'effettivo destinatario. Nel caso in cui le stesse
>> > raggiungessero, per
>> > qualunque motivo, soggetti non interessati, questi ultimi vorranno darne
>> > immediata
>> > notizia al mittente. In ogni caso, eventuali soggetti diversi dai
>> legittimi
>> > destinatari
>> > della presente comunicazione e dei dati contenuti negli allegati,
>> possono
>> > essere
>> > sanzionati ai sensi del T.U. sul trattamento dei dati personali d.lgs.
>> > 196/2003, sia ai
>> > sensi dell'art. 616 del Codice Penale che disciplina la violazione del
>> > segreto sulla
>> > corrispondenza.
>>
>
>
>
> --
>
> P.S. Le informazioni trasmesse attraverso la presente comunicazione sono
> di esclusiva
> spettanza dell'effettivo destinatario. Nel caso in cui le stesse
> raggiungessero, per
> qualunque motivo, soggetti non interessati, questi ultimi vorranno darne
> immediata
> notizia al mittente. In ogni caso, eventuali soggetti diversi dai
> legittimi destinatari
> della presente comunicazione e dei dati contenuti negli allegati, possono
> essere
> sanzionati ai sensi del T.U. sul trattamento dei dati personali d.lgs.
> 196/2003, sia ai
> sensi dell'art. 616 del Codice Penale che disciplina la violazione del
> segreto sulla
> corrispondenza.
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
