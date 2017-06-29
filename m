From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Fwd: Issue on Linux 4.12-rc7 on iMX6 based board
Date: Thu, 29 Jun 2017 10:49:04 -0300
Message-ID: <CAOMZO5CYw-eoOuaP6Tb3c51va9ua7gvg2mTz+kX7fYtQdhsK+w@mail.gmail.com>
References: <7ab79167-fa6c-4aea-0545-48d0522d5d77@eurekelettronica.it>
 <d7d15b1d-ac7f-4b45-b7e6-e4cdc0d5cc65@eurekelettronica.it>
 <CAOMZO5C1HSN2m4P34GQq2+SKB+kmm9WUjr37T_Q_W6LwCQQQFQ@mail.gmail.com>
 <2cb47b9c-d631-6fe0-8e5c-3f1d2604ab0d@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com
 [209.85.216.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 16F1D26736C
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 15:49:05 +0200 (CEST)
Received: by mail-qt0-f176.google.com with SMTP id 32so74681389qtv.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 06:49:05 -0700 (PDT)
In-Reply-To: <2cb47b9c-d631-6fe0-8e5c-3f1d2604ab0d@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gianluca <gianlucarenzi@eurekelettronica.it>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 29, 2017 at 10:39 AM, gianluca
<gianlucarenzi@eurekelettronica.it> wrote:

> In the device-tree the sound node is so configured:
>
>>         sound {
>>                 compatible = "fsl,imx-audio-sgtl5000";
>>                 model = "imx6-ek360-sgtl5000";
>>                 ssi-controller = <&ssi1>;
>>                 audio-codec = <&sgtl5000>;
>>                 audio-routing =
>>                         "MIC_IN", "Mic Jack",
>>                         "Mic Jack", "Mic Bias",
>>                         "Headphone Jack", "HP_OUT";
>>                 mux-int-port = <1>;
>>                 mux-ext-port = <4>;

This should be mux-ext-port = <3>;

> I do not know about the mux-int-port or mux-ext-port. The only thing I know
> is the hardware guy told me he routed the ssi (CLK and DAT) to:
>
> AUD3_TXC_R (i2s_sclk)
> AUD3_TXD   (i2s_din)
> AUD3_TXFS  (i2s_lrclk)
> AUD3_RXD   (i2s_dout)
> SYS_MCLK   (GPIO_0_CLKO sys_mclk)

since you are using AUD3 pins.

>
> So I configured the pinmux for audio in the following way:
>
>>                 pinctrl_audmux: audmuxgrp {
>>                         fsl,pins = <
>>                                 /* SGTL5000 sys_mclk */
>>                                 MX6QDL_PAD_GPIO_0__CCM_CLKO1
>> 0x030b0
>>                                 MX6QDL_PAD_CSI0_DAT4__AUD3_TXC
>> 0x130b0
>>                                 MX6QDL_PAD_CSI0_DAT5__AUD3_TXD
>> 0x110b0
>>                                 MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS
>> 0x130b0
>>                                 MX6QDL_PAD_CSI0_DAT7__AUD3_RXD
>> 0x130b0
>>                         >;
>>                 };
>
>
> Are the values correct for that?

They should be good.

> How can I check or dump the SGTL5000 registers?

cat /sys/kernel/debug/regmap/xxx
