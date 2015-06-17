From: Wojciech Zebrowski <wojtekz@aldec.com>
Subject: Re: Post Audio codec sgtl5000 with ARM/Zynq under Linux
Date: Wed, 17 Jun 2015 16:28:28 +0200
Message-ID: <5581840C.9060808@aldec.com>
References: <557931E5.8070802@aldec.com> <5580D9A1.2050801@mail.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id D7473260483
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 16:28:38 +0200 (CEST)
Received: by wgzl5 with SMTP id l5so38642487wgz.3
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 07:28:38 -0700 (PDT)
In-Reply-To: <5580D9A1.2050801@mail.bg>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikolay Dimitrov <picmaster@mail.bg>
Cc: alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@xilinx.com>, =?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
List-Id: alsa-devel@alsa-project.org

Hi Nikolay

Thx for your advice , i try use it in feature dts files.
My problem is as below , i can send you boot log or , dmesg log if you 
have any other proposition i can debug it too.

1.*I use I2C* controler to configure sgtl5000 :
         axi_iic_sgtl: i2c@41610000 {
             #address-cells = <1>;
             #size-cells = <0>;
             compatible = "xlnx,xps-iic-2.00.a";
             interrupt-parent = <&gic>;
             interrupts = <0 31 4>;
             reg = <0x41610000 0x10000>;

             codec: sgtl5000@0a {
                 #sound-dai-cells = <0>;
                 compatible = "fsl,sgtl5000";
                 reg = <0x0a>;
/*                VDDA-supply = <&reg_3p3v>; */
/*                VDDIO-supply = <&reg_3p3v>;*/
                 clocks = <&clkc 19>;
       };
*
**  How can i set comment lines ? *

2. sound :
         sound {
            compatible = "fsl,imx51-babbage-sgtl5000",
"fsl,imx-audio-sgtl5000";
            model = "imx51-babbage-sgtl5000";
/*          ssi-controller = <&ssi1>; */
            audio-codec = <&codec>;
            audio-routing =
                    "MIC_IN", "Mic Jack",
                    "Mic Jack", "Mic Bias",
                    "Headphone Jack", "HP_OUT";
            mux-int-port = <1>;
            mux-ext-port = <3>;
          };/
*I want use I2C configuration driver not SPI . How can i set comment 
line ? **
***
3. I2S driver looks like ok  :
         axi_i2s_adi_0: axi_i2s_adi@77600000 {
              compatible = "xlnx,axi-i2s-adi-1.0";
              reg = <0x77600000 0x10000>;
              xlnx,bclk-pol = <0x0>;
              xlnx,dma-type = <0x1>;
              xlnx,has-rx = <0x1>;
              xlnx,has-tx = <0x1>;
              xlnx,lrclk-pol = <0x0>;
              xlnx,num-ch = <0x1>;
              xlnx,s-axi-min-size = <0x000001FF>;
              xlnx,slot-width = <0x18>;
          };



W dniu 2015-06-17 o 04:21, Nikolay Dimitrov pisze:
> Hi Wojciech,
>
> On 06/11/2015 09:59 AM, Wojciech Zebrowski wrote:
>> Hi All
>>
>> I try solve problem with support SGTL5000  under Linux , ARM / ZYNQ
>> ARCHITECTURE. Please add this post to "alsa" forum.  If you need any
>> others information i can send it .
>>
>> My post:
>>
>>   I try use freescale audio chip sgtl5000 on my custom board with Zynq
>> chip. I need help with instance driver in device tree and debug first
>> execution.
>>
>> 1.*I use I2C* controler to configure sgtl5000 :
>> /        axi_iic_sgtl: i2c@41610000 {//
>> //            #address-cells = <1>;//
>> //            #size-cells = <0>;//
>> //            compatible = "xlnx,xps-iic-2.00.a";//
>> //            interrupt-parent = <&gic>;//
>> //            interrupts = <0 31 4>;//
>> //            reg = <0x41610000 0x10000>;//
>> ////
>> //            codec: sgtl5000@0a {//
>> //                #sound-dai-cells = <0>;//
>> //                compatible = "fsl,sgtl5000";//
>> //                reg = <0x0a>;//
>> //////                VDDA-supply = <&reg_3p3v>;//
>> //////                VDDIO-supply = <&reg_3p3v>;//
>> //                clocks = <&clkc 19>;//
>> //      }; /
>>
>>   How can i set comment lines ?
>>
>> 2. sound :
>> /        sound {
>>            compatible = "fsl,imx51-babbage-sgtl5000",
>> "fsl,imx-audio-sgtl5000";
>>            model = "imx51-babbage-sgtl5000";
>> //          ssi-controller = <&ssi1>;
>>            audio-codec = <&codec>;
>>            audio-routing =
>>                    "MIC_IN", "Mic Jack",
>>                    "Mic Jack", "Mic Bias",
>>                    "Headphone Jack", "HP_OUT";
>>            mux-int-port = <1>;
>>            mux-ext-port = <3>;
>>          };/
>> I want use I2C configuration driver not SPI . How can i set comment 
>> line ?
>>
>> 3. I2S driver looks like ok  :
>> /        axi_i2s_adi_0: axi_i2s_adi@77600000 {
>>              compatible = "xlnx,axi-i2s-adi-1.0";
>>              reg = <0x77600000 0x10000>;
>>              xlnx,bclk-pol = <0x0>;
>>              xlnx,dma-type = <0x1>;
>>              xlnx,has-rx = <0x1>;
>>              xlnx,has-tx = <0x1>;
>>              xlnx,lrclk-pol = <0x0>;
>>              xlnx,num-ch = <0x1>;
>>              xlnx,s-axi-min-size = <0x000001FF>;
>>              xlnx,slot-width = <0x18>;
>>          };/
>>
>>
>> PS.
>> Right now i can compile device tree but audio is not detected.
>> What kind of log do you need to check Linux boot problem ?
>
> Comments in DTS files are done the old-school C way, /* */.
Changed
>
> Regarding the SGTL5K configuration, please take a look here for
> reference:
>
> https://github.com/torvalds/linux/blob/0f57d86787d8b1076ea8f9cbdddda2a46d534a27/arch/arm/boot/dts/imx6dl-riotboard.dts 
>
>
I thing it is the same as my .
> If the audio codec device is detected during boot, you should see
> something like this in you boot logs:
>
>
> ...
> sgtl5000 0-000a: sgtl5000 revision 0x11
> sgtl5000 0-000a: Using internal LDO instead of VDDD
> imx-sgtl5000 sound: sgtl5000 <-> 2028000.ssi mapping ok
> ...
Nothing
> ALSA device list:
> #0: imx6-riotboard-sgtl5000
> ...
Nothing
>
>
> Regards,
> Nikolay
>
