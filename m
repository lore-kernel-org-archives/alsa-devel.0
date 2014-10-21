From: Jonathan Bennett <jbscience87@gmail.com>
Subject: Re: Help with wm8731 support for the Utilite (imx6q)
Date: Tue, 21 Oct 2014 13:04:27 -0500
Message-ID: <CAB-pspcaMh9DL8bND1kSmphZfMYNOvPS_CYZ8UYZ2EZuVjjksg@mail.gmail.com>
References: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
 <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
 <CAB-pspcNOuW=JN9_avEvyPFUvTfs99PB=ah43YdqMC65mZ8psQ@mail.gmail.com>
 <CAB-pspei1a3TbuFGBT-kupEWU5UY10kQoTtiV895WTi-j+-dzQ@mail.gmail.com>
 <CAOMZO5AVr0xJjf9JjYNuXG-jJC3ft84+fO-5ToSieP9NFP=-+g@mail.gmail.com>
 <CAOMZO5CU+Y8cGJsn4O1ccFZUSjLM1iH3QN2fAv4UyaLMk5yAEg@mail.gmail.com>
 <CAB-pspdvzFX-KjYSC3z3xoDMPvq4g3iFhBG76Y=DGy=YBf5dow@mail.gmail.com>
 <54464C32.8020100@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F867260613
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 20:04:29 +0200 (CEST)
Received: by mail-ig0-f177.google.com with SMTP id a13so1862628igq.16
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 11:04:27 -0700 (PDT)
In-Reply-To: <54464C32.8020100@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Valentin Raevsky <valentin@compulab.co.il>
Cc: Aaron Kling <webgeek1234@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2014 at 7:06 AM, Valentin Raevsky <valentin@compulab.co.il>
wrote:

> Hi Jonathan,
>
> See my comments in line.
>
> Moreover, I'd appreciate it if you could try the CompuLab 3.10.17 kernel
> on your board in order to rule out a hw problem.
>
> Take the latest 3.10.17 source from here:
> https://github.com/utilite-computer/linux-kernel
> tag: v3.10.17-cm-fx6-1-beta1
>
> Build  instructions:
>
> # export LOADADDR=0x10008000
> # make cm_fx6_defconfig
> # make zImage modules -j8 CONFIG_DEBUG_SECTION_MISMATCH=y
> # make imx6q-sbc-fx6m.dtb
> # make imx6q-sbc-fx6.dtb
>
> imx6q-sbc-fx6m.dtb - Utilite
> imx6q-sbc-fx6.dtb  - Evaluation Board
>
> Regards,
> Valentin.

Hey. I have pulled the Ubuntu image and booted it up. Sound worked without
a hitch there. I think we can rule out an actual HW problem.

>
>
> On 10/20/2014 10:59 PM, Jonathan Bennett wrote:
>
>> With those changes:
>> [    8.656319] wm8731 2-001a: simple-card: set_sysclk error
>> [    8.661964] asoc-simple-card sound: ASoC: failed to init
>> 202c000.ssi-wm8731-hifi: -22
>> [    8.670067] asoc-simple-card sound: ASoC: failed to instantiate card
>> -22
>> [    8.678063] Bluetooth: vendor=0x2df, device=0x911b, class=255, fn=3
>> [    8.679996] asoc-simple-card: probe of sound failed with error -22
>>
>>
>> Looking at the 3.10 driver file and digging through some documentation,
>> it looks like the wm8731 can be used in either slave or master mode.
>> According to Compulab's driver, the supplying clocks when the wm8731 is
>> in slave mode are pll4 (IMX6QDL_CLK_PLL4_AUDIO) and ssi.1
>> (IMX6QDL_CLK_SSI2)
>>
> These clocks are correct for slave mode.
>
>>
>> I realized something just last night. I was grabbing changes from the
devel branch of github.com/utilite-computer, thinking that those changes
were based off the vanilla 3.10 kernel. Those changes are actually based on
the Freescale 3.10 kernel. I pulled a Freescale patch that is
obviously missing: "ENGR00276249-1 ARM: imx6q: Add missing baud clock for
ssi" I also switched back to imx-wm8731.c for the driver. With this setup,
the driver registers, and speaker-test thinks it plays, however there is no
actual sound output. I call it progress.

My previous ldiv0 was apparently a result of the missing baudclock in
clk-imx6q.c. s



> In master mode, it's IMX6QDL_CLK_CKO and IMX6QDL_CLK_CKO2.
>>
> These clocks are correct for master mode, but do not try make it work.
> Master mode requires a hw change on the module.
>

>> I have not found an actual schematic to see how it is physically wired.
>> Popped open the case, and the codec is on the bottom side of the board
>> with the cpu on it, 100% unaccessible during operations. Even at that,
>> the cpu and codec are bga, so no probing of pins.
>>
>> Looking at their driver file, I am also wondering if we need to tweak
>> the audmux init. I've played with this some in the dts, but hasn't made
>> much difference.
>>
>> On Mon, Oct 20, 2014 at 11:29 AM, Fabio Estevam <festevam@gmail.com
>> <mailto:festevam@gmail.com>> wrote:
>>
>>     On Mon, Oct 20, 2014 at 10:06 AM, Fabio Estevam <festevam@gmail.com
>>     <mailto:festevam@gmail.com>> wrote:
>>
>>     >>       clocks = <&clks IMX6QDL_CLK_SSI2>;
>>     >
>>     > This 'clocks' entry does not seem correct.
>>     >
>>     > IMX6QDL_CLK_SSI2 is the clock from SSI2 module, which is turned on
>> by
>>     > the ssi driver.
>>     >
>>     > Who provides the MCLK for wm8731 on utilite board? Isn't it mx6
>> CLKO pin?
>>     >
>>     > Are you able to monitor this clock with a scope and make sure that
>> it
>>     > is actually being turned on?
>>     >
>>     > We use CLKO output to drive MCLK pins on mx6qdl-sabresd board with
>>     > wm8762 codec. You can use it as a reference.
>>     >
>>     > Adding the Compulab's folks on Cc.
>>
>>     Do the changes below help? (using IMX6QDL_CLK_CKO)
>>
>>          codec: wm8731@1a {
>>             #sound-dai-cells = <0>;
>>             compatible = "wlf,wm8731";
>>             reg = <0x1a>;
>>             AVDD-supply = <&reg_3p3v>;
>>             HPVDD-supply = <&reg_3p3v>;
>>             DCVDD-supply = <&reg_3p3v>;
>>             DBVDD-supply = <&reg_3p3v>;
>>             clocks = <&clks IMX6QDL_CLK_CKO>;
>>
>>     with this one applied:
>>
>>     --- a/sound/soc/codecs/wm8731.c
>>     +++ b/sound/soc/codecs/wm8731.c
>>     @@ -13,6 +13,7 @@
>>        * published by the Free Software Foundation.
>>        */
>>
>>     +#include <linux/clk.h>
>>       #include <linux/module.h>
>>       #include <linux/moduleparam.h>
>>       #include <linux/init.h>
>>     @@ -46,6 +47,7 @@ struct wm8731_priv {
>>           struct regmap *regmap;
>>           struct regulator_bulk_data supplies[WM8731_NUM_SUPPLIES];
>>           const struct snd_pcm_hw_constraint_list *constraints;
>>     +    struct clk *mclk;
>>           unsigned int sysclk;
>>           int sysclk_type;
>>           int playback_fs;
>>     @@ -742,6 +744,21 @@ static int wm8731_i2c_probe(struct i2c_client
>> *i2c,
>>               return ret;
>>           }
>>
>>     +    wm8731->mclk = devm_clk_get(&i2c->dev, NULL);
>>     +    if (IS_ERR(wm8731->mclk)) {
>>     +        ret = PTR_ERR(wm8731->mclk);
>>     +        dev_err(&i2c->dev, "Failed to get mclock: %d\n", ret);
>>     +        /* Defer the probe to see if the clk will be provided later
>> */
>>     +        if (ret == -ENOENT)
>>     +            return -EPROBE_DEFER;
>>     +    }
>>     +
>>     +    if (!IS_ERR(wm8731->mclk)) {
>>     +        ret = clk_prepare_enable(wm8731->mclk);
>>     +        if (ret)
>>     +            return ret;
>>     +    }
>>     +
>>           i2c_set_clientdata(i2c, wm8731);
>>
>>           ret = snd_soc_register_codec(&i2c->dev,
>>
>>
>>
>
