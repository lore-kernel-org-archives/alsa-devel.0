Return-Path: <SRS0=cqJl=BP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186D4C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:54:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF40022B40
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YcuNfbEX";
	dkim=pass (1024-bit key) header.d=arturia.com header.i=@arturia.com header.b="ohxjZzIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF40022B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arturia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B2A884C;
	Wed,  5 Aug 2020 12:53:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B2A884C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596624846;
	bh=NgSSmfnTKzGmmfI9rzYl934CFRlrPTJ5e4vYcAtFmxY=;
	h=To:From:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YcuNfbEXFozc2N1eK1vcP+MS0hnKOdcnRN+wB0ur3x0FkhKRzcwrkzLfLZpIlf/O0
	 bUVEt7+jsKNrO009mMC+mmS+YqhKky3t9E7TrQ9srWZIgLjZrrd8hBk8Zj6Dipv3pW
	 NYH1AviCNlx+cCbv/GVATLnrH/vqWcKHBP0VC3/E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFCC0F801F7;
	Wed,  5 Aug 2020 12:53:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20CBCF80218; Wed,  5 Aug 2020 12:53:14 +0200 (CEST)
Received: from mail.arturia.com (mail.arturia.com [5.39.71.79])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A4EEF80124
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 12:53:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A4EEF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=arturia.com header.i=@arturia.com
 header.b="ohxjZzIW"
Received: from [192.168.33.240] (226.142.197.77.rev.sfr.net [77.197.142.226])
 (Authenticated sender: markus.bollinger@arturia.com)
 by mail.arturia.com (Postfix) with ESMTPSA id 9DCF547C03A4;
 Wed,  5 Aug 2020 12:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=arturia.com; s=mail;
 t=1596624781; bh=NgSSmfnTKzGmmfI9rzYl934CFRlrPTJ5e4vYcAtFmxY=;
 h=To:Cc:From:Subject:Date:From;
 b=ohxjZzIWmqnC1SRDAKww9AiftI3ZDwgEwBWLz2dMj9Pa4+YPZPOO47bTjWFZTetCJ
 caxST2phHF7Ab3HQpysGep0t57qtzBcbk1+z13KUDzSEn3x/K2RuwBfY1mtdZvm4Kb
 EKOjDqBs9FEEfxYUcG9BwJCmry318X057EeC+joU=
To: alsa-devel@alsa-project.org
From: Markus Bollinger <markus.bollinger@arturia.com>
Subject: asoc : snd_soc_simple_card connection to AKM4556 codec (i2s) issue on
 arm64
Message-ID: <1f6b4d1f-88ff-94d2-5224-7219c61d558f@arturia.com>
Date: Wed, 5 Aug 2020 12:52:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: tiwai@suse.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello,

I try to get working an AKM4556 codec on the arm64 Rockchip RK3399 board 
under Linux 4.4.179
The codec is a simple one (without i2c connection), similar to AKM4554 
(but 24 bit instead of 16 bit audio) and hard configured to use i2s.
I implemented the driver soc/codecs/ak4556.c which has only few 
differences to ak4554.c.
But when I try to get it working with the soc/general/simple-card.c, the 
connection to the codec fails
Both drivers (snd_soc_simple_card and snd_soc_ak4556) get loaded, the 
call to

asoc_simple_card_dai_link_of -> asoc_simple_card_sub_parse_of(cpu, ..)

is OK, but the call to

asoc_simple_card_dai_link_of -> asoc_simple_card_sub_parse_of(codec, ..) 
-> snd_soc_of_get_dai_name

fails with -EPROBE_DEFER.

Now, i am not sure if it is a driver issue or rather a device-tree one. 
I declared dt like this :

/ {

     ak4556_card: ak4556-adc-dac {
         status = "okay";
         compatible = "simple-audio-card";

         simple-audio-card,name = "ak4556";
         simple-audio-card,format = "i2s";
         simple-audio-card,mclk-fs = <256>;

         simple-audio-card,widgets =
             "Line", "Line In",
             "Line", "Line Out";
         simple-audio-card,routing =
             "LIN", "Line In",
             "RIN", "Line In",
             "Line Out", "LOUT",
             "Line Out", "ROUT";

         simple-audio-card,cpu {
             sound-dai = <&i2s0>;
         };
         simple-audio-card,codec {
             sound-dai = <&ak4556_codec>;
         };
     };

     ak4556_codec: ak4556-codec {
         status = "okay";
         compatible = "asahi-kasei,ak4556";
         #sound-dai-cells = <0>;
     };

     i2s0: i2s@ff880000 {

         compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
         reg = <0x0 0xff880000 0x0 0x1000>;
         rockchip,grf = <&grf>;
         interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH 0>;
         dmas = <&dmac_bus 0>, <&dmac_bus 1>;
         dma-names = "tx", "rx";
         clock-names = "i2s_clk", "i2s_hclk";
         clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
         resets = <&cru SRST_I2S0_8CH>, <&cru SRST_H_I2S0_8CH>;
         reset-names = "reset-m", "reset-h";
         pinctrl-names = "default";
         pinctrl-0 = <&i2s0_8ch_bus>;
         power-domains = <&power RK3399_PD_SDIOAUDIO>;
         status = "disabled";
     };

&i2s0 {
     #sound-dai-cells = <0>;
     assigned-clocks = <&cru SCLK_I2S0_DIV>;
     assigned-clock-parents = <&cru PLL_GPLL>;
     status = "okay";
};

Thank you in advance for your suggestions,

Markus

