From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: How to structure CPU DAI
Date: Sun, 18 Nov 2012 21:09:23 -0500
Message-ID: <CAKON4Oz0-K_p0xQEXRo8GXuQjEZD2v4Wyo=jRfO3ibN_JKSeeQ@mail.gmail.com>
References: <CAKON4OyCTQPtfTLyiWrXRKJurF=6ZdDpAY-zQwXvJ2COokbkAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B9FB2650D5
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 03:09:24 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id c10so5679558ieb.38
 for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2012 18:09:23 -0800 (PST)
In-Reply-To: <CAKON4OyCTQPtfTLyiWrXRKJurF=6ZdDpAY-zQwXvJ2COokbkAA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Getting runtime from the substream gives me a pointer chain which lets
me identify the channel.

rtd->card->dev->of_node

On Sun, Nov 18, 2012 at 5:04 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> The LPC3130 has two independent I2S channels but it is not two copies
> of the same hardware block. Instead it is a single hardware block
> implementing the two channels. Some setup registers contain setup bits
> for both channels.
>
> So I have one CPU DAI with two independent CODECs hung off from it.
>
> So in a function like hw_params() for the CPU DAI, how do I know which
> I2S channel I'm supposed to be using? At the point where I created the
> soc_card I know the right channel. But I can't use the card pointer in
> the CPU DAI, since there are two cards and only on CPU DAI. The card
> pointer points to the last one registered. Can I put the info into the
> substream?
>
> Or should I register two CPU DAIs from a single I2S device driver and
> give then two different names?
>
> A device tree like this describes the hardware..
>
> i2s@16000000 {
>     #address-cells = <2>;
>     #size-cells = <0>;
>     compatible = "nxp,lpc31xx-i2s";
>     reg = <0x16000000 0x1000>;
>     i2s0:i2s@0 {
>        interrupts = <13 15>;
>        reg = <0x80 0x180>;
>         /*receive-slave;*/ /* default is master */
>     };
>     i2s1:i2s@1 {
>        interrupts = <14 16>;
>        reg = <0x100 0x200>;
>         /*receive-slave;*/ /* default is master */
>     };
> };
>
> sound@1 {
>     compatible = "ea,ea3131-uda1380";
>     audio-codec = <&uda1380-0>;
>     i2s-controller = <&i2s0>;
> };
>
> sound@2 {
>     compatible = "ea,ea3131-uda1380";
>     audio-codec = <&uda1380-1>;
>     i2s-controller = <&i2s1>;
> };
>
> --
> Jon Smirl
> jonsmirl@gmail.com



-- 
Jon Smirl
jonsmirl@gmail.com
