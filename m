From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Help with wm8731 support for the Utilite (imx6q)
Date: Mon, 20 Oct 2014 10:06:57 -0200
Message-ID: <CAOMZO5AVr0xJjf9JjYNuXG-jJC3ft84+fO-5ToSieP9NFP=-+g@mail.gmail.com>
References: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
 <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
 <CAB-pspcNOuW=JN9_avEvyPFUvTfs99PB=ah43YdqMC65mZ8psQ@mail.gmail.com>
 <CAB-pspei1a3TbuFGBT-kupEWU5UY10kQoTtiV895WTi-j+-dzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id ACD9A260471
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 14:06:57 +0200 (CEST)
Received: by mail-la0-f53.google.com with SMTP id gq15so3714961lab.40
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 05:06:57 -0700 (PDT)
In-Reply-To: <CAB-pspei1a3TbuFGBT-kupEWU5UY10kQoTtiV895WTi-j+-dzQ@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, valentin@compulab.co.il
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 19, 2014 at 3:58 AM, Jonathan Bennett <jbscience87@gmail.com> wrote:
> And a different dts that is closer to the example given:
>
>         sound {
>                 compatible = "simple-audio-card";
>                 simple-audio-card,model = "wm8731-audio";
>                 mux-int-port = <2>;
>                 mux-ext-port = <4>;
>                 simple-audio-card,format = "i2s";
>                 simple-audio-card,cpu {
>                         sound-dai = <&ssi2>;
>                         master-clkdir-out;
>                         frame-master;
>                         bitclock-master;
>                 };
>                 simple-audio-card,codec {
>                         frame-master;
>                         bitclock-master;
>                         sound-dai = <&codec>;
>                 };
>         };
>
> /* i2c3 */
> &i2c3 {
>    pinctrl-names = "default";
>    pinctrl-0 = <&pinctrl_i2c3>;
>    status = "okay";
>
>    eeprom@50 {
>       compatible = "at24,24c02";
>       reg = <0x50>;
>       pagesize = <16>;
>    };
>
>    codec: wm8731@1a {
>       #sound-dai-cells = <0>;
>       compatible = "wlf,wm8731";
>       reg = <0x1a>;
>       AVDD-supply = <&reg_3p3v>;
>       HPVDD-supply = <&reg_3p3v>;
>       DCVDD-supply = <&reg_3p3v>;
>       DBVDD-supply = <&reg_3p3v>;
>       clocks = <&clks IMX6QDL_CLK_SSI2>;

This 'clocks' entry does not seem correct.

IMX6QDL_CLK_SSI2 is the clock from SSI2 module, which is turned on by
the ssi driver.

Who provides the MCLK for wm8731 on utilite board? Isn't it mx6 CLKO pin?

Are you able to monitor this clock with a scope and make sure that it
is actually being turned on?

We use CLKO output to drive MCLK pins on mx6qdl-sabresd board with
wm8762 codec. You can use it as a reference.

Adding the Compulab's folks on Cc.
