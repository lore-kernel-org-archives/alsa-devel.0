From: Edison <edison_xu1981@163.com>
Subject: Community MC13783 driver for Asynchronous DAI mode
Date: Mon, 18 Apr 2016 02:45:24 +0000 (UTC)
Message-ID: <loom.20160418T043755-488@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 962B8261ADB
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 04:55:09 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1arzL6-00082w-Vw
 for alsa-devel@alsa-project.org; Mon, 18 Apr 2016 04:55:05 +0200
Received: from 119.4.94.30 ([119.4.94.30])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 04:55:04 +0200
Received: from edison_xu1981 by 119.4.94.30 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 04:55:04 +0200
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
List-Id: alsa-devel@alsa-project.org

HI Community,
    I'm working on kernel upgrading from FSL BSP to community BSP for my 
customized IMX27 based board, everything works fine except problem when porting 
MC13783 audio device driver. On my board, the hardware schematic for audio part 
is the same as IMX27 ADS, in which MC13783 audio is connect to IMX27 with two 
SSI (SSI1/SS2). In the FSL 2.6.22 BSP, the design is the same as the hardware 
schematic, the ALSA driver use SS1 / SS2 as codec and DAC respectively. In the 
community BSP (4.X),  I tried to assign two difference SSI port for MC13783 
codec as below

  /* MC13783 */

    static struct mc13xxx_codec_platform_data mx27_ads_codec = {

        .dac_ssi_port = MC13783_SSI2_PORT,

        .adc_ssi_port = MC13783_SSI1_PORT,

    };

 
     In the community BSP, mc13783 audio driver will be bind to asynchronous 
MC13783 DAI for separated routing for AD/DA (mc13783.c), one called mc13783-
hifi-playback and the other called mc13783-hifi-capture, but DAI bind will be 
certainly unsuccessful because in mc13783 sound soc driver (imx-mc13783.c),  
the dai_link name is fixed to "mc13783_hifi", so looks like the bind can only 
be successfully if we use synchronized mode (AD/DA use the same SSI port rather 
than different ports). That seems to be a big difference between community BSP 
and FSL BSP. My question:

1. Has someone used the synchronized DAI in their design with community kernel 
version? Is it  works? (I cannot find any reference for mc13783-hifi-
playback/mc13783-hifi-capture in the kernel source code)?

2. Can I use synchronized DAI (force ADC/DAC use same SSI) instead of 
asynchronous  DAI on the community version to make audio works without hardware 
change? (Unfortunately I have done some experiments but seems not work).

Regards,
Edison
 
