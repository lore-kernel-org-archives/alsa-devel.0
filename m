From: ngc <ngc@drvlabo.jp>
Subject: Re: (SoC) Does i.MX27's SSI work as I2S clock master?
Date: Mon, 01 Dec 2008 07:47:54 +0900
Message-ID: <4933181A.9010003@drvlabo.jp>
References: <D66C4C05-340D-4A6E-98FC-7B36F4059C36@drvlabo.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.asahi-net.or.jp (mail1.asahi-net.or.jp [202.224.39.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 582301037E3
	for <alsa-devel@alsa-project.org>; Sun, 30 Nov 2008 23:48:16 +0100 (CET)
Received: from mail.drvlabo.jp (d232177.ppp.asahi-net.or.jp [210.253.232.177])
	by mail.asahi-net.or.jp (Postfix) with ESMTP id A0D08188934
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 07:48:14 +0900 (JST)
Received: from localhost (localhost [127.0.0.1])
	by mail.drvlabo.jp (Postfix) with ESMTP id 31C00706446
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 07:48:14 +0900 (JST)
Received: from mail.drvlabo.jp ([127.0.0.1])
	by localhost (mail.drvlabo.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q7ptRakGe5sv for <alsa-devel@alsa-project.org>;
	Mon,  1 Dec 2008 07:47:55 +0900 (JST)
Received: from [172.30.170.1] (www.n.axe-inc.co.jp [218.44.142.90])
	by mail.drvlabo.jp (Postfix) with ESMTP id 5A84E706443
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 07:47:55 +0900 (JST)
In-Reply-To: <D66C4C05-340D-4A6E-98FC-7B36F4059C36@drvlabo.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

I found some mistakes.
- AUDMUX configuration : Tx clock/fs direction
  I noticed this mistake when checking i.MX21's applicaton note #2628.
  The descriptions in the reference manual is very hard
  to understand the AUDMUX's specfications.
- in ADS board, TOUT/SSI2_MCLK is used to
  receive IRQ from MC13783,
  there is a conflict and the pin configuration was
  overwritten when register IRQ handler.

After correct the above mistakes, I could see the signals:
SSI_CLK,FS,TxDAT and MCLK.
But, still I have a problem.
Though I want to provide an oversampling clock with MCLK to the codec
device,
now the frequency of MCLK is same as SSI_CLK.
Can't the MCLK provide the oversampling frequency?

> Now I'm porting WM8728 driver with i.MX27ADS, based on Freescale's BSP
> kernel(2.6.22) and refering to ALSA SoC git repository.
>   
> I checked SSI-3 signal set with an oscilloscope,
> no clock signal appears on SSI3_CLK.
> I tried the various SSI setting, I2S normal, I2S master,
> asychronous/synchronous, normal mode/network mode, ...
> But, I can't see clock signal, yet.
>   
