From: Jonathan Bennett <jbscience87@gmail.com>
Subject: Re: Help with wm8731 support for the Utilite (imx6q)
Date: Sun, 19 Oct 2014 00:35:08 -0500
Message-ID: <CAB-pspcNOuW=JN9_avEvyPFUvTfs99PB=ah43YdqMC65mZ8psQ@mail.gmail.com>
References: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
 <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
 [209.85.213.178])
 by alsa0.perex.cz (Postfix) with ESMTP id CE48A2604D4
 for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2014 07:35:09 +0200 (CEST)
Received: by mail-ig0-f178.google.com with SMTP id h3so2948633igd.5
 for <alsa-devel@alsa-project.org>; Sat, 18 Oct 2014 22:35:08 -0700 (PDT)
In-Reply-To: <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, alsa-devel@alsa-project.org, Aaron Kling <webgeek1234@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 18, 2014 at 2:13 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Jonathan,
>
> On Fri, Oct 17, 2014 at 1:57 PM, Jonathan Bennett <jbscience87@gmail.com>
> wrote:
> > Hey, I'm working with a compulab utilite, trying to get everything
> working
> > with 3.17, with the eventual goal of getting better support for it
> > upstream. Currently fighting the sound. It's a imx6q talking to a wm8731
> > over i2c/i2s.
> > I am booting Fedora 21 arm Alpha, with my own dtb (
> > http://pastebin.com/4a4PBKwx) and driver (http://pastebin.com/1CsesuVV)
>
> I don't have access to a utilite board, but just trying to understand:
> is wm8731 audio functional with the 3.10.17 kernel com compulab?
>
> The audio works on their pre-canned ubuntu image, which runs 3.10.


> > It shows up in aplay -l, but trying to play anything to it gives me a div
> > by 0 in a driver:  [<c04f27e4>] (Ldiv0) from [<bf50512c>]
> > (fsl_ssi_hw_params+0x194/0x364 [snd_soc_fsl_ssi]) This div0 happens in
> > sound/soc/fsl/fsl_ssi.c, in the function fsl_ssi_set_bclk.
> >
> > My driver file is an almost direct copy of what compulab shipped with a
> > 3.10 kernel. This is my first attempt at kernel hacking, so any help
> would
> > be appreciated.
>
> I would suggest as a first step to get the dts for compulab upstreamed.
>
> There was an attempt from Valentin Raevsky (added on Cc) last year:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204896.html
>
> After the basic dts file is added then you can work on adding audio
> support.
>
> There is already a small dts file upstreamed.  It barely works. I've been
get usb and the second ethernet port working, which I would like to get
pushed upstream. I was hoping to have more of it working before then,
though.

> Some suggestions:
>
> - The dts from 3.10.17 can not be applied 'as-is' into 3.17. Take a
> look for example into the audio node you have:
>
>         sound {
>                 compatible = "fsl,imx6q-cm-fx6-wm8731",
>                           "fsl,imx-audio-wm8731";
>                 model = "wm8731-audio";
>                 ssi-controller = <&ssi2>;
>                 src-port = <2>;
>                 ext-port = <4>;
>                 audio-codec = <&codec>;
>                 audio-routing = "LOUT", "ROUT", "LLINEIN", "RLINEIN";
>         };
>
> 'src-port' and 'ext-port' are not valid properties.
>
> They should be like this instead:
>
>         mux-int-port = <2>;
>         mux-ext-port = <4>;
>
> Take a look at arch/arm/boot/dts/imx6qdl-sabresd.dtsi for a reference.
>
> Also the codec clocks that are passed into the dts are not correct.
> The wm8731 does not acquire any clocks in the mainline driver.
>
> You should also try to use the 'simple-audio-card' binding instead of
> creating the imx-wm8731 machine file.
>
> Here is a reference of the arch/arm/boot/dts/vf610-twr.dts where you
> can see simple-audio-card in use.
>
> I am trying to use simple-audio-card, without any success. I've been
hammering at this for a couple days now. My current dts looks like
this(just the audio related bits):

        sound {
                compatible = "simple-audio-card";
                simple-audio-card,model = "wm8731-audio";
                mux-int-port = <2>;
                mux-ext-port = <4>;
                simple-audio-card,format = "i2s";
                simple-audio-card,mclk-fs = <256>;
                simple-audio-card,cpu {
                        sound-dai = <&ssi2>;
                };
                simple-audio-card,codec {
                        sound-dai = <&codec>;
                };
        };
....
/* i2c3 */
&i2c3 {
   pinctrl-names = "default";
   pinctrl-0 = <&pinctrl_i2c3>;
   status = "okay";

   eeprom@50 {
      compatible = "at24,24c02";
      reg = <0x50>;
      pagesize = <16>;
   };

   codec: wm8731@1a {
      #sound-dai-cells = <0>;
      compatible = "wlf,wm8731";
      reg = <0x1a>;
      AVDD-supply = <&reg_3p3v>;
      HPVDD-supply = <&reg_3p3v>;
      DCVDD-supply = <&reg_3p3v>;
      DBVDD-supply = <&reg_3p3v>;
   };
};
...
&ssi2 {
        fsl,mode = "i2s-master";
        status = "okay";
        #sound-dai-cells = <0>;
};


It registers:
# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: D202c000ssiwm87 [202c000.ssi-wm8731-hifi], device 0:
202c000.ssi-wm8731-hifi wm8731-hifi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0


However:
# speaker-test

speaker-test 1.0.28

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48[   57.443583] asoc-simple-card sound:
ASoC: machine hw_params failed: -22
000Hz)
Buffer size range from 128 to 32768
Period size range from 64 to 16384
Using max buffer size 32768
Periods = 4
Unable to set hw params for playback: Invalid argument
Setting of hwparams failed: Invalid argument




It's a wm8731 hanging off an i2c bus from an i.mx6q chip. Seems like
exactly what simple-audio-card is designed for. I imagine that there is
something simple that I am overlooking, but I'm at a loss to find it.


> Good luck!
>
> Regards,
>
> Fabio Estevam
>

Thanks for the help!
~Jonathan Bennett
