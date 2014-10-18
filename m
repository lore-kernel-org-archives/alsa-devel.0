From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Help with wm8731 support for the Utilite (imx6q)
Date: Sat, 18 Oct 2014 16:13:06 -0300
Message-ID: <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
References: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 328062604F7
 for <alsa-devel@alsa-project.org>; Sat, 18 Oct 2014 21:13:09 +0200 (CEST)
Received: by mail-la0-f41.google.com with SMTP id pn19so2164028lab.14
 for <alsa-devel@alsa-project.org>; Sat, 18 Oct 2014 12:13:06 -0700 (PDT)
In-Reply-To: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Bennett <jbscience87@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, valentin@compulab.co.il
List-Id: alsa-devel@alsa-project.org

Hi Jonathan,

On Fri, Oct 17, 2014 at 1:57 PM, Jonathan Bennett <jbscience87@gmail.com> wrote:
> Hey, I'm working with a compulab utilite, trying to get everything working
> with 3.17, with the eventual goal of getting better support for it
> upstream. Currently fighting the sound. It's a imx6q talking to a wm8731
> over i2c/i2s.
> I am booting Fedora 21 arm Alpha, with my own dtb (
> http://pastebin.com/4a4PBKwx) and driver (http://pastebin.com/1CsesuVV)

I don't have access to a utilite board, but just trying to understand:
is wm8731 audio functional with the 3.10.17 kernel com compulab?

> It shows up in aplay -l, but trying to play anything to it gives me a div
> by 0 in a driver:  [<c04f27e4>] (Ldiv0) from [<bf50512c>]
> (fsl_ssi_hw_params+0x194/0x364 [snd_soc_fsl_ssi]) This div0 happens in
> sound/soc/fsl/fsl_ssi.c, in the function fsl_ssi_set_bclk.
>
> My driver file is an almost direct copy of what compulab shipped with a
> 3.10 kernel. This is my first attempt at kernel hacking, so any help would
> be appreciated.

I would suggest as a first step to get the dts for compulab upstreamed.

There was an attempt from Valentin Raevsky (added on Cc) last year:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204896.html

After the basic dts file is added then you can work on adding audio support.

Some suggestions:

- The dts from 3.10.17 can not be applied 'as-is' into 3.17. Take a
look for example into the audio node you have:

        sound {
                compatible = "fsl,imx6q-cm-fx6-wm8731",
                          "fsl,imx-audio-wm8731";
                model = "wm8731-audio";
                ssi-controller = <&ssi2>;
                src-port = <2>;
                ext-port = <4>;
                audio-codec = <&codec>;
                audio-routing = "LOUT", "ROUT", "LLINEIN", "RLINEIN";
        };

'src-port' and 'ext-port' are not valid properties.

They should be like this instead:

        mux-int-port = <2>;
        mux-ext-port = <4>;

Take a look at arch/arm/boot/dts/imx6qdl-sabresd.dtsi for a reference.

Also the codec clocks that are passed into the dts are not correct.
The wm8731 does not acquire any clocks in the mainline driver.

You should also try to use the 'simple-audio-card' binding instead of
creating the imx-wm8731 machine file.

Here is a reference of the arch/arm/boot/dts/vf610-twr.dts where you
can see simple-audio-card in use.

Good luck!

Regards,

Fabio Estevam
