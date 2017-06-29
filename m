From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Re: Fwd: Issue on Linux 4.12-rc7 on iMX6 based board
Date: Thu, 29 Jun 2017 15:39:18 +0200
Message-ID: <2cb47b9c-d631-6fe0-8e5c-3f1d2604ab0d@eurekelettronica.it>
References: <7ab79167-fa6c-4aea-0545-48d0522d5d77@eurekelettronica.it>
 <d7d15b1d-ac7f-4b45-b7e6-e4cdc0d5cc65@eurekelettronica.it>
 <CAOMZO5C1HSN2m4P34GQq2+SKB+kmm9WUjr37T_Q_W6LwCQQQFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qmail.e-mind.com (qmail34.e-mind.com [188.94.192.34])
 by alsa0.perex.cz (Postfix) with SMTP id C701A26736C
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 15:39:19 +0200 (CEST)
In-Reply-To: <CAOMZO5C1HSN2m4P34GQq2+SKB+kmm9WUjr37T_Q_W6LwCQQQFQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/29/2017 01:37 PM, Fabio Estevam wrote:
> Hi Gianluca,
>
> On Wed, Jun 28, 2017 at 12:34 PM, gianluca
> <gianlucarenzi@eurekelettronica.it> wrote:
>
>> Hello list,
>>
>> I have some issue using the sgtl5000 on two custom boards based with iMX6.
>> One board has iMX6DL and the other has iMX6QP.
>>
>> The issue is I have a (dramatically high) strange value on mixer settings
>> (looks like a int32 limit or similar)
>>
>> This is the output of amixer:
>>>
>>> # amixer
>>> Simple mixer control 'Headphone',0
>>>   Capabilities: pvolume pswitch pswitch-joined
>>>   Playback channels: Front Left - Front Right
>>>   Limits: Playback 0 - 127
>>>   Mono:
>>>   Front Left: Playback 0 [2147483647%] [-51.50dB] [on]
>>>   Front Right: Playback 0 [2147483647%] [-51.50dB] [on]
>
> Double check the codec hardware: is I2C communication working,are you
> able to dump the SGTL5000 registers,

The i2c communication is working:

> # i2cdetect -y -a -r 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 -- -- -- -- -- -- -- -- -- UU -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- 18 -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
> 50: UU UU -- -- 54 -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

sgtl-5000 is 0xa address like specified in the device-tree:

> &i2c1 {
> 	clock-frequency = <100000>;
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_i2c1>;
> 	status = "okay";
>
> 	sgtl5000: codec@0a {
> 		compatible = "fsl,sgtl5000";
> 		reg = <0x0a>;
> 		clocks = <&clks IMX6QDL_CLK_CKO>;
> 		VDDA-supply = <&reg_3p3v>;
> 		VDDIO-supply = <&reg_3p3v>;
> 		VDDD-supply = <&reg_1p2v>;
> 		status = "okay";
> 	};

I did not check the voltage supply yet, but during bootup the kernel is 
saying:

> [    0.620196] sgtl5000 0-000a: sgtl5000 revision 0x11

So I suppose (at least) the Codec is powered and the i2c lines are 
working correctly.

> [    0.650568] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
> [    0.673984] imx-sgtl5000 sound: sgtl5000 <-> 2028000.ssi mapping ok
>

It looks like some basic initialization stuff and probing are working 
good...

> [    0.698683] ALSA device list:
> [    0.698689]   #0: imx6-ek360-sgtl5000

...and the device is added to ALSA device-list.

In the device-tree the sound node is so configured:

> 	sound {
> 		compatible = "fsl,imx-audio-sgtl5000";
> 		model = "imx6-ek360-sgtl5000";
> 		ssi-controller = <&ssi1>;
> 		audio-codec = <&sgtl5000>;
> 		audio-routing =
> 			"MIC_IN", "Mic Jack",
> 			"Mic Jack", "Mic Bias",
> 			"Headphone Jack", "HP_OUT";
> 		mux-int-port = <1>;
> 		mux-ext-port = <4>;
> 		micbias-resistor-k-ohms = <2>;
> 		micbias-voltage-m-volts = <3000>;
> 		status = "okay";
> 	};

I do not know about the mux-int-port or mux-ext-port. The only thing I 
know is the hardware guy told me he routed the ssi (CLK and DAT) to:

AUD3_TXC_R (i2s_sclk)
AUD3_TXD   (i2s_din)
AUD3_TXFS  (i2s_lrclk)
AUD3_RXD   (i2s_dout)
SYS_MCLK   (GPIO_0_CLKO sys_mclk)

So I configured the pinmux for audio in the following way:

> 		pinctrl_audmux: audmuxgrp {
> 			fsl,pins = <
> 				/* SGTL5000 sys_mclk */
> 				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x030b0
> 				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
> 				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
> 				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
> 				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
> 			>;
> 		};

Are the values correct for that?

I was looking at the device-tree for imx6qdl-nit6xlite.dtsi because they 
are using the same pinout as ours.

check the codec power supplies,
> MCLK, etc.

How can I check or dump the SGTL5000 registers?

Regards,
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
