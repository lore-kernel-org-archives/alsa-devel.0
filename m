From: Wojciech Zebrowski <wojtekz@aldec.com>
Subject: Post Audio codec sgtl5000 with ARM/Zynq under Linux
Date: Thu, 11 Jun 2015 08:59:49 +0200
Message-ID: <557931E5.8070802@aldec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 56228261B33
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 09:00:01 +0200 (CEST)
Received: by wibdq8 with SMTP id dq8so771961wib.1
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 00:00:00 -0700 (PDT)
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
Cc: Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?B?U8O2cmVuIEJyaW5rbWFu?= =?UTF-8?B?bg==?= <soren.brinkmann@xilinx.com>
List-Id: alsa-devel@alsa-project.org

Hi All

I try solve problem with support SGTL5000  under Linux , ARM / ZYNQ 
ARCHITECTURE. Please add this post to "alsa" forum.  If you need any 
others information i can send it .

My post:

  I try use freescale audio chip sgtl5000 on my custom board with Zynq 
chip. I need help with instance driver in device tree and debug first 
execution.

1.*I use I2C* controler to configure sgtl5000 :
/        axi_iic_sgtl: i2c@41610000 {//
//            #address-cells = <1>;//
//            #size-cells = <0>;//
//            compatible = "xlnx,xps-iic-2.00.a";//
//            interrupt-parent = <&gic>;//
//            interrupts = <0 31 4>;//
//            reg = <0x41610000 0x10000>;//
////
//            codec: sgtl5000@0a {//
//                #sound-dai-cells = <0>;//
//                compatible = "fsl,sgtl5000";//
//                reg = <0x0a>;//
//////                VDDA-supply = <&reg_3p3v>;//
//////                VDDIO-supply = <&reg_3p3v>;//
//                clocks = <&clkc 19>;//
//      }; /

  How can i set comment lines ?

2. sound :
/        sound {
           compatible = "fsl,imx51-babbage-sgtl5000",
"fsl,imx-audio-sgtl5000";
           model = "imx51-babbage-sgtl5000";
//          ssi-controller = <&ssi1>;
           audio-codec = <&codec>;
           audio-routing =
                   "MIC_IN", "Mic Jack",
                   "Mic Jack", "Mic Bias",
                   "Headphone Jack", "HP_OUT";
           mux-int-port = <1>;
           mux-ext-port = <3>;
         };/
I want use I2C configuration driver not SPI . How can i set comment line ?

3. I2S driver looks like ok  :
/        axi_i2s_adi_0: axi_i2s_adi@77600000 {
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
         };/


PS.
Right now i can compile device tree but audio is not detected.
What kind of log do you need to check Linux boot problem ?
